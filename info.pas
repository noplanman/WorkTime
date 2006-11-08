unit info;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, jpeg, ShellApi, ExtCtrls, JvExControls,
  JvComponent, JvSpeedButton;

type
  TFrm_Info = class(TForm)
    pnlBg: TPanel;
    imgPic: TImage;
    lblName: TLabel;
    lblAuthor: TLabel;
    lblEmail: TLabel;
    lblHomepage: TLabel;
    lblCopyright: TLabel;
    lblVersion: TLabel;
    btnClose: TJvSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure lblHomepageClick(Sender: TObject);
    procedure lblEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Info: TFrm_Info;

implementation
uses globalDefinitions;

{$R *.dfm}

procedure TFrm_Info.FormCreate(Sender: TObject);
begin
  lblName.Caption := progName;
  lblVersion.Caption := 'v.'+progVersion;
  lblAuthor.Caption := progAuthor;
  lblEmail.Caption := progAuthorEmail;
  lblHomepage.Caption := progAuthorHomepage;
  lblCopyright.Caption := progCopyright;
end;

procedure TFrm_Info.lblHomepageClick(Sender: TObject);
begin
  ShellExecute(Application.Handle,
               'open',
               PChar(progAuthorHomepage),
               nil,
               nil,
               SW_ShowNormal);
end;

procedure TFrm_Info.lblEmailClick(Sender: TObject);
begin
  ShellExecute(Application.Handle,
               'open',
               PChar('mailto:'+progAuthorEmail+'?subject='+progName+' '+progVersion),
               nil,
               nil,
               sw_ShowNormal);
end;

end.
