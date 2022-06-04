unit TransactionController;

interface

uses
  InterfaceTransactionsController, Transaction, System.Generics.Collections,
  InterfaceModuleRules, System.SysUtils, InterfaceModuleCategory,
  Kernel, Rule;

type
  TTransactionController = class (TInterfacedObject, ITransactionsController)
  public
    function AnalyzeTransactions (p_Transactions    : TObjectList <TTransaction>;
                                  p_RuleController  : IModuleRules;
                                  p_Categories      : IModuleCategories;
                                  p_Rules           : TObjectList <TRule>;
                                  p_TransWithoutCat : TList <TTransaction>) : boolean;
    function UpdateSummary (const p_Transactions :  TObjectList <TTransaction>;
                            var p_Summary: TList <TSummary>;
                            const p_Categories: IModuleCategories) : boolean; overload;
    function FilterByChoosenCategories (
      p_TransactionList         : TList <TTransaction>;
      p_TransactionListFiltered : TList <TTransaction>;
      p_ChoosenCategories       : TList <Integer>): boolean; overload;
    function FilterByImpactExpense (
            p_TransactionList : TList <TTransaction>;
            p_TransactionListFiltered : TList <TTransaction>;
      const p_Expense : boolean = true;
      const p_Impact  : boolean = true): boolean;
    function Filter (
            p_TransactionList : TList <TTransaction>;
        out p_TransactionListFiltered : TList <TTransaction>;
            p_ChoosenCategories : TList<Integer>;
      const p_Expense : boolean = true;
      const p_Impact  : boolean = true): boolean;
    function EvaluateExpenseSum (p_Summary : TList <TSummary>;
                                 p_ChoosenCat : TList<Integer>) : Double;
    function EvaluateImpactSum (p_Summary : TList <TSummary>;
                                p_ChoosenCat : TList<Integer>) : Double;
    function SaveToDB (p_List : TObjectList <TTransaction>): boolean;
  end;

implementation

uses
  InterfaceTransactionLoader, UsefullMethods;

{ TTransactionController }

function TTransactionController.AnalyzeTransactions(
  p_Transactions    : TObjectList <TTransaction>;
  p_RuleController  : IModuleRules;
  p_Categories      : IModuleCategories;
  p_Rules           : TObjectList <TRule>;
  p_TransWithoutCat : TList <TTransaction>) : boolean;
begin
  if not Assigned (p_RuleController) then
    raise Exception.Create('No rule controller');

  if not Assigned (p_Transactions) then
    raise Exception.Create('No transactions list');

  for var pomTransaction in p_Transactions do
  begin
    pomTransaction.ArrayCategoryIndex.Clear;
    for var pomRule in p_Rules do
      if pomRule.FullfilConditions (pomTransaction) then
        pomTransaction.ArrayCategoryIndex.Add (pomRule.CategoryIndex);

    if  pomTransaction.ArrayCategoryIndex.Count < 1 then
    begin
      pomTransaction.ArrayCategoryIndex.Add (cDefaultCategoryIndex);
      if Assigned (p_TransWithoutCat) then
        p_TransWithoutCat.Add (pomTransaction);
    end;

    if pomTransaction.DocAmount >= 0 then
      pomTransaction.TransactionType := cImpact
    else
      pomTransaction.TransactionType := cExpense
  end;

  Result := True;
end;

function TTransactionController.EvaluateExpenseSum (
  p_Summary : TList <TSummary>; p_ChoosenCat : TList<Integer>) : Double;
begin
  Result := 0;
  for var pomSummary in p_Summary do
  begin
    if     Assigned (p_ChoosenCat)
       and p_ChoosenCat.Contains (pomSummary.CategoryIndex)
    then
      Result := Result + pomSummary.Expense;
  end;

  Result := Abs (Result);
end;

function TTransactionController.EvaluateImpactSum (
  p_Summary : TList <TSummary>; p_ChoosenCat : TList<Integer>) : Double;
begin
  Result := 0;
  for var pomSummary in p_Summary do
  begin
    if     Assigned (p_ChoosenCat)
       and p_ChoosenCat.Contains (pomSummary.CategoryIndex)
    then
      Result := Result + pomSummary.Impact;
  end;

  Result := Abs (Result);
end;

function TTransactionController.Filter(p_TransactionList: TList<TTransaction>;
  out p_TransactionListFiltered: TList<TTransaction>;
      p_ChoosenCategories: TList<Integer>; const p_Expense,
                                                 p_Impact: boolean): boolean;
var
  pomTransactionListTemp : TList <TTransaction>;
begin
  p_TransactionListFiltered.Clear;
  pomTransactionListTemp := TList <TTransaction>.Create;
  try
    FilterByChoosenCategories (p_TransactionList,
                               pomTransactionListTemp,
                               p_ChoosenCategories);
    FilterByImpactExpense(pomTransactionListTemp,
                          p_TransactionListFiltered,
                          p_Expense, p_Impact);
  finally
    pomTransactionListTemp.Free;
  end;
  Result := True;
end;

function TTransactionController.FilterByChoosenCategories (
  p_TransactionList         : TList <TTransaction>;
  p_TransactionListFiltered : TList <TTransaction>;
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

function TTransactionController.FilterByImpactExpense(
            p_TransactionList : TList <TTransaction>;
            p_TransactionListFiltered : TList <TTransaction>;
      const p_Expense : boolean = true;
      const p_Impact  : boolean = true): boolean;
begin
  p_TransactionListFiltered.Clear;
  for var pomTransaction in p_TransactionList do
  begin
    if p_Impact and (pomTransaction.TransactionType = cImpact) then
      p_TransactionListFiltered.Add (pomTransaction);

    if p_Expense and (pomTransaction.TransactionType = cExpense) then
      p_TransactionListFiltered.Add (pomTransaction);
  end;
  Result := true;
end;

function TTransactionController.SaveToDB(p_List: TObjectList<TTransaction>): boolean;
var
  pomTransactionSaverLoader : ITransactionLoader;
  pomHighestIndex : Integer;
begin
  pomTransactionSaverLoader := (MainKernel.GiveObjectByInterface (ITransactionLoader) as ITransactionLoader);
  pomHighestIndex := pomTransactionSaverLoader.GetHighestIndex;
  SetIndexes (pomHighestIndex, TObjectList<TObject> (p_List),
              function (p_ID : Integer; p_List : TObjectList <TObject>) : Integer
              begin
                Result := (p_List [p_ID] as TTransaction).ID;
              end,
              procedure (p_ID : Integer; p_List : TObjectList <TObject>; p_IDValue : Integer)
              begin
                (p_List [p_ID] as TTransaction).ID := p_IDValue;
              end);
  Result := pomTransactionSaverLoader.Save (p_List, '');
end;

function TTransactionController.UpdateSummary(const p_Transactions :  TObjectList <TTransaction>;
                                              var   p_Summary: TList <TSummary>;
                                              const p_Categories: IModuleCategories): boolean;
begin
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
