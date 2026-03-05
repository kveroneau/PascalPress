unit models;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, PQConnection, SQLDB, Forms, DB;

type

  { TDBModel }

  TDBModel = class(TDataModule)
    DBConnection: TPQConnection;
    BlogFS: TSQLQuery;
    ContentDB: TSQLQuery;
    Transaction: TSQLTransaction;
  private

  public
    function TryDBConnect: boolean;
    procedure CreateFile(title, location: string; typ, oid: integer);
    procedure CreateDirectory(title, location: string);
    procedure CreateBasicFS;
    procedure FilterDir(location: string);
    procedure CommitChanges;
  end;

var
  DBModel: TDBModel;

implementation

{$R *.lfm}

{ TDBModel }

function TDBModel.TryDBConnect: boolean;
begin
  Application.ExceptionDialog:=aedOkMessageBox;
  BlogFS.Active:=True;
  {$IFDEF DEBUG}
  Application.ExceptionDialog:=aedOkCancelDialog;
  {$ENDIF}
  if not BlogFS.Active then
  begin
    { Transaction bug if user tries to auth a second time after a failure. }
    Transaction.EndTransaction;
    DBConnection.Connected:=False;
  end
  else
    BlogFS.FieldByName('id').ProviderFlags:=[pfInKey];
  Result:=BlogFS.Active;
end;

procedure TDBModel.CreateFile(title, location: string; typ, oid: integer);
begin
  with BlogFS do
  begin
    Append;
    FieldValues['title']:=title;
    FieldValues['location']:=location;
    FieldValues['type']:=typ;
    FieldValues['added']:=Now;
    FieldValues['published']:=False;
    if oid > -1 then
      FieldValues['objectid']:=oid;
    Post;
  end;
end;

procedure TDBModel.CreateDirectory(title, location: string);
begin
  CreateFile(title, location, 1, -1);
end;

procedure TDBModel.CreateBasicFS;
begin
  BlogFS.Filtered:=False;
  BlogFS.First;
  if BlogFS.Locate('title', 'SiteRoot', []) then
    Exit;
  CreateDirectory('SiteRoot', '');
  CreateFile('Home', 'SiteRoot', 0, -1);
  BlogFS.ApplyUpdates;
  Transaction.CommitRetaining;
end;

procedure TDBModel.FilterDir(location: string);
begin
  with BlogFS do
  begin
    Filtered:=False;
    Filter:='location='+QuotedStr(location);
    Filtered:=True;
  end;
end;

procedure TDBModel.CommitChanges;
begin
  BlogFS.ApplyUpdates;
  Transaction.CommitRetaining;
end;

end.

