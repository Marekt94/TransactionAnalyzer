unit PanelTransactionList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, 
  System.Generics.Collections, Transaction, Vcl.ExtDlgs, Vcl.StdCtrls,
  Vcl.ExtCtrls, InterfaceModuleTransactionAnalyzer;

const
  cExecutionDate   = 'Execution date';
  cOrderDate       = 'Order date';
  cTransactionType = 'Transaction type';
  cDescription     = 'Description';
  cAmount          = 'Amount';

  cDefaultRowCount = 1;
  cDefaultColCount = 5;

type
  TfrmTransactionList = class(TFrame)
    strTransaction: TStringGrid;
    pnlNavigation: TPanel;
    btnLoad: TButton;
    ofdOpenTransactionFile: TOpenTextFileDialog;
    butShowCategories: TButton;
    btnAnalyzeConditions: TButton;
    procedure btnLoadClick(Sender: TObject);
    procedure butShowCategoriesClick(Sender: TObject);
    procedure btnAnalyzeConditionsClick(Sender: TObject);
  strict private
    function FindColIndex (p_Title : string) : integer;  
    procedure InitStringList;
    procedure FillList (p_TransactionList : TObjectList <TTransaction>;
                        p_Clear           : boolean = true);
    procedure AddTransaction (p_Transaction : TTransaction; p_Row : Integer);
  public
    constructor Create (AOwner: TComponent); override;
  end;

implementation

uses
  Main, InterfaceModuleTransactionLoader, InterfaceModuleCategory;

{$R *.dfm}

{ TfrmTransactionList }

procedure TfrmTransactionList.AddTransaction (p_Transaction: TTransaction;
  p_Row: Integer);
begin
  try
    with strTransaction do
    begin
      Cells [FindColIndex (cExecutionDate),   p_Row] := DateToStr (p_Transaction.DocExecutionDate);
      Cells [FindColIndex (cOrderDate),       p_Row] := DateToStr (p_Transaction.DocOrderDate);
      Cells [FindColIndex (cTransactionType), p_Row] := p_Transaction.DocTransactionType;
      Cells [FindColIndex (cDescription),     p_Row] := p_Transaction.DocDescription;
      Cells [FindColIndex (cAmount),          p_Row] := FloatToStr (p_Transaction.DocAmount);
    end;
  except
    strTransaction.RowCount := cDefaultRowCount;
  end;
end;

procedure TfrmTransactionList.btnAnalyzeConditionsClick(Sender: TObject);
var
  pomTrAnalSettings : IModuleTransactionAnalyzer;
begin
  pomTrAnalSettings := GiveObjectByInterface (IModuleTransactionAnalyzer) as IModuleTransactionAnalyzer;
  pomTrAnalSettings.SetConditions;
end;

procedure TfrmTransactionList.btnLoadClick(Sender: TObject);
var
  pomLoader : IModuleTransactionLoader;
begin
  if ofdOpenTransactionFile.Execute (Handle) then
  begin
    pomLoader := GiveObjectByInterface (IModuleTransactionLoader) as IModuleTransactionLoader;
    if pomLoader.LoadTransactions (ofdOpenTransactionFile.FileName) then;
      FillList (pomLoader.TransactionList);
  end
end;

procedure TfrmTransactionList.butShowCategoriesClick(Sender: TObject);
var
  pomCat : IModuleCategories;
begin
  pomCat := GiveObjectByInterface (IModuleCategories) as IModuleCategories;
  var pomTekst : string;
  for var i := 0 to pomCat.CategoryList.Count - 1 do
    pomTekst := pomTekst + pomCat.CategoryList.Items [i].CategoryName + ' ';

  ShowMessage (pomTekst);
end;

constructor TfrmTransactionList.Create (AOwner: TComponent);
begin
  inherited Create (AOwner);
  InitStringList;
end;

procedure TfrmTransactionList.FillList (p_TransactionList: TObjectList<TTransaction>;
                                        p_Clear : boolean = true);
begin
  if p_Clear then strTransaction.RowCount := cDefaultRowCount;

  strTransaction.RowCount := p_TransactionList.Count;
  for var i := 0 to p_TransactionList.Count - 1 do
    AddTransaction(p_TransactionList [i], i + 1);
  strTransaction.FixedRows := 1;
end;

function TfrmTransactionList.FindColIndex(p_Title: string): integer;
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

procedure TfrmTransactionList.InitStringList;
begin
  with strTransaction do
  begin
    ColCount := cDefaultColCount;
    Cells [0,0] := cExecutionDate;
    Cells [1,0] := cOrderDate;
    Cells [2,0] := cTransactionType;
    Cells [3,0] := cDescription;
    Cells [4,0] := cAmount;
  end;
end;

end.