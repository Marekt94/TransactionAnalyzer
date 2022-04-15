unit XMLTransactionLoader;

interface

uses
  System.Generics.Collections, InterfaceXMLTransactionLoaderSaver, Transaction, Dialogs,
  Xml.XMLIntf, System.SysUtils;

resourcestring
 rs_NieZnalezionoWezlas = 'Nie znaleziono wêz³a %s.';
  
type
  TXMLTransactionLoader = class (TInterfacedObject, IXMLTransactionLoaderSaver)
    protected
      function FindNodeInTree (p_NodeName : string; p_NodeList : IXMLNodeList) : IXMLNode;
      function FindNode (p_NodeName : string; p_NodeList : IXMLNode) : IXMLNode;
      procedure FillTransaction (out p_Transaction    : TTransaction;
                                     p_Node           : IXMLNode;
                                     p_FormatSettings : TFormatSettings); virtual; abstract;
    public
      function Save (p_List : TObjectList <TObject>; p_Path : string) : boolean; overload;
      function Load (p_List : TObjectList <TObject>; p_Path : string) : boolean; overload;
      function Save (p_List : TObjectList <TTransaction>; p_Path : string) : boolean; overload;
      function Load (p_List : TObjectList <TTransaction>; p_Path : string) : boolean; overload;
  end;

implementation

uses
  Xml.XMLDoc, ConstXMLLoader;

{ TXMLTransactionLoader }

function TXMLTransactionLoader.FindNode(p_NodeName: string;
  p_NodeList: IXMLNode): IXMLNode;
begin
  Result := p_NodeList.ChildNodes.FindNode (p_NodeName);
  if not Assigned (Result) then
    raise Exception.Create(Format (rs_NieZnalezionoWezlas, [p_NodeName]));
end;

function TXMLTransactionLoader.FindNodeInTree(p_NodeName: string; p_NodeList : IXMLNodeList): IXMLNode;
begin
  Result := p_NodeList.FindNode (p_NodeName);
  if not Assigned (Result) then
    for var i := 0 to p_NodeList.Count - 1 do
      Result := FindNodeInTree (p_NodeName, p_NodeList.Nodes [i].ChildNodes);
end;

function TXMLTransactionLoader.Load(p_List: TObjectList<TTransaction>;
  p_Path: string): boolean;
var
  pomXMLDoc         : IXMLDocument;
  pomTransactions   : IXMLNode;
  pomTransaction    : TTransaction;
  pomFormatSettings : TFormatSettings;
begin
  Result := False;
  pomTransaction := nil;
  pomXMLDoc := TXMLDocument.Create (nil);
  try
    pomXMLDoc.Active := true;
    pomXMLDoc.LoadFromFile (p_Path);

    //znajdŸ element 'operacje'
    pomTransactions := FindNodeInTree (c_NN_Transactions, pomXMLDoc.ChildNodes);
    if not Assigned (pomTransactions) then
      raise Exception.Create(Format (rs_NieZnalezionoWezlas,[c_NN_Transactions]));

    //zmiana formatu na potrzeby formatu daty oraz double-a *.xml-a
    pomFormatSettings := TFormatSettings.Create;
    pomFormatSettings.DateSeparator := '-';
    pomFormatSettings.ShortDateFormat := 'yyyy-mm-dd';
    pomFormatSettings.DecimalSeparator := '.';

    //przeiteruj po operacjach i wype³nij liste transakcji
    for var i := 0 to pomTransactions.ChildNodes.Count - 1 do
    begin
      pomTransaction := TTransaction.Create;
      FillTransaction (pomTransaction, pomTransactions.ChildNodes.Get(i), pomFormatSettings);
      pomTransaction.UpdateHash;
      p_List.Add (pomTransaction);
      pomTransaction := nil;
    end;

    Result := True;
  except
    on E : Exception do
    begin
      ShowMessage(E.Message);
      if Assigned (pomTransaction) then
        pomTransaction.Free;
    end;
  end;
end;

function TXMLTransactionLoader.Load(p_List: TObjectList<TObject>;
  p_Path: string): boolean;
begin
  Result := Load (TObjectList <TTransaction> (p_List), p_Path);
end;

function TXMLTransactionLoader.Save(p_List: TObjectList<TObject>;
  p_Path: string): boolean;
begin
  Result := Save (TObjectList <TTransaction> (p_List), p_Path);
end;

function TXMLTransactionLoader.Save(p_List: TObjectList<TTransaction>;
  p_Path: string): boolean;
begin
  Result := false;
end;

end.
