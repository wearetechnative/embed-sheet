# Embed-sheet Extension For Quarto

Embed Sheet allowed embedding SpreadSheet content as rendered image into PDF or
HTML documents. You can embed LibreOffice or Excel documents of which the first
page of a sheet is rendered as image and embedded in the Quarto document.

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

- LibreOffice for headless rendering spreadsheet documents to images.
- Supported file types: `xls`, `xlsx`, `ods`

## Using

### Preparing the spreadsheet document

You should prepare your spreadsheet for optimal rendering. Check the following settings.

Currently only rendering of the first sheet is supported.

1. Set Print Ranges to the area you want to render.
2. In Page Format:
    - choose landscape or portrait
    - update with and height
    - set margins to 0 (this will set margins to the lowest amount)
    - disable header
    - disable footer
    - disable page numbers

_Tips:_

- Don't forget to save your documents after changing above settings
- Set the view to Page Breaks
- Use the Print Preview functionality to check the output of your document.

### Shortcode

```
{{< embed-sheet my-libreoffice-calc.ods  >}}

{{< embed-sheet my-excel.xlsx >}}

{{< embed-sheet my-excel.xlsx width=50% >}}
```

### Arguments

| option     | default    | description                                     |
|:-----------|:-----------|:------------------------------------------------|
| width      | 100%       | Width of the final image in the quarto document |
| format     | jpg        | The image format to render. Choose: jpg/png     |

## Example

Here is the source code for a minimal example: [example.qmd](example.qmd).
