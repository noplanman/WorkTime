unit options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ColorGrd;

type
  TFrm_options = class(TForm)
    btnlogdirectory: TButton;
    btnok: TButton;
    btncancel: TButton;
    cgtext: TColorGrid;
    gbtc: TGroupBox;
    gblogdir: TGroupBox;
    editlog: TEdit;
    pnlbuttons: TPanel;
    btndefault: TButton;
    rgposition: TRadioGroup;
    procedure btnlogdirectoryClick(Sender: TObject);
    procedure btndefaultClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_options: TFrm_options;

implementation

uses GlobalDefinitions, logfile;

{$R *.dfm}

procedure TFrm_options.btnlogdirectoryClick(Sender: TObject);
begin
  Frm_logdir.BringToFront;
  if Frm_logdir.ShowModal = mrOk then
  editlog.Text := dir;
end;

procedure TFrm_options.btndefaultClick(Sender: TObject);
begin
  editlog.Text := defaultdir;
  rgposition.ItemIndex := 3;;
  cgtext.ForegroundIndex := 10;
end;

end.
