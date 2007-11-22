unit logmessage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvSpeedButton, JvGradient, ExtCtrls, JvExControls, JvButton,
  JvTransparentButton, StdCtrls, jpeg;

type
  TFrm_LogMessage = class(TForm)
    imgTitle: TImage;
    lblTitle: TLabel;
    btnClose: TJvTransparentButton;
    pnlButtons: TPanel;
    gradButtons: TJvGradient;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    memoLogMessage: TMemo;
    pnlMain: TPanel;
    lblLogMessageCounter: TLabel;
    procedure _Close(Sender: TObject);
    procedure _MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure memoLogMessageChange(Sender: TObject);
    procedure memoLogMessageKeyPress(Sender: TObject; var Key: Char);
    procedure memoLogMessageKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_LogMessage: TFrm_LogMessage;

implementation

{$R *.dfm}

{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                          start
*******************************************************************************}
{*******************************************************************************
  PROCEDURES                                                               start
*******************************************************************************}

procedure TFrm_LogMessage._MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Self.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

procedure TFrm_LogMessage._Close(Sender: TObject);
begin
  Close;
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

procedure TFrm_LogMessage.FormCreate(Sender: TObject);
begin
  lblTitle.Caption := Caption;
  Top := Screen.WorkAreaHeight - Height;
  Left := Screen.WorkAreaWidth - Width;
  lblLogMessageCounter.Caption :=
    IntToStr(Length(memoLogMessage.Text)) + ' / ' +
    IntToStr(memoLogMessage.MaxLength);
end;

procedure TFrm_LogMessage.memoLogMessageChange(Sender: TObject);
begin
  lblLogMessageCounter.Caption :=
    IntToStr(Length(memoLogMessage.Text)) + ' / ' +
    IntToStr(memoLogMessage.MaxLength);
end;

procedure TFrm_LogMessage.memoLogMessageKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_RETURN) then
  begin
    btnOk.Click;
  end;
end;

procedure TFrm_LogMessage.memoLogMessageKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #10 then
    Key := #0;
end;

end.
