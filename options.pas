unit options;

interface

uses
  Windows, Messages, SysUtils, Forms, Dialogs, StdCtrls, EButton, Spin,
  ExtCtrls, Classes, Controls, ComCtrls, JvSpeedButton, JvExControls,
  JvComponent, JvGradient, jpeg, Buttons;

type
  TFrm_Options = class(TForm)
    gbLogFile: TGroupBox;
    lblCurrentDir: TLabel;
    saveDialog: TSaveDialog;
    editNewDir: TEdit;
    lblCurrentDirText: TLabel;
    cbNewDir: TCheckBox;
    gbNotifications: TGroupBox;
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
    memoNotifyWtBtMessage: TMemo;
    lblNotifyWtBtMessageCounter: TLabel;
    gradButtons: TJvGradient;
    pnlButtons: TPanel;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    lblHotKeyNoon: TLabel;
    hcNoon: THotKey;
    imgTitleBar: TImage;
    btnClose: TJvSpeedButton;
    btnBrowse: TSpeedButton;
    gbVarious: TGroupBox;
    cbFade: TCheckBox;
    tbFadeSpeed: TTrackBar;
    lblFadeSpeed: TLabel;
    lblFadeSlow: TLabel;
    lblFadeFast: TLabel;
    cbStartMinimized: TCheckBox;
    cbAutoRun: TCheckBox;
    procedure cbNewDirClick(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cbNotifyWtClick(Sender: TObject);
    procedure memoNotifyWtBtMessageChange(Sender: TObject);
    procedure imgTitleBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cbFadeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Options: TFrm_Options;

implementation
uses globalDefinitions, reg, Math;

{$R *.dfm}

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
  editNotifyWtBtTitle.Enabled := cbNotifyWt.Checked;
  memoNotifyWtBtMessage.Enabled := cbNotifyWt.Checked;
end;

procedure TFrm_Options.memoNotifyWtBtMessageChange(Sender: TObject);
begin
  lblNotifyWtBtMessageCounter.Caption := IntToStr(Length(memoNotifyWtBtMessage.Text))+' / 250';
end;

procedure TFrm_Options.imgTitleBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Frm_Options.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

procedure TFrm_Options.cbFadeClick(Sender: TObject);
begin
  tbFadeSpeed.Enabled := cbFade.Checked;
end;

end.
