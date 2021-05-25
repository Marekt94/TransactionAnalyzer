unit Category;

interface

type
  TCategory = class
  strict private
    FCategoryIndex : Integer;
    FCategoryName  : string;
  public
    constructor Create (p_Index : Integer; p_CategoryName : string);
    property CategoryIndex: Integer read FCategoryIndex;
    property CategoryName: string read FCategoryName;
  end;

implementation

{ TCategory }

constructor TCategory.Create(p_Index: Integer; p_CategoryName: string);
begin
  Self.FCategoryIndex := p_Index;
  Self.FCategoryName  := p_CategoryName;
end;

end.
