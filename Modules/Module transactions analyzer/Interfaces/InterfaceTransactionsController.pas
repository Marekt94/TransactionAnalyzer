unit InterfaceTransactionsController;

interface

uses
  System.Generics.Collections, Transaction, InterfaceModuleRules,
  InterfaceModuleCategory, Rule;

type
  ITransactionsController = interface (IInterface)
    ['{E07D96C7-CB68-43AF-BE54-E194BDAB4690}']
    function GetTransactionsList : TObjectList <TTransaction>;
    function AnalyzeTransactions (p_Transactions    : TObjectList <TTransaction>;
                                  p_RuleController  : IModuleRules;
                                  p_Categories      : IModuleCategories;
                                  p_Rules           : TObjectList <TRule>;
                                  p_TransWithoutCat : TList <TTransaction>) : boolean;
    property TransactionsList : TObjectList <TTransaction> read GetTransactionsList;
    function UpdateSummary (const p_Transactions :  TObjectList <TTransaction>;
                            var   p_Summary: TList <TSummary>;
                            const p_Categories: IModuleCategories) : boolean;
    function GetTransactionsListFiltered (
          p_TransactionList : TObjectList <TTransaction>;
      out p_TransactionListFiltered : TList <TTransaction>;
          p_ChoosenCategories : TList<Integer>): boolean;
    function EvaluateExpenseSum (p_Summary : TList <TSummary>;
                                 p_ChoosenCat : TList<Integer>) : Double;
    function EvaluateImpactSum (p_Summary : TList <TSummary>;
                                p_ChoosenCat : TList<Integer>) : Double;
  end;

implementation

end.
