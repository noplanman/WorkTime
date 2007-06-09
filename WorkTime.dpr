program WorkTime;

uses
  Forms,
  SysUtils,
  Dialogs,
  main in 'main.pas' {Work_Time},
  globalDefinitions in 'globalDefinitions.pas',
  reg in 'reg.pas',
  mysql in 'mysql.pas',
  options in 'options.pas' {Frm_Options},
  info in 'info.pas' {Frm_Info},
  activity in 'activity.pas' {Frm_Activity},
  first_start in 'first_start.pas' {Frm_First},
  functions in 'functions.pas';

{$R *.res}

begin
  if(not FileExists('libmysql.dll')) then
  begin
    ShowMessage('libmysql.dll not found!');
  end
  else
  if(not reg.keyExists(defRegKey)) then
  begin
    Application.Initialize;
    Application.CreateForm(TFrm_First, Frm_First);
    Application.Run;
  end
  else
  begin
    if(not TestMySQLConnection(reg.getString(defRegKey,'DBHost',defDBHost),
      reg.getString(defRegKey,'DBUser',defDBUser),
      reg.getString(defRegKey,'DBPass',defDBPass),
      reg.getInteger(defRegKey,'DBPort',defDBPort),
      reg.getString(defRegKey,'DBDatabase',defDBDatabase))) then
    begin
      Application.Initialize;
      Application.CreateForm(TFrm_First, Frm_First);
      Application.Run;
    end
    else
    begin
      Application.Initialize;
      Application.CreateForm(TWork_Time, Work_Time);
      Application.CreateForm(TFrm_Activity, Frm_Activity);
      Application.CreateForm(TFrm_Options, Frm_Options);
      Application.Run;
    end;
  end;
end.
