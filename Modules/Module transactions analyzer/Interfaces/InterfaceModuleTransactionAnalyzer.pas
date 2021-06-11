unit InterfaceModuleTransactionAnalyzer;

interface

uses
  InterfaceModule, System.Generics.Collections, Transaction;

type
  IModuleTransactionAnalyzer = interface(IModule)
    ['{47A3E3C6-9A8F-435F-8617-D1D6F3E14891}']
    function LoadTransactions (p_Path : string) : boolean;
    function SaveTransactions (p_Path : string) : boolean;
    function GetTransactionList : TObjectList<TTransaction>;
    function AnalyzeTransactions (p_Transaction : TObjectList <TTransaction>) : boolean;
    property TransactionList: TObjectList <TTransaction> read GetTransactionList;
  end;

implementation

end.
