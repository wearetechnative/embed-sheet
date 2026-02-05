# Embed-sheet - extension For Quarto

_A Quarto extension that embeds spreadsheet files as images in your documents._

You can embed LibreOffice or Excel documents of which the first page of a sheet
is rendered as image and embedded in the Quarto document.

## Features

- Converts Excel (.xls, .xlsx) and LibreOffice Calc (.ods) files to images
- Uses LibreOffice headless for high-fidelity rendering
- Supports custom width and output format (jpg, png)
- Caches converted images to speed up subsequent renders

## Motivation

We build this extension as we wanted to convert our ISO27001 policies from
Microsoft Word to Quarto Markdown. While most aspects of the documents improved
instantly, we got major headaches from getting the embedded tables rendered
correctly. As hard as we tried, even using raw latex they just couldn't compete
with the easily made tables from inside Word. 

You could say this extension is a concession to WYSIWYG apps like those from
the Office 365 suite. That may be true, but this extension also brings many new
ways to create beautiful, publications with Quarto.

## Installing


```bash
quarto add wearetechnative/embed-sheet
```

This will install the extension under the `_extensions` subdirectory.
If you're using version control, you will want to check in this directory.

## Requirements

- Quarto (https://quarto.org/) 1.3+
- LibreOffice (https://www.libreoffice.org/) (for headless conversion)

## Usage

### Shortcode

```
{{< embedSheet my-spreadsheet.ods >}}
{{< embedSheet data.xlsx width=50% >}}
{{< embedSheet report.ods format=png >}}
{{< embedSheet report.ods format=png auto_trim_exterior_white=true >}}

```

### Shortcode arguments

| option                   | default    | description                                     |
|:-------------------------|:-----------|:------------------------------------------------|
| width                    | 100%       | Width of the final image in the quarto document |
| format                   | jpg        | The image format to render. Choose: jpg/png     |
| auto_trim_exterior_white | false      | Use `convert` to auto trim exterior white space |

### Preparing the spreadsheet document

You should prepare your spreadsheet for optimal rendering. Check the following settings.

Currently only rendering of the first sheet is supported.

1. Set Print Ranges to the area you want to render.
2. In Page Format:
    - choose landscape or portrait
    - disable header
    - disable footer
    - disable page numbers
    - update with and height (if not using `auto_trim_exterior_white`)
    - set margins to 0 (if not using `auto_trim_exterior_white`)

_Tips:_

- Don't forget to save your documents after changing above settings
- Set the view to Page Breaks
- Use the Print Preview functionality to check the output of your document.

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).
