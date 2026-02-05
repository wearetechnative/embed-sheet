# Change: Add Auto-Trim Exterior White Space

## Why
LibreOffice renders spreadsheets with margins and page setup that often results in unwanted white space around the actual table content. Users need a way to automatically remove this exterior white space to achieve cleaner, more compact embedded images.

## What Changes
- Add optional `auto_trim_exterior_white` boolean parameter to the embedSheet shortcode
- When enabled, use ImageMagick's `convert -trim +repage` command to remove exterior white space from the rendered image
- Trimming occurs after LibreOffice conversion but before caching, so trimmed images are cached for subsequent renders

## Impact
- Affected specs: `embed-sheet`
- Affected code: `_extensions/embed-sheet/embed-sheet.lua`
- New dependency: ImageMagick must be installed on the system when using this feature
