unit PropertyDialog;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, DBCtrls, DB,
  models;

type

  { TPropertyForm }

  TPropertyForm = class(TForm)
    CloseBtn: TButton;
    ContentType: TLabel;
    SaveBtn: TButton;
    DataSource: TDataSource;
    DBCheckBox1: TDBCheckBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBMemo1: TDBMemo;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  PropertyForm: TPropertyForm;

implementation

{$R *.lfm}

{ TPropertyForm }

procedure TPropertyForm.FormShow(Sender: TObject);
begin
  ContentType.Caption:=DBModel.GetContentTypeName;
end;

end.

