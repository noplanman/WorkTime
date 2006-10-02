program WorkTime;

uses
  Forms,
  main in 'main.pas' {Work_Time},
  info in 'info.pas' {Frm_info},
  logfile in 'logfile.pas' {Frm_logdir},
  GlobalDefinitions in 'GlobalDefinitions.pas',
  options in 'options.pas' {Frm_options},
  reg in 'reg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWork_Time, Work_Time);
  Application.CreateForm(TFrm_info, Frm_info);
  Application.CreateForm(TFrm_logdir, Frm_logdir);
  Application.CreateForm(TFrm_options, Frm_options);
  Application.Run;
end.
