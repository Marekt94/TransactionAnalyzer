unit InterfaceTransactionLoader;

interface

uses
  System.Generics.Collections, Transaction;

type
  ITransactionLoader = interface (IInterface)
  ['{086C10E6-63EA-476E-8697-E159A37AD492}']
    function Load (p_TransactionList : TObjectList <TTransaction>;
                   p_Path            : string) : boolean;
    function Save (p_TransactionList : TObjectList <TTransaction>;
                   p_Path            : string) : boolean;
    function GetHighestIndex : Integer;
  end;

implementation

end.
