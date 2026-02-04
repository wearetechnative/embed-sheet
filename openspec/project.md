# Project Context

## Purpose
Embed-sheet is a Quarto extension that enables embedding spreadsheet content (LibreOffice Calc, Excel) as rendered images into PDF or HTML documents. The primary motivation is to allow high-quality table rendering in Quarto documents that matches the visual fidelity of WYSIWYG applications like Microsoft Word, particularly useful for document migrations (e.g., ISO27001 policies from Word to Quarto Markdown).

## Tech Stack
- **Lua** - Quarto shortcode extension logic
- **Quarto** - Publishing system (requires >=1.7.0)
- **LibreOffice** - Headless rendering of spreadsheets to images
- **Pandoc** - Document conversion (via Quarto)

## Project Conventions

### Code Style
- Lua code follows standard Lua conventions
- Use descriptive variable and function names
- Comment complex logic, especially LibreOffice CLI interactions
- Keep the extension self-contained in `_extensions/embed-sheet/`

### Architecture Patterns
- **Shortcode pattern**: Extension exposes a single shortcode `{{< embed-sheet >}}`
- **External tool delegation**: Heavy lifting (rendering) is delegated to LibreOffice headless
- **Supported formats**: Input: `xls`, `xlsx`, `ods` | Output: `jpg`, `png`, `svg`

### Testing Strategy
- Use `quarto preview` for iterative development and testing
- Test with `example.qmd` as the primary test document
- Verify output in both HTML and PDF formats

### Git Workflow
- **GitHub Flow**: Feature branches with pull requests to main
- Keep commits focused and descriptive
- Repository: `wearetechnative/embed-sheet`

## Domain Context
- **Print ranges**: LibreOffice uses print ranges to determine what area to render
- **Page setup matters**: Margins, headers, footers, and page orientation affect output
- Only the first sheet of a spreadsheet is rendered (current limitation)
- Users must configure their spreadsheet documents for optimal rendering before use

## Important Constraints
- **LibreOffice required**: Must be installed on the system for headless rendering
- **Cross-platform**: Must work on Linux, macOS, and Windows
- **Dual output**: Must support both PDF and HTML Quarto output formats
- **Quarto version**: Requires Quarto 1.7.0 or higher

## External Dependencies
- **LibreOffice**: Used via CLI for headless spreadsheet-to-image conversion
- **Quarto**: Host publishing system that loads and executes the extension
