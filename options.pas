unit options;

interface

uses
  Windows, Messages, SysUtils, Forms, Dialogs, StdCtrls, EButton, Spin,
  ExtCtrls, Classes, Controls, ComCtrls, JvSpeedButton, JvExControls,
  JvComponent, JvGradient, jpeg, Buttons, Graphics, JvComponentBase,
  JvNavigationPane, DBCtrls, JvPageList, mysql, Grids, DBGrids,
  JvExDBGrids, JvDBGrid, JvExExtCtrls, JvItemsPanel, JvDBDotNetControls;

type
  TFrm_Options = class(TForm)
    lblWt: TLabel;
    cbNotifyWt: TCheckBox;
    seWtHours: TSpinEdit;
    seWtMinutes: TSpinEdit;
    seWtSeconds: TSpinEdit;
    lblWtHours: TLabel;
    lblWtMinutes: TLabel;
    lblWtSeconds: TLabel;
    editNotifyWtBtTitle: TEdit;
    lblNotifyWtBtTitle: TLabel;
    lblNotifyWtBtMessage: TLabel;
    memoNotifyWtBtMessage: TMemo;
    lblNotifyWtBtMessageCounter: TLabel;
    pnlButtons: TPanel;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    lblHotKeyNoon: TLabel;
    hcNoon: THotKey;
    btnClose: TJvSpeedButton;
    cbFade: TCheckBox;
    tbFadeSpeed: TTrackBar;
    lblFadeSpeed: TLabel;
    lblFadeSlow: TLabel;
    lblFadeFast: TLabel;
    cbStartMinimized: TCheckBox;
    cbAutoRun: TCheckBox;
    npOptions: TJvNavigationPane;
    npDatabase: TJvNavPanelPage;
    npNotifications: TJvNavPanelPage;
    npVarious: TJvNavPanelPage;
    npProjects: TJvNavPanelPage;
    npStyleManager: TJvNavPaneStyleManager;
    btnDelete: TSpeedButton;
    btnAdd: TSpeedButton;
    lblProject: TLabel;
    lblProjectList: TLabel;
    editProject: TEdit;
    editDBHost: TLabeledEdit;
    editDBUser: TLabeledEdit;
    editDBPass: TLabeledEdit;
    editDBDatabase: TLabeledEdit;
    editDBPort: TLabeledEdit;
    imgTitle: TImage;
    lblTitle: TLabel;
    gradButtons: TJvGradient;
    btnDefaults: TSpeedButton;
    btnDBTestConnection: TSpeedButton;
    lbProject: TListBox;
    procedure cbNotifyWtClick(Sender: TObject);
    procedure memoNotifyWtBtMessageChange(Sender: TObject);
    procedure cbFadeClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure editProjectChange(Sender: TObject);
    procedure editProjectKeyPress(Sender: TObject; var Key: Char);
    procedure dblProjectsDblClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnDBTestConnectionClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure _MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure InfosComplete(Sender: TObject);
    procedure btnDefaultsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure UpdateListBox;
    function ProjectUsed(Project:String):Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Options: TFrm_Options;
  MySQLConn : PMYSQL;
  MySQLRes : PMYSQL_RES;
  MySQLsql : String;

implementation
uses globalDefinitions, reg, Math, functions;

{$R *.dfm}

{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                          start
*******************************************************************************}
{*******************************************************************************
  PROCEDURES                                                               start
*******************************************************************************}

procedure TFrm_Options._MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Self.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

procedure TFrm_Options.InfosComplete(Sender: TObject);
var
  OK : Boolean;
begin
  with (Sender as TLabeledEdit) do
  begin
    if(Text='')then
      Color := clrWrong
    else
    begin
      if(Name='editDBPort')then
      begin
        if(not IsNumeric(Text))then
          Color := clrWrong
        else
          Color := clWhite;
      end
      else
        Color := clWhite;
    end;
  end;
  OK := ((editDBHost.Text<>'') and
         (editDBPort.Text<>'') and
         (IsNumeric(editDBPort.Text)) and
         (editDBUser.Text<>''));
  btnDBTestConnection.Enabled := OK;
  OK := OK and (editDBDatabase.Text<>'');
  btnOk.Enabled := OK;
end;

procedure TFrm_Options.UpdateListbox;
var
  MySQLRow : PMYSQL_ROW;
begin
  lbProject.Clear;
  MySQLsql := 'SELECT project FROM '+dbTblProject;
  if(mysql_query(MySQLConn,pChar(MySQLsql)) = 0) then
  begin
    MySQLRes := mysql_use_result(MySQLConn);
  	MySQLRow := mysql_fetch_row(MySQLRes);
  	while MySQLRow <> nil do
    begin
      lbProject.Items.Add(MySQLRow[0]);
  		MySQLRow := mysql_fetch_row(MySQLRes);
  	end;
  end;
end;

{*******************************************************************************
  PROCEDURES                                                                 end
*******************************************************************************}
{*******************************************************************************
  FUNCTIONS                                                                start
*******************************************************************************}

function TFrm_Options.ProjectUsed(Project:String):Integer;
var
  MySQLRow : PMYSQL_ROW;
  Res : Integer;
