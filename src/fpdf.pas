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
    Fpage: Integer;               // current page number
    Fn: Integer;                  // current object number
    Foffsets: array of Integer;   // array of object offsets
    Fbuffer: TMemoryStream;       // buffer holding in-memory PDF
    Fpages: array of string;      // array containing pages
    Fstate: Integer;              // current document state
    Fcompress: Boolean;           // compression flag
    Fk: Double;                  // scale factor (number of points in user unit)
    FDefOrientation: Char;       // default orientation
    FCurOrientation: Char;       // current orientation
//    FStdPageSizes;       // standard page sizes
//    FDefPageSize;        // default page size
//    FCurPageSize;        // current page size
//    FPageSizes;          // used for pages with non default sizes or orientations
    FwPt, FhPt: Double;          // dimensions of current page in points
    Fw, Fh: Double;              // dimensions of current page in user unit
    FlMargin: Double;            // left margin
    FtMargin: Double;            // top margin
    FrMargin: Double;            // right margin
    FbMargin: Double;            // page break margin
    FcMargin: Double;            // cell margin
    Fx, Fy: Double;              // current position in user unit
    Flasth: Double;              // height of last printed cell
    FLineWidth: Double;          // line width in user unit
    Ffontpath: Double;           // path containing fonts
    FCoreFonts: array of string;          // array of core font names
    Ffonts: array of string;              // array of used fonts
//    FFontFiles: array of Integer;          // array of font files
    Fdiffs: array of Integer;              // array of encoding differences
    FFontFamily: string;         // current font family
    FFontStyle: string;          // current font style
    Funderline: Boolean;          // underlining flag
//    FCurrentFont;        // current font info
    FFontSizePt: Integer;         // current font size in points
    FFontSize: Integer;           // current font size in user unit
    FDrawColor;          // commands for drawing color
    FFillColor;          // commands for filling color
    FTextColor;          // commands for text color
    FColorFlag;          // indicates whether fill and text colors are different
    Fws;                 // word spacing
    Fimages;             // array of used images
    FPageLinks;          // array of links in pages
    Flinks;              // array of internal links
    FAutoPageBreak;      // automatic page breaking
    FPageBreakTrigger;   // threshold used to trigger page breaks
    FInHeader;           // flag set when processing header
    FInFooter;           // flag set when processing footer
    FZoomMode;           // zoom display mode
    FLayoutMode;         // layout display mode
    Ftitle;              // title
    Fsubject;            // subject
    Fauthor;             // author
    Fkeywords;           // keywords
    Fcreator;            // creator
    FAliasNbPages;       // alias for total number of pages
    FPDFVersion;         // PDF version number
  end;

implementation

end.

