unit ModuleCategories;

interface

uses
  Module, InterfaceModuleCategory, System.Generics.Collections, Category;

type
  TModuleCategories = class (TBaseModule, IModuleCategories)
  strict private
    FCategoryList : TObjectList <TCategory>;
    FPeriodicityList : TObjectList <TCategory>;
  public
    constructor Create; override;
    destructor Destroy; override;
    function FindCategoryByIndex (p_Index : integer) : TCategory;
    function GetSelfInterface: TGUID; override;
    function LoadCategories (p_Path : string) : boolean;
    function SaveCategories (p_Path : string) : boolean;
    function GetCateogryList : TObjectList <TCategory>;
    function GetPeriodicityList : TObjectList <TCategory>;
    property CategoryList : TObjectList <TCategory> read GetCateogryList;
    property PeriodicityList : TObjectList <TCategory> read GetPeriodicityList;
  end;

implementation

uses
  System.SysUtils;

{ TModuleCategories }

function TModuleCategories.GetSelfInterface: TGUID;
begin
  Result := IModuleCategories;
end;

constructor TModuleCategories.Create;
begin
  inherited;
  FCategoryList := TObjectList <TCategory>.Create;
  FPeriodicityList := TObjectList <TCategory>.Create;
  LoadCategories ('');
end;

destructor TModuleCategories.Destroy;
begin
  SaveCategories ('');
  FreeAndNil (FCategoryList);
  FreeAndNil (FPeriodicityList);
  inherited;
end;

function TModuleCategories.FindCategoryByIndex(p_Index: integer): TCategory;
begin
  for var pomCategory in FCategoryList do
    if pomCategory.CategoryIndex = p_Index then
      Exit (pomCategory);
  Result := nil;
end;

function TModuleCategories.GetCateogryList: TObjectList<TCategory>;
begin
  Result := FCategoryList
end;

function TModuleCategories.GetPeriodicityList: TObjectList<TCategory>;
begin
  Result := FPeriodicityList;
end;

function TModuleCategories.LoadCategories(p_Path: string): boolean;
begin
  FCategoryList.Add (TCategory.Create (0, 'zakupy'));
  FCategoryList.Add (TCategory.Create (1, 'paliwo'));

  FPeriodicityList.Add (TCategory.Create (0, 'sta³e'));
  FPeriodicityList.Add (TCategory.Create (0, 'zmienne'));

  Result := true;
end;

function TModuleCategories.SaveCategories(p_Path: string): boolean;
begin
  Result := true
end;

end.
