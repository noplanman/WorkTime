program WorkTime;

uses
  Forms,
  main in 'main.pas' {Work_Time},
  options in 'options.pas' {Frm_options},
  reg in 'reg.pas',
  info in 'pics\info.pas' {Frm_info};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWork_Time, Work_Time);
  Application.CreateForm(TFrm_options, Frm_options);
  Application.CreateForm(TFrm_info, Frm_info);
  Application.Run;
end.
