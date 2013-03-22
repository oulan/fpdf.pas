unit FPDF;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const
  FPDF_VERSION = '1.7';

var
  FPDF_FONTPATH: string = '';

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
//#    FStdPageSizes;       // standard page sizes
//#    FDefPageSize;        // default page size
//#    FCurPageSize;        // current page size
//#    FPageSizes;          // used for pages with non default sizes or orientations
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
    Ffontpath: string;           // path containing fonts
    FCoreFonts: array of string;          // array of core font names
    Ffonts: array of string;              // array of used fonts
//#    FFontFiles: array of Integer;          // array of font files
    Fdiffs: array of Integer;              // array of encoding differences
    FFontFamily: string;         // current font family
    FFontStyle: string;          // current font style
    Funderline: Boolean;          // underlining flag
//#    FCurrentFont;        // current font info
    FFontSizePt: Double;         // current font size in points
    FFontSize: Double;           // current font size in user unit
    FDrawColor: string;          // commands for drawing color
    FFillColor: string;          // commands for filling color
    FTextColor: string;          // commands for text color
    FColorFlag: Boolean;          // indicates whether fill and text colors are different
    Fws: Integer;                 // word spacing
//#    Fimages;             // array of used images
//#   FPageLinks;          // array of links in pages
//#    Flinks;              // array of internal links
//#    FAutoPageBreak;      // automatic page breaking
//#    FPageBreakTrigger;   // threshold used to trigger page breaks
    FInHeader: Boolean;           // flag set when processing header
    FInFooter: Boolean;           // flag set when processing footer
{#    FZoomMode;           // zoom display mode
    FLayoutMode;         // layout display mode
    Ftitle;              // title
    Fsubject;            // subject
    Fauthor;             // author
    Fkeywords;           // keywords
    Fcreator;            // creator
    FAliasNbPages;       // alias for total number of pages
    FPDFVersion;         // PDF version number
  #}
  protected
    procedure _dochecks;
    procedure Error(const Amsg: string);
  public
    constructor Create(Aorientation: Char='P'; Aunit: Char='mm'; Asize: string='A4');
    destructor Destroy; override;
  end;

implementation

{ TFPDF }

(*******************************************************************************
*                                                                              *
*                              Protected methods                               *
*                                                                              *
*******************************************************************************)
procedure TFPDF._dochecks;
begin
  {
  // Check availability of %F
  if(sprintf('%.1F',1.0)!='1.0')
	  $this->Error('This version of PHP is not supported');
  // Check mbstring overloading
  if(ini_get('mbstring.func_overload') & 2)
	  $this->Error('mbstring overloading must be disabled');
  // Ensure runtime magic quotes are disabled
  if(get_magic_quotes_runtime())
	  @set_magic_quotes_runtime(0);
  }
end;

procedure TFPDF.Error(const Amsg: string);
begin
  raise Exception.Create('FPDF error: ' + Amsg);
end;



(*******************************************************************************
*                                                                              *
*                               Public methods                                 *
*                                                                              *
*******************************************************************************)
constructor TFPDF.Create(Aorientation: Char; Aunit: Char; Asize: string);
begin
  // Some checks
  _dochecks;
  // Initialization of properties
  Fpage := 0;
  Fn := 2;
  Fbuffer := TMemoryStream.Create;
  //#Fpages := array();
  //#FPageSizes := array();
  Fstate := 0;
  //#Ffonts := array();
  //#FFontFiles := array();
  //#Fdiffs := array();
  //#Fimages := array();
  //#Flinks := array();
  FInHeader := False;
  FInFooter := False;
  Flasth := 0;
  FFontFamily := '';
  FFontStyle := '';
  FFontSizePt := 12;
  Funderline := False;
  FDrawColor := '0 G';
  FFillColor := '0 g';
  FTextColor := '0 g';
  FColorFlag := False;
  Fws := 0;
  // Font path
  if FPDF_FONTPATH <> '' then
    Ffontpath := IncludeTrailingPathDelimiter(FPDF_FONTPATH)
  else if DirectoryExists('font') then
    Ffontpath := ExtractFilePath(ParamStr(0)) + DirectorySeparator + 'font' + DirectorySeparator
  else
    Ffontpath := '';
  // Core fonts
  SetLength(FCoreFonts, 5);
  FCoreFonts[0] := 'courier';
  FCoreFonts[0] := 'helvetica';
  FCoreFonts[0] := 'times';
  FCoreFonts[0] := 'symbol';
  FCoreFonts[0] := 'zapfdingbats';
  // Scale factor
  if Aunit = 'pt' then
    Fk := 1
  else if Aunit ='mm' then
    Fk := 72/25.4
  else if Aunit = 'cm' then
    Fk := 72/2.54
  else if Aunit = 'in' then
    Fk := 72
  else
    Error('Incorrect unit: ' + Aunit);
  // Page sizes
  FStdPageSizes = array('a3'=>array(841.89,1190.55), 'a4'=>array(595.28,841.89), 'a5'=>array(420.94,595.28),
  	'letter'=>array(612,792), 'legal'=>array(612,1008));
  $size = $this->_getpagesize($size);
  $this->DefPageSize = $size;
  $this->CurPageSize = $size;
  // Page orientation
  $orientation = strtolower($orientation);
  if($orientation=='p' || $orientation=='portrait')
  {
  	$this->DefOrientation = 'P';
  	$this->w = $size[0];
  	$this->h = $size[1];
  }
  elseif($orientation=='l' || $orientation=='landscape')
  {
  	$this->DefOrientation = 'L';
  	$this->w = $size[1];
  	$this->h = $size[0];
  }
  else
  	$this->Error('Incorrect orientation: '.$orientation);
  $this->CurOrientation = $this->DefOrientation;
  $this->wPt = $this->w*$this->k;
  $this->hPt = $this->h*$this->k;
  // Page margins (1 cm)
  $margin = 28.35/$this->k;
  $this->SetMargins($margin,$margin);
  // Interior cell margin (1 mm)
  $this->cMargin = $margin/10;
  // Line width (0.2 mm)
  $this->LineWidth = .567/$this->k;
  // Automatic page break
  $this->SetAutoPageBreak(true,2*$margin);
  // Default display mode
  $this->SetDisplayMode('default');
  // Enable compression
  $this->SetCompression(true);
  // Set default PDF version number
  $this->PDFVersion = '1.3';
end;

destructor TFPDF.Destroy;
begin
  Fbuffer.Free;
  inherited Destroy;
end.

