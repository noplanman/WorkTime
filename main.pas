unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, Buttons, Menus, ExtCtrls, AppEvnts, jpeg,
  CoolTrayIcon, TextTrayIcon, ImgList, HotKeyManager, Math;

type 
  TWmMoving = record
    uMsg  : UINT;
    wParam: WPARAM;
    lParam: ^TRect;
    Result: HRESULT;
  end;

const
  IC_CLICK = WM_APP + 201;

type
  TWork_Time = class(TForm)
    lblTime: TLabel;
    btnOptions: TSpeedButton;
    pm: TPopupMenu;
    pmShowHide: TMenuItem;
    pmNoon: TMenuItem;
    counter: TTimer;
    pmExit: TMenuItem;
    btnMinimize: TSpeedButton;
    btnClose: TSpeedButton;
    bg: TImage;
    btnInfo: TSpeedButton;
    trayIcon: TCoolTrayIcon;
    imgList: TImageList;
    hkm: THotKeyManager;
    appEvents: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure btnOptionsClick(Sender: TObject);
    procedure counterTimer(Sender: TObject);
    procedure pmNoonClick(Sender: TObject);
    procedure pmShowHideClick(Sender: TObject);
    procedure pmExitClick(Sender: TObject);
    procedure btnMinimizeClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure bgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lblTimeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btnInfoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure hkmHotKeyPressed(HotKey: Cardinal; Index: Word);
    procedure FormActivate(Sender: TObject);
    procedure trayIconClick(Sender: TObject);
    procedure appEventsException(Sender: TObject; E: Exception);
    procedure trayIconBalloonHintTimeout(Sender: TObject);
    procedure trayIconBalloonHintClick(Sender: TObject);
  protected
  private
    { Private declarations }
  public
    { Public declarations }
    procedure WmMoving(var Message: TWmMoving); message WM_MOVING;
    procedure getOptions;
    procedure StartLog;
    procedure Noon;
  end;

var
  Work_Time: TWork_Time;
  Log : TextFile;

implementation

uses globalDefinitions, reg, options, info;

var
  mHandle:THandle;
  StartedTick,NoonTick:Cardinal; //startedTick:program start,noonTick:noon start
  s,m,h,wh:Double; //seconds, minutes, hours, workinghours
  hotkeyNoon:Cardinal;
  WtOver:Boolean; // check if the set worktime is allready over
  // setting variables
  LogFile:String;
  Wt:Integer;
  NotifyWt:Boolean;
  NotifyWtBtTitle:String;
  NotifyWtBtMessage:String;

{$R *.dfm}

procedure delay(msecs:Cardinal);
var
  FirstTickCount:Cardinal;
begin
  FirstTickCount := GetTickCount;
  repeat
    Application.ProcessMessages; {allowing access to other controls, etc.}
  until ((GetTickCount-FirstTickCount) >= msecs);
end;

procedure TWork_Time.WmMoving(var Message: TWmMoving);
var
  WorkArea: TRect;
begin
  inherited;
  if SystemParametersInfo(SPI_GETWORKAREA, 0, @WorkArea, 0) then
    with Message do
    begin
      if lParam.Right > WorkArea.Right then
        OffsetRect(lParam^, WorkArea.Right - lParam.Right, 0);
      if lParam.Left < WorkArea.Left then
        OffsetRect(lParam^, WorkArea.Left - lParam.Left, 0);
      if lParam.Bottom > WorkArea.Bottom then
        OffsetRect(lParam^, 0, WorkArea.Bottom - lParam.Bottom);
      if lParam.Top < WorkArea.Top then
        OffsetRect(lParam^, 0, WorkArea.Top - lParam.Top);
      Result := HRESULT(True);
    end;
end;

