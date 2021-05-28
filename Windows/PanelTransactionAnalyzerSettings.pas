unit PanelTransactionAnalyzerSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls;

resourcestring
  rs_ConditionsVisualizerMain = 'Wybierz transakcje, które zawieraj¹ %s.';
  rs_TitleConditions = 'tekst ''%s'' w tytule';
  rs_and = 'oraz';
  rs_DateConditions = 'datê pomiêdzy %s a %s';

type
  TfrmTransactionAnalyzerSettings = class(TFrame)
    GridPanel1: TGridPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    chbTitleContains: TCheckBox;
    edtTitleContains: TEdit;
    chbDateBetween: TCheckBox;
    dtpFromDate: TDateTimePicker;
    Label1: TLabel;
    dtpToDate: TDateTimePicker;
    mmoConditionsVisualizer: TMemo;
    procedure edtTitleContainsChange(Sender: TObject);
    procedure dtpFromDateChange(Sender: TObject);
    procedure dtpToDateChange(Sender: TObject);
    procedure chbDateBetweenClick(Sender: TObject);
    procedure chbTitleContainsClick(Sender: TObject);
  private
    procedure RefreshConditionsVisualizer (p_Mmo : TMemo);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TfrmTransactionAnalyzerSettings }

procedure TfrmTransactionAnalyzerSettings.chbDateBetweenClick(Sender: TObject);
begin
  RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

procedure TfrmTransactionAnalyzerSettings.chbTitleContainsClick(
  Sender: TObject);
begin
  RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

procedure TfrmTransactionAnalyzerSettings.dtpFromDateChange(Sender: TObject);
begin
  if chbDateBetween.Checked then
    RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

procedure TfrmTransactionAnalyzerSettings.dtpToDateChange(Sender: TObject);
begin
  if chbDateBetween.Checked then
    RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

procedure TfrmTransactionAnalyzerSettings.edtTitleContainsChange(
  Sender: TObject);
begin
  if chbTitleContains.Checked then
    RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

procedure TfrmTransactionAnalyzerSettings.RefreshConditionsVisualizer(
  p_Mmo: TMemo);
var
  pomTitle : string;
  pomDate  : string;
  pomResultText : string;
begin
  pomTitle := '';
  pomDate := '';
  pomResultText := '';
  
  if chbTitleContains.Checked then
    pomTitle := Format (rs_TitleConditions, [edtTitleContains.Text]);
  if chbDateBetween.Checked then
    pomDate := Format (rs_DateConditions, [DateToStr (dtpFromDate.Date), DateToStr (dtpToDate.Date)]);

  if not pomTitle.IsEmpty and not pomDate.IsEmpty then
    pomResultText := pomTitle + ' ' + rs_and + ' ' + pomDate
  else if not pomTitle.IsEmpty then
    pomResultText := pomTitle
  else if not pomDate.IsEmpty then
    pomResultText := pomDate
  else
  begin
    mmoConditionsVisualizer.Text := '';
    Exit;
  end;

  mmoConditionsVisualizer.Text := '';
  mmoConditionsVisualizer.Text := Format (rs_ConditionsVisualizerMain, [pomResultText]);
end;

end.
