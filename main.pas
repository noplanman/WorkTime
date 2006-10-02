unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ShellApi, AppEvnts, Menus, Math,
  ImgList;

const
  IC_CLICK = WM_APP + 201;
  clrs : Array [0..15] of TColor =
  (clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clSilver,
  clGray, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);

type
  TWork_Time = class(TForm)
    TimerBottom: TTimer;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    PM_close: TMenuItem;
    TimerTop: TTimer;
    PM_noon: TMenuItem;
    counter: TTimer;
    icon_noon: TImage;
    icon_main: TImage;
    PM_show: TMenuItem;
    PM_hide: TMenuItem;
    PM_info: TMenuItem;
    PM_options: TMenuItem;
    procedure TimerBottomTimer(Sender: TObject);
    procedure TimerTopTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PM_closeClick(Sender: TObject);
    procedure PM_noonClick(Sender: TObject);
    procedure counterTimer(Sender: TObject);
    procedure PM_showClick(Sender: TObject);
    procedure PM_hideClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure PM_infoClick(Sender: TObject);
    procedure PM_optionsClick(Sender: TObject);
  protected
    procedure hotkey(var msg:TMessage); message WM_HOTKEY;
  private
    { Private declarations }
    procedure Systray(var sMsg: TMessage); message IC_CLICK;
  public
    { Public declarations }
    procedure StartLog;
  end;

var
  Work_Time: TWork_Time;
  NIM : TNotifyIconData;
  log : TextFile;

implementation

uses GlobalDefinitions, info, options, reg;
var
  i : integer;
  sec : integer;
  hk : integer;
  mHandle : THandle;

{$R *.dfm}

procedure bl;
begin
  Work_Time.TimerBottom.Enabled := True;
  Work_Time.TimerTop.Enabled := False;
  Work_Time.label1.Alignment := taLeftJustify;
  Work_Time.label1.Left := screen.WorkAreaLeft;
  Work_Time.label1.Top := screen.WorkAreaHeight - 70;
  Work_Time.label1.Caption := FloatToStr((sec div 360) / 10) + #13 + FloatToStr((sec div 6) / 10) + #13 + IntToStr(sec);
end;

procedure br;
begin
  Work_Time.TimerBottom.Enabled := True;
  Work_Time.TimerTop.Enabled := False;
  Work_Time.label1.Alignment := taRightJustify;
  Work_Time.label1.Left := screen.WorkAreaWidth - Work_Time.label1.Width;
  Work_Time.label1.Top := screen.WorkAreaHeight - 70;
  Work_Time.label1.Caption := FloatToStr((sec div 360) / 10) + #13 + FloatToStr((sec div 6) / 10) + #13 + IntToStr(sec);
end;

procedure tr;
begin
  Work_Time.TimerBottom.Enabled := False;
  Work_Time.TimerTop.Enabled := True;
  Work_Time.label1.Alignment := taRightJustify;
  Work_Time.label1.Left := screen.WorkAreaWidth - Work_Time.label1.Width;
  Work_Time.label1.Top := screen.WorkAreaTop;
  Work_Time.label1.Caption := IntToStr(sec) + #13 + FloatToStr((sec div 6) / 10) + #13 + FloatToStr((sec div 360) / 10);
end;

procedure tl;
begin
  Work_Time.TimerBottom.Enabled := False;
  Work_Time.TimerTop.Enabled := True;
  Work_Time.label1.Alignment := taLeftJustify;
  Work_Time.label1.Left := screen.WorkAreaLeft;
  Work_Time.label1.Top := screen.WorkAreaTop;
  Work_Time.label1.Caption := IntToStr(sec) + #13 + FloatToStr((sec div 6) / 10) + #13 + FloatToStr((sec div 360) / 10);
end;

procedure SetParams;
begin
  Work_Time.Label1.Font.Color := clrs[textcolor];
  case txtpos of
  0 : tl;
  1 : tr;
  2 : bl;
  3 : br;
  end;
  Frm_options.editlog.Text := dir;
  Frm_options.rgposition.ItemIndex := txtpos;
  Frm_options.cgtext.ForegroundIndex := textcolor;
end;

procedure TWork_Time.StartLog;
begin
  AssignFile(log, dir + '\WorkTimeLog.txt');
  if FileExists(dir + '\WorkTimeLog.txt')
  then Append(log)
  else ReWrite(log, dir + '\WorkTimeLog.txt');
  WriteLn(log, '___' + FormatDateTime('dd:mm:yyyy', Now) + '_________________');
  WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Started');
  CloseFile(log);
end;

procedure TWork_Time.FormDestroy(Sender: TObject);
begin
  UnRegisterHotKey(handle,hk);
end;

procedure TWork_Time.hotkey(var msg:TMessage);
begin
  if (msg.LParamLo = MOD_CONTROL + MOD_ALT) and (msg.LParamHi = VK_SPACE) then
  PM_noon.Click;
end;

