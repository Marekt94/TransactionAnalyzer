unit XMLDebitAccountTransactionLoader;

interface

uses
  XMLTransactionLoader, Transaction, Xml.XMLIntf, System.SysUtils;

type
  TXMLDebitAccountTransactionLoader = class (TXMLTransactionLoader)
  protected
    procedure FillTransaction (out p_Transaction    : TTransaction;
                                   p_Node           : IXMLNode;
                                   p_FormatSettings : TFormatSettings); override;
  end;

implementation

uses
  ConstXMLLoader;

{ TXMLDebitAccountTransactionLoader }

procedure TXMLDebitAccountTransactionLoader.FillTransaction(
  out p_Transaction: TTransaction; p_Node: IXMLNode;
  p_FormatSettings: TFormatSettings);
begin
  p_Transaction.DocExecutionDate   := StrToDate  (FindNode (c_NN_ExecDate,          p_Node).Text, p_FormatSettings);
  p_Transaction.DocOrderDate       := StrToDate  (FindNode (c_NN_OrderDate,         p_Node).Text, p_FormatSettings);
  p_Transaction.DocTransactionType :=             FindNode (c_NN_Type,              p_Node).Text;
  p_Transaction.DocDescription     :=             FindNode (c_NN_Description,       p_Node).Text;
  p_Transaction.DocAmount          := StrToFloat (FindNode (c_NN_AmountCurr,        p_Node).Text, p_FormatSettings);
  p_Transaction.AccountState       := StrToFloat (FindNode (c_NN_EndingBalanceCurr, p_Node).Text, p_FormatSettings);
end;

end.