begin
  Res := -1;
  MySQLsql := 'SELECT id FROM '+dbTblActivityList+' WHERE project = '''+Project+'''';
  if(mysql_query(MySQLConn,pChar(MySQLsql)) = 0) then
  begin
    MySQLRes := mysql_use_result(MySQLConn);
  	MySQLRow := mysql_fetch_row(MySQLRes);
    Res := StrToInt(MySQLRow[0]);
  end;
  Result := Res;
end;

{*******************************************************************************
  FUNCTIONS                                                                  end
*******************************************************************************}
{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                            end
*******************************************************************************}

procedure TFrm_Options.FormCreate(Sender: TObject);
begin
  lblTitle.Caption := Caption;
  MySQLConn := mysql_init(nil);
  mysql_real_connect(MySQLConn,
                     pChar(reg.getString(defRegKey,'DBHost',defDBHost)),
                     pChar(reg.getString(defRegKey,'DBUser',defDBUser)),
                     pChar(reg.getString(defRegKey,'DBPass',defDBPass)),
                     nil,
                     reg.getInteger(defRegKey,'DBPort',defDBPort),
                     nil,
                     0);
  mysql_select_db(MySQLConn,pChar(reg.getString(defRegKey,'DBDatabase',defDBDatabase)));
  UpdateListBox;
end;

procedure TFrm_Options.cbNotifyWtClick(Sender: TObject);
begin
  seWtHours.Enabled := cbNotifyWt.Checked;
  seWtMinutes.Enabled := cbNotifyWt.Checked;
  seWtSeconds.Enabled := cbNotifyWt.Checked;
  editNotifyWtBtTitle.Enabled := cbNotifyWt.Checked;
  memoNotifyWtBtMessage.Enabled := cbNotifyWt.Checked;
end;

procedure TFrm_Options.memoNotifyWtBtMessageChange(Sender: TObject);
begin
  lblNotifyWtBtMessageCounter.Caption := IntToStr(Length(memoNotifyWtBtMessage.Text))+' / 250';
end;

procedure TFrm_Options.cbFadeClick(Sender: TObject);
begin
  tbFadeSpeed.Enabled := cbFade.Checked;
end;

procedure TFrm_Options.btnAddClick(Sender: TObject);
begin
  if editProject.Text <> '' then
//    if not valueExists(cdsProjects,'project',editProject.Text) then
//    begin
  MySQLsql := 'INSERT INTO '+dbTblProject+
    ' (project) '+
    'VALUES'+
    ' ('''+editProject.Text+''')';
  if(mysql_query(MySQLConn,pChar(MySQLsql)) <> 0) then
  begin
    ShowMessage('Insert failed...');
  end;

//  MySQLRes := mysql_store_result(MySQLConn);
//      if not insertRow(cdsProjects,'project',editProject.Text) then
//        ShowMessage('Failed to add Project!');
//    end
//    else ShowMessage('Entry already exists!' + editProject.Text);
  editProject.Clear;
  UpdateListBox;
end;

procedure TFrm_Options.btnDeleteClick(Sender: TObject);
var
  i : Integer;
  projectID : Integer;
  errors : String;
  projectCount : Integer;
begin
  if(lbProject.SelCount > 0) then
  begin
    if MessageDlg('Delete selected entries?',mtWarning,mbOKCancel,0) = mrOk then
    begin
      projectCount := lbProject.Count-1;
      i := 0;
      while i <= projectCount do
      begin
        if(lbProject.Selected[i]) then
        begin
          projectID := ProjectUsed(lbProject.Items.Strings[i]);
          if(projectID > 0) then
          begin
            MySQLsql := 'UPDATE '+dbTblProject+' SET deleted = ''1'' WHERE id = '''+IntToStr(projectID)+'''';
          end
          else
          begin
            MySQLsql := 'DELETE FROM '+dbTblProject+' WHERE project = '''+lbProject.Items.Strings[i]+'''';
          end;
          if(mysql_query(MySQLConn,pChar(MySQLsql)) = 0) then
          begin
            lbProject.Items.Delete(i);
            Dec(projectCount);
            Dec(i);
          end
          else
            errors := errors+#13+lbProject.Items.Strings[i];
        end;
        Inc(i);
      end;
      if(errors <> '') then
        ShowMessage('Failed to delete entries:'+errors);
    end;
  end;
end;

procedure TFrm_Options.editProjectChange(Sender: TObject);
begin
  btnAdd.Enabled := editProject.Text <> '';
end;

procedure TFrm_Options.editProjectKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then btnAdd.Click;
end;

procedure TFrm_Options.dblProjectsDblClick(Sender: TObject);
begin
//  btnDelete.Enabled := dblProjects.SelCount > 0;
end;

procedure TFrm_Options.btnOkClick(Sender: TObject);
begin
{  saveToFile(cdsProjects,dbProjects,dfBinary);}
end;

procedure TFrm_Options.FormShow(Sender: TObject);
begin
{  loadFromFile(cdsProjects,dbProjects);}
end;

procedure TFrm_Options.btnDBTestConnectionClick(Sender: TObject);
var
  MySQLConn : PMYSQL;
begin
  MySQLConn := mysql_init(nil);
  if MySQLConn = nil then ShowMessage('Couldn''t init PMYSQL object');
  if(mysql_real_connect(
    MySQLConn,
    pChar(editDBHost.Text),
    pChar(editDBUser.Text),
    pChar(editDBPass.Text),
    nil,
    strToIntDef(editDBPort.Text, MYSQL_PORT),
    nil,
    0)) = nil
  then ShowMessage('Connection Failed!')
  else ShowMessage('Connection OK!');
  try
  finally
    mysql_close(MySQLConn);
  end;
end;

procedure TFrm_Options.btnDefaultsClick(Sender: TObject);
begin
  editDBHost.Text := defDBHost;
  editDBPort.Text := IntToStr(defDBPort);
  editDBUser.Text := defDBUser;
  editDBPass.Text := defDBPass;
  editDBDatabase.Text := defDBDatabase;
end;

procedure TFrm_Options.FormDestroy(Sender: TObject);
begin
  mysql_close(MySQLConn);
end;

end.
