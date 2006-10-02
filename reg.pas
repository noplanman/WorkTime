unit reg;

interface

procedure CheckForOptions;
function GetOptions : String;
procedure SetOptions(dir : String);

implementation
uses Registry;

var
  regist : TRegistry;

procedure CheckForOptions;
begin
  regist := TRegistry.Create;
  // default HKEY is HKEY_CURRENT_USER
  if not regist.KeyExists('Software\ArmyMan\WorkTime')
  then
  begin
  // if no key exists create key with default entrys
    regist.OpenKey('Software\ArmyMan\WorkTime', true);
    regist.WriteString('dir','C:\');
  end;
  regist.CloseKey;
  regist.Free;
end;

function GetOptions : String;
var
  dir : String;
begin
  regist := TRegistry.Create;
  regist.OpenKey('Software\ArmyMan\WorkTime', true);
  dir := regist.ReadString('dir');
  result := dir;
  regist.CloseKey;
  regist.Free;
end;

procedure SetOptions(dir : String);
begin
  regist := TRegistry.Create;
  regist.OpenKey('Software\ArmyMan\WorkTime', true);
  regist.WriteString('dir',dir);
  regist.CloseKey;
  regist.Free;
end;



end.
