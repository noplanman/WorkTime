unit options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, Buttons;

type
  TFrm_options = class(TForm)
    gb_options: TGroupBox;
    lbl_directory: TLabel;
    dlb: TDirectoryListBox;
    dcb: TDriveComboBox;
    btn_ok: TSpeedButton;
    btn_cancel: TSpeedButton;
    procedure btn_okClick(Sender: TObject);
    procedure dlbChange(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_options: TFrm_options;

implementation

{$R *.dfm}

procedure TFrm_options.btn_okClick(Sender: TObject);
begin
  Frm_options.ModalResult := mrOK;
end;

procedure TFrm_options.dlbChange(Sender: TObject);
begin
  lbl_directory.Caption := dlb.Directory;
end;

procedure TFrm_options.btn_cancelClick(Sender: TObject);
begin
  Frm_options.ModalResult := mrCancel;
end;

end.
