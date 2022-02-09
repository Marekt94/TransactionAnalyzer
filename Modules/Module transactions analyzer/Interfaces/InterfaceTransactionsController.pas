unit InterfaceTransactionsController;

interface

uses
  System.Generics.Collections, Transaction, InterfaceModuleRules,
  InterfaceModuleCategory, Rule;

type
  ITransactionsController = interface (IInterface)
    ['{E07D96C7-CB68-43AF-BE54-E194BDAB4690}']
    function AnalyzeTransactions (p_Transactions    : TObjectList <TTransaction>;
                                  p_RuleController  : IModuleRules;
                                  p_Categories      : IModuleCategories;
                                  p_Rules           : TObjectList <TRule>;
                                  p_TransWithoutCat : TList <TTransaction>) : boolean;
    function UpdateSummary (const p_Transactions :  TObjectList <TTransaction>;
                            var   p_Summary: TList <TSummary>;
                            const p_Categories: IModuleCategories) : boolean;
    function FilterByChoosenCategories (
      p_TransactionList : TList <TTransaction>;
      p_TransactionListFiltered : TList <TTransaction>;
      p_ChoosenCategories : TList<Integer>): boolean;
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

end.
