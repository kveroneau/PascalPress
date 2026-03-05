unit ExplorerWindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ActnList, StdActns, ExtCtrls, PairSplitter;

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
    procedure IconPaneResize(Sender: TObject);
    procedure TreePaneResize(Sender: TObject);
  private

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

end.

