unit PanelTransactionAnalyzerBoosted;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.Generics.Collections, Transaction, Vcl.ExtDlgs,
  Category, InterfaceTransactionsController, InterfaceModuleRules,
  InterfaceModuleTransactionAnalyzer, PanelTransactionsList, WindowSkeleton,
  PanelMain;

type
  TFrmTransactionAnalyzerBoosted = class(TFrame)
    pnlFilter: TPanel;
    ofdTransactions: TOpenTextFileDialog;
    frmTrnsactionsList: TfrmTransasctionsList;
    procedure strTransactionClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
  private
    FSummary                 : TList <TSummary>;
    FTransactionListFiltered : TList <TTransaction>;
    FChoosenCategories       : TList<Integer>;
    FController              : ITransactionsController;
    FCategoriesAndChbDict    : TDictionary <TCategory, TCheckBox>;
    FTransWithoutCat         : TList<TTransaction>;
    procedure InitCategories;
    procedure FillChoosenCategories;
    procedure UpdateView;
    procedure LoadAndAnalyzeTransactions;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

uses
  GUIMethods, Kernel, InterfaceModuleCategory, InterfaceTransactionLoader,
  InterfaceRuleSaver, Rule;

{$R *.dfm}

procedure TFrmTransactionAnalyzerBoosted.InitCategories;
begin
  var pomCategories := Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
  for var i := 0 to pomCategories.CategoriesList.Count - 1 do
  begin
    var pomChb : TCheckbox;
    var pomCategory := pomCategories.CategoriesList [i];
    pomChb := TCheckBox.Create(Self);
    with pomChb do
    begin
      Name     := 'chb' + IntToStr (pomCategory.CategoryIndex);
      Caption  := pomCategory.CategoryName;
      Left     := 10;
      Top      := 20 * (i + 1);
      AutoSize := true;
      Parent   := pnlFilter;
      Checked  := true;
      OnClick  := CheckBoxClick;
    end;
    FCategoriesAndChbDict.Add (pomCategory, pomChb);
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.LoadAndAnalyzeTransactions;
var
  pomCategories : IModuleCategories;
  pomRules      : TObjectList<TRule>;
begin
  if ofdTransactions.Execute then
  begin
    FController := Kernel.GiveObjectByInterface (ITransactionsController) as ITransactionsController;
    if Assigned (FController) then
    begin
      pomRules := TObjectList<TRule>.Create;
      try
        (Kernel.GiveObjectByInterface(ITransactionLoader) as ITransactionLoader).Load(FController.TransactionsList, ofdTransactions.FileName);
        (Kernel.GiveObjectByInterface(IRuleSaver) as IRuleSaver).LoadRules (pomRules);
        var pomRuleController : IModuleRules;
        pomRuleController := Kernel.GiveObjectByInterface (IModuleRules) as IModuleRules;
        pomCategories := Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
        FTransWithoutCat.Clear;
        FController.AnalyzeTransactions (FController.TransactionsList, pomRuleController, pomCategories, pomRules, FTransWithoutCat);
        FController.UpdateSummary (FController.TransactionsList, FSummary, pomCategories);
        UpdateView;
      finally
        pomRules.Free;
      end;
    end;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.strTransactionClick(Sender: TObject);
begin
  frmTrnsactionsList.UpdateDescription;
end;

procedure TFrmTransactionAnalyzerBoosted.UpdateView;
begin
  FillChoosenCategories;
  FController.GetTransactionsListFiltered (FController.TransactionsList, FTransactionListFiltered, FChoosenCategories);
  frmTrnsactionsList.Init(FTransactionListFiltered, FSummary);
  frmTrnsactionsList.FillList;
  frmTrnsactionsList.UpdateDescription;
  frmTrnsactionsList.UpdateBilans;
end;

procedure TFrmTransactionAnalyzerBoosted.AfterConstruction;
var
  pomWnd : TWndSkeleton;
  pomFrm : TfrmTransasctionsList;
begin
  inherited;
  FCategoriesAndChbDict := TDictionary <TCategory, TCheckBox>.Create;
  FSummary := TList <TSummary>.Create;
  FTransactionListFiltered := TList <TTransaction>.Create;
  FChoosenCategories := TList<Integer>.Create;
  FTransWithoutCat := TList <TTransaction>.Create;

  frmTrnsactionsList.InitStringList;
  InitCategories;

  LoadAndAnalyzeTransactions;

  pomWnd := TWndSkeleton.Create(nil);
  try
    pomFrm := TfrmTransasctionsList.Create (pomWnd);
    pomWnd.Init(pomFrm, 'Transakcje bez kategorii', false);
    pomFrm.Init (FTransWithoutCat, nil);
    pomFrm.InitStringList;
    pomFrm.FillList;
    pomFrm.UpdateDescription;
    pomWnd.ShowModal;
  finally
    pomWnd.Free;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.BeforeDestruction;
begin
  inherited;
  FreeAndNil (FCategoriesAndChbDict);
  FreeAndNil (FSummary);
  FreeAndNil (FTransactionListFiltered);
  FreeAndNil (FChoosenCategories);
  FreeAndNil (FTransWithoutCat);
end;

procedure TFrmTransactionAnalyzerBoosted.FillChoosenCategories;
var
  pomCategories : TObjectList<TCategory>;
begin
  FChoosenCategories.Clear;
  pomCategories := (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories).CategoriesList;
  for var pomCat in pomCategories do
    if FCategoriesAndChbDict.Items [pomCat].Checked then
      FChoosenCategories.Add (pomCat.CategoryIndex);
end;

procedure TFrmTransactionAnalyzerBoosted.CheckBoxClick(Sender: TObject);
begin
  UpdateView;
end;

end.