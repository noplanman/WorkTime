unit activity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, EButton, ExtCtrls, StdCtrls, JvButton,
  JvTransparentButton, JvExControls, JvComponent, JvGradient, JvSpeedButton,
  jpeg, DBCtrls, DB, DBClient;

type
  TFrm_Activity = class(TForm)
    memoActivity: TMemo;
    gbActivity: TGroupBox;
    pnlButtons: TPanel;
    gradButtons: TJvGradient;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    lblProject: TLabel;
    lblActivity: TLabel;
    imgTitleBar: TImage;
    btnClose: TJvSpeedButton;
    dbcbxProjects: TDBComboBox;
    procedure imgTitleBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Activity: TFrm_Activity;

implementation

uses globalDefinitions, projects, DateUtils, options;

{$R *.dfm}

procedure TFrm_Activity.imgTitleBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Frm_Activity.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

end.
