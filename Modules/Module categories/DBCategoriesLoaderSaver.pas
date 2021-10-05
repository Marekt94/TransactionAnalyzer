unit DBCategoriesLoaderSaver;

interface

uses
  InterfaceCategoriesLoaderSaver, System.Generics.Collections,
  Category, DataModuleCategories, Data.Win.ADODB;

type
  TDBCategoriesLoaderSaver = class (TInterfacedObject, ICategoriesLoaderSaver)
  strict private
    FTable : TdtmCategories;
    procedure PackToObject (p_Table : TADOTable;
                            p_Obj   : TCategory);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function Load (p_List : TObjectList <TCategory>) : boolean;
    function Save (p_List : TObjectList <TCategory>) : boolean;
  end;

implementation

uses
  System.SysUtils, System.Variants;

{ TDBCategoriesLoaderSaver }

procedure TDBCategoriesLoaderSaver.AfterConstruction;
begin
  inherited;
  FTable := TdtmCategories.Create (nil);
end;

procedure TDBCategoriesLoaderSaver.BeforeDestruction;
begin
  FreeAndNil (FTable);
  inherited;
end;

function TDBCategoriesLoaderSaver.Load(p_List: TObjectList<TCategory>): boolean;
begin
  with FTable.FTable do
  begin
    while not Eof do
    begin
      var pomCat : TCategory;
      pomCat := TCategory.Create;
      PackToObject(Ftable.FTable, pomCat);
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
    with FTable.FTable do
    begin
      Edit;
      while not Eof do
      begin
        var pomCat : TCategory;
        pomCat := TCategory.Create;
        try
          PackToObject(FTable.FTable, pomCat);
          if not p_List.BinarySearch (pomCat, pomIndex, pomComparer) then
            FTable.FTable.Delete
          else
            Next;
        finally
          FreeAndNil (pomCat);
        end;
      end;
    end;

    for var pomObj in p_List do
    begin
      if FTable.FTable.Locate('ID',pomObj.CategoryIndex,[]) then
        FTable.FTable.Edit
      else
        FTable.FTable.Insert;
      FTable.FTable ['ID']   := pomObj.CategoryIndex;
      FTable.FTable ['NAME'] := pomObj.CategoryName;
      FTable.FTable.Post;
    end;
    Result := true;
  finally
    pomComparer.Free;
  end;
end;

end.
