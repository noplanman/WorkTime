unit reg;

interface

function keyExists(key:String):Boolean;
function getString(key,name,default:String):String;
function getInteger(key,name:String;default:Integer):Integer;
function getBoolean(key,name:String;default:Boolean):Boolean;
function getDouble(key,name:String;default:Double):Double;

function setString(key,name,value:String):Boolean;
function setInteger(key,name:String;value:Integer):Boolean;
function setBoolean(key,name:String;value:Boolean):Boolean;
function setDouble(key,name:String;value:Double):Boolean;

implementation
uses Registry, globalDefinitions, Windows;

var
  regist : TRegistry;

function keyExists(key:String):Boolean;
begin
  try
    regist := TRegistry.Create;
    regist.RootKey := defRootKey;
    result := regist.KeyExists(key);
  finally
    regist.Free;
  end;
end;

function getString(key,name,default:String):String;
begin
  result := default;
  try
    regist := TRegistry.Create;
    regist.RootKey := defRootKey;
    if regist.OpenKey(key, false) then
      if (regist.ValueExists(name)) then
        result := regist.ReadString(name);
  finally
    regist.CloseKey;
    regist.Free;
  end;
end;

function getInteger(key,name:String;default:Integer):Integer;
begin
  result := default;
  try
    regist := TRegistry.Create;
    regist.RootKey := defRootKey;
    if regist.OpenKey(key, false) then
      if (regist.ValueExists(name)) then
        result := regist.ReadInteger(name);
  finally
    regist.CloseKey;
    regist.Free;
  end;
end;

function getBoolean(key,name:String;default:Boolean):Boolean;
begin
  result := default;
  try
    regist := TRegistry.Create;
    regist.RootKey := defRootKey;
    if regist.OpenKey(key, false) then
      if (regist.ValueExists(name)) then
        result := regist.ReadBool(name);
  finally
    regist.CloseKey;
    regist.Free;
  end;
end;

function getDouble(key,name:String;default:Double):Double;
begin
  result := default;
  try
    regist := TRegistry.Create;
    regist.RootKey := defRootKey;
    if regist.OpenKey(key, false) then
      if (regist.ValueExists(name)) then
        result := regist.ReadFloat(name);
  finally
    regist.CloseKey;
    regist.Free;
  end;
end;

function setString(key,name,value:String):Boolean;
begin
  result := False;
  try
    regist := TRegistry.Create;
    regist.RootKey := defRootKey;
    if regist.OpenKey(key, true) then
    begin
      regist.WriteString(name,value);
      result := True;
    end;
  finally
    regist.CloseKey;
    regist.Free;
  end;
end;

function setInteger(key,name:String;value:Integer):Boolean;
begin
  result := False;
  try
    regist := TRegistry.Create;
    regist.RootKey := defRootKey;
    if regist.OpenKey(key, true) then
    begin
      regist.WriteInteger(name,value);
      result := True;
    end;
  finally
    regist.CloseKey;
    regist.Free;
  end;
end;

function setBoolean(key,name:String;value:Boolean):Boolean;
begin
  result := False;
  try
    regist := TRegistry.Create;
    regist.RootKey := defRootKey;
    if regist.OpenKey(key, true) then
    begin
      regist.WriteBool(name,value);
      result := True;
    end;
  finally
    regist.CloseKey;
    regist.Free;
  end;
end;

function setDouble(key,name:String;value:Double):Boolean;
begin
  result := False;
  try
    regist := TRegistry.Create;
    regist.RootKey := defRootKey;
    if regist.OpenKey(key, true) then
    begin
      regist.WriteFloat(name,value);
      result := True;
    end;
  finally
    regist.CloseKey;
    regist.Free;
  end;
end;

end.
