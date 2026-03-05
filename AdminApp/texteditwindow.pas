unit TextEditWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls, DB;

type

  { TTextEditorForm }

  TTextEditorForm = class(TForm)
    SaveBtn: TButton;
    DataSource: TDataSource;
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    Label1: TLabel;
    procedure FormResize(Sender: TObject);
  private

  public

  end;

var
  TextEditorForm: TTextEditorForm;

implementation

{$R *.lfm}

{ TTextEditorForm }

procedure TTextEditorForm.FormResize(Sender: TObject);
begin
  DBMemo1.Height:=ClientHeight-DBEdit1.Height;
  DBMemo1.Width:=ClientWidth;
end;

end.

