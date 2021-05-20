unit CSVLoader;

interface

uses
  InterfaceTransactionLoader, System.Generics.Collections, Transaction;

type
  TCSVLoader = class (TInterfacedObject, ITransactionLoader)
    function Load (p_TransactionList : TObjectList <TTransaction>;
                   p_Path            : string) : boolean;
  end;

implementation

{ TCSVLoader }

function TCSVLoader.Load(p_TransactionList: TObjectList<TTransaction>;
  p_Path: string): boolean;
begin
  Result := True;
end;

end.
