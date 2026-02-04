## Context

The embed-sheet Quarto extension needs its core shortcode implemented. The shortcode must convert spreadsheet files to images using LibreOffice headless and embed them in Quarto documents.

**Constraints:**
- Linux platform target (may extend to other platforms later)
- LibreOffice must be installed on the system
- Output images should be placed in a predictable location for Quarto to find

## Goals / Non-Goals

**Goals:**
- Implement functional shortcode that converts spreadsheets to images
- Support jpg, png output formats
- Support configurable image width in output
- Provide clear error messages when things fail

**Non-Goals:**
- Windows/macOS support (can be added later)
- Multi-sheet support (README states first sheet only)
- LibreOffice availability checking (accept raw error on failure)

## Decisions

### Decision: Use os.execute for LibreOffice invocation
LibreOffice CLI is invoked via `os.execute()` with the command:
```
libreoffice --headless --convert-to <format> --outdir <output_dir> <input_file>
```

**Rationale:** This is the standard Lua approach for external command execution and the proven method provided by the user.

### Decision: Output images to same directory as source file
Converted images will be placed alongside the source spreadsheet file.

**Rationale:** 
- Keeps images near their source for easy discovery
- LibreOffice outputs to current directory or specified `--outdir`
- Quarto can reference images with relative paths

### Decision: Image naming convention
Output filename: `_cache_embsht_<original_basename>.<format>` (e.g., `budget.ods` -> `_cache_embsht_budget.jpg`)

**Rationale:** 
- Prefix clearly identifies generated cache files
- Easy bulk cleanup: `rm _cache_embsht_*`
- Keeps cache files alongside source for simple relative paths

### Decision: Cache converted images
The shortcode SHALL skip LibreOffice conversion if a cached image already exists for the source file.

**Cache invalidation:** Manual only - user deletes `_cache_embsht_*` files to force re-render.

**Rationale:**
- Avoids slow LibreOffice conversion on every Quarto render
- Simple invalidation strategy (delete files)
- No modification time checking needed initially

### Decision: No LibreOffice availability check
The shortcode SHALL NOT check if LibreOffice is installed before attempting conversion.

**Rationale:** Accept the raw error message from the system if LibreOffice is missing. Keeps implementation simple.

## Risks / Trade-offs

- **LibreOffice not installed** -> Raw system error (accepted trade-off)
- **Conversion failure** -> Return error text in document rather than crashing
- **Stale cache** -> User must manually delete cache files to force re-render
