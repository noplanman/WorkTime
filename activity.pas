unit activity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, EButton, ExtCtrls, StdCtrls, JvButton,
  JvTransparentButton, JvExControls, JvComponent, JvGradient, JvSpeedButton,
  jpeg;

type
  TFrm_Activity = class(TForm)
    cbxProjects: TComboBox;
    memoActivity: TMemo;
    gbActivity: TGroupBox;
    btnProjectEdit: TSpeedButton;
    pnlButtons: TPanel;
    gradButtons: TJvGradient;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    lblProject: TLabel;
    lblActivity: TLabel;
    imgTitleBar: TImage;
    btnClose: TJvSpeedButton;
    procedure btnProjectEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgTitleBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    procedure refreshProjects;
  public
    { Public declarations }
  end;

var
  Frm_Activity: TFrm_Activity;

implementation

uses projects, main, DateUtils, DB;

{$R *.dfm}

procedure TFrm_Activity.refreshProjects;
begin
  cbxProjects.Clear;
  with Work_Time.cdsProjects do
  begin
    First;
    while not EoF do
    begin
      cbxProjects.Items.Add(FieldByName('project').Value);
      Next;
    end;
  end;
  cbxProjects.ItemIndex := 0;
end;

procedure TFrm_Activity.btnProjectEditClick(Sender: TObject);
begin
  Application.CreateForm(TFrm_Projects, Frm_Projects);
  try
    if Frm_Projects.ShowModal = mrOk then
    begin
      refreshProjects;
    end;
  finally
    Frm_Projects.Release;
  end;
end;

procedure TFrm_Activity.FormShow(Sender: TObject);
begin
  refreshProjects;
end;

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
