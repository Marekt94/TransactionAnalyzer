unit PanelTransactionAnalyzerBoosted;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls, System.Generics.Collections, Transaction, Vcl.ExtDlgs, InterfaceModuleTransactionAnalyzer;

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
    procedure FrameResize(Sender: TObject);
    procedure strTransactionClick(Sender: TObject);
  private
    FController : IModuleTransactionAnalyzer;
    procedure InitStringList;
    procedure FillList (p_TransactionList: TObjectList<TTransaction>;
                        p_Clear : boolean = true);
    procedure UpdateView;
    procedure UpdateDescription;
    procedure AddTransaction (p_Transaction: TTransaction; p_Row: Integer);
    function FindColIndex(p_Title: string): integer;
    function CategoriesToLine (p_Transaction : TTransaction) : string;
  public
    procedure AfterConstruction; override;
  end;

implementation

uses
  GUIMethods, Kernel, InterfaceModuleCategory;

{$R *.dfm}

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

procedure TFrmTransactionAnalyzerBoosted.strTransactionClick(Sender: TObject);
begin
  UpdateDescription;
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
begin
  if (strTransaction.Row > 0) and (FController.TransactionList.Count > 0) then
  begin
    pomTransaction := FController.TransactionList [strTransaction.Row - 1];

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
  FillList (FController.TransactionList, True);
  UpdateDescription;
end;

procedure TFrmTransactionAnalyzerBoosted.FrameResize(Sender: TObject);
begin
  GUIMethods.FitGridAlClient (strTransaction);
end;

procedure TFrmTransactionAnalyzerBoosted.AfterConstruction;
begin
  inherited;
  InitStringList;
  if ofdTransactions.Execute then
  begin
    FController := Kernel.GiveObjectByInterface (IModuleTransactionAnalyzer) as IModuleTransactionAnalyzer;
    if Assigned (FController) then
    begin
      FController.LoadTransactions(ofdTransactions.FileName);
      FController.AnalyzeTransactions (FController.TransactionList);
      UpdateView;
    end;
  end;
end;

procedure TFrmTransactionAnalyzerBoosted.FillList (p_TransactionList : TObjectList<TTransaction>;
                                                   p_Clear           : boolean = true);
begin
  if p_Clear then strTransaction.RowCount := cDefaultRowCount;

  strTransaction.RowCount := p_TransactionList.Count;
  for var i := 0 to p_TransactionList.Count - 1 do
    AddTransaction(p_TransactionList [i], i + 1);
  strTransaction.FixedRows := 1;
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

end.
