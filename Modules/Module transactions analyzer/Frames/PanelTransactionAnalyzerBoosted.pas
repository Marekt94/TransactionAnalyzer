unit PanelTransactionAnalyzerBoosted;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, PanelTransactionsList, BasePanel,
  PanelCategories, PanelTransactionsInGraphic, Vcl.Grids, Vcl.ComCtrls,
  Vcl.StdCtrls, PanelBilans, Vcl.ExtCtrls, Vcl.ExtDlgs,
  InterfaceModuleCategory, System.Generics.Collections, InterfaceTransactionsController, Transaction,
  Category, System.Actions, Vcl.ActnList, Vcl.Menus, Vcl.ToolWin,
  InterfaceTransactionLoader;

type
  TFrmTransactionAnalyzerBoosted2 = class(TfrmTransasctionsList)
    frmCategories: TfrmCategories;
    ofdTransactions: TOpenTextFileDialog;
    mmLoadFromDB: TMenuItem;
    aLoadFromDB: TAction;
    pmTransactionRightClick: TPopupMenu;
    pmAddRule: TMenuItem;
    aAddRule: TAction;
    procedure strTransactionDblClick(Sender: TObject);
    procedure chbExpenseClick(Sender: TObject);
    procedure strTransactionKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure aWczytajExecute(Sender: TObject);
    procedure aSaveToDBExecute(Sender: TObject);
    procedure aLoadFromDBExecute(Sender: TObject);
    procedure strTransactionMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure aAddRuleExecute(Sender: TObject);
    procedure aSaveToDBUpdate(Sender: TObject);
    procedure aLoadFromDBUpdate(Sender: TObject);
  private
    FChoosenCategories       : TList<Integer>;
    FController              : ITransactionsController;
    procedure CheckBoxClick(Sender: TObject);
    function LoadAndAnalyzeTransactions (p_TransactionLoader : ITransactionLoader; p_Path : string = '') : boolean;
    procedure FillChoosenCategories;
    function AnalyzeTransactions : boolean;
    procedure AddRule;
    procedure UpdateView;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure UpdateChart; override;
  end;

implementation

uses
  WindowSkeleton, Kernel, Rule, InterfaceXMLTransactionLoaderSaver, InterfaceRuleSaver,
  InterfaceModuleRules, InterfaceModuleTransactionAnalyzer;

{$R *.dfm}

procedure TFrmTransactionAnalyzerBoosted2.aAddRuleExecute(Sender: TObject);
begin
  inherited;
  AddRule;
end;

procedure TFrmTransactionAnalyzerBoosted2.AddRule;
begin
  (MainKernel.GiveObjectByInterface(IModuleRules) as IModuleRules).OpenMainWindowInAddMode;
  AnalyzeTransactions;
  UpdateView;
  UpdateBilans;
end;

procedure TFrmTransactionAnalyzerBoosted2.AfterConstruction;
begin
  inherited;
  FSummary := TList <TSummary>.Create;
  FChoosenCategories := TList<Integer>.Create;
  FController := MainKernel.GiveObjectByInterface (ITransactionsController) as ITransactionsController;

  InitStringList;
  frmCategories.InitCategories (CheckBoxClick);
end;

procedure TFrmTransactionAnalyzerBoosted2.aLoadFromDBExecute(Sender: TObject);
begin
  inherited;
  LoadAndAnalyzeTransactions ((MainKernel.GiveObjectByInterface(ITransactionLoader) as ITransactionLoader))
end;

procedure TFrmTransactionAnalyzerBoosted2.aLoadFromDBUpdate(Sender: TObject);
begin
  inherited;
  aLoadFromDB.Enabled := Assigned (MainKernel. GiveObjectByInterface (ITransactionLoader, true));
end;

function TFrmTransactionAnalyzerBoosted2.AnalyzeTransactions: boolean;
begin
  var pomRules := TObjectList<TRule>.Create;
  try
    (MainKernel.GiveObjectByInterface(IRuleSaver) as IRuleSaver).LoadRules (pomRules);
    var pomCategories := MainKernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
    FController.AnalyzeTransactions (FTransactionList,pomCategories,
                                     pomRules, nil);
    FController.UpdateSummary (FTransactionList, FSummary, pomCategories);
    Result := true;
  finally
    pomRules.Free;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted2.aSaveToDBExecute(Sender: TObject);
begin
  inherited;
  FController.SaveToDB (FTransactionList);
end;

procedure TFrmTransactionAnalyzerBoosted2.aSaveToDBUpdate(Sender: TObject);
begin
  inherited;
  aSaveToDB.Enabled := Assigned (MainKernel.GiveObjectByInterface (ITransactionLoader, true));
end;

procedure TFrmTransactionAnalyzerBoosted2.aWczytajExecute(Sender: TObject);
begin
  inherited;
  if (MainKernel.GiveObjectByInterface(IModuleTransactionAnalyzer) as IModuleTransactionAnalyzer).RegisterLoaderSaverClass
     and ofdTransactions.Execute
  then
    LoadAndAnalyzeTransactions ((MainKernel.GiveObjectByInterface(IXMLTransactionLoaderSaver) as ITransactionLoader), ofdTransactions.FileName)
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
  pomCategories := (MainKernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories).CategoriesList;
  for var pomCat in pomCategories do
    if frmCategories.CategoriesAndChbDict.Items [pomCat.CategoryIndex].Checked then
      FChoosenCategories.Add (pomCat.CategoryIndex);
end;

function TFrmTransactionAnalyzerBoosted2.LoadAndAnalyzeTransactions (p_TransactionLoader : ITransactionLoader; p_Path : string): boolean;
begin
  Result := false;
  if Assigned (FController) then
  begin
    FTransactionList.Clear;
    p_TransactionLoader.Load (FTransactionList, p_Path);
    Result := AnalyzeTransactions;
    UpdateView;
    UpdateBilans;
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
                                (MainKernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories));
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

procedure TFrmTransactionAnalyzerBoosted2.strTransactionMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Button = mbRight then
    pmTransactionRightClick.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
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
