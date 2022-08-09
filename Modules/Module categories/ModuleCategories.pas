unit ModuleCategories;

interface

uses
  Module, InterfaceModuleCategory, System.Generics.Collections, Category,
  InterfaceCategoriesLoaderSaver,
  PanelCategory, WindowObjectControllerSteeringClass;

type
  TModuleCategories = class (TBaseModule, IModuleCategories)
  strict private
    FCategoryList : TObjectList <TCategory>;
    FPeriodicityList : TObjectList <TCategory>;
    procedure InitCategories;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure RegisterClasses; override;
    function OpenModule : boolean; override;
    function OpenMainWindow : Integer; override;
    function FindCategoryByIndex (p_Index : integer) : TCategory;
    function GetSelfInterface: TGUID; override;
    function GetCateogryList : TObjectList <TCategory>;
    function GetPeriodicityList : TObjectList <TCategory>;
    property CategoryList : TObjectList <TCategory> read GetCateogryList;
    property PeriodicityList : TObjectList <TCategory> read GetPeriodicityList;
  end;

implementation

uses
  System.SysUtils, XMLCategoriesLoaderSaver, Kernel, Vcl.Grids,
  InterfaceXMLCategoriesLoaderSaver, System.UITypes, UsefullMethods,
  ObjectWindowsCreator;

{ TModuleCategories }

function TModuleCategories.GetSelfInterface: TGUID;
begin
  Result := IModuleCategories;
end;

procedure TModuleCategories.InitCategories;
var
  pomCategories : TObjectList <TCategory>;
begin
  pomCategories := TObjectList <TCategory>.Create;
  try
    (MainKernel.GiveObjectByInterface (ICategoriesLoaderSaver) as ICategoriesLoaderSaver).LoadCategories(pomCategories);
    if pomCategories.Count < 1 then
    begin
      var pomCategory := TCategory.Create;
      pomCategory.CategoryIndex := cDefaultCategoryIndex;
      pomCategory.CategoryName  := 'bez kategorii';
      pomCategories.Add (pomCategory);
      (MainKernel.GiveObjectByInterface (ICategoriesLoaderSaver) as ICategoriesLoaderSaver).SaveCategories(pomCategories)
    end;
  finally
    pomCategories.Free;
  end;
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
  for var pomCategory in CategoryList do
    if pomCategory.CategoryIndex = p_Index then
      Exit (pomCategory);
  Result := nil;
end;

function TModuleCategories.GetCateogryList: TObjectList<TCategory>;
begin
  FCategoryList.Clear;
  (MainKernel.GiveObjectByInterface (ICategoriesLoaderSaver) as ICategoriesLoaderSaver).LoadCategories(FCategoryList);
  Result := FCategoryList
end;

function TModuleCategories.GetPeriodicityList: TObjectList<TCategory>;
begin
  Result := FPeriodicityList;
end;

function TModuleCategories.OpenMainWindow: Integer;
resourcestring
  rs_CategoriesPanelTitle = 'Kategorie';
var
  pomSteeringObj : TWndObjControllerSteeringClass;
  pomCategories : TObjectList <TCategory>;
begin
  pomSteeringObj := TWndObjControllerSteeringClass.Create;
  pomCategories := TObjectList <TCategory>.Create;
  try
    (MainKernel.GiveObjectByInterface (ICategoriesLoaderSaver) as ICategoriesLoaderSaver).LoadCategories(pomCategories);
    with pomSteeringObj do
    begin
      ObjectClass := TCategory;
      ObjectFrame := TFrmCategory.Create (nil);
      UpdateView := procedure (p_Grid : TStringGrid; p_Obj : TObject)
                    begin
                      p_Grid.ColCount := 1;
                      p_Grid.RowCount := 1;
                      p_Grid.Cells[0,0] := 'Kategoria';
                      p_Grid.RowCount := pomCategories.Count + 1;
                      if pomCategories.Count < 1 then
                        Exit;
                      for var i := 0 to pomCategories.Count - 1 do
                        p_Grid.Cells [0, i + 1] := pomCategories [i].CategoryName;
                      p_Grid.FixedRows := 1;
                    end;
      ObjectList := pomCategories;
      WndListTitle := 'Kategorie';
      WndObjTitle  := 'Kategoria';
      NavigationKeys := true;
      FullScreen := false;
      XMLLoaderSaver := MainKernel.GiveObjectByInterface(IXMLCategoriesLoaderSaver, true) as IXMLCategoriesLoaderSaver;
    end;
    Result := TObjectWindowsCreator.OpenObjControllerWindow (pomSteeringObj);
    SetIndexes (TObjectList<TObject> (pomCategories),
                function (p_ID : Integer; p_List : TObjectList <TObject>) : Integer
                begin
                  Result := (p_List [p_ID] as TCategory).CategoryIndex;
                end,
                procedure (p_ID : Integer; p_List : TObjectList <TObject>; p_IDValue : Integer)
                begin
                  (p_List [p_ID] as TCategory).CategoryIndex := p_IDValue;
                end);
    if Result = mrOk then
      (MainKernel.GiveObjectByInterface (ICategoriesLoaderSaver) as ICategoriesLoaderSaver).SaveCategories(pomCategories);
  finally
    pomSteeringObj.Free;
    pomCategories.Free;
  end
end;

function TModuleCategories.OpenModule: boolean;
begin
  Result := inherited;
  InitCategories;
end;

procedure TModuleCategories.RegisterClasses;
begin
  inherited;
  RegisterClass(IXMLCategoriesLoaderSaver, TXMLCategoriesLoaderSaver);
end;

end.
