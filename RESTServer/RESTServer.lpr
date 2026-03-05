program RESTServer;

{$mode objfpc}{$H+}

uses
  {$IFDEF FCGI}fpFCGI{$ENDIF}
  {$IFDEF HTTP}fphttpapp{$ENDIF}, restapp;

begin
  Application.Title:='PascalPress REST API Server';
  Application.Port:=3000;
  Application.LegacyRouting:=True;
  Application.Initialize;
  Application.Run;
end.

