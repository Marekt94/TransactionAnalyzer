unit Category;

interface

type
  TCategory = class
  strict private
    FCategoryIndex : Integer;
    FCategoryName  : string;
  public
    constructor Create; overload;
    constructor Create (p_Index : Integer; p_CategoryName : string); overload;
    property CategoryIndex: Integer read FCategoryIndex write FCategoryIndex;
    property CategoryName: string read FCategoryName write FCategoryName;
  end;

implementation

{ TCategory }

constructor TCategory.Create(p_Index: Integer; p_CategoryName: string);
begin
  Self.FCategoryIndex := p_Index;
  Self.FCategoryName  := p_CategoryName;
end;

constructor TCategory.Create;
begin
  Self.FCategoryIndex := -1;
  Self.FCategoryName  := '';
end;

end.
