unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, Buttons, Menus, ExtCtrls, AppEvnts,
  HotKeyManager, ImgList, CoolTrayIcon, jpeg, JvExControls, JvButton,
  JvTransparentButton;

const
  IC_CLICK = WM_APP + 201;

type
  TFrm_Main = class(TForm)
    lblTime: TLabel;
    pmTNA: TPopupMenu;
    pmShowHide: TMenuItem;
    pmNoon: TMenuItem;
    tmrCounter: TTimer;
    pmExit: TMenuItem;
    imgBg: TImage;
    trayIcon: TCoolTrayIcon;
    imgList: TImageList;
    hkm: THotKeyManager;
    appEvents: TApplicationEvents;
    tmrFade: TTimer;
    btnClose: TJvTransparentButton;
    btnInfo: TJvTransparentButton;
    btnMinimize: TJvTransparentButton;
    btnOptions: TJvTransparentButton;
    procedure btnOptionsClick(Sender: TObject);
    procedure tmrCounterTimer(Sender: TObject);
    procedure pmNoonClick(Sender: TObject);
    procedure pmShowHideClick(Sender: TObject);
    procedure btnMinimizeClick(Sender: TObject);
    procedure btnInfoClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure hkmHotKeyPressed(HotKey: Cardinal; Index: Word);
    procedure FormActivate(Sender: TObject);
    procedure trayIconClick(Sender: TObject);
    procedure appEventsException(Sender: TObject; E: Exception);
    procedure trayIconBalloonHintTimeout(Sender: TObject);
    procedure trayIconBalloonHintClick(Sender: TObject);
    procedure tmrFadeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure trayIconStartup(Sender: TObject; var ShowMainForm: Boolean);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure _MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure _Close(Sender: TObject);
  protected
  private
    { Private declarations }
    procedure Init;
    procedure FadeForm(Action:String);
    procedure getOptions;
    procedure StartLog;
    procedure Noon(IsNoon:Boolean);
  public
    { Public declarations }
  end;

var
  Frm_Main: TFrm_Main;
  Log : TextFile;

implementation

uses globalDefinitions, reg, options, info;

var
  mHandle:THandle;
  StartedTick,NoonTick:Cardinal; //startedTick:program start,noonTick:noon start
  s,m,h,wh:Double; //seconds, minutes, hours, workinghours

  // setting variables
  LogFilePath:String;
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
procedure TFrm_Main.Init;
begin
  NoonTick := 0;
  StartedTick := GetTickCount; // Seconds since computer running
  WtOver := False;
end;

procedure TFrm_Main._MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
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

procedure TFrm_Main.FadeForm(Action:String);
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

procedure TFrm_Main.getOptions;
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
  LogFilePath := reg.getString(defRegKey,'LogFilePath',defLogFilePath);
  if LogFilePath = defLogFilePath then reg.setString(defRegKey,'LogFilePath',defLogFilePath);
  AutoRun := reg.getString(runRegKey,'WorkTime','') <> '';
end;

