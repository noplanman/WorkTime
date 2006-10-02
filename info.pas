unit info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ShellApi, ComCtrls, TabNotBk;

type
  TFrm_info = class(TForm)
    Panel1: TPanel;
    bg: TImage;
    lblepsag: TLabel;
    lblarmando: TLabel;
    lblworktime: TLabel;
    lblversion: TLabel;
    btnclose: TButton;
    procedure MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btncloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_info: TFrm_info;

implementation

uses GlobalDefinitions, logfile;

{$R *.dfm}

procedure TFrm_info.MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (ssLeft in Shift) then begin
    ReleaseCapture;
    SendMessage(Frm_info.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
    end;
end;

procedure TFrm_info.btncloseClick(Sender: TObject);
begin
  close;
end;

end.
