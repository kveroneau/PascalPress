unit DBLoginWindow;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, RTTICtrls,
  models;

type

  { TDBLoginForm }

  TDBLoginForm = class(TForm)
    ConnectBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    TIEdit1: TTIEdit;
    TIEdit2: TTIEdit;
    TIEdit3: TTIEdit;
    TIEdit4: TTIEdit;
    procedure ConnectBtnClick(Sender: TObject);
  private

  public

  end;

var
  DBLoginForm: TDBLoginForm;

implementation

{$R *.lfm}

{ TDBLoginForm }

procedure TDBLoginForm.ConnectBtnClick(Sender: TObject);
begin
  if not DBModel.TryDBConnect then
    Exit;
  ModalResult:=mrOK;
end;

end.

