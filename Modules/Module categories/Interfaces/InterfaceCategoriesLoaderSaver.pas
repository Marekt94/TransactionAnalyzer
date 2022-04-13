unit InterfaceCategoriesLoaderSaver;

interface

uses
  System.Generics.Collections, InterfaceLoaderSaver, Category;

type
  ICategoriesLoaderSaver = interface (ILoaderSaver)
    ['{C4BD712C-872C-45A0-AA16-DF633AD177E9}']
    function LoadCategories (p_List : TObjectList <TCategory>) : boolean;
    function SaveCategories (p_List : TObjectList <TCategory>) : boolean;
  end;

implementation

end.
