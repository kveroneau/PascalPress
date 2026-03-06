program PascalPress;

{$mode objfpc}

uses
  BrowserApp, JS, Classes, SysUtils, Web, restapp, webrouter, textfrag, fragman;

type

  { TPascalPressApp }

  TPascalPressApp = class(TBrowserApplication)
  private
    procedure DBReady(Sender: TObject);
  protected
    procedure DoRun; override;
  public
  end;

{ TPascalPressApp }

procedure TPascalPressApp.DBReady(Sender: TObject);
begin
  if Router.RouteFromURL = '' then
    Router.Push('/Home');
end;

procedure TPascalPressApp.DoRun;
begin
  Router.InitHistory(hkHash);
  RESTFragment:=TRESTFragment.Create(Self);
  RESTFragment.OnDBReady:=@DBReady;
  TextFragment:=TTextFragment.Create(Self);
end;

var
  Application : TPascalPressApp;

begin
  Application:=TPascalPressApp.Create(Nil);
  Application.Initialize;
  Application.Run;
end.
