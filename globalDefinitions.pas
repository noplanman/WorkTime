unit globalDefinitions;

interface
uses SysUtils, Windows;

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
end;

initialization
setDefaultValues;

end.
