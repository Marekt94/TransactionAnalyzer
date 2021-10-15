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
    function Load (p_List : TObjectList <TCategory>) : boolean;
    function Save (p_List : TObjectList <TCategory>) : boolean;
  end;

implementation

uses
  System.SysUtils, System.Variants, Kernel, InterfaceModuleDatabase;

{ TDBCategoriesLoaderSaver }

procedure TDBCategoriesLoaderSaver.AfterConstruction;
begin
  inherited;
  FTable := (Kernel.GiveObjectByInterface (IModuleDatabase) as IModuleDatabase).FindTable(cTableName);
end;

function TDBCategoriesLoaderSaver.Load(p_List: TObjectList<TCategory>): boolean;
begin
  Result := inherited Load <TCategory> (FTable, p_List, PackToObject);
end;

procedure TDBCategoriesLoaderSaver.PackToObject (p_Table: TADOTable;
                                                 p_Obj: TCategory);
begin
  p_Obj.CategoryIndex := p_Table ['ID'];
  p_Obj.CategoryName  := p_Table ['NAME'];
end;

procedure TDBCategoriesLoaderSaver.PackToTable (p_Obj: TCategory;
                                                p_Table: TADOTable);
begin
  p_Table ['ID']   := p_Obj.CategoryIndex;
  p_Table ['NAME'] := p_Obj.CategoryName;
end;

function TDBCategoriesLoaderSaver.ReturnFieldToLocate(p_Obj: TCategory): Integer;
begin
  Result := p_Obj.CategoryIndex;
end;

function TDBCategoriesLoaderSaver.Save(p_List: TObjectList<TCategory>): boolean;
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
