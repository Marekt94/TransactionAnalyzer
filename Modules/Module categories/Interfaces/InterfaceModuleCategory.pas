unit InterfaceModuleCategory;

interface

uses
  InterfaceModule, System.Generics.Collections, Category;

const
  cDefaultCategoryIndex = 0;

type
  IModuleCategories = interface(IModule)
    ['{9797894E-E2BF-403C-BA3A-E6685BAA6704}']
    function LoadCategories : boolean;
    function SaveCategories : boolean;
    function GetCateogryList : TObjectList <TCategory>;
    function GetPeriodicityList : TObjectList <TCategory>;
    function FindCategoryByIndex (p_Index : integer) : TCategory;
    property CategoriesList : TObjectList <TCategory> read GetCateogryList;
    property PeriodicityList : TObjectList <TCategory> read GetPeriodicityList;
  end;

implementation


end.