procedure TWork_Time.getOptions;
begin
  LogFile := reg.getString(defRegKey,'LogFile',defLogFile);
  if LogFile = defLogFile then reg.setString(defRegKey,'LogFile',defLogFile);
  Wt := reg.getInteger(defRegKey,'Wt',defWt);
  if Wt = defWt then reg.setInteger(defRegKey,'Wt',defWt);
  NotifyWt := reg.getBoolean(defRegKey,'NotifyWt',defNotifyWt);
  if NotifyWt = defNotifyWt then reg.setBoolean(defRegKey,'NotifyWt',defNotifyWt);
  NotifyWtBtTitle := reg.getString(defRegKey,'NotifyWtBtTitle',defNotifyWtBtTitle);
  if NotifyWtBtTitle = defNotifyWtBtTitle then reg.setString(defRegKey,'NotifyWtBtTitle',defNotifyWtBtTitle);
  NotifyWtBtMessage := reg.getString(defRegKey,'NotifyWtBtMessage',defNotifyWtBtMessage);
  if NotifyWtBtMessage = defNotifyWtBtMessage then reg.setString(defRegKey,'NotifyWtBtMessage',defNotifyWtBtMessage);

  Frm_Options.cbNotifyWt.Checked := NotifyWt;
  Frm_Options.seWtSeconds.Value := Wt mod 60;
  Frm_Options.seWtMinutes.Value := Wt div 60 mod 60;
  Frm_Options.seWtHours.Value   := Wt div 60 div 60;
  Frm_Options.seWtSeconds.Enabled := NotifyWt;
  Frm_Options.seWtMinutes.Enabled := NotifyWt;
  Frm_Options.seWtHours.Enabled := NotifyWt;
  Frm_Options.editNotifyWtBtTitle.Text := NotifyWtBtTitle;
  Frm_Options.editNotifyWtBtMessage.Text := NotifyWtBtMessage;
end;

