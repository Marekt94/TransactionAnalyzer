unit InterfaceModuleTransactionLoader;

interface

uses
  InterfaceModule, System.Generics.Collections, Transaction;

type
  IModuleTransactionLoader = interface (IModule)
    ['{06AF1078-7D6F-46E2-AFCC-478DD0A45E89}']
    function GetTransactionList : TObjectList <TTransaction>;
    function LoadTransactions (p_Path : string) : boolean;
    property TransactionList : TObjectList <TTransaction> read GetTransactionList;
  end;

implementation

end.
