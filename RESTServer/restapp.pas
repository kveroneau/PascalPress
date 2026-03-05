unit restapp;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, Classes , HTTPDefs, fpHTTP, sqldbrestmodule, sqldbrestbridge,
  sqldbrestschema, PQConnection, sqldbrestcds;

type

  { TSQLDBRest }

  TSQLDBRest = class(TSQLDBRestModule)
    RestDispatcher: TSQLDBRestDispatcher;
    RESTSchema: TSQLDBRestSchema;
  private

  public

  end;

var
  SQLDBRest: TSQLDBRest;

implementation

{$R *.lfm}

{ TSQLDBRest }


initialization
  TSQLDBRest.RegisterModule('REST');
end.

