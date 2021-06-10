unit PanelRule;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.ComCtrls, Rule, System.Generics.Collections, Category,
  InterfaceModuleRuleController;

type
  TfrmRule = class(TFrame)
    GroupBox1: TGroupBox;
    chbTitleContains: TCheckBox;
    edtTitleContains: TEdit;
    chbDateBetween: TCheckBox;
    dtpFromDate: TDateTimePicker;
    Label1: TLabel;
    dtpToDate: TDateTimePicker;
    mmoConditionsVisualizer: TMemo;
    Label2: TLabel;
    cmbCategories: TComboBox;
    procedure edtTitleContainsChange(Sender: TObject);
    procedure dtpFromDateChange(Sender: TObject);
    procedure dtpToDateChange(Sender: TObject);
    procedure chbDateBetweenClick(Sender: TObject);
    procedure chbTitleContainsClick(Sender: TObject);
    procedure cmbCategoriesChange(Sender: TObject);
  strict private
    FCategoryList : TObjectList <TCategory>;
    function FindCategoryByIndex (p_Index : Integer) : TCategory;
    procedure RefreshConditionsVisualizer (p_Mmo : TMemo);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Unpack (const p_Rule : TRule);
    procedure Pack (var p_Rule : TRule);
    { Public declarations }
  end;

implementation

uses
  InterfaceModuleCategory, Kernel;

{$R *.dfm}

{ TfrmTransactionAnalyzerSettings }

procedure TfrmRule.chbDateBetweenClick(Sender: TObject);
begin
  RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

procedure TfrmRule.chbTitleContainsClick(
  Sender: TObject);
begin
  RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

procedure TfrmRule.cmbCategoriesChange(Sender: TObject);
begin
  RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

constructor TfrmRule.Create(AOwner: TComponent);
var
  pomCategories : IModuleCategories;
begin
  inherited Create (AOwner);
  pomCategories := GiveObjectByInterface (IModuleCategories) as IModuleCategories;
  FCategoryList := pomCategories.CategoriesList;
  cmbCategories.AddItem('',nil);
  for var i := 0 to pomCategories.CategoriesList.Count - 1 do
    cmbCategories.AddItem (FCategoryList.Items [i].CategoryName, FCategoryList.Items [i]);
end;

procedure TfrmRule.dtpFromDateChange(Sender: TObject);
begin
  if chbDateBetween.Checked then
    RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

procedure TfrmRule.dtpToDateChange(Sender: TObject);
begin
  if chbDateBetween.Checked then
    RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

procedure TfrmRule.edtTitleContainsChange(
  Sender: TObject);
begin
  if chbTitleContains.Checked then
    RefreshConditionsVisualizer(mmoConditionsVisualizer);
end;

function TfrmRule.FindCategoryByIndex(p_Index: Integer): TCategory;
begin
  for var i := 0 to FCategoryList.Count - 1 do
    if FCategoryList.Items [i].CategoryIndex = p_Index then
      Exit (FCategoryList.Items [i]);

  Result := nil;
end;

procedure TfrmRule.RefreshConditionsVisualizer(
  p_Mmo: TMemo);
var
  pomRule : TRule;
begin
  pomRule := TRule.Create;
  try
    Pack (pomRule);

    mmoConditionsVisualizer.Text := '';
    mmoConditionsVisualizer.Text := (Kernel.GiveObjectByInterface(IModuleRuleController) as IModuleRuleController).GetRuleDescription (pomRule);
  finally
    pomRule.Free;
  end;
end;

procedure TfrmRule.Unpack(const p_Rule: TRule);
begin
  if Assigned (p_Rule) then
  begin
    cmbCategories.ItemIndex  := cmbCategories.Items.IndexOfObject (FindCategoryByIndex (p_Rule.CategoryIndex));
    chbTitleContains.Checked := p_Rule.TitleContains;
    chbDateBetween.Checked   := p_Rule.DateBetween;
    edtTitleContains.Text    := p_Rule.TitleSubstring;
    dtpFromDate.Date         := p_Rule.DateFrom;
    dtpToDate.Date           := p_Rule.DateTo;
    RefreshConditionsVisualizer (mmoConditionsVisualizer)
  end;
end;

procedure TfrmRule.Pack(var p_Rule: TRule);
var
  pomCategory : TCategory;
begin
  with p_Rule do
  begin
    TitleContains := chbTitleContains.Checked;
    if TitleContains then
      TitleSubstring := edtTitleContains.Text;

    DateBetween := chbDateBetween.Checked;
    if DateBetween then
    begin
      DateTo   := dtpToDate.Date;
      DateFrom := dtpFromDate.Date;
    end;

    pomCategory := TCategory (cmbCategories.Items.Objects [cmbCategories.ItemIndex]);
    if not Assigned (pomCategory) then
      CategoryIndex := -1
    else
      CategoryIndex := pomCategory.CategoryIndex;
  end
end;

end.
