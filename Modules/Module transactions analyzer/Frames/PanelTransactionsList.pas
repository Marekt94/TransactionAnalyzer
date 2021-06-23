unit PanelTransactionsList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Transaction, System.Generics.Collections;

type
  TfrmTransasctionsList = class(TFrame)
    pnlDescription: TPanel;
    lblDescription: TLabel;
    lblBilans: TLabel;
    pnlGrid: TPanel;
    strTransaction: TStringGrid;
    procedure FrameResize(Sender: TObject);
  private
    procedure AddTransaction (p_Transaction : TTransaction;
                              p_Row         : Integer);
    function FindColIndex(p_Title: string): integer;
    function CategoriesToLine (p_Transaction : TTransaction) : string;
  public
    procedure UpdateDescription;
    procedure InitStringList;
    procedure FillList (p_TransactionList : TList<TTransaction>;
                        p_Clear           : boolean = true);
    procedure UpdateBilans;
  end;

implementation

{$R *.dfm}

uses GUIMethods, PanelTransactionAnalyzerBoosted, Kernel,
  InterfaceModuleCategory;

procedure TfrmTransasctionsList.AddTransaction (p_Transaction : TTransaction;
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

function TfrmTransasctionsList.FindColIndex(p_Title: string): integer;
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

procedure TfrmTransasctionsList.FillList (p_TransactionList : TList<TTransaction>;
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

procedure TfrmTransasctionsList.FrameResize(Sender: TObject);
begin
  GUIMethods.FitGridAlClient (strTransaction);
end;

procedure TfrmTransasctionsList.UpdateDescription;
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
//  pomTransactionList := FTransactionListFiltered;
//  if (strTransaction.Row > 0) and (pomTransactionList.Count > 0) then
//  begin
//    pomTransaction := pomTransactionList [t.strTransaction.Row - 1];
//
//    with pomTransaction do
//    begin
//      pomExecDate  := Format ('%s:' + sLineBreak + '%s', [cExecutionDate, DateToStr (DocExecutionDate)]);
//      pomOrderDate := Format ('%s:' + sLineBreak + '%s', [cOrderDate,     DateToStr (DocOrderDate)]);
//      pomDocTransactionType := Format ('%s: %s', [cTransactionType, DocTransactionType]);
//      pomDesc := Format ('%s:' + sLineBreak + '%s', [cDescription, DocDescription]);
//      pomAmount := Format ('%s:' + sLineBreak + '%s', [cAmount, FloatToStr (DocAmount)]);
//      pomCategories := 'Kategorie: ' + sLineBreak + CategoriesToLine (pomTransaction);
//      if TransactionType = cExpense then
//        pomType := 'Typ:' + sLineBreak + 'Wydatek'
//      else
//        pomType := 'Typ:' + sLineBreak + 'Wp³yw';
//    end;
//    t.lblDescription.Caption := pomExecDate + sLineBreak + sLineBreak +
//                              pomOrderDate + sLineBreak + sLineBreak +
//                              pomDocTransactionType + sLineBreak + sLineBreak +
//                              pomDesc + sLineBreak + sLineBreak +
//                              pomAmount + sLineBreak + sLineBreak +
//                              pomCategories + sLineBreak + sLineBreak +
//                              pomType;
//  end
//  else
//    t.lblDescription.Caption := '';
end;

procedure TfrmTransasctionsList.InitStringList;
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

function TfrmTransasctionsList.CategoriesToLine (p_Transaction : TTransaction) : string;
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

procedure TfrmTransasctionsList.UpdateBilans;
begin
//  var pomStr : string;
//  pomStr := '';
//  for var pomSummary in FSummary do
//  begin
//    var pomCategory : TCategory;
//    pomCategory := (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories).FindCategoryByIndex (pomSummary.CategoryIndex);
//    pomStr := pomStr + pomCategory.CategoryName + ' - wp³yw: ' + FloatToStr(pomSummary.Impact) + ' - wydatek: ' + FloatToStr (pomSummary.Expense) + sLineBreak;
//  end;
//
//  frmTrnsactionsList.lblBilans.Caption := pomStr;
end;

end.
