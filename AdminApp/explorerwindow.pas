unit ExplorerWindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ActnList, StdActns, ExtCtrls, PairSplitter, DBLoginWindow, models;

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
    procedure FileOpenExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure IconPaneResize(Sender: TObject);
    procedure TreePaneResize(Sender: TObject);
  private
    function AddDirectory(aParent: TTreeNode; aDir: string): TTreeNode;
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
  AddDirectory(Nil, 'SiteRoot');
end;

procedure TExplorerForm.IconPaneResize(Sender: TObject);
begin
  IconView.Width:=IconPane.ClientWidth;
  IconView.Height:=IconPane.ClientHeight;
end;

procedure TExplorerForm.TreePaneResize(Sender: TObject);
begin
  VFSTree.Width:=TreePane.ClientWidth;
  VFSTree.Height:=TreePane.ClientHeight;
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

end.

