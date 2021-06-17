unit TransactionController;

interface

uses
  InterfaceTransactionsController, Transaction, System.Generics.Collections,
  InterfaceModuleRuleController, System.SysUtils, InterfaceModuleCategory,
  Kernel;

type
  TTransactionController = class (TInterfacedObject, ITransactionsController)
  strict private
    FTransactionList : TObjectList<TTransaction>;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function GetTransactionsList : TObjectList <TTransaction>;
    function AnalyzeTransactions (p_Transactions   : TObjectList <TTransaction>;
                                  p_RuleController : IModuleRuleController;
                                  p_Categories     : IModuleCategories) : boolean;
    function UpdateSummary (    p_Transactions :  TObjectList <TTransaction>;
                            out p_Summary: TList <TSummary>;
                                p_Categories: IModuleCategories) : boolean; overload;
    function GetTransactionsListFiltered (
          p_TransactionList         : TObjectList <TTransaction>;
      out p_TransactionListFiltered : TList <TTransaction>;
          p_ChoosenCategories       : TList<Integer>): boolean; overload;
  end;

implementation

{ TTransactionController }

procedure TTransactionController.AfterConstruction;
begin
  inherited;
  FTransactionList         := TObjectList<TTransaction>.Create;
end;

function TTransactionController.AnalyzeTransactions(
  p_Transactions   : TObjectList <TTransaction>;
  p_RuleController : IModuleRuleController;
  p_Categories     : IModuleCategories) : boolean;
begin
  if not Assigned (p_RuleController) then
    raise Exception.Create('No rule controller');

  if not Assigned (p_Transactions) then
    raise Exception.Create('No transactions list');

  for var pomTransaction in p_Transactions do
  begin
    pomTransaction.ArrayCategoryIndex.Clear;
    for var pomRule in p_RuleController.RuleList do
      if pomRule.FullfilConditions (pomTransaction) then
        pomTransaction.ArrayCategoryIndex.Add (pomRule.CategoryIndex);

    if  pomTransaction.ArrayCategoryIndex.Count < 1 then
       pomTransaction.ArrayCategoryIndex.Add (cDefaultCategoryIndex);

    if pomTransaction.DocAmount >= 0 then
      pomTransaction.TransactionType := cImpact
    else
      pomTransaction.TransactionType := cExpense
  end;

  Result := True;
end;

procedure TTransactionController.BeforeDestruction;
begin
  inherited;
  FreeAndNil (FTransactionList);
end;

function TTransactionController.GetTransactionsList: TObjectList<TTransaction>;
begin
  Result := FTransactionList;
end;

function TTransactionController.GetTransactionsListFiltered (
      p_TransactionList         : TObjectList <TTransaction>;
  out p_TransactionListFiltered : TList <TTransaction>;
      p_ChoosenCategories       : TList<Integer>): boolean;
begin
  if    not Assigned (p_TransactionList)
     or not Assigned (p_TransactionListFiltered)
     or not Assigned (p_ChoosenCategories)
  then
    Exit (False);

  p_TransactionListFiltered.Clear;
  for var i := 0 to p_TransactionList.Count - 1 do
  begin
    for var pomCategory in p_ChoosenCategories do
    begin
      if p_TransactionList [i].ArrayCategoryIndex.Contains (pomCategory) then
      begin
        p_TransactionListFiltered.Add (p_TransactionList [i]);
        break;
      end;
    end;
  end;
  Result := True;
end;

function TTransactionController.UpdateSummary(    p_Transactions :  TObjectList <TTransaction>;
                                              out p_Summary: TList <TSummary>;
                                                  p_Categories: IModuleCategories): boolean;
begin
  if not Assigned (p_Transactions) then
    raise Exception.Create('No transactions list');

  if not Assigned (p_Summary) then
    raise Exception.Create('No summary list');

  if not Assigned (p_Categories) then
    raise Exception.Create('No categories');

  p_Summary.Clear;
  for var pomCategory in p_Categories.CategoriesList do
  begin
    var pomSummary : TSummary;
    pomSummary.Expense := 0;
    pomSummary.Impact  := 0;
    pomSummary.CategoryIndex := pomCategory.CategoryIndex;

    for var pomTransaction in p_Transactions do
    begin
      if pomTransaction.ArrayCategoryIndex.Contains (pomCategory.CategoryIndex) then
        if pomTransaction.TransactionType = cExpense then
          pomSummary.Expense := pomSummary.Expense + pomTransaction.DocAmount
        else
          pomSummary.Impact := pomSummary.Impact + pomTransaction.DocAmount;
    end;

    p_Summary.Add (pomSummary)
  end;
  Result := True;
end;

end.
