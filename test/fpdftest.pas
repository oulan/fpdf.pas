unit fpdftest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry,
  FPDF;

type

  TFPDFTest = class(TTestCase)
  protected
    FFPDF: TFPDF;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestHookUp;
  end;

implementation

procedure TFPDFTest.SetUp;
begin
  FFPDF := TFPDF.Create;
end;

procedure TFPDFTest.TearDown;
begin
  FFPDF.Free;
end;

procedure TFPDFTest.TestHookUp;
begin
  Fail('Write your own test');
end;

initialization

  RegisterTest(TFPDFTest);

end.

