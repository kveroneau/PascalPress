unit textfrag;

{$mode ObjFPC}

interface

uses
  SysUtils, Classes, Rtl.HTMLActions, htmlfragment, restapp, webrouter,
  jsondataset, sqldbrestdataset, fragman, DB;

type

  { TTextFragment }

  TTextFragment = class(THTMLFragment)
    actdocument: THTMLElementAction;
    ActionList: THTMLElementActionList;
    acttitle: THTMLElementAction;
    ContentDB: TSQLDBRestDataset;
    procedure ContentDBAfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleRendered(Sender: TObject);
    procedure DataModuleUnrendered(Sender: TObject);
  private
    Procedure TextRoute(URL: String; aRoute: TRoute; Params: TStrings);
  public

  end;

var
  TextFragment: TTextFragment;

implementation

{$R *.lfm}

{ TTextFragment }

procedure TTextFragment.DataModuleRendered(Sender: TObject);
begin
  with RESTFragment.BlogFS do
  begin
    acttitle.Value:=FieldByName('title').AsString;
    actdocument.Value:=FieldByName('summary').AsString;
  end;
  ContentDB.Load;
end;

procedure TTextFragment.DataModuleUnrendered(Sender: TObject);
begin
  WriteLn('I am gone!');
end;

procedure TTextFragment.TextRoute(URL: String; aRoute: TRoute; Params: TStrings
  );
begin
  RESTFragment.BlogFS.Locate('title', 'Home', []);
  HideCurFragment;
  Show;
  CurrentFragment:=Self;
end;

procedure TTextFragment.DataModuleCreate(Sender: TObject);
begin
  Router.RegisterRoute('/Home', @TextRoute);
end;

procedure TTextFragment.ContentDBAfterOpen(DataSet: TDataSet);
begin
  ContentDB.Active:=True;
  ContentDB.Filter:='id='+IntToStr(RESTFragment.BlogFS.FieldByName('objectid').AsInteger);
  ContentDB.Filtered:=True;
  if ContentDB.IsEmpty then
    Exit;
  acttitle.Value:=ContentDB.FieldByName('title').AsString;
  actdocument.Value:=ContentDB.FieldByName('content').AsString;
end;

end.