procedure TWork_Time.Systray(var sMsg: TMessage);
begin
  inherited;
  if (sMsg.LParam = WM_RBUTTONDOWN) then
    popupmenu1.Popup(mouse.CursorPos.X,mouse.CursorPos.Y)
  else
  if (sMsg.LParam = WM_LBUTTONDBLCLK) then
    PM_options.Click;
end;

procedure TWork_Time.TimerBottomTimer(Sender: TObject);
begin
  sec := i;
  label1.Caption := FloatToStr((sec div 360) / 10) + #13 + FloatToStr((sec div 6) / 10) + #13 + IntToStr(sec);
end;

procedure TWork_Time.TimerTopTimer(Sender: TObject);
begin
  sec := i;
  label1.Caption := IntToStr(sec) + #13 + FloatToStr((sec div 6) / 10) + #13 + FloatToStr((sec div 360) / 10);
end;

procedure TWork_Time.FormCreate(Sender: TObject);
begin
  StartLog;
  hk := GlobalAddAtom('HotKey_noon');
  RegisterHotKey(handle,hk,MOD_CONTROL + MOD_ALT, VK_SPACE);
  sec := i;
  label1.Caption := FloatToStr((sec div 360) / 10) + #13 + FloatToStr((sec div 6) / 10) + #13 + IntToStr(sec);
  label1.Left := screen.WorkAreaWidth - label1.Width;
  label1.Top := screen.WorkAreaHeight - 70;
  //TNA
  Work_Time.FormStyle:=fsStayOnTop;
  Hide;
  with NIM do begin
    cbSize := SizeOf (nIM);
    Wnd := Handle;
    uID := 0;
    uFlags := NIF_ICON or NIF_MESSAGE or NIF_TIP;
    uCallbackMessage := IC_CLICK;
    hIcon := icon_main.Picture.Icon.Handle;
    szTip := 'WorkTime';
  end;
  Shell_NotifyIcon(NIM_ADD, @NIM);
end;

procedure TWork_Time.FormActivate(Sender: TObject);
begin
  SetParams;
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TWork_Time.PM_closeClick(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @NIM);
  close;
end;

procedure TWork_Time.PM_noonClick(Sender: TObject);
begin
  Append(log);
  if PM_noon.Checked then
  begin
      with NIM do begin
      hIcon := icon_noon.Picture.Icon.Handle;
      szTip := 'WorkTime - Noon';
    end;
    Shell_NotifyIcon(NIM_MODIFY, @NIM);
    counter.Enabled := false;
    WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Noon Started');
  end
  else
  begin
      with NIM do begin
      hIcon := icon_main.Picture.Icon.Handle;
      szTip := 'WorkTime';
    end;
    Shell_NotifyIcon(NIM_MODIFY, @NIM);
    counter.Enabled := true;
    WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Noon Finished');
  end;

  if (Frm_options.rgposition.ItemIndex = 0) or (Frm_options.rgposition.ItemIndex = 1) then
  begin
    timertop.Enabled := not PM_noon.Checked;
    timerbottom.Enabled := not PM_noon.Checked;
  end
  else
  begin
    timerbottom.Enabled := not PM_noon.Checked;
    timertop.Enabled := not PM_noon.Checked;
  end;
  CloseFile(log);
end;

procedure TWork_Time.counterTimer(Sender: TObject);
begin
  Inc(i);
end;

procedure TWork_Time.PM_showClick(Sender: TObject);
begin
  PM_hide.Enabled := true;
  PM_show.Enabled := false;
  Work_Time.Show;
end;

procedure TWork_Time.PM_hideClick(Sender: TObject);
begin
  PM_show.Enabled := true;
  PM_hide.Enabled := false;
  Work_Time.Hide;
end;

procedure TWork_Time.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Append(log);
  WriteLn(log, ' - ' + FormatDateTime('hh:nn:ss', Now) + ' : Work Finished');
  WriteLn(log, '------------------------------');
  WriteLn(log, 'Total working seconds : ' + IntToStr(sec));
  WriteLn(log, 'Total working minutes : ' + FloatToStr(sec div 6 / 10));
  WriteLn(log, 'Total working hours   : ' + FloatToStr(sec div 360 / 10));
  WriteLn(log, '------------------------------');
  WriteLn(log, '');
  CloseFile(log);
  UnRegisterHotKey(handle,hk);
end;

procedure TWork_Time.PM_infoClick(Sender: TObject);
begin
  Frm_info.ShowModal;
end;

procedure TWork_Time.PM_optionsClick(Sender: TObject);
begin
  Frm_options.BringToFront;
  if Frm_options.ShowModal = mrOk then
  begin
    textcolor := Frm_options.cgtext.ForegroundIndex;
    txtpos := Frm_options.rgposition.ItemIndex;
    dir := Frm_options.editlog.Text;
    reg.saveoptions(dir,txtpos,textcolor);
    SetParams;
  end;
end;

Initialization
  defaultdir := 'C:\';
  reg.readoptions(dir,txtpos,textcolor);

mHandle := CreateMutex(nil,True,'Work_Time');
if GetLastError = ERROR_ALREADY_EXISTS then begin // Already running
  halt;
end;

finalization
if mHandle <> 0 then CloseHandle(mHandle)

end.
