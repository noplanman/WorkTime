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
    npNotifications: TJvNavPanelPage;
    npVarious: TJvNavPanelPage;
    npStyleManager: TJvNavPaneStyleManager;
    imgTitle: TImage;
    lblTitle: TLabel;
    gradButtons: TJvGradient;
    editNotifyWtBtTitle: TLabeledEdit;
    btnBrowse: TSpeedButton;
    editLogFilePath: TLabeledEdit;
    procedure cbNotifyWtClick(Sender: TObject);
    procedure memoNotifyWtBtMessageChange(Sender: TObject);
    procedure cbFadeClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure _MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure btnDefaultsClick(Sender: TObject);
  private
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

{*******************************************************************************
  PROCEDURES                                                                 end
*******************************************************************************}
{*******************************************************************************
  FUNCTIONS                                                                start
*******************************************************************************}

{*******************************************************************************
  FUNCTIONS                                                                  end
*******************************************************************************}
{*******************************************************************************
  CUSTOM PROCEDURES AND FUNCTIONS                                            end
*******************************************************************************}

procedure TFrm_Options.FormCreate(Sender: TObject);
begin
  lblTitle.Caption := Caption;
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

procedure TFrm_Options.btnOkClick(Sender: TObject);
begin
{  saveToFile(cdsProjects,dbProjects,dfBinary);}
end;

procedure TFrm_Options.FormShow(Sender: TObject);
begin
{  loadFromFile(cdsProjects,dbProjects);}
end;

procedure TFrm_Options.btnDefaultsClick(Sender: TObject);
begin
  editLogFilePath.Text := defLogFilePath;
end;

end.
