unit restapp;

{$mode ObjFPC}

interface

uses
  SysUtils, Classes, Rtl.HTMLActions, htmlfragment, jsondataset,
  sqldbrestdataset, DB;

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

  public

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
end;

procedure TRESTFragment.BlogFSAfterOpen(DataSet: TDataSet);
begin
  BlogFS.Active:=True;
  actDBTitle.Value:=BlogFS.FieldByName('title').AsString;
end;

procedure TRESTFragment.DataModuleRendered(Sender: TObject);
begin

end;

end.

