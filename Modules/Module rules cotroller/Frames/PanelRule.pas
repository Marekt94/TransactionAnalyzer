unit PanelRule;

interface

uses
  InterfaceBasePanel, Vcl.StdCtrls, Vcl.ComCtrls, System.Generics.Collections, Category,
  System.Classes, Vcl.Controls, Vcl.Forms, System.SysUtils, InterfaceModuleCategory;

type
  TfrmRule = class(TFrame, IBasePanel, IBasePanelValidator)
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
    chbPrice: TCheckBox;
    edtPriceLow: TEdit;
    Label3: TLabel;
    edtPriceMax: TEdit;
    procedure edtTitleContainsChange(Sender: TObject);
    procedure dtpFromDateChange(Sender: TObject);
    procedure dtpToDateChange(Sender: TObject);
    procedure chbDateBetweenClick(Sender: TObject);
    procedure chbTitleContainsClick(Sender: TObject);
    procedure cmbCategoriesChange(Sender: TObject);
    procedure chbPriceClick(Sender: TObject);
    procedure edtPriceLowChange(Sender: TObject);
    procedure edtPriceMaxChange(Sender: TObject);
  strict private
    FCategoryList : TObjectList <TCategory>;
    FCategories : IModuleCategories;
    procedure RefreshRulesVisualizer (p_Mmo : TMemo);
  public
    constructor Create(AOwner: TComponent); override;
    function Unpack (const p_Object : TObject) : boolean;
    function Pack   (var   p_Object : TObject) : boolean;
    procedure Clean;
    function Check : boolean;
  end;

implementation

uses
  InterfaceKernel, Rule,
  InterfaceRulesController, Vcl.Dialogs, System.UITypes;

{$R *.dfm}

{ TfrmTransactionAnalyzerSettings }

procedure TfrmRule.chbDateBetweenClick(Sender: TObject);
begin
  RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.chbPriceClick(Sender: TObject);
begin
  RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.chbTitleContainsClick(Sender: TObject);
begin
  RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

function TfrmRule.Check: boolean;
begin
  Result := chbTitleContains.Checked or chbDateBetween.Checked or chbPrice.Checked;
  if not Result then
    MessageDlg('Co najmniej jeden z checkbox''ów musi byæ zaznaczony',
      mtInformation, [mbOK], 0);
end;

procedure TfrmRule.Clean;
begin

end;

procedure TfrmRule.cmbCategoriesChange(Sender: TObject);
begin
  RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

constructor TfrmRule.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FCategories := MainKernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
  FCategoryList := FCategories.CategoriesList;
  cmbCategories.AddItem('',nil);
  for var i := 0 to FCategoryList.Count - 1 do
    cmbCategories.AddItem (FCategoryList.Items [i].CategoryName, TObject (FCategoryList.Items [i].CategoryIndex));
  cmbCategories.ItemIndex := 0;
end;

procedure TfrmRule.dtpFromDateChange(Sender: TObject);
begin
  if chbDateBetween.Checked then
    RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.dtpToDateChange(Sender: TObject);
begin
  if chbDateBetween.Checked then
    RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.edtPriceLowChange(Sender: TObject);
begin
  RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.edtPriceMaxChange(Sender: TObject);
begin
  RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.edtTitleContainsChange(Sender: TObject);
begin
  if chbTitleContains.Checked then
    RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.RefreshRulesVisualizer(p_Mmo: TMemo);
var
  pomRule : TRule;
begin
  pomRule := TRule.Create;
  try
    Pack (TObject (pomRule));

    mmoConditionsVisualizer.Text := '';
    mmoConditionsVisualizer.Text := (MainKernel.GiveObjectByInterface(IRulesController) as IRulesController).GetRuleDescription (pomRule);
  finally
    pomRule.Free;
  end;
end;

function TfrmRule.Unpack (const p_Object : TObject) : boolean;
var
  pomRule           : TRule;
  pomRuleController : IModuleCategories;
  pomCategory       : TCategory;
begin
  Result := true;
  pomRule := p_Object as TRule;
  if Assigned (pomRule) then
  begin
    pomRuleController := MainKernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
    if Assigned (pomRuleController) then
    begin
      pomCategory := pomRuleController.FindCategoryByIndex(pomRule.CategoryIndex);
      if Assigned (pomCategory) then
        cmbCategories.ItemIndex  := cmbCategories.Items.IndexOfObject (TObject (pomCategory.CategoryIndex));
    end;
    chbTitleContains.Checked := pomRule.TitleContains;
    chbDateBetween.Checked   := pomRule.DateBetween;
    chbPrice.Checked         := pomRule.PriceBetween;
    edtTitleContains.Text    := pomRule.TitleSubstring;
    dtpFromDate.Date         := pomRule.DateFrom;
    dtpToDate.Date           := pomRule.DateTo;
    edtPriceLow.Text         := FloatToStr (pomRule.PriceLow);
    edtPriceMax.Text         := FloatToStr (pomRule.PriceHigh);
    RefreshRulesVisualizer (mmoConditionsVisualizer)
  end;
end;

function TfrmRule.Pack(var p_Object : TObject) : boolean;
var
  pomCategory : TCategory;
  pomRule     : TRule;
begin
  pomRule := p_Object as TRule;
  with pomRule do
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

    PriceBetween := chbPrice.Checked;
    if PriceBetween then
    begin
      PriceLow  := StrToFloat (edtPriceLow.Text);
      PriceHigh := StrToFloat (edtPriceMax.Text);
    end;

    pomCategory := FCategories.FindCategoryByIndex (Integer (cmbCategories.Items.Objects [cmbCategories.ItemIndex]));
    if not Assigned (pomCategory) then
      CategoryIndex := -1
    else
      CategoryIndex := pomCategory.CategoryIndex;
  end;
  Result := true;
end;

end.
