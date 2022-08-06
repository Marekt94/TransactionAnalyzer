unit PanelSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Settings;

type
  TfrmSettings = class(TFrame)
    GroupBox1: TGroupBox;
    edtMainFolderPAth: TLabeledEdit;
    btnLoad: TButton;
    ofdMainFolderSelector: TFileOpenDialog;
    procedure btnLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Unpack (const p_Settings : TSettings);
    procedure Pack   (var p_Settings : TSettings);
  end;

implementation

{$R *.dfm}

procedure TfrmSettings.btnLoadClick(Sender: TObject);
begin
  if ofdMainFolderSelector.Execute then
    edtMainFolderPAth.Text := ofdMainFolderSelector.FileName + '\';
end;

procedure TfrmSettings.Pack(var p_Settings: TSettings);
begin
  p_Settings.MainFolderPath := edtMainFolderPAth.Text;
end;

procedure TfrmSettings.Unpack(const p_Settings: TSettings);
begin
  edtMainFolderPAth.Text := p_Settings.MainFolderPath;
end;

end.
