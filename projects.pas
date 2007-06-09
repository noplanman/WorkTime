unit projects;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, EButton, ExtCtrls, Grids, DBGrids,
  JvSpeedButton, JvExControls, JvComponent, JvGradient, jpeg, DBCtrls, DB,
  DBClient;

type
  TFrm_Projects = class(TForm)
    gbProject: TGroupBox;
    editProject: TEdit;
    btnDelete: TSpeedButton;
    pnlButtons: TPanel;
    gradButtons: TJvGradient;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    btnAdd: TSpeedButton;
    lblProject: TLabel;
    lblProjectList: TLabel;
    imgTitleBar: TImage;
    btnClose: TJvSpeedButton;
    dblProjects: TDBListBox;
    dsProjects: TDataSource;
    cdsProjects: TClientDataSet;
    cdsProjectsid: TAutoIncField;
    cdsProjectsproject: TStringField;
    procedure btnOkClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure editProjectChange(Sender: TObject);
    procedure imgTitleBarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure editProjectKeyPress(Sender: TObject; var Key: Char);
    procedure dbgProjectsCellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Projects: TFrm_Projects;

implementation
uses main, globalDefinitions, database;

{$R *.dfm}

procedure TFrm_Projects.btnOkClick(Sender: TObject);
begin
{  saveToFile(cdsProjects,dbProjects,dfBinary);}
end;

procedure TFrm_Projects.btnAddClick(Sender: TObject);
begin
  if editProject.Text <> '' then
    if not valueExists(cdsProjects,'project',editProject.Text) then
    begin
      if not insertRow(cdsProjects,'project',editProject.Text) then
        ShowMessage('Failed to add Project!')
    end
    else ShowMessage('Entry already exists!' + editProject.Text);
  editProject.Clear;
end;

procedure TFrm_Projects.FormShow(Sender: TObject);
begin
{  loadFromFile(cdsProjects,dbProjects);}
end;

procedure TFrm_Projects.btnDeleteClick(Sender: TObject);
begin
  if (dblProjects.DataSource.DataSet.RecordCount > 0) and (dblProjects.SelCount > 0) then
    if MessageDlg('Delete the entry?' + #13 + dblProjects.Items.ValueFromIndex[dblProjects.ItemIndex],mtWarning,mbOKCancel,0) = mrOk then dblProjects.DeleteSelected;
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

procedure TFrm_Projects.editProjectKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key = #13 then btnAdd.Click;
end;

procedure TFrm_Projects.dbgProjectsCellClick(Column: TColumn);
begin
  btnDelete.Enabled := dblProjects.SelCount > 0;
end;

end.
