program PascalPress;

{$mode objfpc}

uses
  BrowserApp, JS, Classes, SysUtils, Web, restapp;

type
  TMyApplication = class(TBrowserApplication)
  protected
    procedure DoRun; override;
  public
  end;

procedure TMyApplication.DoRun;
begin
  RESTFragment:=TRESTFragment.Create(Self);
  RESTFragment.Show;
end;

var
  Application : TMyApplication;

begin
  Application:=TMyApplication.Create(nil);
  Application.Initialize;
  Application.Run;
end.
