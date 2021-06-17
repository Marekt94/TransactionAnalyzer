unit ModuleCategories;

interface

uses
  Module, InterfaceModuleCategory, System.Generics.Collections, Category,
  WindowSkeleton, InterfaceCategoriesLoaderSaver,
  PanelCategory, WindowObjectControllerSteeringClass;

type
  TModuleCategories = class (TBaseModule, IModuleCategories)
  strict private
    FCategoryList : TObjectList <TCategory>;
    FPeriodicityList : TObjectList <TCategory>;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure RegisterClasses; override;
    function OpenModule : boolean; override;
    function OpenMainWindow : Integer; override;
    function CloseModule : boolean; override;
    function FindCategoryByIndex (p_Index : integer) : TCategory;
    function GetSelfInterface: TGUID; override;
    function LoadCategories : boolean;
    function SaveCategories : boolean;
    function GetCateogryList : TObjectList <TCategory>;
    function GetPeriodicityList : TObjectList <TCategory>;
    procedure SetIndexes;
    property CategoryList : TObjectList <TCategory> read GetCateogryList;
    property PeriodicityList : TObjectList <TCategory> read GetPeriodicityList;
  end;

implementation

uses
  System.SysUtils, XMLCategoriesLoaderSaver, Kernel, BaseListPanel, Vcl.Grids;

{ TModuleCategories }

function TModuleCategories.GetSelfInterface: TGUID;
begin
  Result := IModuleCategories;
end;

function TModuleCategories.CloseModule: boolean;
begin
  SaveCategories;
  Result := inherited;
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

function TModuleCategories.LoadCategories : boolean;
begin
  Result := (Kernel.GiveObjectByInterface (ICategoriesLoaderSaver) as ICategoriesLoaderSaver).Load(FCategoryList, '');
  if FCategoryList.Count < 1 then
  begin
    var pomCategory := TCategory.Create;
    pomCategory.CategoryIndex := cDefaultCategoryIndex;
    pomCategory.CategoryName  := 'bez kategorii';
    FCategoryList.Add (pomCategory)
  end;
end;

function TModuleCategories.OpenMainWindow: Integer;
resourcestring
  rs_CategoriesPanelTitle = 'Kategorie';
var
  pomSteeringObj : TWndObjControllerSteeringClass;
begin
  pomSteeringObj := TWndObjControllerSteeringClass.Create;
  try
    with pomSteeringObj do
    begin
      ObjectClass := TCategory;
      ObjectFrame := TFrmCategory.Create (nil);
      UpdateView := procedure (p_Grid : TStringGrid)
                    begin
                      p_Grid.ColCount := 1;
                      p_Grid.RowCount := 1;
                      p_Grid.Cells[0,0] := 'Kategoria';
                      p_Grid.RowCount := FCategoryList.Count + 1;
                      for var i := 0 to FCategoryList.Count - 1 do
                        p_Grid.Cells [0, i + 1] := FCategoryList [i].CategoryName;
                      p_Grid.FixedRows := 1;
                    end;
      ObjectList := FCategoryList;
      WndListTitle := 'Kategorie';
      WndObjTitle  := 'Kategoria';
      NavigationKeys := False;
      FullScreen := True;
    end;
    Result := WindowSkeleton.OpenObjControllerWindow (pomSteeringObj);
    SetIndexes;
  finally
    pomSteeringObj.Free;
  end
end;

function TModuleCategories.OpenModule: boolean;
begin
  Result := inherited;
  LoadCategories;
end;

procedure TModuleCategories.RegisterClasses;
begin
  inherited;
  RegisterClass(TXMLCategoriesLoaderSaver);
end;

function TModuleCategories.SaveCategories : boolean;
begin
  Result := (Kernel.GiveObjectByInterface (ICategoriesLoaderSaver) as ICategoriesLoaderSaver).Save(FCategoryList, '');
end;

procedure TModuleCategories.SetIndexes;
var
  pomHighestIndex : Integer;
  pomCategory     : TCategory;
begin
  pomHighestIndex := 0;
  for var i := 0 to FCategoryList.Count - 1 do
    if pomHighestIndex < FCategoryList [i].CategoryIndex then
      pomHighestIndex := FCategoryList [i].CategoryIndex;

  for var i := 0 to FCategoryList.Count - 1 do
  begin
    if FCategoryList [i].CategoryIndex < 0 then
    begin
      Inc (pomHighestIndex);
      pomCategory := FCategoryList [i];
      pomCategory.CategoryIndex := pomHighestIndex;
    end;
  end;
end;

end.
