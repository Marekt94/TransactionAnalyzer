unit InterfaceCategoriesLoaderSaver;

interface

uses
  System.Generics.Collections, Category;

type
  ICategoriesLoaderSaver = interface (IInterface)
    ['{C4BD712C-872C-45A0-AA16-DF633AD177E9}']
    function Load (p_List : TObjectList <TCategory>; p_Path : string) : boolean;
    function Save (p_List : TObjectList <TCategory>; p_Path : string) : boolean;
  end;

implementation

end.