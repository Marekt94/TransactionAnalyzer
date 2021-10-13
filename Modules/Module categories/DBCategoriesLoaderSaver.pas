unit DBCategoriesLoaderSaver;

interface

uses
  InterfaceCategoriesLoaderSaver, System.Generics.Collections,
  Category, Data.Win.ADODB;

const
  cTableName = 'CATEGORY';

type
  TDBCategoriesLoaderSaver = class (TInterfacedObject, ICategoriesLoaderSaver)
  strict private
    FTable : TADOTable;
    procedure PackToObject (p_Table : TADOTable;
                            p_Obj   : TCategory);
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
  with FTable do
  begin
    while not Eof do
    begin
      var pomCat : TCategory;
      pomCat := TCategory.Create;
      PackToObject(Ftable, pomCat);
      p_List.Add(pomCat);
      Next;
    end;
  end;
  Result := true;
end;

procedure TDBCategoriesLoaderSaver.PackToObject(p_Table : TADOTable;
                                                p_Obj: TCategory);
begin
  p_Obj.CategoryIndex := p_Table ['ID'];
  p_Obj.CategoryName  := p_Table ['NAME'];
end;

function TDBCategoriesLoaderSaver.Save(p_List: TObjectList<TCategory>): boolean;
var
  pomComparer : TCategoryComparer;
  pomIndex : Integer;
begin
  pomComparer := TCategoryComparer.Create;
  try
    p_List.Sort (pomComparer);
    FTable.First;
    with FTable do
    begin
      Edit;
      while not Eof do
      begin
        var pomCat : TCategory;
        pomCat := TCategory.Create;
        try
          PackToObject(FTable, pomCat);
          if not p_List.BinarySearch (pomCat, pomIndex, pomComparer) then
            FTable.Delete
          else
            Next;
        finally
          FreeAndNil (pomCat);
        end;
      end;
    end;

    for var pomObj in p_List do
    begin
      if FTable.Locate('ID',pomObj.CategoryIndex,[]) then
        FTable.Edit
      else
        FTable.Insert;
      FTable ['ID']   := pomObj.CategoryIndex;
      FTable ['NAME'] := pomObj.CategoryName;
      FTable.Post;
    end;
    Result := true;
  finally
    pomComparer.Free;
  end;
end;

end.
