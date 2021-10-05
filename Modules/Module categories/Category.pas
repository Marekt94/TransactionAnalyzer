unit Category;

interface

uses
  System.Generics.Defaults;

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

  TCategoryComparer = class (TComparer <TCategory>)
    function Compare (const p_Left, p_Right : TCategory) : Integer; override;
  end;

implementation

{ TCategory }
procedure TCategory.AfterConstruction;
begin
  inherited;
  Self.FCategoryIndex := -1;
  Self.FCategoryName  := '';
end;
{ TCategoryComparer }

function TCategoryComparer.Compare (const p_Left, p_Right: TCategory): Integer;
begin
  Result := p_Left.CategoryIndex - p_Right.CategoryIndex;
end;

end.
