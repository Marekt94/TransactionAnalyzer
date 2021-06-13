unit Category;

interface

type
  TCategory = class
  strict private
    FCategoryIndex : Integer;
    FCategoryName  : string;
  public
    procedure AfterConstruction;override;
    property CategoryIndex: Integer read FCategoryIndex write FCategoryIndex;
    property CategoryName: string read FCategoryName write FCategoryName;
  end;

implementation

{ TCategory }
procedure TCategory.AfterConstruction;
begin
  inherited;
  Self.FCategoryIndex := -1;
  Self.FCategoryName  := '';
end;
end.
