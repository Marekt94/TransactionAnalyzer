unit DBCategoriesLoaderSaver;

interface

uses
  InterfaceCategoriesLoaderSaver, System.Generics.Collections,
  Category, Data.Win.ADODB, DBLoaderSaver;

const
  cTableName = 'CATEGORY';

type
  TDBCategoriesLoaderSaver = class (TDBLoaderSaver, ICategoriesLoaderSaver)
  strict private
    procedure PackToObject (p_Table : TADOTable;
                            p_Obj   : TCategory);
    procedure PackToTable (p_Obj   : TCategory;
                           p_Table : TADOTable);
    function ReturnFieldToLocate (p_Obj : TCategory) : Integer;
  public
    procedure AfterConstruction; override;
    function Save (p_List : TObjectList <TObject>; p_Path : string) : boolean; overload;
    function Load (p_List : TObjectList <TObject>; p_Path : string) : boolean; overload;
    function LoadCategories (p_List : TObjectList <TCategory>) : boolean;
    function SaveCategories (p_List : TObjectList <TCategory>) : boolean;
  end;

implementation

uses
  System.SysUtils, System.Variants, InterfaceKernel, InterfaceModuleDatabase, ConstXMLCategoriesLoaderSaver;

{ TDBCategoriesLoaderSaver }

procedure TDBCategoriesLoaderSaver.AfterConstruction;
begin
  inherited;
  FTable := (MainKernel.GiveObjectByInterface (IModuleDatabase) as IModuleDatabase).FindTable(cTableName);
end;

function TDBCategoriesLoaderSaver.Load(p_List: TObjectList<TObject>;
  p_Path: string): boolean;
begin
  Result := LoadCategories (TObjectList <TCategory> (p_List));
end;

function TDBCategoriesLoaderSaver.LoadCategories(p_List: TObjectList<TCategory>): boolean;
begin
  Result := inherited Load <TCategory> (FTable, p_List, PackToObject);
end;

procedure TDBCategoriesLoaderSaver.PackToObject (p_Table: TADOTable;
                                                 p_Obj: TCategory);
begin
  p_Obj.CategoryIndex := p_Table [UpperCase (rs_NN_Index)];
  p_Obj.CategoryName  := p_Table [UpperCase (rs_NN_Name)];
end;

procedure TDBCategoriesLoaderSaver.PackToTable (p_Obj: TCategory;
                                                p_Table: TADOTable);
begin
  p_Table [UpperCase (rs_NN_Index)] := p_Obj.CategoryIndex;
  p_Table [UpperCase (rs_NN_Name)]  := p_Obj.CategoryName;
end;

function TDBCategoriesLoaderSaver.ReturnFieldToLocate(p_Obj: TCategory): Integer;
begin
  Result := p_Obj.CategoryIndex;
end;

function TDBCategoriesLoaderSaver.Save(p_List: TObjectList<TObject>;
  p_Path: string): boolean;
begin
  Result := SaveCategories (TObjectList <TCategory> (p_List));
end;

function TDBCategoriesLoaderSaver.SaveCategories(p_List: TObjectList<TCategory>): boolean;
begin
  var pomComparer := TCategoryComparer.Create;
  try
    Result := inherited Save <TCategory> (FTable,
                                          p_List,
                                          pomComparer,
                                          PackToObject,
                                          PackToTable,
                                          ReturnFieldToLocate);
  finally
    PomComparer.Free;
  end;
end;

end.
