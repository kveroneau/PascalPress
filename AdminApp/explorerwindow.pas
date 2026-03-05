unit ExplorerWindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ActnList, StdActns, ExtCtrls, PairSplitter, DBLoginWindow, models, DateUtils;

type

  { TExplorerForm }

  TExplorerForm = class(TForm)
    FileExit: TFileExit;
    FileProperties: TAction;
    FileOpen: TAction;
    FileDelete: TAction;
    ActionList: TActionList;
    IconView: TListView;
    Icons: TImageList;
    MenuBar: TMainMenu;
    FileMenu: TMenuItem;
    DirMenu: TMenuItem;
    HTMLItem: TMenuItem;
    DeleteItem: TMenuItem;
    ExitItem: TMenuItem;
    SaveItem: TMenuItem;
    Splitter: TPairSplitter;
    TreePane: TPairSplitterSide;
    IconPane: TPairSplitterSide;
    PropItem: TMenuItem;
    OpenItem: TMenuItem;
    Separator1: TMenuItem;
    TextItem: TMenuItem;
    NewMenu: TMenuItem;
    StatusBar: TStatusBar;
    VFSTree: TTreeView;
    procedure DirMenuClick(Sender: TObject);
    procedure FileDeleteExecute(Sender: TObject);
    procedure FileOpenExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HTMLItemClick(Sender: TObject);
    procedure IconPaneResize(Sender: TObject);
    procedure SaveItemClick(Sender: TObject);
    procedure TextItemClick(Sender: TObject);
    procedure TreePaneResize(Sender: TObject);
    procedure VFSTreeSelectionChanged(Sender: TObject);
  private
    FCurLocation: string;
    function AddDirectory(aParent: TTreeNode; aDir: string): TTreeNode;
    function GetContentTypeName: string;
    procedure RenderDetails(aDir: string);
    procedure NewFile(aPrompt: string; typ: integer);
  public

  end;

var
  ExplorerForm: TExplorerForm;

implementation

{$R *.lfm}

{ TExplorerForm }

procedure TExplorerForm.FileOpenExecute(Sender: TObject);
begin

end;

procedure TExplorerForm.DirMenuClick(Sender: TObject);
begin
  NewFile('Folder Title:', 1);
  VFSTree.Items.Clear;
  AddDirectory(Nil, 'SiteRoot');
end;

procedure TExplorerForm.FileDeleteExecute(Sender: TObject);
begin
  if not DBModel.BlogFS.Locate('title', IconView.Selected.Caption, []) then
  begin
    ShowMessage('Hmm, odd.');
    Exit;
  end;
  DBModel.BlogFS.Delete;
  RenderDetails(FCurLocation);
end;

procedure TExplorerForm.FormResize(Sender: TObject);
begin
  Splitter.Width:=ClientWidth;
  Splitter.Height:=ClientHeight-StatusBar.Height;
end;

procedure TExplorerForm.FormShow(Sender: TObject);
var
  r: TModalResult;
begin
  r:=DBLoginForm.ShowModal;
  if r <> mrOK then
    Close;
  {$IFDEF DEBUG}
  StatusBar.SimpleText:='Running DEBUG Mode.';
  {$ENDIF}
  if DBModel.BlogFS.IsEmpty then
    DBModel.CreateBasicFS;
  VFSTree.Selected:=AddDirectory(Nil, 'SiteRoot');
end;

procedure TExplorerForm.HTMLItemClick(Sender: TObject);
begin
  NewFile('HTML Document Title:', 2);
end;

procedure TExplorerForm.IconPaneResize(Sender: TObject);
begin
  IconView.Width:=IconPane.ClientWidth;
  IconView.Height:=IconPane.ClientHeight;
end;

procedure TExplorerForm.SaveItemClick(Sender: TObject);
begin
  DBModel.CommitChanges;
  StatusBar.SimpleText:='Database changes committed.';
end;

procedure TExplorerForm.TextItemClick(Sender: TObject);
begin
  NewFile('Title:', 0);
end;

procedure TExplorerForm.TreePaneResize(Sender: TObject);
begin
  VFSTree.Width:=TreePane.ClientWidth;
  VFSTree.Height:=TreePane.ClientHeight;
end;

procedure TExplorerForm.VFSTreeSelectionChanged(Sender: TObject);
begin
  if VFSTree.Selected = Nil then
  begin
    FCurLocation:='';
    NewMenu.Enabled:=False;
    FileOpen.Enabled:=False;
    FileDelete.Enabled:=False;
    FileProperties.Enabled:=False;
    IconView.Clear;
  end
  else
  begin
    FCurLocation:=VFSTree.Selected.Text;
    NewMenu.Enabled:=True;
    FileOpen.Enabled:=True;
    FileDelete.Enabled:=True;
    FileProperties.Enabled:=True;
    RenderDetails(FCurLocation);
  end;
end;

function TExplorerForm.AddDirectory(aParent: TTreeNode; aDir: string
  ): TTreeNode;
var
  root, node: TTreeNode;
  dirList: Array of TTreeNode;
  typ, i: Integer;
begin
  DBModel.FilterDir(aDir);
  if aParent = Nil then
  begin
    root:=VFSTree.Items.Add(Nil, aDir);
    root.ImageIndex:=1;
    root.SelectedIndex:=1;
  end
  else
    root:=aParent;
  SetLength(dirList, 0);
  with DBModel.BlogFS do
  begin
    First;
    if not IsEmpty then
    begin
      repeat
        typ:=FieldValues['type'];
        if typ = 1 then
        begin
          node:=VFSTree.Items.AddChild(root, FieldValues['title']);
          node.ImageIndex:=typ;
          node.SelectedIndex:=typ;
          SetLength(dirList, Length(dirList)+1);
          dirList[Length(dirList)-1]:=node;
        end;
        Next;
      until EOF;
    end;
  end;
  for i:=0 to Length(dirList)-1 do
    AddDirectory(dirList[i], dirList[i].Text);
  SetLength(dirList, 0);
  Result:=root;
end;

function TExplorerForm.GetContentTypeName: string;
begin
  case DBModel.BlogFS.FieldByName('type').AsInteger of
    0: Result:='Text Document';
    1: Result:='Directory';
    2: Result:='HTML Document';
  else
    Result:='Unknown';
  end;
end;

procedure TExplorerForm.RenderDetails(aDir: string);
var
  itm: TListItem;
begin
  IconView.Clear;
  DBModel.FilterDir(aDir);
  with DBModel.BlogFS do
  begin
    First;
    if IsEmpty then
      Exit;
    repeat
      itm:=IconView.Items.Add;
      itm.ImageIndex:=FieldByName('type').AsInteger;
      itm.Caption:=FieldValues['title'];
      itm.SubItems.Add(GetContentTypeName);
      itm.SubItems.Add(FormatDateTime('MM/DD/YYYY', FieldByName('added').AsDateTime));
      Next;
    until EOF;
  end;
end;

procedure TExplorerForm.NewFile(aPrompt: string; typ: integer);
var
  fname, location: string;
begin
  fname:=InputBox('PascalPress', aPrompt, '');
  if fname = '' then
    Exit;
  if VFSTree.Selected.ImageIndex = 1 then
    location:=VFSTree.Selected.Text
  else if VFSTree.Selected.Parent.ImageIndex = 1 then
    location:=VFSTree.Selected.Parent.Text
  else
    location:='SiteRoot';
  DBModel.CreateFile(fname, location, typ, -1);
  if location = VFSTree.Selected.Text then
    RenderDetails(location);
end;

end.

