unit PanelTransactionsList;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Transaction, System.Generics.Collections, PanelBilans,
  PanelTransactionsInGraphic, Vcl.ComCtrls, InterfaceTransactionsController,
  Vcl.Menus, Vcl.ActnList, System.Actions, Vcl.ToolWin;

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
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    mmTransactions: TMenuItem;
    mmLoad: TMenuItem;
    aActions: TActionList;
    aWczytaj: TAction;
    aSaveToDB: TAction;
    SaveToDB: TMenuItem;
    procedure FrameResize(Sender: TObject);
    procedure strTransactionClick(Sender: TObject);
    procedure chbExpenseClick(Sender: TObject);
    procedure chbGraphicallyClick(Sender: TObject);
  protected
    FTransactionList : TObjectList<TTransaction>;
    FTransactionListView : TList<TTransaction>;
    FSummary : TList <TSummary>;
    FController : ITransactionsController;
    function GetSelectedTransaction : TTransaction;
    procedure AddTransaction (p_Transaction : TTransaction;
                              p_Row         : Integer);
    function FindColIndex(p_Title: string): integer;
    function CategoriesToLine (p_Transaction : TTransaction) : string;
  public
    procedure InitStringList;
    procedure Init (p_TransactionList : TList <TTransaction>;
                    p_Summary         : TList <TSummary>);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure UpdateList;
    procedure UpdateChart; virtual;
    procedure UpdateGrid (p_Clear : boolean = true);
    procedure UpdateDescription;
    procedure UpdateBilans;
    property TransactionListView: TList <TTransaction> read FTransactionListView
                                                       write FTransactionListView;
    property TransactionList: TObjectList <TTransaction> read FTransactionList;
  end;

implementation

{$R *.dfm}

uses GUIMethods, InterfaceKernel, InterfaceModuleCategory, Category;

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

procedure TfrmTransasctionsList.UpdateGrid (p_Clear : boolean = true);
var
  pomSelectedRow : Integer;
begin
  pomSelectedRow := strTransaction.Row;
  if p_Clear then strTransaction.RowCount := cDefaultRowCount;

  strTransaction.RowCount := FTransactionListView.Count + 1;
  for var i := 0 to FTransactionListView.Count - 1 do
    AddTransaction(FTransactionListView [i], i + 1);
  if strTransaction.RowCount > 1 then
    strTransaction.FixedRows := 1
  else
    strTransaction.RowCount := 0;

  if strTransaction.RowCount > cDefaultRowCount then
    if pomSelectedRow >= strTransaction.RowCount then
      strTransaction.Row := strTransaction.RowCount - 1
    else if (pomSelectedRow >= cDefaultRowCount) then
      strTransaction.Row := pomSelectedRow
    else
      strTransaction.Row := 1;
end;

procedure TfrmTransasctionsList.UpdateList;
begin
  FController.FilterByImpactExpense(FTransactionList, FTransactionListView,
    chbExpense.Checked, chbImpact.Checked)
end;

procedure TfrmTransasctionsList.FrameResize(Sender: TObject);
begin
  GUIMethods.FitGridAlClient (strTransaction);
end;

function TfrmTransasctionsList.GetSelectedTransaction: TTransaction;
begin
  if strTransaction.Row > 0 then
    Result := FTransactionListView [strTransaction.Row - 1]
  else
    Result := nil;
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
begin
  pomTransaction := GetSelectedTransaction;
  if Assigned (pomTransaction) then
  begin
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
  FController := MainKernel.GiveObjectByInterface (ITransactionsController) as ITransactionsController;
  FTransactionListView := TList <TTransaction>.Create;
  FTransactionList := TObjectList <TTransaction>.Create;
  for var i := 0 to pgcTransactions.PageCount - 1 do
    pgcTransactions.Pages [i].TabVisible := false;
  chbGraphicallyClick (nil);
end;

procedure TfrmTransasctionsList.BeforeDestruction;
begin
  FreeAndNil (FTransactionListView);
  FreeAndNil (FTransactionList);
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
    pomCategoriesModul := MainKernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
    Result := '';
    for var j := 0 to p_Transaction.ArrayCategoryIndex.Count - 2 do
      Result := Result + pomCategoriesModul.FindCategoryByIndex (p_Transaction.ArrayCategoryIndex [j]).CategoryName + ',';
    Result := Result + pomCategoriesModul.FindCategoryByIndex (p_Transaction.ArrayCategoryIndex.Last).CategoryName
  end;
end;

procedure TfrmTransasctionsList.chbExpenseClick(Sender: TObject);
begin
  UpdateList;
  UpdateGrid(true);
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

end.
