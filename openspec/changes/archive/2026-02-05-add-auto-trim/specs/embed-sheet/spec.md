## ADDED Requirements

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
