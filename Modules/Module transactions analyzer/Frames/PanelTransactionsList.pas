unit PanelTransactionsList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Transaction, System.Generics.Collections, PanelBilans,
  PanelTransactionsInGraphic, Vcl.ComCtrls;

const
  cLP              = 'L. p.';
  cExecutionDate   = 'Data wykonania';
  cOrderDate       = 'Data zamówienia';
  cTransactionType = 'Typ';
  cDescription     = 'Tytu³';
  cAmount          = 'Kwota';
  cCategories      = 'Kategorie';

  cDefaultRowCount = 1;
  cDefaultColCount = 7;

type
  TfrmTransasctionsList = class(TFrame)
    pnlDescription: TPanel;
    lblDescription: TLabel;
    pnlGrid: TPanel;
    strTransaction: TStringGrid;
    chbImpact: TCheckBox;
    chbExpense: TCheckBox;
    grpDescription: TGroupBox;
    grpFoot: TGroupBox;
    frmBilans: TfrmBilans;
    frmTransactionInGraphic: TfrmTransactionsInGraphic;
    pgcTransactions: TPageControl;
    tabGrid: TTabSheet;
    tabChart: TTabSheet;
    chbGraphically: TCheckBox;
    procedure FrameResize(Sender: TObject);
    procedure strTransactionClick(Sender: TObject);
    procedure chbExpenseClick(Sender: TObject);
    procedure chbGraphicallyClick(Sender: TObject);
  private
    FTransactionList : TList<TTransaction>;
    FTransactionListFiltered : TList<TTransaction>;
    FSummary : TList <TSummary>;
    procedure AddTransaction (p_Transaction : TTransaction;
                              p_Row         : Integer);
    function FindColIndex(p_Title: string): integer;
    function CategoriesToLine (p_Transaction : TTransaction) : string;
    procedure FillList (p_TransactionList : TList<TTransaction>;
                        p_Clear           : boolean = true); overload;
    procedure UpdateDescription (p_TransactionList : TList<TTransaction>); overload;
  public
    procedure InitStringList;
    procedure FillList (p_Clear : boolean = true); overload;
    procedure UpdateDescription; overload;
    procedure UpdateBilans;
    procedure Init (p_TransactionList : TList <TTransaction>;
                    p_Summary         : TList <TSummary>);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure UpdateChart;
  end;

implementation

{$R *.dfm}

uses GUIMethods, Kernel, InterfaceModuleCategory, Category, System.Math;

procedure TfrmTransasctionsList.AddTransaction (p_Transaction : TTransaction;
                                                p_Row         : Integer);
begin
  try
    with strTransaction do
    begin
      Cells [FindColIndex (cLP),              p_Row] := IntToStr(p_Row) + '.';
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

procedure TfrmTransasctionsList.FillList(p_Clear: boolean);
begin
  FTransactionListFiltered.Clear;
  for var pomTransaction in FTransactionList do
  begin
    if chbImpact.Checked and (pomTransaction.TransactionType = cImpact) then
      FTransactionListFiltered.Add (pomTransaction);

    if chbExpense.Checked and (pomTransaction.TransactionType = cExpense) then
      FTransactionListFiltered.Add (pomTransaction);
  end;
  FillList(FTransactionListFiltered, p_Clear);
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

procedure TfrmTransasctionsList.UpdateDescription (p_TransactionList : TList<TTransaction>);
var
  pomExecDate, pomOrderDate : string;
  pomDocTransactionType : string;
  pomDesc : string;
  pomAmount : string;
  pomCategories : string;
  pomType : string;

  pomTransaction : TTransaction;
begin
  if (strTransaction.Row > 0) and (p_TransactionList.Count > 0) then
  begin
    pomTransaction := p_TransactionList [strTransaction.Row - 1];

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

procedure TfrmTransasctionsList.Init(p_TransactionList: TList<TTransaction>;
  p_Summary: TList<TSummary>);
begin
  FTransactionList := p_TransactionList;
  FSummary := p_Summary;
end;

procedure TfrmTransasctionsList.InitStringList;
begin
  with strTransaction do
  begin
    ColCount := cDefaultColCount;
    Cells [0,0] := cLP;
    Cells [1,0] := cExecutionDate;
    Cells [2,0] := cOrderDate;
    Cells [3,0] := cTransactionType;
    Cells [4,0] := cDescription;
    Cells [5,0] := cAmount;
    Cells [6,0] := cCategories;
  end;
end;

procedure TfrmTransasctionsList.strTransactionClick(Sender: TObject);
begin
  UpdateDescription;
end;

procedure TfrmTransasctionsList.AfterConstruction;
begin
  inherited;
  FTransactionListFiltered := TList <TTransaction>.Create;
  for var i := 0 to pgcTransactions.PageCount - 1 do
    pgcTransactions.Pages [i].TabVisible := false;
  chbGraphicallyClick (nil);
end;

procedure TfrmTransasctionsList.BeforeDestruction;
begin
  FreeAndNil (FTransactionListFiltered);
  inherited;
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

procedure TfrmTransasctionsList.chbExpenseClick(Sender: TObject);
begin
  FillList(true);
  UpdateDescription;
  UpdateChart;
end;

procedure TfrmTransasctionsList.chbGraphicallyClick(Sender: TObject);
begin
  if chbGraphically.Checked then
    pgcTransactions.ActivePageIndex := 1
  else
    pgcTransactions.ActivePageIndex := 0;
end;

procedure TfrmTransasctionsList.UpdateBilans;
begin
  frmBilans.UpdateBilans (FSummary);
end;

procedure TfrmTransasctionsList.UpdateChart;
begin
  frmTransactionInGraphic.ssImpact.Visible   := chbImpact.Checked;
  frmTransactionInGraphic.ssExpenses.Visible := chbExpense.Checked;
end;

procedure TfrmTransasctionsList.UpdateDescription;
begin
  UpdateDescription (FTransactionListFiltered)
end;

end.
