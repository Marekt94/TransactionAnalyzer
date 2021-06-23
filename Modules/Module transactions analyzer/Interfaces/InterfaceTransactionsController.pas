unit InterfaceTransactionsController;

interface

uses
  System.Generics.Collections, Transaction, InterfaceModuleRules,
  InterfaceModuleCategory, Rule;

type
  ITransactionsController = interface (IInterface)
    ['{E07D96C7-CB68-43AF-BE54-E194BDAB4690}']
    function GetTransactionsList : TObjectList <TTransaction>;
    function AnalyzeTransactions (p_Transactions   : TObjectList <TTransaction>;
                                  p_RuleController : IModuleRules;
                                  p_Categories     : IModuleCategories;
                                  p_Rules          : TObjectList <TRule>) : boolean;
    property TransactionsList : TObjectList <TTransaction> read GetTransactionsList;
    function UpdateSummary (    p_Transactions :  TObjectList <TTransaction>;
                            out p_Summary: TList <TSummary>;
                                p_Categories: IModuleCategories) : boolean;
    function GetTransactionsListFiltered (
          p_TransactionList : TObjectList <TTransaction>;
      out p_TransactionListFiltered : TList <TTransaction>;
          p_ChoosenCategories : TList<Integer>): boolean;
  end;

implementation

end.
