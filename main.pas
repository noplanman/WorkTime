unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, Buttons, Menus, ExtCtrls, AppEvnts,
  ImgList, HotKeyManager, CoolTrayIcon, DB, DBClient, jpeg,
  JvComponentBase, JvgLanguageLoader;

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
    cdsWorkTime: TClientDataSet;
    cdsActivityList: TClientDataSet;
    cdsActivity: TClientDataSet;
    cdsWorkTimeactivitylist_id: TIntegerField;
    cdsWorkTimeworkstart: TDateTimeField;
    cdsWorkTimeworkend: TDateTimeField;
    cdsWorkTimenoonstart: TDateTimeField;
    cdsWorkTimenoonend: TDateTimeField;
    cdsActivityListworktime_id: TIntegerField;
    cdsActivityListactivity_id: TIntegerField;
    cdsActivityproject_id: TIntegerField;
    cdsActivityactivity: TMemoField;
    btnChangeActivity: TSpeedButton;
    dsProjects: TDataSource;
    cdsProjects: TClientDataSet;
    cdsProjectsid: TAutoIncField;
    cdsProjectsproject: TStringField;
    cdsActivityid: TAutoIncField;
    cdsActivityListid: TAutoIncField;
    cdsWorkTimeid: TAutoIncField;
    tmrFade: TTimer;
    procedure btnOptionsClick(Sender: TObject);
    procedure tmrCounterTimer(Sender: TObject);
    procedure pmNoonClick(Sender: TObject);
    procedure pmShowHideClick(Sender: TObject);
    procedure pmExitClick(Sender: TObject);
    procedure btnMinimizeClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure imgBgMouseMove(Sender: TObject; Shift: TShiftState; X,
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
    procedure btnChangeActivityClick(Sender: TObject);
    procedure tmrFadeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
  private
    { Private declarations }
    procedure Init;
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

uses globalDefinitions, reg, options, info, activity;

var
  mHandle:THandle;
  StartedTick,NoonTick:Cardinal; //startedTick:program start,noonTick:noon start
  s,m,h,wh:Double; //seconds, minutes, hours, workinghours
  HotKeyNoon:Cardinal;
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

// initialize all variables needed at startup
procedure TWork_Time.Init;
begin
  NoonTick := 0;
  StartedTick := GetTickCount; // Seconds since computer running
  WtOver := False;
end;

procedure TWork_Time.FormCreate(Sender: TObject);
begin
  Work_Time.Top := Screen.WorkAreaHeight - Height;
  Work_Time.Left := Screen.WorkAreaWidth - Width;
end;

procedure TWork_Time.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
  Work_Time.getOptions;
  hkm.AddHotKey(HotKeyNoon);
  StartLog;
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
  HotKeyNoon := reg.getInteger(defRegKey,'HotKeyNoon',defHotKeyNoon);
  if HotKeyNoon = defHotKeyNoon then reg.setInteger(defRegKey,'HotKeyNoon',defHotKeyNoon);
end;

procedure TWork_Time.Noon;
begin
  Append(Log);
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
  CloseFile(Log);
end;

procedure TWork_Time.StartLog;
begin
// DB
  if(not DirectoryExists(dbDataDir)) then CreateDir(dbDataDir);
  if(FileExists(dbDataDir + 'WorkTime.cds')) then
    cdsWorkTime.LoadFromFile(dbDataDir+'WorkTime.cds')
  else
    cdsWorkTime.SaveToFile(dbDataDir+'WorkTime.cds',dfBinary);
  if(FileExists(dbDataDir + 'Activity.cds')) then
    cdsActivity.LoadFromFile(dbDataDir+'Activity.cds')
  else
    cdsActivity.SaveToFile(dbDataDir+'Activity.cds',dfBinary);
  if(FileExists(dbDataDir + 'ActivityList.cds')) then
    cdsActivityList.LoadFromFile(dbDataDir+'ActivityList.cds')
  else
    cdsActivityList.SaveToFile(dbDataDir+'ActivityList.cds',dfBinary);
  if(FileExists(dbDataDir + 'Projects.cds')) then
    cdsProjects.LoadFromFile(dbDataDir+'Projects.cds')
  else
    cdsProjects.SaveToFile(dbDataDir+'Projects.cds',dfBinary);

// FILE
  if FileExists(LogFile) then
  begin
    AssignFile(Log, LogFile);
    Append(Log);
  end
  else
  begin
    LogFile := defLogFile;
    AssignFile(Log, LogFile);
    Rewrite(Log);
    reg.setString(defRegKey,'LogFile',LogFile);
  end;
  WriteLn(Log, '');
  WriteLn(Log, '__ ' + FormatDateTime('dd.mm.yyyy', Now) + ' ________________');
  WriteLn(Log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Started');
  CloseFile(Log);
end;

procedure TWork_Time.btnOptionsClick(Sender: TObject);
var
  SameFile:Boolean;
begin
  hkm.RemoveHotKey(HotKeyNoon);
  Application.CreateForm(TFrm_Options, Frm_Options);
  try
    with Frm_Options do
    begin
      lblCurrentDir.Caption := LogFile;
      lblCurrentDir.Hint := LogFile;
      saveDialog.InitialDir := ExtractFilePath(LogFile);
      cbNotifyWt.Checked := NotifyWt;
      seWtSeconds.Value := Wt mod 60;
      seWtMinutes.Value := Wt div 60 mod 60;
      seWtHours.Value   := Wt div 60 div 60;
      seWtSeconds.Enabled := NotifyWt;
      seWtMinutes.Enabled := NotifyWt;
      seWtHours.Enabled := NotifyWt;
      editNotifyWtBtTitle.Text := NotifyWtBtTitle;
      memoNotifyWtBtMessage.Text := NotifyWtBtMessage;
      hcNoon.HotKey := HotKeyNoon;
      if Frm_Options.ShowModal = mrOK then
      begin
        if cbNewDir.Checked then
        begin
          SameFile := (LogFile = editNewDir.Text) or (editNewDir.Text = '');
          if not SameFile then
          begin
            if CopyFile(pChar(LogFile),pChar(saveDialog.FileName),False) then
            begin
              DeleteFile(LogFile);
              LogFile := saveDialog.FileName;
              reg.setString(defRegKey,'LogFile',LogFile);
              StartLog;
            end;
          end;
        end;
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
      end;
      hkm.AddHotKey(HotKeyNoon);
    end;
  finally
    Frm_Options.Release;
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
  tmrFade.Enabled := True;
end;

procedure TWork_Time.btnMinimizeClick(Sender: TObject);
begin
  tmrFade.Enabled := True;
end;

procedure TWork_Time.pmExitClick(Sender: TObject);
begin
  Close;
end;

procedure TWork_Time.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TWork_Time.imgBgMouseMove(Sender: TObject; Shift: TShiftState; X,
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
  AssignFile(Log, LogFile);
  Append(Log);
  WriteLn(Log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Finished');
  WriteLn(Log, '------------------------------');
  WriteLn(Log, 'Total working hours   : ' + FloatToStr(h));
  WriteLn(Log, 'Total working minutes : ' + FloatToStr(m));
  WriteLn(Log, 'Total working seconds : ' + FloatToStr(s));
  WriteLn(Log, '------------------------------');
  CloseFile(Log);
  hkm.ClearHotKeys;
  if Visible then
  begin
    tmrFade.Enabled := True;
    while Visible do delay(1);
  end;
end;

procedure TWork_Time.hkmHotKeyPressed(HotKey: Cardinal; Index: Word);
begin
  if HotKey = HotKeyNoon then Noon;
end;

procedure TWork_Time.trayIconClick(Sender: TObject);
begin
  tmrFade.Enabled := True;
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

procedure TWork_Time.btnChangeActivityClick(Sender: TObject);
begin
  Application.CreateForm(TFrm_Activity, Frm_Activity);
  try
    Frm_Activity.ShowModal;
  finally
    Frm_Activity.Release;
  end;
end;

procedure TWork_Time.tmrFadeTimer(Sender: TObject);
begin
  AlphaBlend := True;
  if Visible and (pmShowHide.Caption = 'Hide') then
  begin
    if AlphaBlendValue >= 10 then
      AlphaBlendValue := AlphaBlendValue - 10
    else
    begin
      Hide;
      AlphaBlend := False;
      tmrFade.Enabled := False;
      pmShowHide.Caption := 'Show';
    end;
  end
  else
  begin
    Show;
    if AlphaBlendValue <= 245 then
      AlphaBlendValue := AlphaBlendValue + 10
    else
    begin
      AlphaBlend := False;
      tmrFade.Enabled := False;
      pmShowHide.Caption := 'Hide';
    end;
  end;
end;

Initialization
  Work_Time.Init;
// Check if WorkTime.exe is already running
  mHandle := CreateMutex(nil,True,'Work_Time');
  if GetLastError = ERROR_ALREADY_EXISTS then Halt; // Already running

finalization
if mHandle <> 0 then CloseHandle(mHandle)

end.
