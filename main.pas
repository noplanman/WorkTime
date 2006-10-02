unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi, Buttons, Menus, ExtCtrls, AppEvnts, jpeg;

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
    lbl_time: TLabel;
    btn_options: TSpeedButton;
    pm: TPopupMenu;
    pm_show: TMenuItem;
    pm_noon: TMenuItem;
    icon_main: TImage;
    icon_noon: TImage;
    counter: TTimer;
    pm_exit: TMenuItem;
    noon_counter: TTimer;
    btn_minimize: TSpeedButton;
    btn_close: TSpeedButton;
    bg: TImage;
    btn_info: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btn_optionsClick(Sender: TObject);
    procedure counterTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pm_noonClick(Sender: TObject);
    procedure noon_counterTimer(Sender: TObject);
    procedure pm_showClick(Sender: TObject);
    procedure pm_exitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_minimizeClick(Sender: TObject);
    procedure btn_closeClick(Sender: TObject);
    procedure bgMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure lbl_timeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btn_infoClick(Sender: TObject);
    procedure bgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lbl_timeMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  protected
    procedure hotkey(var msg:TMessage); message WM_HOTKEY;
  private
    { Private declarations }
    procedure Systray(var sMsg: TMessage); message IC_CLICK;
  public
    { Public declarations }
    procedure WmMoving(var Message: TWmMoving); message WM_MOVING;
    procedure StartLog;
    procedure Noon;
  end;

var
  Work_Time: TWork_Time;
  NIM : TNotifyIconData;
  log : TextFile;

implementation

uses options, reg, info;

var
  hk : Integer;
  mHandle : THandle;
  dir : String;
  TickCount : Integer; //TickCount value when program started
  noon_time : Integer; //noon time
{$R *.dfm}

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

procedure TWork_Time.hotkey(var msg:TMessage);
begin
  if (msg.LParamLo = MOD_CONTROL + MOD_ALT) and (msg.LParamHi = VK_SPACE) then
  pm_noon.Click;
end;

procedure TWork_Time.Systray(var sMsg: TMessage);
begin
  inherited;
  if (sMsg.LParam = WM_RBUTTONDOWN) then
    pm.Popup(mouse.CursorPos.X,mouse.CursorPos.Y)
  else
  if (sMsg.LParam = WM_LBUTTONDBLCLK) then
    Work_Time.Show;
end;

procedure TWork_Time.Noon;
begin
  Append(log);
  if pm_noon.Checked then
  begin
    noon_counter.Enabled := true;
    counter.Enabled := false;
    NIM.hIcon := icon_noon.Picture.Icon.Handle;
    Shell_NotifyIcon(NIM_MODIFY, @NIM);
    WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Noon Started');
  end
  else
  begin
    noon_counter.Enabled := false;
    counter.Enabled := true;
    NIM.hIcon := icon_main.Picture.Icon.Handle;
    Shell_NotifyIcon(NIM_MODIFY, @NIM);
    WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Noon Finished');
  end;
  CloseFile(log);
end;

procedure TWork_Time.FormCreate(Sender: TObject);
begin
  StartLog;
  noon_time := 0;
  TickCount := GetTickCount; // Seconds since computer running

  //TNA
  Work_Time.FormStyle := fsStayOnTop;
  Hide;
  with NIM do begin
    cbSize := SizeOf (NIM);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    uCallbackMessage := IC_CLICK;
    hIcon := icon_main.Picture.Icon.Handle;
  end;
  Shell_NotifyIcon(NIM_ADD, @NIM);
end;

procedure TWork_Time.StartLog;
begin
  AssignFile(log, dir + '\WorkTimeLog.txt');
  if FileExists(dir + '\WorkTimeLog.txt')
  then Append(log)
  else ReWrite(log, dir + '\WorkTimeLog.txt');
  WriteLn(log, '');
  WriteLn(log, '___' + FormatDateTime('dd:mm:yyyy', Now) + '_________________');
  WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Started');
  CloseFile(log);
end;

