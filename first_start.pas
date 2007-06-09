unit first_start;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvSpeedButton, JvExControls, JvComponent, JvGradient,
  ExtCtrls, jpeg, Buttons, mysql;

type
  TFrm_First = class(TForm)
    lblMessage: TLabel;
    editDBUser: TLabeledEdit;
    editDBPort: TLabeledEdit;
    editDBPass: TLabeledEdit;
    editDBHost: TLabeledEdit;
    editDBDatabase: TLabeledEdit;
    pnlButtons: TPanel;
    gradButtons: TJvGradient;
    btnOk: TJvSpeedButton;
    btnCancel: TJvSpeedButton;
    btnClose: TJvSpeedButton;
    imgTitle: TImage;
    lblTitle: TLabel;
    btnDBTestConnection: TSpeedButton;
    btnDefaults: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnDBTestConnectionClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure InfosComplete(Sender: TObject);
    procedure _MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure btnDefaultsClick(Sender: TObject);
  private
    procedure CreateDBTables;
    function CheckCreateDB:Boolean;
    function CreateRegEntries:Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_First: TFrm_First;

implementation
uses
  functions, globalDefinitions, Math, reg;

{$R *.dfm}

{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                          start
*******************************************************************************}
{*******************************************************************************
  PROCEDURES                                                               start
*******************************************************************************}

procedure TFrm_First._MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (ssLeft in Shift) then
  begin
    ReleaseCapture;
    SendMessage(Self.Handle, WM_SYSCOMMAND, SC_MOVE+1,0);
  end;
end;

procedure TFrm_First.InfosComplete(Sender: TObject);
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

procedure TFrm_First.CreateDBTables;
var
  MySQLConn : PMYSQL;
  sql : String;
begin
  MySQLConn := mysql_init(nil);
  mysql_real_connect(
  MySQLConn,
  pChar(editDBHost.Text),
  pChar(editDBUser.Text),
  pChar(editDBPass.Text),
  nil,
  strToIntDef(editDBPort.Text, MYSQL_PORT),
  nil,
  0);
  try
    try
      mysql_select_db(MySQLConn,pChar(LowerCase(editDBDatabase.Text)));
      sql := 'CREATE TABLE '+dbTblWorktime+' ('+
        'id int(19) NOT NULL auto_increment,'+
        'activity_list_id int(19) NOT NULL,'+
        'start_time TIMESTAMP NOT NULL,'+
        'end_time TIMESTAMP NOT NULL,'+
        'start_noon TIMESTAMP NOT NULL,'+
        'end_noon TIMESTAMP NOT NULL,'+
        'PRIMARY KEY(id))'+
        'ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci';
      mysql_query(MySQLConn,pChar(sql));

      sql := 'CREATE TABLE '+dbTblActivity+' ('+
        'id int(19) NOT NULL auto_increment,'+
        'project_id int(19) NOT NULL,'+
        'activity text collate latin1_general_ci NOT NULL,'+
        'PRIMARY KEY(id))'+
        'ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci';
      mysql_query(MySQLConn,pChar(sql));

      sql := 'CREATE TABLE '+dbTblActivityList+' ('+
        'id int(19) NOT NULL auto_increment,'+
        'activity_id int(19) NOT NULL,'+
        'PRIMARY KEY(id))'+
        'ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci';
      mysql_query(MySQLConn,pChar(sql));

      sql := 'CREATE TABLE '+dbTblProject+' ('+
        'id int(19) NOT NULL auto_increment,'+
        'project varchar(250) NOT NULL,'+
        'deleted int(19) NOT NULL,'+
        'PRIMARY KEY(id))'+
        'ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci';
      mysql_query(MySQLConn,pChar(sql));
    except
      ShowMessage(mysql_error(MySQLConn));
    end;
  finally
    mysql_close(MySQLConn);
  end;
end;

{*******************************************************************************
  PROCEDURES                                                                 end
*******************************************************************************}
{*******************************************************************************
  FUNCTIONS                                                                start
*******************************************************************************}

// Check if DB exists. If it exists prompt if a new one shall be created.
function TFrm_First.CheckCreateDB:Boolean;
var
  OK : Boolean;
  MySQLConn : PMYSQL;
