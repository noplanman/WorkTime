unit globalDefinitions;

interface
uses SysUtils, Windows, HotKeyManager;

const
  // Info Params
  progName = 'WorkTime';
  progVersion = '1.2';
  progAuthor  = 'Armando Lüscher';
  progCopyright = '©2007 ArmyMan';
  progAuthorEmail = 'armyman@armyman.ch';
  progAuthorHomepage = 'www.armyman.ch';

  clrWrong = $0064FFFF;

var
  defRegKey:String;
  runRegKey:String; // RegKey of AutoRun
  defWt:Integer; //seconds
  defNotifyWt:Boolean;
  defNotifyWtBtTitle:String;
  defNotifyWtBtMessage:String;
  defRootKey:HKEY=HKEY_CURRENT_USER;
  defHotKeyNoon:Cardinal;
  defFade:Boolean;
  defFadeSpeed:Integer;
  defStartMinimized:Boolean;
  defAutoRun:Boolean;

  defLogFilePath:String;

implementation

procedure setDefaultValues;
begin
  defRegKey :=
    'Software\ArmyMan\WorkTime';
  runRegKey :=
    'Software\Microsoft\Windows\CurrentVersion\Run';
  defWt :=
    30240; // is equivalent with 8.4 hours
  defNotifyWt :=
    True;
  defNotifyWtBtTitle :=
    'Worktime Over!';
  defNotifyWtBtMessage :=
    'The Working Time you have set is over!';

  defHotKeyNoon :=
    GetHotKey(MOD_CONTROL+MOD_ALT,ord('M'));

  defFade :=
    True;
  defFadeSpeed :=
    5;

  defStartMinimized :=
    False;
  defAutoRun :=
    True;

  defLogFilePath :=
    ExtractFilePath(ParamStr(0))+'WorkTimeLog.txt';
end;

initialization
setDefaultValues;

end.
