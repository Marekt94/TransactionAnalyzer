unit Transaction;

interface

uses
  InterfaceTransaction;

const
  cExpense = 0;
  cImpact  = 1;

type
  //doc prefix - from document
  TTransaction = class
  strict private
    FDocExecutionDate : TDate;
    FDocOrderDate : TDate;
    FDocType : string;
    FDocDescription : string;
    FDocAmount : Double;
//    FType : Byte; //expense, impact
//    FCategory : Integer;
  public
    property DocExecutionDate   : TDate  read FDocExecutionDate write FDocExecutionDate;
    property DocOrderDate       : TDate  read FDocOrderDate     write FDocOrderDate;
    property DocTransactionType : string read FDocType          write FDocType;
    property DocDescription     : string read FDocDescription   write FDocDescription;
    property DocAmount          : Double read FDocAmount        write FDocAmount;
  end;

implementation

{ TTransaction }

end.
