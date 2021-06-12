unit PanelRule;

interface

uses
  BasePanel, Vcl.StdCtrls, Vcl.ComCtrls, System.Generics.Collections, Category,
  System.Classes, Vcl.Controls;

type
  TfrmRule = class(TFrmBasePanel)
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
    procedure RefreshRulesVisualizer (p_Mmo : TMemo);
  public
    constructor Create(AOwner: TComponent); override;
    function Unpack (const p_Object : TObject) : boolean; override;
    function Pack   (var   p_Object : TObject) : boolean; override;
  end;

implementation

uses
  InterfaceModuleCategory, Kernel, Rule, InterfaceModuleRuleController;

{$R *.dfm}

{ TfrmTransactionAnalyzerSettings }

procedure TfrmRule.chbDateBetweenClick(Sender: TObject);
begin
  RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.chbTitleContainsClick(Sender: TObject);
begin
  RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.cmbCategoriesChange(Sender: TObject);
begin
  RefreshRulesVisualizer (mmoConditionsVisualizer);
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
    RefreshRulesVisualizer (mmoConditionsVisualizer);
end;

procedure TfrmRule.dtpToDateChange(Sender: TObject);
begin
  if chbDateBetween.Checked then
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
    mmoConditionsVisualizer.Text := (Kernel.GiveObjectByInterface(IModuleRuleController) as IModuleRuleController).GetRuleDescription (pomRule);
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
  Result := inherited Unpack(p_Object);
  pomRule := p_Object as TRule;
  if Assigned (pomRule) then
  begin
    pomRuleController := Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
    if Assigned (pomRuleController) then
    begin
      pomCategory := pomRuleController.FindCategoryByIndex(pomRule.CategoryIndex);
      if Assigned (pomCategory) then
        cmbCategories.ItemIndex  := cmbCategories.Items.IndexOfObject (pomCategory);
    end;
    chbTitleContains.Checked := pomRule.TitleContains;
    chbDateBetween.Checked   := pomRule.DateBetween;
    edtTitleContains.Text    := pomRule.TitleSubstring;
    dtpFromDate.Date         := pomRule.DateFrom;
    dtpToDate.Date           := pomRule.DateTo;
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

    pomCategory := TCategory (cmbCategories.Items.Objects [cmbCategories.ItemIndex]);
    if not Assigned (pomCategory) then
      CategoryIndex := -1
    else
      CategoryIndex := pomCategory.CategoryIndex;
  end;
  Result := inherited Pack(p_Object);
end;

end.
