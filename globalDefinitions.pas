unit globalDefinitions;

interface
uses SysUtils, Windows, HotKeyManager;

const
// Info Params
progName = 'WorkTime';
progVersion = '1.2';
progAuthor  = 'Armando Lüscher';
progCopyright = '©2006 ArmyMan';
progAuthorEmail = 'armyman@armyman.ch';
progAuthorHomepage = 'www.armyman.ch';

var
  defRegKey:String;
  defLogFile:String;
  defWt:Integer; //seconds
  defNotifyWt:Boolean;
  defNotifyWtBtTitle:String;
  defNotifyWtBtMessage:String;
  defRootKey:HKEY=HKEY_CURRENT_USER;
  defHotKeyNoon:Cardinal;
  dbDataDir:String;
  dbWorkTime:String;
  dbActivity:String;
  dbActivityList:String;
  dbProjects:String;

implementation

procedure setDefaultValues;
begin
  defRegKey :=
    'Software\ArmyMan\WorkTime';
  defLogFile :=
    IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'WorkTimeLog.txt';
  defWt :=
    30240; // is equivalent with 8.4 hours
  defNotifyWt :=
    True;
  defNotifyWtBtTitle :=
    'Worktime Over!';
  defNotifyWtBtMessage :=
    'The Working Time you have set is over!';

  defHotKeyNoon :=
    GetHotKey(MOD_CONTROL+MOD_ALT,VK_SPACE);


  dbDataDir :=
    IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'data\';
  dbWorkTime :=
    dbDataDir+'WorkTime.cds';
  dbActivity :=
    dbDataDir+'Activity.cds';
  dbActivityList :=
    dbDataDir+'ActivityList.cds';
  dbProjects :=
    dbDataDir+'Projects.cds';
end;

initialization
setDefaultValues;

end.
