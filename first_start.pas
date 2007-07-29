unit first_start;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvSpeedButton, JvGradient, ExtCtrls, JvExControls,
  JvButton, JvTransparentButton, jpeg;

type
  TFrm_First = class(TForm)
    lblMessage: TLabel;
    editLogFilePath: TLabeledEdit;
    pnlButtons: TPanel;
    gradButtons: TJvGradient;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    imgTitle: TImage;
    lblTitle: TLabel;
    cbDesktopShortcut: TCheckBox;
    btnClose: TJvTransparentButton;
    btnBrowse: TJvTransparentButton;
    pnlMain: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure _Close(Sender: TObject);
    procedure _MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure btnBrowseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_First: TFrm_First;

implementation
uses functions, globalDefinitions, Math, reg;

{$R *.dfm}

{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                          start
*******************************************************************************}
{*******************************************************************************
  PROCEDURES                                                               start
*******************************************************************************}

procedure TFrm_First._MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
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

procedure TFrm_First.FormCreate(Sender: TObject);
begin
  lblTitle.Caption := Caption;
  lblMessage.Caption := 'Please complete required options.';
  editLogFilePath.Text := defLogFilePath;
end;

procedure TFrm_First.btnOkClick(Sender: TObject);
begin
  if not FileExists(editLogFilePath.Text) then
  begin
    if FileCreate(editLogFilePath.Text) = -1 then
    begin
      ShowMessage('Couldn''t create file!');
      exit;
    end;
  end;

  if cbDesktopShortcut.Checked then
  begin
    if not CreateDesktopShortcut(ParamStr(0),GetDesktopFolder+'\'+progName+'.lnk','',ExtractFilePath(ParamStr(0))) then
    begin
      ShowMessage('Error while creating Desktop Shortcut!');
      exit;
    end;
  end;

  if not reg.setString(defRegKey,'LogFilePath',defLogFilePath) then
  begin
    ShowMessage('Error while writing to registry!');
    exit;
  end;
  ShowMessage('Please restart program');
  Close;
end;

procedure TFrm_First._Close(Sender: TObject);
begin
  Close;
end;

procedure TFrm_First.btnBrowseClick(Sender: TObject);
var
  sd : TSaveDialog;
begin
  sd := TSaveDialog.Create(Self);
  sd.Options := sd.Options + [ofOverwritePrompt] + [ofPathMustExist];
  sd.InitialDir := ExtractFileDir(editLogFilePath.Text);
  sd.FileName := ExtractFileName(editLogFilePath.Text);
  if sd.Execute then
  begin
    editLogFilePath.Text := sd.FileName;
  end;
end;

end.
