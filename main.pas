unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, Buttons, Menus, ExtCtrls, AppEvnts,
  ImgList, HotKeyManager, CoolTrayIcon, DB, DBClient, jpeg,
  JvComponentBase, JvgLanguageLoader, Provider;

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
    pmTNA: TPopupMenu;
    pmShowHide: TMenuItem;
    pmNoon: TMenuItem;
    tmrCounter: TTimer;
    pmExit: TMenuItem;
    btnMinimize: TSpeedButton;
    btnClose: TSpeedButton;
    imgBg: TImage;
    btnInfo: TSpeedButton;
    trayIcon: TCoolTrayIcon;
    imgList: TImageList;
    hkm: THotKeyManager;
    appEvents: TApplicationEvents;
    btnChangeActivity: TSpeedButton;
    tmrFade: TTimer;
    procedure btnOptionsClick(Sender: TObject);
    procedure tmrCounterTimer(Sender: TObject);
    procedure pmNoonClick(Sender: TObject);
    procedure pmShowHideClick(Sender: TObject);
    procedure pmExitClick(Sender: TObject);
    procedure btnMinimizeClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure hkmHotKeyPressed(HotKey: Cardinal; Index: Word);
    procedure FormActivate(Sender: TObject);
    procedure trayIconClick(Sender: TObject);
    procedure appEventsException(Sender: TObject; E: Exception);
    procedure trayIconBalloonHintTimeout(Sender: TObject);
    procedure trayIconBalloonHintClick(Sender: TObject);
    procedure btnChangeActivityClick(Sender: TObject);
    procedure tmrFadeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure trayIconStartup(Sender: TObject; var ShowMainForm: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure _MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  protected
  private
    { Private declarations }
    procedure Init;
    procedure FadeForm(Action:String);
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

uses globalDefinitions, reg, options, info, activity, projects,mysql;

var
  mHandle:THandle;
  StartedTick,NoonTick:Cardinal; //startedTick:program start,noonTick:noon start
  s,m,h,wh:Double; //seconds, minutes, hours, workinghours

  // setting variables
  LogFile:String;
  Wt:Integer;
  WtOver:Boolean; // check if the set worktime is allready over
  NotifyWt:Boolean;
  NotifyWtBtTitle:String;
  NotifyWtBtMessage:String;
  HotKeyNoon:Cardinal;
  Fade:Boolean;
  FadeSpeed:Integer;
  StartMinimized:Boolean;
  AutoRun:Boolean;

//  DBConn:TMYSQL;
  DBHost:String;
  DBPort:Integer;
  DBUser:String;
  DBPass:String;
  DBDatabase:String;

  // various variables
  FadeAction:String; // show, hide or close with fade effect

{$R *.dfm}

{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                          start
*******************************************************************************}
{*******************************************************************************
  PROCEDURES                                                               start
*******************************************************************************}

// initialize all variables needed at startup
procedure TWork_Time.Init;
begin
  NoonTick := 0;
  StartedTick := GetTickCount; // Seconds since computer running
  WtOver := False;
{  DBConn.host := pAnsiChar(DBHost);
  DBConn.port := DBPort;
  DBConn.user := pAnsiChar(DBUser);
  DBConn.passwd := pAnsiChar(DBPass);
  DBConn.db := pAnsiChar(DBDatabase);}
end;

procedure TWork_Time._MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Self.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

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
  WorkArea:TRect;
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


procedure TWork_Time.FadeForm(Action:String);
begin
  FadeAction := LowerCase(Action);
  if FadeAction = 'auto' then
    if Visible then FadeAction := 'hide' else FadeAction := 'show';

  if FadeAction = 'show' then
    AlphaBlendValue := 0
  else
  if FadeAction = 'hide' then
    AlphaBlendValue := 255;
  tmrFade.Enabled := True;
end;

procedure TWork_Time.getOptions;
begin
  Wt := reg.getInteger(defRegKey,'Wt',defWt);
  if Wt = defWt then reg.setInteger(defRegKey,'Wt',defWt);
  NotifyWt := reg.getBoolean(defRegKey,'NotifyWt',defNotifyWt);
  if NotifyWt = defNotifyWt then reg.setBoolean(defRegKey,'NotifyWt',defNotifyWt);
  NotifyWtBtTitle := reg.getString(defRegKey,'NotifyWtBtTitle',defNotifyWtBtTitle);
  if NotifyWtBtTitle = defNotifyWtBtTitle then reg.setString(defRegKey,'NotifyWtBtTitle',defNotifyWtBtTitle);
  NotifyWtBtMessage := reg.getString(defRegKey,'NotifyWtBtMessage',defNotifyWtBtMessage);
  if NotifyWtBtMessage = defNotifyWtBtMessage then reg.setString(defRegKey,'NotifyWtBtMessage',defNotifyWtBtMessage);
  HotKeyNoon := reg.getInteger(defRegKey,'HotKeyNoon',defHotKeyNoon);
  if HotKeyNoon = defHotKeyNoon then reg.setInteger(defRegKey,'HotKeyNoon',defHotKeyNoon);
  Fade := reg.getBoolean(defRegKey,'Fade',defFade);
  if Fade = defFade then reg.setBoolean(defRegKey,'Fade',defFade);
  FadeSpeed := reg.getInteger(defRegKey,'FadeSpeed',defFadeSpeed);
  if FadeSpeed = defFadeSpeed then reg.setInteger(defRegKey,'FadeSpeed',defFadeSpeed);
  StartMinimized := reg.getBoolean(defRegKey,'StartMinimized',defStartMinimized);
  if StartMinimized = defStartMinimized then reg.setBoolean(defRegKey,'StartMinimized',defStartMinimized);
  AutoRun := reg.getString(runRegKey,'WorkTime','') <> '';

// Database
  DBHost := reg.getString(defRegKey,'DBHost',defDBHost);
  if DBHost = defDBHost then reg.setString(defRegKey,'DBHost',defDBHost);
  DBUser := reg.getString(defRegKey,'DBUser',defDBUser);
  if DBUser = defDBUser then reg.setString(defRegKey,'DBUser',defDBUser);
  DBPass := reg.getString(defRegKey,'DBPass','');
  if DBPass = defDBPass then reg.setString(defRegKey,'DBPass',defDBPass);
  DBDatabase := reg.getString(defRegKey,'DBDatabase','');
  if DBDatabase = defDBDatabase then reg.setString(defRegKey,'DBDatabase',defDBDatabase);
  DBPort := reg.getInteger(defRegKey,'DBPort',defDBPort);
  if DBPort = defDBPort then reg.setInteger(defRegKey,'DBPort',defDBPort);
end;

procedure TWork_Time.StartLog;
begin
// FILE
  if FileExists(LogFile) then
  begin
    AssignFile(Log, LogFile);
    Append(Log);
  end
  else
  begin
{    LogFile := defLogFile;
    AssignFile(Log, LogFile);
    Rewrite(Log);
    reg.setString(defRegKey,'LogFile',LogFile);}
  end;
{  WriteLn(Log, '');
  WriteLn(Log, '__ ' + FormatDateTime('dd.mm.yyyy', Now) + ' ________________');
  WriteLn(Log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Started');
  CloseFile(Log);}
end;

procedure TWork_Time.Noon;
begin
{  Append(Log);
  if pmNoon.Checked then
  begin
    NoonTick := GetTickCount - NoonTick;
    tmrCounter.Enabled := false;
    TrayIcon.IconIndex := 1;
    WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Noon Started');
  end
  else
  begin
    NoonTick := GetTickCount - NoonTick;
    tmrCounter.Enabled := True;
    TrayIcon.IconIndex := 0;
    WriteLn(Log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Noon Finished');
  end;
  CloseFile(Log);}
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

procedure TWork_Time.FormCreate(Sender: TObject);
begin
  Top := Screen.WorkAreaHeight - Height;
  Left := Screen.WorkAreaWidth - Width;
end;

procedure TWork_Time.FormActivate(Sender: TObject);
begin
  SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
  getOptions;

  hkm.AddHotKey(HotKeyNoon);
  StartLog;
  if not StartMinimized then
    if Fade then FadeForm('show') else Show
  else AlphaBlendValue := 0;
end;

procedure TWork_Time.btnOptionsClick(Sender: TObject);
begin
  hkm.RemoveHotKey(HotKeyNoon);
  with Frm_Options do
  begin
    cbNotifyWt.Checked := NotifyWt;
    seWtSeconds.Value := Wt mod 60;
    seWtMinutes.Value := Wt div 60 mod 60;
    seWtHours.Value   := Wt div 60 div 60;
    seWtSeconds.Enabled := NotifyWt;
    seWtMinutes.Enabled := NotifyWt;
    seWtHours.Enabled := NotifyWt;
    editNotifyWtBtTitle.Text := NotifyWtBtTitle;
    editNotifyWtBtTitle.Enabled := NotifyWt;
    memoNotifyWtBtMessage.Text := NotifyWtBtMessage;
    memoNotifyWtBtMessage.Enabled := NotifyWt;
    hcNoon.HotKey := HotKeyNoon;
    cbFade.Checked := Fade;
    tbFadeSpeed.Enabled := Fade;
    tbFadeSpeed.Position := FadeSpeed;
    cbStartMinimized.Checked := StartMinimized;
    cbAutoRun.Checked := AutoRun;

    //Database
    editDBHost.Text := DBHost;
    editDBPort.Text := IntToStr(DBPort);
    editDBUser.Text := DBUser;
    editDBPass.Text := DBPass;
    editDBDatabase.Text := DBDatabase;

    if Frm_Options.ShowModal = mrOK then
    begin
      NotifyWt := cbNotifyWt.Checked;
      reg.setBoolean(defRegKey,'NotifyWt',NotifyWt);
      if NotifyWt then
      begin
        Wt := (seWtHours.Value*60*60) +
              (seWtMinutes.Value*60) +
              (seWtSeconds.Value);
        reg.setInteger(defRegKey,'Wt',Wt);
        WtOver := False;

        NotifyWtBtTitle := editNotifyWtBtTitle.Text;
        reg.setString(defRegKey,'NotifyWtBtTitle',NotifyWtBtTitle);
        NotifyWtBtMessage := memoNotifyWtBtMessage.Text;
        reg.setString(defRegKey,'NotifyWtBtMessage',NotifyWtBtMessage);
      end;

      HotKeyNoon := hcNoon.HotKey;
      reg.setInteger(defRegKey,'HotKeyNoon',HotKeyNoon);
      Fade := cbFade.Checked;
      reg.setBoolean(defRegKey,'Fade',Fade);
      FadeSpeed := tbFadeSpeed.Position;
      reg.setInteger(defRegKey,'FadeSpeed',FadeSpeed);
      StartMinimized := cbStartMinimized.Checked;
      reg.setBoolean(defRegKey,'StartMinimized',StartMinimized);
      AutoRun := cbAutoRun.Checked;
      if AutoRun then reg.setString(runRegKey,progName,ParamStr(0)) else reg.delValue(runRegKey,progName);

      //Database
      DBHost := editDBHost.Text;
      reg.setString(defRegKey,'DBHost',DBHost);
      DBPort := StrToInt(editDBPort.Text);
      reg.setInteger(defRegKey,'DBPort',DBPort);
      DBUser := editDBUser.Text;
      reg.setString(defRegKey,'DBUser',DBUser);
      DBPass := editDBPass.Text;
      reg.setString(defRegKey,'DBPass',DBPass);
      DBDatabase := editDBDatabase.Text;
      reg.setString(defRegKey,'DBDatabase',DBDatabase);
    end;
    hkm.AddHotKey(HotKeyNoon);
  end;
end;

procedure TWork_Time.tmrCounterTimer(Sender: TObject);
begin
  if ((GetTickCount - StartedTick - NoonTick) > (1000 * 60 * 60 * 24)) then
  begin
    tmrCounter.Enabled := False;
    hkm.RemoveHotKey(HotKeyNoon);
    pmNoon.Enabled := False;
    ShowMessage('Max. Working Time in 1 day! Restart Program!');
    Exit;
  end;

  s :=  ((GetTickCount - StartedTick - NoonTick) div 1000) mod 60;
  m :=  ((GetTickCount - StartedTick - NoonTick) div (1000*60)) mod 60;
  h :=  ((GetTickCount - StartedTick - NoonTick) div (1000*60*60));
  wh := ((GetTickCount - StartedTick - NoonTick) div (1000*60*6)) / 10;

  TrayIcon.Hint :=
    FloatToStr(wh) + ' Working Hours' + #13 +
    FloatToStr(h) + 'h ' + FloatToStr(m) + 'm ' + FloatToStr(s) + 's';

  lblTime.Caption := FloatToStr(wh) + #13 +
                     FloatToStr(m) + #13 +
                     FloatToStr(s);

  if NotifyWt and not WtOver then
  begin
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
end;

procedure TWork_Time.pmNoonClick(Sender: TObject);
begin
  Noon;
end;

procedure TWork_Time.pmShowHideClick(Sender: TObject);
begin
  if Fade then FadeForm('auto') else
  if Visible then Hide else Show;
end;

procedure TWork_Time.btnMinimizeClick(Sender: TObject);
begin
  if Fade then FadeForm('auto') else
    if Visible then Hide else Show;
end;

procedure TWork_Time.pmExitClick(Sender: TObject);
begin
  if Fade then FadeForm('close') else Close;
end;

procedure TWork_Time.btnCloseClick(Sender: TObject);
begin
  if Fade then FadeForm('close') else Close;
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
{  AssignFile(Log, LogFile);
  Append(Log);
  WriteLn(Log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Finished');
  WriteLn(Log, '------------------------------');
  WriteLn(Log, 'Total working hours   : ' + FloatToStr(h));
  WriteLn(Log, 'Total working minutes : ' + FloatToStr(m));
  WriteLn(Log, 'Total working seconds : ' + FloatToStr(s));
  WriteLn(Log, '------------------------------');
  CloseFile(Log);}
  hkm.ClearHotKeys;
end;

procedure TWork_Time.hkmHotKeyPressed(HotKey: Cardinal; Index: Word);
begin
  if HotKey = HotKeyNoon then Noon;
end;

procedure TWork_Time.trayIconClick(Sender: TObject);
begin
  if Fade then
    FadeForm('auto')
  else if Visible then Hide else Show;
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
  if not Visible then Show;
end;

procedure TWork_Time.btnChangeActivityClick(Sender: TObject);
begin
  Frm_Activity.ShowModal;
end;

procedure TWork_Time.tmrFadeTimer(Sender: TObject);
begin
  AlphaBlend := True;
  if FadeAction = 'show' then
  begin
    if not Visible then Show;
    if AlphaBlendValue <= 255 - FadeSpeed then
      AlphaBlendValue := AlphaBlendValue + FadeSpeed
    else
    begin
      AlphaBlend := False;
      tmrFade.Enabled := False;
    end;
  end
  else
  if FadeAction = 'hide' then
  begin
    if AlphaBlendValue >= FadeSpeed then
      AlphaBlendValue := AlphaBlendValue - FadeSpeed
    else
    begin
      Hide;
      AlphaBlend := False;
      tmrFade.Enabled := False;
    end;
  end
  else
  if FadeAction = 'close' then
  begin
    if AlphaBlendValue >= FadeSpeed then
      AlphaBlendValue := AlphaBlendValue - FadeSpeed
    else
    begin
      Close;
    end;
  end;
end;

procedure TWork_Time.trayIconStartup(Sender: TObject;
  var ShowMainForm: Boolean);
begin
  ShowMainForm := False;
  Work_Time.FormActivate(Work_Time);
end;

procedure TWork_Time.FormShow(Sender: TObject);
begin
  pmShowHide.Caption := 'Hide';
end;

procedure TWork_Time.FormHide(Sender: TObject);
begin
  pmShowHide.Caption := 'Show';
end;

Initialization
  Work_Time.Init;
// Check if WorkTime.exe is already running
  mHandle := CreateMutex(nil,True,'Work_Time');
  if GetLastError = ERROR_ALREADY_EXISTS then Halt; // Already running

finalization
if mHandle <> 0 then CloseHandle(mHandle)

end.
