unit PanelTransactionAnalyzerBoosted;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.Generics.Collections, Transaction, Vcl.ExtDlgs,
  Category, InterfaceTransactionsController, InterfaceModuleRuleController,
  InterfaceModuleTransactionAnalyzer;

const
  cExecutionDate   = 'Data wykonania';
  cOrderDate       = 'Data zamówienia';
  cTransactionType = 'Typ';
  cDescription     = 'Tytu³';
  cAmount          = 'Kwota';
  cCategories      = 'Kategorie';

  cDefaultRowCount = 1;
  cDefaultColCount = 6;

type
  TFrmTransactionAnalyzerBoosted = class(TFrame)
    pnlGrid: TPanel;
    pnlFilter: TPanel;
    pnlDescription: TPanel;
    lblDescription: TLabel;
    strTransaction: TStringGrid;
    ofdTransactions: TOpenTextFileDialog;
    Label1: TLabel;
    lblBilans: TLabel;
    procedure FrameResize(Sender: TObject);
    procedure strTransactionClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
  private
    FSummary                 : TList <TSummary>;
    FTransactionListFiltered : TList <TTransaction>;
    FChoosenCategories       : TList<Integer>;
    FController              : ITransactionsController;
    FCategoriesAndChbDict    : TDictionary <TCategory, TCheckBox>;
    procedure InitCategories;
    procedure InitStringList;
    procedure FillList (p_TransactionList : TList<TTransaction>;
                        p_Clear           : boolean = true);
    procedure FillChoosenCategories;
    procedure UpdateView;
    procedure UpdateDescription;
    procedure UpdateBilans;
    procedure AddTransaction (p_Transaction: TTransaction; p_Row: Integer);
    procedure LoadAndAnalyzeTransactions;
    function FindColIndex(p_Title: string): integer;
    function CategoriesToLine (p_Transaction : TTransaction) : string;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

uses
  GUIMethods, Kernel, InterfaceModuleCategory, InterfaceTransactionLoader;

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

procedure TFrmTransactionAnalyzerBoosted.InitStringList;
begin
  with strTransaction do
  begin
    ColCount := cDefaultColCount;
    Cells [0,0] := cExecutionDate;
    Cells [1,0] := cOrderDate;
    Cells [2,0] := cTransactionType;
    Cells [3,0] := cDescription;
    Cells [4,0] := cAmount;
    Cells [5,0] := cCategories;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.LoadAndAnalyzeTransactions;
var
  pomCategories : IModuleCategories;
begin
  if ofdTransactions.Execute then
  begin
    FController := Kernel.GiveObjectByInterface (ITransactionsController) as ITransactionsController;
    if Assigned (FController) then
    begin
      (Kernel.GiveObjectByInterface(ITransactionLoader) as ITransactionLoader).Load(FController.TransactionsList, ofdTransactions.FileName);
      var pomRuleController : IModuleRuleController;
      pomRuleController := Kernel.GiveObjectByInterface (IModuleRuleController) as IModuleRuleController;
      pomCategories := Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
      FController.AnalyzeTransactions (FController.TransactionsList, pomRuleController, pomCategories);
      FController.UpdateSummary (FController.TransactionsList, FSummary, pomCategories);
      UpdateView;
    end;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.strTransactionClick(Sender: TObject);
begin
  UpdateDescription;
end;

procedure TFrmTransactionAnalyzerBoosted.UpdateBilans;
begin
  var pomStr : string;
  pomStr := '';
  for var pomSummary in FSummary do
  begin
    var pomCategory : TCategory;
    pomCategory := (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories).FindCategoryByIndex (pomSummary.CategoryIndex);
    pomStr := pomStr + pomCategory.CategoryName + ' - wp³yw: ' + FloatToStr(pomSummary.Impact) + ' - wydatek: ' + FloatToStr (pomSummary.Expense) + sLineBreak;
  end;

  lblBilans.Caption := pomStr;
end;

procedure TFrmTransactionAnalyzerBoosted.UpdateDescription;
var
  pomExecDate, pomOrderDate : string;
  pomDocTransactionType : string;
  pomDesc : string;
  pomAmount : string;
  pomCategories : string;
  pomType : string;

  pomTransaction : TTransaction;
  pomTransactionList : TList<TTransaction>;
