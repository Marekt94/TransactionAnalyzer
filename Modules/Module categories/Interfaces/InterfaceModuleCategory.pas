unit InterfaceModuleCategory;

interface

uses
  InterfaceModule, System.Generics.Collections, Category;

type
  IModuleCategories = interface(IModule)
    ['{9797894E-E2BF-403C-BA3A-E6685BAA6704}']
    function LoadCategories (p_Path : string) : boolean;
    function SaveCategories (p_Path : string) : boolean;
    function GetCateogryList : TObjectList <TCategory>;
    function GetPeriodicityList : TObjectList <TCategory>;
    function FindCategoryByIndex (p_Index : integer) : TCategory;
    property CategoriesList : TObjectList <TCategory> read GetCateogryList;
    property PeriodicityList : TObjectList <TCategory> read GetPeriodicityList;
  end;

implementation


end.
