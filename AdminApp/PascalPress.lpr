program PascalPress;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, runtimetypeinfocontrols, ExplorerWindow, models, DBLoginWindow,
PropertyDialog, TextEditWindow
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='PascalPress Desktop Publisher';
  Application.Scaled:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TExplorerForm, ExplorerForm);
  Application.CreateForm(TDBModel, DBModel);
  Application.CreateForm(TDBLoginForm, DBLoginForm);
  Application.CreateForm(TPropertyForm, PropertyForm);
  Application.CreateForm(TTextEditorForm, TextEditorForm);
  Application.Run;
end.

