unit Transaction;

interface

uses
  InterfaceTransaction, System.SysUtils, System.Generics.Collections;

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
    FType : Byte; //expense, impact
    FArrayCategoryIndex : TList<Integer>;
    FAccountState : Double;
    FHash : string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure UpdateHash;
    property DocExecutionDate   : TDate          read FDocExecutionDate   write FDocExecutionDate;
    property DocOrderDate       : TDate          read FDocOrderDate       write FDocOrderDate;
    property DocTransactionType : string         read FDocType            write FDocType;
    property DocDescription     : string         read FDocDescription     write FDocDescription;
    property DocAmount          : Double         read FDocAmount          write FDocAmount;
    property ArrayCategoryIndex : TList<Integer> read FArrayCategoryIndex write FArrayCategoryIndex;
    property TransactionType    : Byte           read FType               write FType;
    property Hash               : string         read FHash;
    property AccountState       : Double         read FAccountState       write FAccountState;
  end;

  TSummary = record
    CategoryIndex : Integer;
    Impact        : Double;
    Expense       : Double;
  end;

implementation

uses
  IdHashMessageDigest;

{ TTransaction }

constructor TTransaction.Create;
begin
  inherited;
  FArrayCategoryIndex := TList<Integer>.Create;
end;

destructor TTransaction.Destroy;
begin
  FreeAndNil (FArrayCategoryIndex);
  inherited;
end;

procedure TTransaction.UpdateHash;
var
  pomStringToHash : string;
begin
  pomStringToHash :=   DateToStr (FDocExecutionDate)
                     + FDocDescription
                     + FloatToStr (FDocAmount)
                     + FloatToStr (FAccountState);
  with TIdHashMessageDigest5.Create do
  try
    FHash := HashStringAsHex (pomStringToHash)
  finally
    Free;
  end;

end;

end.