begin
  pomTransactionList := FTransactionListFiltered;
  if (strTransaction.Row > 0) and (pomTransactionList.Count > 0) then
  begin
    pomTransaction := pomTransactionList [strTransaction.Row - 1];

    with pomTransaction do
    begin
      pomExecDate  := Format ('%s:' + sLineBreak + '%s', [cExecutionDate, DateToStr (DocExecutionDate)]);
      pomOrderDate := Format ('%s:' + sLineBreak + '%s', [cOrderDate,     DateToStr (DocOrderDate)]);
      pomDocTransactionType := Format ('%s: %s', [cTransactionType, DocTransactionType]);
      pomDesc := Format ('%s:' + sLineBreak + '%s', [cDescription, DocDescription]);
      pomAmount := Format ('%s:' + sLineBreak + '%s', [cAmount, FloatToStr (DocAmount)]);
      pomCategories := 'Kategorie: ' + sLineBreak + CategoriesToLine (pomTransaction);
      if TransactionType = cExpense then
        pomType := 'Typ:' + sLineBreak + 'Wydatek'
      else
        pomType := 'Typ:' + sLineBreak + 'Wp³yw';
    end;
    lblDescription.Caption := pomExecDate + sLineBreak + sLineBreak +
                              pomOrderDate + sLineBreak + sLineBreak +
                              pomDocTransactionType + sLineBreak + sLineBreak +
                              pomDesc + sLineBreak + sLineBreak +
                              pomAmount + sLineBreak + sLineBreak +
                              pomCategories + sLineBreak + sLineBreak +
                              pomType;
  end
  else
    lblDescription.Caption := '';
end;

procedure TFrmTransactionAnalyzerBoosted.UpdateView;
begin
  FillChoosenCategories;
  FController.GetTransactionsListFiltered (FController.TransactionsList, FTransactionListFiltered, FChoosenCategories);
  FillList (FTransactionListFiltered, true);
  UpdateDescription;
  UpdateBilans;
end;

procedure TFrmTransactionAnalyzerBoosted.FrameResize(Sender: TObject);
begin
  GUIMethods.FitGridAlClient (strTransaction);
end;

procedure TFrmTransactionAnalyzerBoosted.AfterConstruction;
begin
  inherited;
  FCategoriesAndChbDict := TDictionary <TCategory, TCheckBox>.Create;
  FSummary := TList <TSummary>.Create;
  FTransactionListFiltered := TList <TTransaction>.Create;
  FChoosenCategories := TList<Integer>.Create;

  InitStringList;
  InitCategories;

  LoadAndAnalyzeTransactions;
end;

procedure TFrmTransactionAnalyzerBoosted.BeforeDestruction;
begin
  inherited;
  FreeAndNil (FCategoriesAndChbDict);
  FreeAndNil (FSummary);
  FreeAndNil (FTransactionListFiltered);
  FreeAndNil (FChoosenCategories);
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

procedure TFrmTransactionAnalyzerBoosted.FillList (p_TransactionList : TList<TTransaction>;
                                                   p_Clear           : boolean = true);
begin
  if p_Clear then strTransaction.RowCount := cDefaultRowCount;

  strTransaction.RowCount := p_TransactionList.Count + 1;
  for var i := 0 to p_TransactionList.Count - 1 do
    AddTransaction(p_TransactionList [i], i + 1);
  if strTransaction.RowCount > 1 then
    strTransaction.FixedRows := 1
  else
    strTransaction.RowCount := 0;
end;

function TFrmTransactionAnalyzerBoosted.FindColIndex(p_Title: string): integer;
resourcestring
  rs_NoSuchColumn_s = 'Kolumna o takiej nazwie nie istnieje : %s';
begin
  for var i := 0 to strTransaction.ColCount - 1 do
  begin
    if strTransaction.Cells [i, 0] = p_Title then
      Exit (i);
  end;
  raise Exception.Create(Format (rs_NoSuchColumn_s, [p_Title]));
end;

procedure TFrmTransactionAnalyzerBoosted.AddTransaction (p_Transaction : TTransaction;
                                                         p_Row         : Integer);
begin
  try
    with strTransaction do
    begin
      Cells [FindColIndex (cExecutionDate),   p_Row] := DateToStr (p_Transaction.DocExecutionDate);
      Cells [FindColIndex (cOrderDate),       p_Row] := DateToStr (p_Transaction.DocOrderDate);
      Cells [FindColIndex (cTransactionType), p_Row] := p_Transaction.DocTransactionType;
      Cells [FindColIndex (cDescription),     p_Row] := p_Transaction.DocDescription;
      Cells [FindColIndex (cAmount),          p_Row] := FloatToStr (p_Transaction.DocAmount);
      Cells [FindColIndex (cCategories),      p_Row] := CategoriesToLine (p_Transaction);
    end;
  except
    strTransaction.RowCount := cDefaultRowCount;
  end;
end;

function TFrmTransactionAnalyzerBoosted.CategoriesToLine (p_Transaction : TTransaction) : string;
var
  pomCategoriesModul : IModuleCategories;
begin
  if not Assigned (p_Transaction.ArrayCategoryIndex) then
    Exit ('');
  for var i := 0 to p_Transaction.ArrayCategoryIndex.Count - 1 do
  begin
    pomCategoriesModul := Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
    Result := '';
    for var j := 0 to p_Transaction.ArrayCategoryIndex.Count - 2 do
      Result := Result + pomCategoriesModul.FindCategoryByIndex (p_Transaction.ArrayCategoryIndex [j]).CategoryName + ',';
    Result := Result + pomCategoriesModul.FindCategoryByIndex (p_Transaction.ArrayCategoryIndex.Last).CategoryName
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.CheckBoxClick(Sender: TObject);
begin
  UpdateView;
end;

end.
