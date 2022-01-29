unit XMLTransactionLoader;

interface

uses
  System.Generics.Collections, InterfaceTransactionLoader, Transaction, Dialogs,
  Xml.XMLIntf, System.SysUtils;

type
  TXMLTransactionLoader = class (TInterfacedObject, ITransactionLoader)
    strict private
      function FindNode (p_NodeName : string; p_NodeList : IXMLNodeList) : IXMLNode;
      procedure FillTransaction (out p_Transaction    : TTransaction;
                                     p_Node           : IXMLNode;
                                     p_FormatSettings : TFormatSettings);
    public
      function Load (p_TransactionList : TObjectList <TTransaction>;
                     p_Path            : string) : boolean;
  end;

implementation

uses
  Xml.XMLDoc, ConstXMLLoader;

{ TXMLTransactionLoader }

procedure TXMLTransactionLoader.FillTransaction(out p_Transaction    : TTransaction;
                                                    p_Node           : IXMLNode;
                                                    p_FormatSettings : TFormatSettings);
resourcestring
  rs_Empty_Transaction = 'Transakcja jest pusta';
begin
  if not Assigned (p_Transaction) then
    raise Exception.Create(rs_Empty_Transaction);

  p_Transaction.DocExecutionDate   := StrToDate  (p_Node.ChildNodes.FindNode (c_NN_ExecDate).Text,  p_FormatSettings);
  p_Transaction.DocOrderDate       := StrToDate  (p_Node.ChildNodes.FindNode (c_NN_OrderDate).Text, p_FormatSettings);
  p_Transaction.DocTransactionType :=             p_Node.ChildNodes.FindNode (c_NN_Type).Text;
  p_Transaction.DocDescription     :=             p_Node.ChildNodes.FindNode (c_NN_Description).Text;
  p_Transaction.DocAmount          := StrToFloat (p_Node.ChildNodes.FindNode (c_NN_AmountCurr).Text, p_FormatSettings);
  p_Transaction.AccountState       := StrToFloat (p_Node.ChildNodes.FindNode (c_NN_EndingBalanceCurr).Text, p_FormatSettings);
end;

function TXMLTransactionLoader.FindNode(p_NodeName: string; p_NodeList : IXMLNodeList): IXMLNode;
begin
  Result := p_NodeList.FindNode (p_NodeName);
  if not Assigned (Result) then
    for var i := 0 to p_NodeList.Count - 1 do
      Result := FindNode (p_NodeName, p_NodeList.Nodes [i].ChildNodes);
end;

function TXMLTransactionLoader.Load (p_TransactionList : TObjectList<TTransaction>;
                          p_Path            : string) : boolean;
var
  pomXMLDoc         : IXMLDocument;
  pomTransactions   : IXMLNode;
  pomTransaction    : TTransaction;
  pomFormatSettings : TFormatSettings;
begin
  pomXMLDoc := TXMLDocument.Create (nil);
  pomXMLDoc.Active := true;
  pomXMLDoc.LoadFromFile (p_Path);

  //znajd� element 'operacje'
  pomTransactions := FindNode (c_NN_Transactions, pomXMLDoc.ChildNodes);

  //zmiana formatu na potrzeby formatu daty oraz double-a *.xml-a
  pomFormatSettings := TFormatSettings.Create;
  pomFormatSettings.DateSeparator := '-';
  pomFormatSettings.ShortDateFormat := 'yyyy-mm-dd';
  pomFormatSettings.DecimalSeparator := '.';

  //przeiteruj po operacjach i wype�nij liste transakcji
  for var i := 0 to pomTransactions.ChildNodes.Count - 1 do
  begin
    pomTransaction := TTransaction.Create;
    FillTransaction (pomTransaction, pomTransactions.ChildNodes.Get(i), pomFormatSettings);
    pomTransaction.UpdateHash;
    p_TransactionList.Add (pomTransaction);
  end;

  Result := True;
end;

end.
