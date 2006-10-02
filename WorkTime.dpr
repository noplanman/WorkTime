program WorkTime;

uses
  Forms,
  main in 'main.pas' {Work_Time},
  options in 'options.pas' {Frm_Options},
  reg in 'reg.pas',
  info in 'info.pas' {Frm_Info},
  globalDefinitions in 'globalDefinitions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWork_Time, Work_Time);
  Application.CreateForm(TFrm_Options, Frm_Options);
  Application.Run;
end.
