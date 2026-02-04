# Change: Implement embed-sheet shortcode

## Why
The embed-sheet shortcode currently returns a placeholder string. Users need the actual functionality to embed spreadsheet content as rendered images in their Quarto documents, as described in the README.

## What Changes
- Implement the `embed-sheet` Lua shortcode to:
  - Accept a spreadsheet file path as the first positional argument
  - Support `width` kwarg (default: 100%) for controlling image display size
  - Support `format` kwarg (default: jpg) for output format (jpg/png)
  - Use LibreOffice headless CLI to convert spreadsheets to images
  - Return a Pandoc image element for embedding in the document

## Impact
- Affected specs: embed-sheet (new capability)
- Affected code: `_extensions/embed-sheet/embed-sheet.lua`
- Platform: Linux (using `libreoffice --headless --convert-to <format>`)
