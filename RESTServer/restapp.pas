unit restapp;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, Classes , HTTPDefs, fpHTTP, sqldbrestmodule, sqldbrestbridge,
  sqldbrestschema, PQConnection, sqldbrestcds, sqldbrestauth, SQLDB, DB;

type

  { TSQLDBRest }

  TSQLDBRest = class(TSQLDBRestModule)
    RestDispatcher: TSQLDBRestDispatcher;
    RESTSchema: TSQLDBRestSchema;
    procedure RestDispatcherLog(Sender: TObject;
      aType: TRestDispatcherLogOption; const aMessage: UTF8String);
    procedure RESTSchemaResources0AllowRecord(aSender: TObject;
      aContext: TBaseRestContext; aDataSet: TDataset; var allowRecord: Boolean);
  private

  public

  end;

var
  SQLDBRest: TSQLDBRest;

implementation

{$R *.lfm}

{ TSQLDBRest }

procedure TSQLDBRest.RestDispatcherLog(Sender: TObject;
  aType: TRestDispatcherLogOption; const aMessage: UTF8String);
begin
  WriteLn(aMessage);
end;

procedure TSQLDBRest.RESTSchemaResources0AllowRecord(aSender: TObject;
  aContext: TBaseRestContext; aDataSet: TDataset; var allowRecord: Boolean);
begin
  if aDataSet.FieldByName('published').AsBoolean then
    allowRecord:=True
  else
    allowRecord:=False;
end;

initialization
  TSQLDBRest.RegisterModule('REST');
end.

