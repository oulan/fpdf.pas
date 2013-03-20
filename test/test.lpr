program test;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, fpdftest;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

