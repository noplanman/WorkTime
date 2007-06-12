program WorkTime;

uses
  Forms,
  SysUtils,
  Dialogs,
  main in 'main.pas' {Frm_Main},
  globalDefinitions in 'globalDefinitions.pas',
  reg in 'reg.pas',
  options in 'options.pas' {Frm_Options},
  info in 'info.pas' {Frm_Info},
  first_start in 'first_start.pas' {Frm_First},
  functions in 'functions.pas';

{$R *.res}

begin
  if(not reg.keyExists(defRegKey)) then
  begin
    Application.Initialize;
    Application.CreateForm(TFrm_First, Frm_First);
  Application.Run;
  end
  else
  begin
    Application.Initialize;
    Application.CreateForm(TFrm_Main, Frm_Main);
    Application.CreateForm(TFrm_Options, Frm_Options);
    Application.Run;
  end;
end.
