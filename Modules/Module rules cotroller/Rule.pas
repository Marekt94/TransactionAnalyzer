unit Rule;

interface

uses
  Transaction;

type
  TRule = class
  strict private
    FTitleContains  : boolean;
    FDateBetween    : boolean;
    FDateFrom       : TDate;
    FDateTo         : TDate;
    FTitleSubstring : string;
    FCategoryIndex  : integer;
  public
    function FullfilTitleCondition (p_Transaction : TTransaction) : boolean;
    function FullfilDataCondition  (p_Transaction : TTransaction) : boolean;
    function FullfilConditions     (p_Transaction : TTransaction) : boolean;
    property TitleContains: boolean read FTitleContains write FTitleContains;
    property DateBetween: boolean read FDateBetween write FDateBetween;
    property DateFrom : TDate read FDateFrom  write FDateFrom;
    property DateTo: TDate read FDateTo write FDateTo;
    property TitleSubstring: string read FTitleSubstring write FTitleSubstring;
    property CategoryIndex: integer read FCategoryIndex write FCategoryIndex;
  end;

implementation

uses
  System.StrUtils;

{ TRule }

function TRule.FullfilConditions(p_Transaction: TTransaction): boolean;
begin
  Result := FullfilTitleCondition (p_Transaction) and FullfilDataCondition (p_Transaction);
end;

function TRule.FullfilDataCondition (p_Transaction : TTransaction): boolean;
begin
  if FDateBetween then
    Result :=     (p_Transaction.DocOrderDate >= FDateFrom)
              and (p_Transaction.DocOrderDate <= FDateTo)
  else
    Exit (true)
end;

function TRule.FullfilTitleCondition (p_Transaction : TTransaction) : boolean;
begin
  if FTitleContains then
    Result := ContainsText (p_Transaction.DocDescription, FTitleSubstring)
  else
    Exit (true);
end;

end.
