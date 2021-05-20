unit XMLLoader;

interface

uses
  System.Generics.Collections, InterfaceTransactionLoader, Transaction;

type
  TXMLLoader = class (TInterfacedObject, ITransactionLoader)
    public
      function Load (p_TransactionList : TObjectList <TTransaction>;
                     p_Path            : string) : boolean;
  end;

implementation

uses
  Xml.XMLDoc;

{ TXMLLoader }

function TXMLLoader.Load(p_TransactionList : TObjectList<TTransaction>;
                         p_Path            : string) : boolean;
var
  pomXMLDoc : TXMLDocument;
begin
  pomXMLDoc := TXMLDocument.Create (nil);
  pomXMLDoc.LoadFromFile (p_Path);

  Result := True;
end;

end.
