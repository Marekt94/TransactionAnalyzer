unit Transaction;

interface

uses
  InterfaceTransaction;

type
  TTransaction = class
  strict private
    FExecutionDate : TDate;
    FOrderDate : TDate;
    FType : string;
    FDescription : string;
    FAmount : Double;
  public
    property ExecutionDate   : TDate  read FExecutionDate write FExecutionDate;
    property OrderDate       : TDate  read FOrderDate     write FOrderDate;
    property TransactionType : string read FType          write FType;
    property Description     : string read FDescription   write FDescription;
    property Amount          : Double read FAmount        write FAmount;
  end;

implementation

{ TTransaction }

end.
