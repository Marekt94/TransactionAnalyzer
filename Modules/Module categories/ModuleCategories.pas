unit ModuleCategories;

interface

uses
  Module, InterfaceModuleCategory, System.Generics.Collections, Category,
  PanelCategoriesList, WindowSkeleton, InterfaceCategoriesLoaderSaver;

type
  TModuleCategories = class (TBaseModule, IModuleCategories)
  strict private
    FCategoryList : TObjectList <TCategory>;
    FPeriodicityList : TObjectList <TCategory>;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure RegisterClasses; override;
    function FindCategoryByIndex (p_Index : integer) : TCategory;
    function GetSelfInterface: TGUID; override;
    function LoadCategories (p_Path : string) : boolean;
    function SaveCategories (p_Path : string) : boolean;
    function GetCateogryList : TObjectList <TCategory>;
    function GetPeriodicityList : TObjectList <TCategory>;
    procedure SetIndexes;
    procedure SetCategories;
    property CategoryList : TObjectList <TCategory> read GetCateogryList;
    property PeriodicityList : TObjectList <TCategory> read GetPeriodicityList;
  end;

implementation

uses
  System.SysUtils, XMLCategoriesLoaderSaver, Kernel;

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
end;

destructor TModuleCategories.Destroy;
begin
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
  Result := (Kernel.GiveObjectByInterface (ICategoriesLoaderSaver) as ICategoriesLoaderSaver).Load(FCategoryList, '');
end;

procedure TModuleCategories.RegisterClasses;
begin
  inherited;
  RegisterClass(TXMLCategoriesLoaderSaver);
end;

function TModuleCategories.SaveCategories(p_Path: string): boolean;
begin
  SetIndexes;
  Result := (Kernel.GiveObjectByInterface (ICategoriesLoaderSaver) as ICategoriesLoaderSaver).Save(FCategoryList, '');
end;

procedure TModuleCategories.SetCategories;
resourcestring
  rs_CategoriesPanelTitle = 'Kategorie';
var
  pomWindow : TWndSkeleton;
begin
  pomWindow := TWndSkeleton.Create(nil);
  try
    pomWindow.Init (TFrmCategoriesList.Create (pomWindow), rs_CategoriesPanelTitle, false);
    pomWindow.ShowModal;
  finally
    FreeAndNil (pomWindow);
  end
end;

procedure TModuleCategories.SetIndexes;
var
  pomHighestIndex : Integer;
  pomCategory     : TCategory;
begin
  pomHighestIndex := Low (Integer);
  for var i := 0 to FCategoryList.Count - 1 do
    if pomHighestIndex < FCategoryList [i].CategoryIndex then
      pomHighestIndex := FCategoryList [i].CategoryIndex;

  for var i := 0 to FCategoryList.Count - 1 do
    if FCategoryList [i].CategoryIndex < 0 then
    begin
      Inc (pomHighestIndex);
      pomCategory := FCategoryList [i];
      pomCategory.CategoryIndex := pomHighestIndex;
    end;
end;

end.
