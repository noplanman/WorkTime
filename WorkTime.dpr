program WorkTime;

uses
  Forms,
  SysUtils,
  Dialogs,
  main in 'main.pas' {Frm_Main},
  globalDefinitions in 'globalDefinitions.pas',
  options in 'options.pas' {Frm_Options},
  info in 'info.pas' {Frm_Info},
  first_start in 'first_start.pas' {Frm_First},
  reg in 'reg.pas',
  functions in 'functions.pas',
  logmessage in 'logmessage.pas' {Frm_LogMessage};

{$R *.res}

var
  LogFile:String;
  Log:Integer;
begin
  Application.Initialize;

  if(not reg.keyExists(defRegKey)) then
  begin
    Application.CreateForm(TFrm_First, Frm_First);
  end
  else
  begin
    LogFile := reg.getString(defRegKey,'LogFilePath',defLogFilePath);
    if(FileExists(LogFile))then
    begin
      try
        Log := FileOpen(LogFile,fmOpenReadWrite);
        FileClose(Log);
        Application.CreateForm(TFrm_Main, Frm_Main);
        Application.CreateForm(TFrm_Options, Frm_Options);
        Application.CreateForm(TFrm_LogMessage, Frm_LogMessage);
      except
        Application.CreateForm(TFrm_First, Frm_First);
      end;
    end
    else
    begin
      Application.CreateForm(TFrm_First, Frm_First);
    end;
  end;
  Application.Run;
end.