procedure TWork_Time.Noon;
begin
  Append(Log);
  if pmNoon.Checked then
  begin
    NoonTick := GetTickCount - NoonTick;
    Counter.Enabled := false;
    TrayIcon.IconIndex := 1;
    WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Noon Started');
  end
  else
  begin
    NoonTick := GetTickCount - NoonTick;
    Counter.Enabled := True;
    TrayIcon.IconIndex := 0;
    WriteLn(Log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Noon Finished');
  end;
  CloseFile(Log);
end;

procedure TWork_Time.FormCreate(Sender: TObject);
begin
  NoonTick := 0;
  StartedTick := GetTickCount; // Seconds since computer running

  Work_Time.FormStyle := fsStayOnTop;
  hkm.AddHotKey(hotkeyNoon);
end;

procedure TWork_Time.StartLog;
begin
  AssignFile(Log, LogFile);
  if FileExists(LogFile)
  then Append(Log)
  else ReWrite(Log, LogFile);
  WriteLn(Log, '');
  WriteLn(Log, '__ ' + FormatDateTime('dd.mm.yyyy', Now) + ' ________________');
  WriteLn(Log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Started');
  CloseFile(Log);
end;

procedure TWork_Time.btnOptionsClick(Sender: TObject);
var
  SameFile : Boolean;
begin
  Frm_Options.lblCurrentDir.Caption := LogFile;
  Frm_Options.lblCurrentDir.Hint := LogFile;
  Frm_Options.saveDialog.InitialDir := ExtractFilePath(LogFile);
  if Frm_Options.ShowModal = mrOK then
  begin
    SameFile := (LogFile = Frm_Options.editNewDir.Text) or (Frm_Options.editNewDir.Text = '');
    if not SameFile then
    begin
      if CopyFile(pChar(LogFile),pChar(Frm_options.saveDialog.FileName),False) then
      begin
        DeleteFile(LogFile);
        LogFile := Frm_options.saveDialog.FileName;
        reg.setString(defRegKey,'LogFile',LogFile);
        StartLog;
      end;
    end;
    NotifyWt := Frm_Options.cbNotifyWt.Checked;
    reg.setBoolean(defRegKey,'NotifyWt',NotifyWt);
    Wt := (Frm_Options.seWtHours.Value*60*60) +
          (Frm_Options.seWtMinutes.Value*60) +
          (Frm_Options.seWtSeconds.Value);
    reg.setInteger(defRegKey,'Wt',Wt);
    WtOver := False;

    NotifyWtBtTitle := Frm_Options.editNotifyWtBtTitle.Text;
    reg.setString(defRegKey,'NotifyWtBtTitle',NotifyWtBtTitle);
    NotifyWtBtMessage := Frm_Options.editNotifyWtBtMessage.Text;
    reg.setString(defRegKey,'NotifyWtBtMessage',NotifyWtBtMessage);
  end;
end;

procedure TWork_Time.counterTimer(Sender: TObject);
begin
  s :=  ((GetTickCount - StartedTick - NoonTick) div 1000) mod 60;
  m :=  ((GetTickCount - StartedTick - NoonTick) div (1000*60)) mod 60;
  h :=  ((GetTickCount - StartedTick - NoonTick) div (1000*60*60));
  wh := ((GetTickCount - StartedTick - NoonTick) div (1000*60*6)) / 10;

  TrayIcon.Hint :=
    FloatToStr(wh) + ' Working Hours' + #13 +
    FloatToStr(h) + 'h ' + FloatToStr(m) + 'm ' + FloatToStr(s) + 's';

  lblTime.Caption := FloatToStr(h) + #13 +
                     FloatToStr(m) + #13 +
                     FloatToStr(s);

  if NotifyWt and not WtOver then
    if ((GetTickCount - StartedTick - NoonTick) div 1000) >= Wt then
    begin
      WtOver := True;
      trayIcon.IconIndex := 2;
      trayIcon.ShowBalloonHint(
        NotifyWtBtTitle,
        NotifyWtBtMessage,
        bitInfo,
        10);
    end;
end;

procedure TWork_Time.pmNoonClick(Sender: TObject);
begin
  Noon;
end;

procedure TWork_Time.pmShowHideClick(Sender: TObject);
begin
  if Visible then
  begin
    pmShowHide.Caption := 'Show';
    Hide;
  end
  else
  begin
    pmShowHide.Caption := 'Hide';
    Show;
  end;
end;

procedure TWork_Time.pmExitClick(Sender: TObject);
begin
  Close;
end;

procedure TWork_Time.btnMinimizeClick(Sender: TObject);
begin
  Hide;
end;

procedure TWork_Time.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TWork_Time.bgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Work_Time.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

procedure TWork_Time.lblTimeMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Work_Time.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

procedure TWork_Time.btnInfoClick(Sender: TObject);
begin
  Application.CreateForm(TFrm_info, Frm_info);
  try
    Frm_info.ShowModal;
  finally
    Frm_info.Release;
  end;
end;

procedure TWork_Time.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if FileExists(logFile)
  then Append(log)
  else ReWrite(log, logFile);
  WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Finished');
  WriteLn(log, '------------------------------');
  WriteLn(log, 'Total working hours   : ' + FloatToStr(h));
  WriteLn(log, 'Total working minutes : ' + FloatToStr(m));
  WriteLn(log, 'Total working seconds : ' + FloatToStr(s));
  WriteLn(log, '------------------------------');
  CloseFile(log);
end;

procedure TWork_Time.hkmHotKeyPressed(HotKey: Cardinal; Index: Word);
begin
  if HotKey = hotkeyNoon then pmNoon.Click;
end;

procedure TWork_Time.FormActivate(Sender: TObject);
begin
  WtOver := False;
  Work_Time.getOptions;
  ShowWindow(Application.Handle, SW_HIDE);
  Work_Time.Top := Screen.WorkAreaHeight - Height;
  Work_Time.Left := Screen.WorkAreaWidth - Width;
  StartLog;
end;

procedure TWork_Time.trayIconClick(Sender: TObject);
begin
  if Visible then
  begin
    pmShowHide.Caption := 'Show';
    Hide;
  end
  else
  begin
    pmShowHide.Caption := 'Hide';
    Show;
  end;
end;

procedure TWork_Time.appEventsException(Sender: TObject; E: Exception);
begin
  ShowMessage(e.Message);
end;

procedure TWork_Time.trayIconBalloonHintTimeout(Sender: TObject);
begin
  trayIcon.IconIndex := 0;
end;

procedure TWork_Time.trayIconBalloonHintClick(Sender: TObject);
begin
  trayIcon.IconIndex := 0;
end;

Initialization
  hotkeyNoon := GetHotKey(MOD_CONTROL + MOD_ALT, VK_SPACE);

// Check if WorkTime.exe is already running
  mHandle := CreateMutex(nil,True,'Work_Time');
  if GetLastError = ERROR_ALREADY_EXISTS then begin // Already running
  Halt;
  end;

finalization
if mHandle <> 0 then CloseHandle(mHandle)

end.
