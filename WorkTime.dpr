program WorkTime;

uses
  Forms,
  main in 'main.pas' {Work_Time},
  options in 'options.pas' {Frm_Options},
  reg in 'reg.pas',
  info in 'info.pas' {Frm_Info},
  globalDefinitions in 'globalDefinitions.pas',
  activity in 'activity.pas' {Frm_Activity},
  projects in 'projects.pas' {Frm_Projects};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWork_Time, Work_Time);
  Application.Run;
end.