procedure TFrm_Main.StartLog;
begin
// FILE
  if FileExists(LogFilePath) then
  begin
    AssignFile(Log, LogFilePath);
    Append(Log);
  end
  else
  begin
    LogFilePath := defLogFilePath;
    AssignFile(Log, LogFilePath);
    Rewrite(Log);
  end;
  WriteLn(Log, '');

  WriteLn(Log, '__ ' + FormatDateTime('dd.mm.yyyy', Now) + ' ________________');
  WriteLn(Log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Started');
  CloseFile(Log);
end;

procedure TFrm_Main.Noon(IsNoon:Boolean);
begin
  Append(Log);
  if IsNoon then
  begin
    NoonTick := GetTickCount - NoonTick;
    tmrCounter.Enabled := False;
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
  CloseFile(Log);
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

procedure TFrm_Main.FormCreate(Sender: TObject);
begin
  Top := Screen.WorkAreaHeight - Height;
  Left := Screen.WorkAreaWidth - Width;
end;

procedure TFrm_Main.FormActivate(Sender: TObject);
begin
  SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
  getOptions;

  hkm.AddHotKey(HotKeyNoon);
  StartLog;
  if not StartMinimized then
    if Fade then FadeForm('show') else Show
  else AlphaBlendValue := 0;
end;

procedure TFrm_Main.btnOptionsClick(Sender: TObject);
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
    editLogFilePath.Text := LogFilePath;
    cbAutoRun.Checked := AutoRun;

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
      LogFilePath := editLogFilePath.Text;
      reg.setString(defRegKey,'LogFilePath',LogFilePath);
      AutoRun := cbAutoRun.Checked;
      if AutoRun then reg.setString(runRegKey,progName,ParamStr(0)) else reg.delValue(runRegKey,progName);
    end;
    hkm.AddHotKey(HotKeyNoon);
  end;
end;

procedure TFrm_Main.tmrCounterTimer(Sender: TObject);
begin
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

procedure TFrm_Main.pmNoonClick(Sender: TObject);
begin
  Noon(pmNoon.Checked);
end;

procedure TFrm_Main.pmShowHideClick(Sender: TObject);
begin
  if Fade then FadeForm('auto') else
  if Visible then Hide else Show;
end;

procedure TFrm_Main.btnMinimizeClick(Sender: TObject);
begin
  if Fade then FadeForm('auto') else
    if Visible then Hide else Show;
end;

procedure TFrm_Main._Close(Sender: TObject);
begin
  tmrCounter.Enabled := False;
  if Fade then FadeForm('close') else Close;
end;

procedure TFrm_Main.btnInfoClick(Sender: TObject);
begin
  Application.CreateForm(TFrm_info, Frm_info);
  try
    Frm_info.ShowModal;
  finally
    Frm_info.Release;
  end;
end;

procedure TFrm_Main.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(Log, LogFilePath);
  Append(Log);
  WriteLn(Log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Finished');
  WriteLn(Log, '------------------------------');
  WriteLn(Log, 'Total working hours   : ' + FloatToStr(h));
  WriteLn(Log, 'Total working minutes : ' + FloatToStr(m));
  WriteLn(Log, 'Total working seconds : ' + FloatToStr(s));
  WriteLn(Log, '------------------------------');
  CloseFile(Log);
  hkm.ClearHotKeys;
end;

procedure TFrm_Main.hkmHotKeyPressed(HotKey: Cardinal; Index: Word);
begin
  pmNoon.Checked := not pmNoon.Checked;
  if HotKey = HotKeyNoon then Noon(pmNoon.Checked);
end;

procedure TFrm_Main.trayIconClick(Sender: TObject);
begin
  if Fade then
    FadeForm('auto')
  else if Visible then Hide else Show;
end;

procedure TFrm_Main.appEventsException(Sender: TObject; E: Exception);
begin
  ShowMessage(e.Message);
end;

procedure TFrm_Main.trayIconBalloonHintTimeout(Sender: TObject);
begin
  trayIcon.IconIndex := 0;
end;

procedure TFrm_Main.trayIconBalloonHintClick(Sender: TObject);
begin
  trayIcon.IconIndex := 0;
  if not Visible then Show;
end;

procedure TFrm_Main.tmrFadeTimer(Sender: TObject);
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

procedure TFrm_Main.trayIconStartup(Sender: TObject;
  var ShowMainForm: Boolean);
begin
  ShowMainForm := False;
  Frm_Main.FormActivate(Frm_Main);
end;

procedure TFrm_Main.FormShow(Sender: TObject);
begin
  pmShowHide.Caption := 'Hide';
end;

procedure TFrm_Main.FormHide(Sender: TObject);
begin
  pmShowHide.Caption := 'Show';
end;

Initialization
  Frm_Main.Init;
// Check if WorkTime.exe is already running
  mHandle := CreateMutex(nil,True,'Frm_Main');
  if GetLastError = ERROR_ALREADY_EXISTS then Halt; // Already running

finalization
if mHandle <> 0 then CloseHandle(mHandle)

end.
