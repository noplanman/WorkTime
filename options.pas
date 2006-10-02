unit options;

interface

uses
  Windows, Messages, SysUtils, Forms, Dialogs, StdCtrls, EButton, Spin,
  ExtCtrls, Classes, Controls;

type
  TFrm_Options = class(TForm)
    gbOptions: TGroupBox;
    lblCurrentDir: TLabel;
    saveDialog: TSaveDialog;
    editNewDir: TEdit;
    lblCurrentDirText: TLabel;
    cbNewDir: TCheckBox;
    btnBrowse: TEButton;
    btnCancel: TEButton;
    btnOk: TEButton;
    gbNotifications: TGroupBox;
    pnlButtons: TPanel;
    lblWt: TLabel;
    cbNotifyWt: TCheckBox;
    seWtHours: TSpinEdit;
    seWtMinutes: TSpinEdit;
    seWtSeconds: TSpinEdit;
    lblWtHours: TLabel;
    lblWtMinutes: TLabel;
    lblWtSeconds: TLabel;
    editNotifyWtBtTitle: TEdit;
    lblNotifyWtBtTitle: TLabel;
    lblNotifyWtBtMessage: TLabel;
    editNotifyWtBtMessage: TMemo;
    lblNotifyWtBtMessageCounter: TLabel;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbNewDirClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbNotifyWtClick(Sender: TObject);
    procedure editNotifyWtBtMessageChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Options: TFrm_Options;

implementation
uses globalDefinitions, reg;

{$R *.dfm}

procedure TFrm_Options.btnOkClick(Sender: TObject);
begin
  Frm_options.ModalResult := mrOK;
end;

procedure TFrm_Options.btnCancelClick(Sender: TObject);
begin
  Frm_options.ModalResult := mrCancel;
end;

procedure TFrm_Options.cbNewDirClick(Sender: TObject);
begin
  editNewDir.Enabled := cbNewDir.Checked;
  btnBrowse.Enabled := cbNewDir.Checked;
end;

procedure TFrm_Options.btnBrowseClick(Sender: TObject);
begin
  if saveDialog.Execute then
  begin
    editNewDir.Text := saveDialog.FileName;
  end;
end;

procedure TFrm_Options.FormActivate(Sender: TObject);
begin
  cbNewDir.Checked := False;
  editNewDir.Text := '';
  btnBrowse.Enabled := False;
end;

procedure TFrm_Options.cbNotifyWtClick(Sender: TObject);
begin
  seWtHours.Enabled := cbNotifyWt.Checked;
  seWtMinutes.Enabled := cbNotifyWt.Checked;
  seWtSeconds.Enabled := cbNotifyWt.Checked;
end;

procedure TFrm_Options.editNotifyWtBtMessageChange(Sender: TObject);
begin
  lblNotifyWtBtMessageCounter.Caption := IntToStr(Length(editNotifyWtBtMessage.Text))+' / 250';
end;

end.
