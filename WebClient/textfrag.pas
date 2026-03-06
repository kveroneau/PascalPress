unit textfrag;

{$mode ObjFPC}

interface

uses
  SysUtils, Classes, Rtl.HTMLActions, htmlfragment, restapp, webrouter,
  jsondataset, sqldbrestdataset, fragman, DB, strutils;

type

  { TTextFragment }

  TTextFragment = class(THTMLFragment)
    actadded: THTMLElementAction;
    actdocument: THTMLElementAction;
    ActionList: THTMLElementActionList;
    actsummary: THTMLElementAction;
    acttitle: THTMLElementAction;
    ContentDB: TSQLDBRestDataset;
    procedure ContentDBAfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleRendered(Sender: TObject);
    procedure DataModuleUnrendered(Sender: TObject);
  private
    procedure RenderContent;
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
    actadded.Value:=FieldByName('added').AsString;
    actsummary.Value:=FieldByName('summary').AsString;
  end;
  if not ContentDB.Active then
    ContentDB.Load
  else
    RenderContent;
end;

procedure TTextFragment.DataModuleUnrendered(Sender: TObject);
begin
  WriteLn('I am gone!');
end;

procedure TTextFragment.RenderContent;
begin
  if not ContentDB.Locate('id', RESTFragment.BlogFS.FieldByName('objectid').AsInteger, []) then
  begin
    actdocument.Value:='No Content to Render.';
    Exit;
  end;
  acttitle.Value:=ContentDB.FieldByName('title').AsString;
  case RESTFragment.BlogFS.FieldByName('type').AsInteger of
    0: actdocument.Element.innerHTML:='<pre>'+ContentDB.FieldByName('content').AsString+'</pre>';
    2: actdocument.Element.innerHTML:=ContentDB.FieldByName('content').AsString;
  else
    actdocument.Value:='Cannot Render Content.';
  end;
end;

procedure TTextFragment.TextRoute(URL: String; aRoute: TRoute; Params: TStrings
  );
var
  path, location: string;
begin
  path:=Params.Values['VFSPath'];
  location:=Copy2SymbDel(path,':');
  RESTFragment.FilterDir(location);
  if not RESTFragment.BlogFS.Locate('title', path, []) then
  begin
    { Thinking of creating and showing a 404 HTMLFragment here. }
    HideCurFragment;
    Exit;
  end;
  HideCurFragment;
  Show;
  CurrentFragment:=Self;
end;

procedure TTextFragment.DataModuleCreate(Sender: TObject);
begin
  { Wondering if I should make the path here a constant so it can be easily
    changed to something other than /Post/ }
  Router.RegisterRoute('/Post/:VFSPath', @TextRoute);
end;

procedure TTextFragment.ContentDBAfterOpen(DataSet: TDataSet);
begin
  ContentDB.Active:=True;
  RenderContent;
end;

end.

