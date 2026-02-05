# Tasks

## 1. Implementation
- [x] 1.1 Add `auto_trim_exterior_white` parameter parsing in embed-sheet.lua
- [x] 1.2 Implement ImageMagick trim command execution after LibreOffice conversion
- [x] 1.3 Update cache filename to differentiate trimmed vs non-trimmed versions
- [x] 1.4 Add error handling for ImageMagick failures

## 2. Testing
- [x] 2.1 Test with `auto_trim_exterior_white=true` produces trimmed output
- [x] 2.2 Test without parameter preserves original behavior
- [x] 2.3 Test caching works correctly for both trimmed and non-trimmed
- [x] 2.4 Test error message when ImageMagick is not installed

## 3. Documentation
- [x] 3.1 Update example.qmd with auto_trim_exterior_white usage example
