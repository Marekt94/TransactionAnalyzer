unit InterfaceModuleTransactionAnalyzer;

interface

uses
  InterfaceModule, System.Generics.Collections, Transaction;

type
  IModuleTransactionAnalyzer = interface(IModule)
    ['{47A3E3C6-9A8F-435F-8617-D1D6F3E14891}']
    function AnalyzeTransactions (p_Transaction : TObjectList <TTransaction>) : boolean;
    procedure SetConditions;
  end;

implementation

end.
