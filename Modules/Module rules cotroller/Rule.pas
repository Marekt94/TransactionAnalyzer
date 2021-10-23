unit Rule;

interface

uses
  Transaction, System.Generics.Defaults;

type
  TRule = class
  strict private
    FID             : integer;
    FTitleContains  : boolean;
    FDateBetween    : boolean;
    FPriceBetween   : boolean;
    FDateFrom       : TDate;
    FDateTo         : TDate;
    FTitleSubstring : string;
    FCategoryIndex  : integer;
    FPriceLow       : Double;
    FPriceHigh      : Double;
  public
    procedure AfterConstruction;override;
    function FullfilTitleCondition (p_Transaction : TTransaction) : boolean;
    function FullfilDataCondition  (p_Transaction : TTransaction) : boolean;
    function FullfilConditions     (p_Transaction : TTransaction) : boolean;
    function FullfilPriceCondition (p_Transaction : TTransaction) : boolean;
    property TitleContains: boolean read FTitleContains write FTitleContains;
    property DateBetween: boolean read FDateBetween write FDateBetween;
    property DateFrom : TDate read FDateFrom  write FDateFrom;
    property DateTo: TDate read FDateTo write FDateTo;
    property TitleSubstring: string read FTitleSubstring write FTitleSubstring;
    property CategoryIndex: integer read FCategoryIndex write FCategoryIndex;
    property PriceBetween: boolean read FPriceBetween write FPriceBetween;
    property PriceLow: Double read FPriceLow write FPriceLow;
    property PriceHigh: Double read FPriceHigh write FPriceHigh;
    property ID: Integer read FID write FID;
  end;

  TRuleComparer = class (TComparer <TRule>)
    function Compare (const p_Left, p_Right : TRule) : Integer; override;
  end;

implementation

uses
  System.StrUtils;

{ TRule }

procedure TRule.AfterConstruction;
begin
  inherited;
  Self.ID := -1;
end;

function TRule.FullfilConditions(p_Transaction: TTransaction): boolean;
begin
  Result :=     FullfilTitleCondition (p_Transaction)
            and FullfilDataCondition  (p_Transaction)
            and FullfilPriceCondition (p_Transaction);
end;

function TRule.FullfilDataCondition (p_Transaction : TTransaction): boolean;
begin
  if FDateBetween then
    Result :=     (p_Transaction.DocOrderDate >= FDateFrom)
              and (p_Transaction.DocOrderDate <= FDateTo)
  else
    Exit (true)
end;

function TRule.FullfilPriceCondition(p_Transaction: TTransaction): boolean;
begin
  if FPriceBetween then
    Result :=     (Abs (p_Transaction.DocAmount) >= FPriceLow)
              and (Abs (p_Transaction.DocAmount) <= FPriceHigh)
  else
    Exit (true);
end;

function TRule.FullfilTitleCondition (p_Transaction : TTransaction) : boolean;
begin
  if FTitleContains then
    Result := ContainsText (p_Transaction.DocDescription, FTitleSubstring)
  else
    Exit (true);
end;

{ TRuleComparer }

function TRuleComparer.Compare(const p_Left, p_Right: TRule): Integer;
begin
  Result := p_Left.ID - p_Right.ID;
end;

end.
