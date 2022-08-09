unit Transaction;

interface

uses
  System.SysUtils, System.Generics.Collections,
  System.Generics.Defaults;

const
  cExpense = 0;
  cImpact  = 1;

type
  //doc prefix - from document
  TTransaction = class
  strict private
    FID : Integer;
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
    property ID                 : Integer        read FID                 write FID;
    property DocExecutionDate   : TDate          read FDocExecutionDate   write FDocExecutionDate;
    property DocOrderDate       : TDate          read FDocOrderDate       write FDocOrderDate;
    property DocTransactionType : string         read FDocType            write FDocType;
    property DocDescription     : string         read FDocDescription     write FDocDescription;
    property DocAmount          : Double         read FDocAmount          write FDocAmount;
    property ArrayCategoryIndex : TList<Integer> read FArrayCategoryIndex write FArrayCategoryIndex;
    property TransactionType    : Byte           read FType               write FType;
    property Hash               : string         read FHash               write FHash;
    property AccountState       : Double         read FAccountState       write FAccountState;
  end;

  TSummary = record
    CategoryIndex : Integer;
    Impact        : Double;
    Expense       : Double;
  end;

  TTransactionComparer = class (TComparer <TTransaction>)
    function Compare (const p_Left, p_Right : TTransaction) : Integer; override;
  end;

implementation

uses
  IdHashMessageDigest;

{ TTransaction }

constructor TTransaction.Create;
begin
  inherited;
  FArrayCategoryIndex := TList<Integer>.Create;
  FID := -1;
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

{ TTransactionComparer }

function TTransactionComparer.Compare(const p_Left,
  p_Right: TTransaction): Integer;
begin
  Result := p_Left.ID - p_Right.ID;
end;

end.
