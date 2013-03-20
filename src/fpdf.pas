unit FPDF;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  FPDF_VERSION = '1.7';

type
  TFPDF = class
  private
    page;               // current page number
    n;                  // current object number
    offsets;            // array of object offsets
    buffer;             // buffer holding in-memory PDF
    pages;              // array containing pages
    state;              // current document state
    compress;           // compression flag
    k;                  // scale factor (number of points in user unit)
    DefOrientation;     // default orientation
    CurOrientation;     // current orientation
    StdPageSizes;       // standard page sizes
    DefPageSize;        // default page size
    CurPageSize;        // current page size
    PageSizes;          // used for pages with non default sizes or orientations
    wPt, $hPt;          // dimensions of current page in points
    w, $h;              // dimensions of current page in user unit
    lMargin;            // left margin
    tMargin;            // top margin
    rMargin;            // right margin
    bMargin;            // page break margin
    cMargin;            // cell margin
    x, $y;              // current position in user unit
    lasth;              // height of last printed cell
    LineWidth;          // line width in user unit
    fontpath;           // path containing fonts
    CoreFonts;          // array of core font names
    fonts;              // array of used fonts
    FontFiles;          // array of font files
    diffs;              // array of encoding differences
    FontFamily;         // current font family
    FontStyle;          // current font style
    underline;          // underlining flag
    CurrentFont;        // current font info
    FontSizePt;         // current font size in points
    FontSize;           // current font size in user unit
    DrawColor;          // commands for drawing color
    FillColor;          // commands for filling color
    TextColor;          // commands for text color
    ColorFlag;          // indicates whether fill and text colors are different
    ws;                 // word spacing
    images;             // array of used images
    PageLinks;          // array of links in pages
    links;              // array of internal links
    AutoPageBreak;      // automatic page breaking
    PageBreakTrigger;   // threshold used to trigger page breaks
    InHeader;           // flag set when processing header
    InFooter;           // flag set when processing footer
    ZoomMode;           // zoom display mode
    LayoutMode;         // layout display mode
    title;              // title
    subject;            // subject
    author;             // author
    keywords;           // keywords
    creator;            // creator
    AliasNbPages;       // alias for total number of pages
    PDFVersion;         // PDF version number

  end;

implementation

end.

