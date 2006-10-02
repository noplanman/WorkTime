unit reg;

interface

procedure saveoptions(dir : string; txtpos : integer; textcolor : integer);
procedure readoptions(var dir : string; var txtpos : integer; var textcolor : integer);

implementation
uses options, registry, GlobalDefinitions;

procedure saveoptions(dir : string; txtpos : integer; textcolor : integer);
var
  regist : TRegistry;
begin
  //Registry einstellungen zum speichern der Optionen
  regist := TRegistry.Create;
  regist.OpenKey('Software\EPS\WorkTime', true);
  regist.WriteString('dir', dir);
  regist.WriteInteger('pos', txtpos);
  regist.WriteInteger('textcolor', textcolor);
  regist.Free;
end;

procedure readoptions(var dir : string; var txtpos : integer; var textcolor : integer);
var
  regist : TRegistry;
begin
  //Registry einstellungen zum laden der Optionen
  regist := TRegistry.Create;
  if regist.KeyExists('Software\EPS\WorkTime') then
  begin
    regist.OpenKey('Software\EPS\WorkTime', true);
    if regist.ValueExists('dir') then
    dir := regist.ReadString('dir') else
    regist.WriteString('dir', 'C:\');
    if regist.ValueExists('pos') then
    txtpos := regist.ReadInteger('pos') else
    regist.WriteInteger('pos', 3);
    if regist.ValueExists('textcolor') then
    textcolor := regist.ReadInteger('textcolor') else
    regist.WriteInteger('textcolor', 10);
  end
  else
  begin
    dir := cdir;
    txtpos := ctxtpos;
    textcolor := ctextcolor;
    regist.OpenKey('Software\EPS\WorkTime', true);
    regist.WriteString('dir', 'C:\');
    regist.WriteInteger('pos', 3);
    regist.WriteInteger('textcolor', 10);
  end;
  regist.Free;
end;

end.