procedure TWork_Time.btn_optionsClick(Sender: TObject);
begin
  Frm_options.lbl_directory.Caption := dir;
  Frm_options.dlb.Directory := dir;
  if Frm_options.ShowModal = mrOK then
  dir := Frm_options.lbl_directory.Caption;
  reg.SetOptions(dir);
end;

procedure TWork_Time.counterTimer(Sender: TObject);
begin
  text :=
  FloatToStr(((GetTickCount - TickCount - (noon_time * 1000)) div 360000) / 10) + 'h  |  ' +
  FloatToStr(((GetTickCount - TickCount - (noon_time * 1000)) div 6000) / 10) + 'm  |  ' +
  IntToStr((GetTickCount - TickCount - (noon_time * 1000)) div 1000) + 's';

  StrCopy(NIM.szTip, PChar(text));
  Shell_NotifyIcon(NIM_MODIFY, @NIM);

  lbl_time.Caption :=
  FloatToStr(((GetTickCount - TickCount - (noon_time * 1000)) div 360000) / 10) + #13 +
  FloatToStr(((GetTickCount - TickCount - (noon_time * 1000)) div 6000) / 10) + #13 +
  IntToStr((GetTickCount - TickCount - (noon_time * 1000)) div 1000);
end;

procedure TWork_Time.FormDestroy(Sender: TObject);
begin
  UnRegisterHotKey(handle,hk);
  Shell_NotifyIcon(NIM_DELETE, @NIM);
end;

procedure TWork_Time.pm_noonClick(Sender: TObject);
begin
  noon;
end;

procedure TWork_Time.noon_counterTimer(Sender: TObject);
begin
  inc(noon_time);
end;

procedure TWork_Time.pm_showClick(Sender: TObject);
begin
  Work_Time.Show;
end;

procedure TWork_Time.pm_exitClick(Sender: TObject);
begin
  close;
end;

procedure TWork_Time.FormActivate(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
  hk := GlobalAddAtom('HotKey_noon');
  RegisterHotKey(handle,hk,MOD_CONTROL + MOD_ALT, VK_SPACE);
end;

procedure TWork_Time.btn_minimizeClick(Sender: TObject);
begin
  Work_Time.Hide;
end;

procedure TWork_Time.btn_closeClick(Sender: TObject);
begin
  close;
end;

procedure TWork_Time.bgMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (ssLeft in Shift) then begin
    ReleaseCapture;
    SendMessage(Work_Time.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
    end;
end;

procedure TWork_Time.lbl_timeMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if (ssLeft in Shift) then begin
    ReleaseCapture;
    SendMessage(Work_Time.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
    end;
end;

procedure TWork_Time.btn_infoClick(Sender: TObject);
begin
  Frm_info.Top := Work_Time.Top;
  Frm_info.Left := Work_Time.Left;
  Frm_info.ShowModal;
end;

procedure TWork_Time.bgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Frm_info.Top := Work_Time.Top;
  Frm_info.Left := Work_Time.Left;
end;

procedure TWork_Time.lbl_timeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Frm_info.Top := Work_Time.Top;
  Frm_info.Left := Work_Time.Left;
end;

procedure TWork_Time.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Append(log);
  WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Finished');
  WriteLn(log, '------------------------------');
  WriteLn(log, 'Total working seconds : ' + IntToStr((GetTickCount - TickCount - (noon_time * 1000)) div 1000));
  WriteLn(log, 'Total working minutes : ' + FloatToStr(((GetTickCount - TickCount - (noon_time * 1000)) div 6000) / 10));
  WriteLn(log, 'Total working hours   : ' + FloatToStr(((GetTickCount - TickCount - (noon_time * 1000)) div 360000) / 10));
  WriteLn(log, '------------------------------');
  CloseFile(log);
end;

Initialization
  reg.CheckForOptions;
  dir := reg.GetOptions;

// Check if WorkTime.exe is already running
  mHandle := CreateMutex(nil,True,'Work_Time');
  if GetLastError = ERROR_ALREADY_EXISTS then begin // Already running
  halt;
  end;

finalization
if mHandle <> 0 then CloseHandle(mHandle)

end.
