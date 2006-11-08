unit projects;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, EButton, ExtCtrls, Grids, DBGrids,
  JvSpeedButton, JvExControls, JvComponent, JvGradient, jpeg;

type
  TFrm_Projects = class(TForm)
    gbProject: TGroupBox;
    editProject: TEdit;
    btnDelete: TSpeedButton;
    dbgProjects: TDBGrid;
    pnlButtons: TPanel;
    gradButtons: TJvGradient;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    btnAdd: TSpeedButton;
    lblProject: TLabel;
    lblProjectList: TLabel;
    imgTitleBar: TImage;
    btnClose: TJvSpeedButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure editProjectChange(Sender: TObject);
    procedure imgTitleBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Projects: TFrm_Projects;

implementation
uses main, globalDefinitions, DBClient, DB;

{$R *.dfm}

procedure TFrm_Projects.btnOkClick(Sender: TObject);
begin
  with Work_Time.cdsProjects do
  begin
    SaveToFile(dbProjects,dfBinary);
  end;
end;

procedure TFrm_Projects.btnAddClick(Sender: TObject);
begin
  if editProject.Text <> '' then
  begin
    with Work_Time.cdsProjects do
    begin
      Insert;
      FieldByName('project').Value := editProject.Text;
      Post;
    end;
  end;
  editProject.Clear;
end;

procedure TFrm_Projects.FormShow(Sender: TObject);
begin
  with Work_Time.cdsProjects do
  begin
    LoadFromFile(dbProjects);
  end;
end;

procedure TFrm_Projects.btnDeleteClick(Sender: TObject);
begin
  dbgProjects.SelectedRows.Delete;
end;

procedure TFrm_Projects.editProjectChange(Sender: TObject);
begin
  btnAdd.Enabled := editProject.Text <> '';
end;

procedure TFrm_Projects.imgTitleBarMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Frm_Projects.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

end.
