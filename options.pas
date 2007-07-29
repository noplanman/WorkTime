unit options;

interface

uses
  Windows, Messages, SysUtils, Forms, Dialogs, StdCtrls, jpeg,
  ExtCtrls, Classes, Controls, ComCtrls, JvExComCtrls, JvComCtrls,
  JvSpeedButton, JvGradient, JvExControls, JvButton, JvTransparentButton,
  Spin;

type
  TFrm_Options = class(TForm)
    lblWt: TLabel;
    cbNotifyWt: TCheckBox;
    seWtHours: TSpinEdit;
    seWtMinutes: TSpinEdit;
    seWtSeconds: TSpinEdit;
    lblWtHours: TLabel;
    lblWtMinutes: TLabel;
    lblWtSeconds: TLabel;
    lblNotifyWtBtMessage: TLabel;
    memoNotifyWtBtMessage: TMemo;
    lblNotifyWtBtMessageCounter: TLabel;
    pnlButtons: TPanel;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    lblHotKeyNoon: TLabel;
    hcNoon: THotKey;
    cbFade: TCheckBox;
    tbFadeSpeed: TTrackBar;
    lblFadeSpeed: TLabel;
    lblFadeSlow: TLabel;
    lblFadeFast: TLabel;
    cbStartMinimized: TCheckBox;
    cbAutoRun: TCheckBox;
    imgTitle: TImage;
    lblTitle: TLabel;
    gradButtons: TJvGradient;
    editNotifyWtBtTitle: TLabeledEdit;
    editLogFilePath: TLabeledEdit;
    btnClose: TJvTransparentButton;
    pcOptions: TJvPageControl;
    tsNotification: TTabSheet;
    tsVarious: TTabSheet;
    btnBrowse: TJvTransparentButton;
    procedure cbNotifyWtClick(Sender: TObject);
    procedure memoNotifyWtBtMessageChange(Sender: TObject);
    procedure cbFadeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure _MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure _Close(Sender: TObject);
    procedure btnBrowseClick(Sender: TObject);
    procedure hcNoonChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Options: TFrm_Options;

implementation
uses globalDefinitions, reg, hotkeymanager, Math, functions;

{$R *.dfm}

{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                          start
*******************************************************************************}
{*******************************************************************************
  PROCEDURES                                                               start
*******************************************************************************}

procedure TFrm_Options._MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Self.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

{*******************************************************************************
  PROCEDURES                                                                 end
*******************************************************************************}
{*******************************************************************************
  FUNCTIONS                                                                start
*******************************************************************************}

{*******************************************************************************
  FUNCTIONS                                                                  end
*******************************************************************************}
{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                            end
*******************************************************************************}

procedure TFrm_Options.FormCreate(Sender: TObject);
begin
  lblTitle.Caption := Caption;
  Top := Screen.WorkAreaHeight - Height;
  Left := Screen.WorkAreaWidth - Width;
  lblNotifyWtBtMessageCounter.Caption :=
    IntToStr(Length(memoNotifyWtBtMessage.Text)) + ' / ' +
    IntToStr(memoNotifyWtBtMessage.MaxLength);
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
  lblNotifyWtBtMessageCounter.Caption :=
    IntToStr(Length(memoNotifyWtBtMessage.Text)) + ' / ' +
    IntToStr(memoNotifyWtBtMessage.MaxLength);
end;

procedure TFrm_Options.cbFadeClick(Sender: TObject);
begin
  tbFadeSpeed.Enabled := cbFade.Checked;
end;

procedure TFrm_Options._Close(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;

procedure TFrm_Options.btnBrowseClick(Sender: TObject);
var
  sd : TSaveDialog;
  fh : Integer;
begin
  sd := TSaveDialog.Create(Self);
  sd.Options := sd.Options + [ofOverwritePrompt] + [ofPathMustExist];
  sd.InitialDir := ExtractFileDir(editLogFilePath.Text);
  sd.FileName := ExtractFileName(editLogFilePath.Text);
  if sd.Execute then
  begin
    fh := FileOpen(sd.FileName,fmOpenReadWrite);
    if fh <> -1 then
    begin
      editLogFilePath.Text := sd.FileName;
    end
    else
    begin
      ShowMessage('Can''t Write File!');
    end;
    FileClose(fh);
  end;
end;

procedure TFrm_Options.hcNoonChange(Sender: TObject);
begin
  if not HotKeyAvailable(hcNoon.HotKey) then
  begin
    ShowMessage('HotKey in use!');
    hcNoon.HotKey := 0;
  end;
end;

end.
