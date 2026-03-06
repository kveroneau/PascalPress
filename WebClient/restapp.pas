unit restapp;

{$mode ObjFPC}

interface

uses
  SysUtils, Classes, Rtl.HTMLActions, htmlfragment, jsondataset,
  sqldbrestdataset, DB, webrouter, fragman;

type

  { TRESTFragment }

  TRESTFragment = class(THTMLFragment)
    actDBTitle: THTMLElementAction;
    ActionList: THTMLElementActionList;
    RESTConnection: TSQLDBRestConnection;
    BlogFS: TSQLDBRestDataset;
    procedure BlogFSAfterOpen(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleRendered(Sender: TObject);
  private
    FDBReady: TNotifyEvent;
    Procedure RESTRoute(URL: String; aRoute: TRoute; Params: TStrings);
  public
    property OnDBReady: TNotifyEvent read FDBReady write FDBReady;
  end;

var
  RESTFragment: TRESTFragment;

implementation

{$R *.lfm}

{ TRESTFragment }

procedure TRESTFragment.DataModuleCreate(Sender: TObject);
begin
  ParentID:='content';
  {RESTConnection.GetResources;}
  BlogFS.Load;
  Router.RegisterRoute('/REST', @RESTRoute);
end;

procedure TRESTFragment.BlogFSAfterOpen(DataSet: TDataSet);
begin
  BlogFS.Active:=True;
  if Assigned(FDBReady) then
    FDBReady(Self);
end;

procedure TRESTFragment.DataModuleRendered(Sender: TObject);
begin
  actDBTitle.Value:=BlogFS.FieldByName('title').AsString;
end;

procedure TRESTFragment.RESTRoute(URL: String; aRoute: TRoute; Params: TStrings
  );
begin
  HideCurFragment;
  Show;
  CurrentFragment:=Self;
end;

end.

