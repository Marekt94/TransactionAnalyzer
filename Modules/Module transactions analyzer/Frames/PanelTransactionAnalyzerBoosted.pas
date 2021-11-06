unit PanelTransactionAnalyzerBoosted;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.Generics.Collections, Transaction, Vcl.ExtDlgs,
  Category, InterfaceTransactionsController, InterfaceModuleRules,
  InterfaceModuleTransactionAnalyzer, PanelTransactionsList, WindowSkeleton,
  PanelMain, PanelTransactionsInGraphic, BasePanel, PanelCategories;

type
  TFrmTransactionAnalyzerBoosted = class(TFrame)
    ofdTransactions: TOpenTextFileDialog;
    frmTrnsactionsList: TfrmTransasctionsList;
    frmCategories: TfrmCategories;
    procedure strTransactionClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure frmTrnsactionsListchbImpactClick(Sender: TObject);
    procedure frmTrnsactionsListchbGraphicallyClick(Sender: TObject);
    procedure frmTrnsactionsListstrTransactionDblClick(Sender: TObject);
  private
    FSummary                 : TList <TSummary>;
    FTransactionListFiltered : TList <TTransaction>;
    FChoosenCategories       : TList<Integer>;
    FController              : ITransactionsController;
    FTransWithoutCat         : TList<TTransaction>;
    function LoadAndAnalyzeTransactions : boolean;
    procedure FillChoosenCategories;
    procedure UpdateView;
    procedure UpdateChart;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

uses
  GUIMethods, Kernel, InterfaceModuleCategory, InterfaceTransactionLoader,
  InterfaceRuleSaver, Rule;

{$R *.dfm}

function TFrmTransactionAnalyzerBoosted.LoadAndAnalyzeTransactions : boolean;
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
        (Kernel.GiveObjectByInterface(ITransactionLoader) as ITransactionLoader).Load(FController.TransactionsList, ofdTransactions.FileName);
        (Kernel.GiveObjectByInterface(IRuleSaver) as IRuleSaver).LoadRules (pomRules);
        var pomRuleController : IModuleRules;
        pomRuleController := Kernel.GiveObjectByInterface (IModuleRules) as IModuleRules;
        pomCategories := Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
        FTransWithoutCat.Clear;
        FController.AnalyzeTransactions (FController.TransactionsList, pomRuleController, pomCategories, pomRules, FTransWithoutCat);
        FController.UpdateSummary (FController.TransactionsList, FSummary, pomCategories);
        UpdateView;
        frmTrnsactionsList.UpdateBilans;
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

procedure TFrmTransactionAnalyzerBoosted.UpdateChart;
begin
  if frmTrnsactionsList.chbGraphically.Checked then
  begin
    frmTrnsactionsList.frmTransactionInGraphic.UpdateData(FChoosenCategories, FSummary);
    frmTrnsactionsList.UpdateChart;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.UpdateView;
begin
  FillChoosenCategories;
  FController.GetTransactionsListFiltered (FController.TransactionsList,
                                           FTransactionListFiltered,
                                           FChoosenCategories);
  frmTrnsactionsList.Init(FTransactionListFiltered, FSummary);
  frmTrnsactionsList.FillList;
  frmTrnsactionsList.UpdateDescription;
  UpdateChart;
end;

procedure TFrmTransactionAnalyzerBoosted.AfterConstruction;
var
  pomWnd : TWndSkeleton;
  pomFrm : TfrmTransasctionsList;
begin
  inherited;
  FSummary := TList <TSummary>.Create;
  FTransactionListFiltered := TList <TTransaction>.Create;
  FChoosenCategories := TList<Integer>.Create;
  FTransWithoutCat := TList <TTransaction>.Create;

  frmTrnsactionsList.InitStringList;
  frmCategories.InitCategories (CheckBoxClick);

  if LoadAndAnalyzeTransactions then
  begin
    pomWnd := TWndSkeleton.Create(nil);
    try
      pomFrm := TfrmTransasctionsList.Create (pomWnd);
      pomWnd.Init(pomFrm, 'Transakcje bez kategorii', false);
      pomFrm.frmBilans.Visible := False;
      pomFrm.Init (FTransWithoutCat, nil);
      pomFrm.InitStringList;
      pomFrm.FillList;
      pomFrm.UpdateDescription;
      pomWnd.ShowModal;
    finally
      pomWnd.Free;
    end;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.BeforeDestruction;
begin
  inherited;
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
    if frmCategories.CategoriesAndChbDict.Items [pomCat.CategoryIndex].Checked then
      FChoosenCategories.Add (pomCat.CategoryIndex);
end;

procedure TFrmTransactionAnalyzerBoosted.frmTrnsactionsListchbGraphicallyClick(
  Sender: TObject);
begin
  UpdateChart;
  frmTrnsactionsList.chbGraphicallyClick(Sender);
end;

procedure TFrmTransactionAnalyzerBoosted.frmTrnsactionsListchbImpactClick(
  Sender: TObject);
begin
  frmTrnsactionsList.chbExpenseClick(Sender);
  UpdateChart;
end;

procedure TFrmTransactionAnalyzerBoosted.frmTrnsactionsListstrTransactionDblClick(Sender: TObject);
var
  pomWndSkeleton : TWndSkeleton;
  pomCategories : TfrmCategories;
begin
  pomWndSkeleton := TWndSkeleton.Create(nil);
  pomCategories := TfrmCategories.Create (pomWndSkeleton);
  try
    pomWndSkeleton.Init (pomCategories, 'Kategorie');
    pomCategories.InitCategories(nil, false);
    pomCategories.Unpack (FTransactionListFiltered [frmTrnsactionsList.strTransaction.Row - 1].ArrayCategoryIndex);
    if pomWndSkeleton.ShowModal = mrOk then
    begin
      var pomList := FTransactionListFiltered [frmTrnsactionsList.strTransaction.Row - 1].ArrayCategoryIndex as TObject;
      pomCategories.Pack (pomList);
      FController.UpdateSummary(FController.TransactionsList,
                                FSummary,
                                (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories));
      frmTrnsactionsList.frmBilans.UpdateBilans (FSummary);
      UpdateView;
    end;
  finally
    pomWndSkeleton.Free;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.CheckBoxClick(Sender: TObject);
begin
  UpdateView;
end;

end.
