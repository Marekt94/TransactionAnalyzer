unit ModuleCategories;

interface

uses
  Module, InterfaceModuleCategory, System.Generics.Collections, Category;

type
  TModuleCategories = class (TBaseModule, IModuleCategories)
  strict private
    FCategoryList : TObjectList <TCategory>;
  public
    constructor Create;
    destructor Destroy; override;
    function GetSelfInterface: TGUID; override;
    function LoadCategories (p_Path : string) : boolean;
    function SaveCategories (p_Path : string) : boolean;
    function GetCateogryList : TObjectList <TCategory>;
    property CategoryList : TObjectList <TCategory> read GetCateogryList;
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
  LoadCategories ('');
end;

destructor TModuleCategories.Destroy;
begin
  SaveCategories ('');
  FreeAndNil (FCategoryList);
  inherited;
end;

function TModuleCategories.GetCateogryList: TObjectList<TCategory>;
begin
  Result := FCategoryList
end;

function TModuleCategories.LoadCategories(p_Path: string): boolean;
begin
  FCategoryList.Add(TCategory.Create (0, 'zakupy'));
  FCategoryList.Add(TCategory.Create (1, 'paliwo'));
  Result := true;
end;

function TModuleCategories.SaveCategories(p_Path: string): boolean;
begin
  Result := true;
end;

end.
