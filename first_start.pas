unit first_start;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvSpeedButton, JvExControls, JvComponent, JvGradient,
  ExtCtrls, jpeg, Buttons, mysql;

type
  TFrm_First = class(TForm)
    lblMessage: TLabel;
    editFilename: TLabeledEdit;
    pnlButtons: TPanel;
    gradButtons: TJvGradient;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    btnClose: TJvSpeedButton;
    imgTitle: TImage;
    lblTitle: TLabel;
    btnBrowse: TSpeedButton;
    cbDesktopShortcut: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure CloseClick(Sender: TObject);
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
uses
  functions, globalDefinitions, Math, reg;

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
  editFilename.Text := defLogFilePath;
end;

procedure TFrm_First.btnOkClick(Sender: TObject);
begin
  if FileExists(editFilename.Text) then
  begin
    if cbDesktopShortcut.Checked then
    begin
      CreateDesktopShortcut(ParamStr(0),GetDesktopFolder+'\WorkTime.lnk','',ExtractFilePath(ParamStr(0)));
    end;

    if reg.setString(defRegKey,'LogFilePath',defLogFilePath) then
    begin
      ShowMessage('Registry values successfully written!');
      ForceKillApplication(True);
    end  
    else
    begin
      ShowMessage('Error while writing to registry!');
    end;
  end
  else
  begin
    ShowMessage('File doesn''t exist!');
  end;
end;

procedure TFrm_First.CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrm_First.btnBrowseClick(Sender: TObject);
var
  sd : TSaveDialog;
begin
  sd := TSaveDialog.Create(Self);
  if sd.Execute then
  begin
    editFilename.Text := sd.FileName;
  end;
end;

end.
