unit PanelTransactionAnalyzerBoosted;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PanelTransactionsList, BasePanel,
  PanelCategories, PanelTransactionsInGraphic, Vcl.Grids, Vcl.ComCtrls,
  Vcl.StdCtrls, PanelBilans, Vcl.ExtCtrls, Vcl.ExtDlgs,
  InterfaceModuleCategory, System.Generics.Collections, InterfaceTransactionsController, Transaction,
  Category, System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.ToolWin;

type
  TFrmTransactionAnalyzerBoosted2 = class(TfrmTransasctionsList)
    frmCategories: TfrmCategories;
    ofdTransactions: TOpenTextFileDialog;
    procedure strTransactionDblClick(Sender: TObject);
    procedure chbExpenseClick(Sender: TObject);
    procedure strTransactionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure aWczytajExecute(Sender: TObject);
  private
    FChoosenCategories       : TList<Integer>;
    FController              : ITransactionsController;
    procedure CheckBoxClick(Sender: TObject);
    function LoadAndAnalyzeTransactions : boolean;
    procedure FillChoosenCategories;
    procedure UpdateView;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure UpdateChart; override;
  end;

implementation

uses
  WindowSkeleton, Kernel, Rule, InterfaceTransactionLoader, InterfaceRuleSaver,
  InterfaceModuleRules;

{$R *.dfm}

procedure TFrmTransactionAnalyzerBoosted2.AfterConstruction;
begin
  inherited;
  FSummary := TList <TSummary>.Create;
  FChoosenCategories := TList<Integer>.Create;

  InitStringList;
  frmCategories.InitCategories (CheckBoxClick);
end;

procedure TFrmTransactionAnalyzerBoosted2.aWczytajExecute(Sender: TObject);
begin
  inherited;
  LoadAndAnalyzeTransactions
end;

procedure TFrmTransactionAnalyzerBoosted2.BeforeDestruction;
begin
  inherited;
  FreeAndNil (FSummary);
  FreeAndNil (FChoosenCategories);
end;

procedure TFrmTransactionAnalyzerBoosted2.chbExpenseClick(Sender: TObject);
begin
  UpdateView;
end;

procedure TFrmTransactionAnalyzerBoosted2.CheckBoxClick(Sender: TObject);
begin
  UpdateView;
end;

procedure TFrmTransactionAnalyzerBoosted2.FillChoosenCategories;
var
  pomCategories : TObjectList<TCategory>;
begin
  FChoosenCategories.Clear;
  pomCategories := (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories).CategoriesList;
  for var pomCat in pomCategories do
    if frmCategories.CategoriesAndChbDict.Items [pomCat.CategoryIndex].Checked then
      FChoosenCategories.Add (pomCat.CategoryIndex);
end;

function TFrmTransactionAnalyzerBoosted2.LoadAndAnalyzeTransactions: boolean;
var
  pomCategories : IModuleCategories;
  pomRules      : TObjectList<TRule>;
begin
  Result := ofdTransactions.Execute;
  if Result then
  begin
    FController := Kernel.GiveObjectByInterface (ITransactionsController) as ITransactionsController;
    if Assigned (FController) then
    begin
      pomRules := TObjectList<TRule>.Create;
      try
        FTransactionList.Clear;
        (Kernel.GiveObjectByInterface(ITransactionLoader) as ITransactionLoader).Load(FTransactionList, ofdTransactions.FileName);
        (Kernel.GiveObjectByInterface(IRuleSaver) as IRuleSaver).LoadRules (pomRules);
        var pomRuleController : IModuleRules;
        pomRuleController := Kernel.GiveObjectByInterface (IModuleRules) as IModuleRules;
        pomCategories := Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
        FController.AnalyzeTransactions (FTransactionList, pomRuleController,
                                         pomCategories, pomRules, nil);
        FController.UpdateSummary (FTransactionList, FSummary, pomCategories);
        UpdateView;
        UpdateBilans;
      finally
        pomRules.Free;
      end;
    end;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted2.strTransactionDblClick(
  Sender: TObject);
var
  pomWndSkeleton : TWndSkeleton;
  pomCategories : TfrmCategories;
begin
  pomWndSkeleton := TWndSkeleton.Create(nil);
  pomCategories := TfrmCategories.Create (pomWndSkeleton);
  try
    pomWndSkeleton.Init (pomCategories, 'Kategorie');
    pomCategories.InitCategories(nil, false);
    pomCategories.Unpack (GetSelectedTransaction.ArrayCategoryIndex);
    if pomWndSkeleton.ShowModal = mrOk then
    begin
      var pomList := GetSelectedTransaction.ArrayCategoryIndex as TObject;
      pomCategories.Pack (pomList);
      FController.UpdateSummary(FTransactionList, FSummary,
                                (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories));
      frmBilans.UpdateBilans (FSummary);
      UpdateView;
    end;
  finally
    pomWndSkeleton.Free;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted2.strTransactionKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
    strTransactionDblClick (nil);
end;

procedure TFrmTransactionAnalyzerBoosted2.UpdateChart;
begin
  frmTransactionInGraphic.UpdateData(FChoosenCategories, FSummary);
  inherited UpdateChart;
end;

procedure TFrmTransactionAnalyzerBoosted2.UpdateView;
begin
  FillChoosenCategories;
  FController.Filter (FTransactionList,
                      FTransactionListView,
                      FChoosenCategories,
                      chbExpense.Checked,
                      chbImpact.Checked);
  UpdateGrid;
  UpdateDescription;
  UpdateChart;
end;

end.