begin
  OK := True;
  if(TestMySQLConnection(editDBHost.Text,editDBUser.Text,editDBPass.Text,StrToInt(editDBPort.Text))) then
  begin
    MySQLConn := mysql_init(nil);
    mysql_real_connect(
    MySQLConn,
    pChar(editDBHost.Text),
    pChar(editDBUser.Text),
    pChar(editDBPass.Text),
    nil,
    strToIntDef(editDBPort.Text, MYSQL_PORT),
    nil,
    0);
    try
      try
        if(mysql_select_db(MySQLConn,pChar(editDBDatabase.Text)) = 0) then
        begin
          case MessageDlg('Selected Database already exists!'+#13+'Drop Database and create a new one?',
          mtConfirmation,
          mbYesNoCancel,
          0) of
          mrYes :
            begin
              if mysql_drop_db(MySQLConn,pChar(editDBDatabase.Text)) = 0 then
              begin
                if mysql_create_db(MySQLConn,pChar(editDBDatabase.Text)) = 0 then
                begin
                  CreateDBTables;
                  ShowMessage('Database created successfully!');
                end
                else
                  ShowMessage('Failed to create Database!');
              end
              else
                ShowMessage('Failed to drop old Database!');
            end;
          mrCancel :
            begin
              OK := False;
            end;
          end;
        end
        else
        begin
          case MessageDlg('Selected Database doesn''t exist!'+#13+'Create it?',
          mtConfirmation,
          mbOKCancel,
          0) of
          mrOK :
            begin
              if mysql_create_db(MySQLConn,pChar(editDBDatabase.Text)) = 0 then
              begin
                CreateDBTables;
                ShowMessage('Database created successfully!');
              end
              else
                ShowMessage('Failed to create Database!');
            end;
          end;
        end;
      except
        OK := False;
        ShowMessage(mysql_error(MySQLConn));
      end;
    finally
      mysql_close(MySQLConn);
    end;
  end
  else
    ShowMessage('Couldn''t Connect To MySQL Server');
  Result := OK;
end;

function TFrm_First.CreateRegEntries:Boolean;
begin
  if(not reg.setBoolean(defRegKey,'NotifyWt',defNotifyWt)) then begin Result := False; exit; end;
  if(not reg.setString(defRegKey,'NotifyWtBtTitle',defNotifyWtBtTitle)) then begin Result := False; exit; end;
  if(not reg.setString(defRegKey,'NotifyWtBtMessage',defNotifyWtBtMessage)) then begin Result := False; exit; end;

  if(not reg.setInteger(defRegKey,'HotKeyNoon',defHotKeyNoon)) then begin Result := False; exit; end;
  if(not reg.setBoolean(defRegKey,'Fade',defFade)) then begin Result := False; exit; end;
  if(not reg.setInteger(defRegKey,'FadeSpeed',defFadeSpeed)) then begin Result := False; exit; end;
  if(not reg.setBoolean(defRegKey,'StartMinimized',defStartMinimized)) then begin Result := False; exit; end;

  //Database
  if(not reg.setString(defRegKey,'DBHost',editDBHost.Text)) then begin Result := False; exit; end;
  if(not reg.setInteger(defRegKey,'DBPort',StrToInt(editDBPort.Text))) then begin Result := False; exit; end;
  if(not reg.setString(defRegKey,'DBUser',editDBUser.Text)) then begin Result := False; exit; end;
  if(not reg.setString(defRegKey,'DBPass',editDBPass.Text)) then begin Result := False; exit; end;
  if(not reg.setString(defRegKey,'DBDatabase',editDBDatabase.Text)) then begin Result := False; exit; end;

  Result := True;
end;

{*******************************************************************************
  FUNCTIONS                                                                  end
*******************************************************************************}
{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                            end
*******************************************************************************}

procedure TFrm_First.FormCreate(Sender: TObject);
begin
  lblTitle.Caption := Caption;
  lblMessage.Caption := 'Please complete MySQL DB Connection options.';
  editDBHost.Text := reg.getString(defRegKey,'DBHost',defDBHost);
  editDBPort.Text := IntToStr(reg.getInteger(defRegKey,'DBPort',defDBPort));
  editDBUser.Text := reg.getString(defRegKey,'DBUser',defDBUser);
  editDBPass.Text := reg.getString(defRegKey,'DBPass',defDBPass);
  editDBDatabase.Text := reg.getString(defRegKey,'DBDatabase',defDBDatabase);
end;

procedure TFrm_First.btnDBTestConnectionClick(Sender: TObject);
begin
  if(TestMySQLConnection(editDBHost.Text,editDBUser.Text,editDBPass.Text,StrToIntDef(editDBPort.Text,defDBPort))) then
    ShowMessage('Connection OK!')
  else
    ShowMessage('Couldn''t Connect To MySQL Server');
end;

procedure TFrm_First.btnOkClick(Sender: TObject);
begin
  if(CheckCreateDB)then
  begin
    if(CreateRegEntries) then
    begin
      ShowMessage('Registry Values Successfully Written!');
      ShowMessage('Please restart the program!');
      Close;
    end
    else
      ShowMessage('Error While Writting Registry Values');
  end;
end;

procedure TFrm_First.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFrm_First.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrm_First.btnDefaultsClick(Sender: TObject);
begin
  editDBHost.Text := defDBHost;
  editDBPort.Text := IntToStr(defDBPort);
  editDBUser.Text := defDBUser;
  editDBPass.Text := defDBPass;
  editDBDatabase.Text := defDBDatabase;
end;

end.
