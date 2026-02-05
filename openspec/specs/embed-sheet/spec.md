# embed-sheet Specification

## Purpose
TBD - created by archiving change implement-embed-sheet-shortcode. Update Purpose after archive.
## Requirements
### Requirement: Spreadsheet to Image Conversion
The shortcode SHALL convert spreadsheet files to images using LibreOffice headless rendering.

#### Scenario: Successful conversion of ODS file
- **WHEN** user includes `{{< embedSheet my-file.ods >}}` in their Quarto document
- **THEN** the system SHALL execute `libreoffice --headless --convert-to jpg --outdir <dir> <file>`
- **AND** the resulting image SHALL be embedded in the document output

#### Scenario: Successful conversion with custom format
- **WHEN** user includes `{{< embedSheet my-file.xlsx format=png >}}`
- **THEN** the system SHALL convert to PNG format instead of the default JPG

### Requirement: Supported Input Formats
The shortcode SHALL support the following spreadsheet file extensions: `xls`, `xlsx`, `ods`.

#### Scenario: Accept ODS file
- **WHEN** user provides a file with `.ods` extension
- **THEN** the system SHALL accept and process the file

#### Scenario: Accept XLSX file
- **WHEN** user provides a file with `.xlsx` extension
- **THEN** the system SHALL accept and process the file

#### Scenario: Accept XLS file
- **WHEN** user provides a file with `.xls` extension
- **THEN** the system SHALL accept and process the file

### Requirement: Width Parameter
The shortcode SHALL support a `width` parameter to control the display width of the embedded image.

#### Scenario: Default width
- **WHEN** user does not specify a width parameter
- **THEN** the image SHALL be displayed at 100% width

#### Scenario: Custom width
- **WHEN** user includes `{{< embedSheet file.ods width=50% >}}`
- **THEN** the image SHALL be displayed at 50% width

### Requirement: Format Parameter
The shortcode SHALL support a `format` parameter to specify the output image format.

#### Scenario: Default format
- **WHEN** user does not specify a format parameter
- **THEN** the system SHALL output a JPG image

#### Scenario: PNG format
- **WHEN** user specifies `format=png`
- **THEN** the system SHALL output a PNG image

### Requirement: Image Caching
The shortcode SHALL cache converted images to avoid redundant LibreOffice invocations.

#### Scenario: Cache hit
- **WHEN** the cached image file `_cache_embsht_<basename>.<format>` already exists
- **THEN** the system SHALL skip LibreOffice conversion and use the cached image

#### Scenario: Cache miss
- **WHEN** no cached image exists for the source file
- **THEN** the system SHALL execute LibreOffice conversion and save to `_cache_embsht_<basename>.<format>`

#### Scenario: Force re-render
- **WHEN** user deletes `_cache_embsht_*` files from the directory
- **THEN** the next render SHALL regenerate all cached images

### Requirement: Error Handling
The shortcode SHALL display an error message when the input file is missing.

#### Scenario: Missing input file
- **WHEN** the specified spreadsheet file does not exist
- **THEN** the system SHALL display an error message indicating the file was not found

### Requirement: Auto-Trim Exterior White Space
The shortcode SHALL support an optional `auto_trim_exterior_white` boolean parameter that trims exterior white space from the rendered image using ImageMagick.

#### Scenario: Trim enabled
- **WHEN** user includes `{{< embedSheet file.ods auto_trim_exterior_white=true >}}`
- **THEN** the system SHALL execute ImageMagick `convert <image> -trim +repage <output>` after LibreOffice conversion
- **AND** the resulting trimmed image SHALL be cached and embedded in the document

#### Scenario: Trim disabled by default
- **WHEN** user does not specify the `auto_trim_exterior_white` parameter
- **THEN** the system SHALL NOT perform any trimming
- **AND** the image SHALL be embedded as-is from LibreOffice conversion

#### Scenario: ImageMagick not available
- **WHEN** `auto_trim_exterior_white=true` is specified but ImageMagick is not installed
- **THEN** the system SHALL display an error message indicating ImageMagick is required for trimming

#### Scenario: Cache differentiation
- **WHEN** the same source file is embedded with and without `auto_trim_exterior_white`
- **THEN** the system SHALL cache both versions separately to avoid conflicts

