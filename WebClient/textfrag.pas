unit textfrag;

{$mode ObjFPC}

interface

uses
  SysUtils, Classes, Rtl.HTMLActions, htmlfragment, restapp, webrouter,
  jsondataset, sqldbrestdataset, fragman, DB, strutils, status404frag;

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
    procedure RenderFolder;
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

procedure TTextFragment.RenderFolder;
var
  html, title, location: string;
begin
  location:=RESTFragment.BlogFS.FieldByName('title').AsString;
  html:='';
  RESTFragment.FilterDir(location);
  with RESTFragment.BlogFS do
  begin
    if IsEmpty then
      Exit;
    First;
    repeat
      if FieldByName('published').AsBoolean then
      begin
        title:=FieldByName('title').AsString;
        html:=html+'<a href="#/Post/'+location+':'+title+'">'+title+'</a><br/>';
      end;
      Next;
    until EOF;
  end;
  actdocument.Element.innerHTML:=html;
end;

procedure TTextFragment.RenderContent;
var
  typ: Integer;
begin
  typ:=RESTFragment.BlogFS.FieldByName('type').AsInteger;
  if typ = 1 then
  begin
    RenderFolder;
    Exit;
  end;
  if not ContentDB.Locate('id', RESTFragment.BlogFS.FieldByName('objectid').AsInteger, []) then
  begin
    actdocument.Value:='No Content to Render.';
    Exit;
  end;
  acttitle.Value:=ContentDB.FieldByName('title').AsString;
  case typ of
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
    Show404;
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

