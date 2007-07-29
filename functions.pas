unit functions;

interface
const
  //required for desktop shortcut
  IID_IPersistFile: TGUID = (D1:$0000010B;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));

// FUNCTIONS
function Timestamp(Const D:TDateTime):Cardinal;
function IsNumeric(const S:String):Boolean;
function CreateDesktopShortcut(PathObj,PathLink,Desc,Workdir:String):Boolean;
function GetDesktopFolder:String;

// PROCEDURES

implementation
uses
  activeX,comobj,shlobj,Windows,SysUtils, DateUtils;

function Timestamp(Const D:TDateTime):Cardinal;
begin
  Result := DateTimeToUnix(D);
end;

function IsNumeric(Const S:String):Boolean;
var
  i : Integer;
  res : Boolean;
begin
  res := True;
  for i := 1 to Length(S) do
  begin
    res := (S[i] in [#8, #48..#57]);
    if not res then break;
  end;
  Result := res;
end;

function CreateDesktopShortcut(PathObj,PathLink,Desc,Workdir:String):Boolean;
var
  psl: IShellLink;
  ppf: IPersistFile;
begin
  Result := False;
  if Succeeded(CoCreateInstance(CLSID_ShellLink,nil,CLSCTX_INPROC_SERVER,IID_IShellLinkA,psl)) then
  begin
    psl.SetPath(pChar(PathObj));
    psl.SetDescription(pChar(Desc));
    psl.SetWorkingDirectory(pChar(Workdir));
    if Succeeded(psl.QueryInterface(IID_IPersistFile,ppf)) then
    begin
      ppf.Save(StringToOleStr(PathLink),True);
      Result := True;
    end;
  end;
end;

function GetDesktopFolder:String;
var
  pidl:PItemIDList;
  Path:array[0..250] of char;
begin
  if Succeeded(SHGetSpecialFolderLocation(0,CSIDL_DESKTOP,pidl)) then
  begin
    SHGetPathFromIDList(pidl,Path);
    Result := Path;
  end
  else
  begin
    Result := '';
  end;
end;

end.
