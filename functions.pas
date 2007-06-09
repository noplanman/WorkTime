unit functions;

interface
uses
  mysql;

function TestMySQLConnection(DBHost,DBUser,DBPass:String;DBPort:Integer=3306;DBDatabase:String=''):Boolean;
function IsNumeric(const S:String):Boolean;

implementation

{*******************************************************************************
  Database
*******************************************************************************}
function TestMySQLConnection(DBHost,DBUser,DBPass:String;DBPort:Integer=3306;DBDatabase:String=''):Boolean;
var
  MySQLConn : PMYSQL;
  res : Boolean;
begin
  res := True;
  MySQLConn := mysql_init(nil);
  if(mysql_real_connect(
    MySQLConn,
    pChar(DBHost),
    pChar(DBUser),
    pChar(DBPass),
    nil,
    DBPort,
    nil,
    0)) = nil
  then res := False;
  if(res and (DBDatabase<>''))then
  begin
    res := (mysql_select_db(MySQLConn,pChar(DBDatabase))=0);
  end;
  mysql_close(MySQLConn);
  result := res;
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

end.
