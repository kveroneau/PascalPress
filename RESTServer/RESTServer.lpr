program RESTServer;

{$mode objfpc}{$H+}

uses
  {$IFDEF FCGI}custfcgi{$ENDIF}
  {$IFDEF HTTP}fphttpapp{$ENDIF}, restapp, eventlog;

type
{$IFDEF FCGI}

  { TRESTServer }

  TRESTServer = class(TCustomFCGIApplication)
  protected
    function CreateEventLog: TEventLog; override;
  end;

{ TRESTServer }

function TRESTServer.CreateEventLog: TEventLog;
begin
  Result:=TEventLog.Create(Self);
  with Result do
  begin
    Name:=Self.Name+'Logger';
    Identification:=Title;
    LogType:=ltStdOut;
    Active:=True;
  end;
end;

var
  Application: TRESTServer;
{$ENDIF}
begin
  {$IFDEF FCGI}
  Application:=TRESTServer.Create(Nil);
  {$ENDIF}
  Application.Title:='PascalPress REST API Server';
  Application.Port:=3000;
  Application.LegacyRouting:=True;
  Application.Initialize;
  Application.Run;
  {$IFDEF FCGI}
  Application.Free;
  {$ENDIF}
end.

