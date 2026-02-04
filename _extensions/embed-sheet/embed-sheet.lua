-- embed-sheet: Convert spreadsheets to images using LibreOffice headless
-- see https://quarto.org/docs/extensions/shortcodes.html

local CACHE_PREFIX = "_cache_embsht_"
local SUPPORTED_EXTENSIONS = { xls = true, xlsx = true, ods = true }

-- Check if file exists
local function file_exists(path)
  local f = io.open(path, "r")
  if f then
    f:close()
    return true
  end
  return false
end

-- Get directory from path (returns "." for files in current dir)
local function get_dir(path)
  local dir = path:match("(.*/)")
  if dir then
    -- Remove trailing slash
    return dir:sub(1, -2)
  end
  return "."
end

-- Get basename without extension
local function get_basename(path)
  local filename = path:match("([^/]+)$") or path
  local basename = filename:match("(.+)%.[^.]+$")
  return basename or filename
end

-- Get file extension (lowercase)
local function get_extension(path)
  local ext = path:match("%.([^.]+)$")
  return ext and ext:lower() or ""
end

return {
  ['embedSheet'] = function(args, kwargs, meta, raw_args, context)
    -- 1.1 Parse shortcode arguments
    local file_path = pandoc.utils.stringify(args[1])
    if not file_path or file_path == "" then
      return pandoc.Strong(pandoc.Str("[embed-sheet error: no file path provided]"))
    end

    -- Parse optional arguments with proper defaults
    local width_raw = kwargs["width"]
    local width = "100%"  -- default
    if width_raw then
      local w = pandoc.utils.stringify(width_raw)
      if w ~= "" then width = w end
    end
    
    local format_raw = kwargs["format"]
    local format = "jpg"  -- default
    if format_raw then
      local f = pandoc.utils.stringify(format_raw)
      if f ~= "" then format = f end
    end

    -- 1.2 Validate input file exists and has supported extension
    local ext = get_extension(file_path)
    if not SUPPORTED_EXTENSIONS[ext] then
      return pandoc.Strong(pandoc.Str(string.format(
        "[embed-sheet error: unsupported file extension '%s'. Supported: xls, xlsx, ods]", ext)))
    end

    if not file_exists(file_path) then
      return pandoc.Strong(pandoc.Str(string.format(
        "[embed-sheet error: file not found '%s']", file_path)))
    end

    -- 1.3 Determine output path for converted image
    local dir = get_dir(file_path)
    local basename = get_basename(file_path)
    local output_filename = CACHE_PREFIX .. basename .. "." .. format
    local output_path = dir .. "/" .. output_filename

    -- 1.4 Execute LibreOffice headless conversion command (only if not cached)
    if not file_exists(output_path) then
      -- LibreOffice outputs files with original basename, so we need to rename
      local temp_output = dir .. "/" .. basename .. "." .. format
      local cmd = string.format(
        'libreoffice --headless --convert-to %s --outdir "%s" "%s"',
        format, dir, file_path)
      
      local result = os.execute(cmd)
      
      -- 1.6 Handle conversion failure
      if result ~= 0 and result ~= true then
        return pandoc.Strong(pandoc.Str(string.format(
          "[embed-sheet error: LibreOffice conversion failed for '%s']", file_path)))
      end
      
      -- Rename to cache filename
      if file_exists(temp_output) then
        os.rename(temp_output, output_path)
      end
      
      -- Verify output was created
      if not file_exists(output_path) then
        return pandoc.Strong(pandoc.Str(string.format(
          "[embed-sheet error: conversion did not produce expected output '%s']", output_path)))
      end
    end

    -- 1.5 Return Pandoc image element with width attribute
    local img = pandoc.Image({}, output_path)
    img.attributes.width = width
    
    return pandoc.Para({ img })
  end
}
