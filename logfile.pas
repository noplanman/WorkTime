unit logfile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, ExtCtrls;

type
  TFrm_logdir = class(TForm)
    dcb: TDriveComboBox;
    dlb: TDirectoryListBox;
    btnok: TButton;
    btncancel: TButton;
    Panel1: TPanel;
    procedure btnokClick(Sender: TObject);
    procedure btncancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_logdir: TFrm_logdir;

implementation

uses options, GlobalDefinitions;

{$R *.dfm}

procedure TFrm_logdir.btnokClick(Sender: TObject);
begin
  dir := dlb.Directory;
end;

procedure TFrm_logdir.btncancelClick(Sender: TObject);
begin
  dlb.Directory := dir;
end;

end.
