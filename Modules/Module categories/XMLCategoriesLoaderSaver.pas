unit XMLCategoriesLoaderSaver;

interface

uses
  InterfaceCategoriesLoaderSaver, System.Generics.Collections, Category,
  InterfaceModuleSettings, Kernel, InterfaceXMLCategoriesLoaderSaver;

const
  rs_FileName = 'categories.xml';

type
  TXMLCategoriesLoaderSaver = class (TInterfacedObject, ICategoriesLoaderSaver, IXMLCategoriesLoaderSaver)
  public
    function Save (p_List : TObjectList <TObject>; p_Path : string) : boolean; overload;
    function Load (p_List : TObjectList <TObject>; p_Path : string) : boolean; overload;
    function LoadCategories (p_List : TObjectList <TCategory>; p_Path : string) : boolean; overload;
    function SaveCategories (p_List : TObjectList <TCategory>; p_Path : string) : boolean; overload;
    function LoadCategories (p_List : TObjectList <TCategory>) : boolean; overload;
    function SaveCategories (p_List : TObjectList <TCategory>) : boolean; overload;
  end;

implementation

uses
  Xml.XMLIntf, Xml.XMLDoc, System.SysUtils, ConstXMLCategoriesLoaderSaver;

{ TXMLCategoriesLoaderSaver }

function TXMLCategoriesLoaderSaver.LoadCategories(p_List: TObjectList<TCategory>;
  p_Path: string): boolean;
var
  pomCategory     : TCategory;
  pomDocument     : IXMLDocument;
  pomListNode     : IXMLNode;
  pomCategoryNode : IXMLNode;
begin
  if not Assigned (p_List) then
    Exit (false);

  pomListNode := nil;
  pomDocument := TXMLDocument.Create(nil);
  if FileExists (p_Path) then
  begin
    pomDocument.LoadFromFile (p_Path);
    pomListNode := pomDocument.ChildNodes.FindNode (rs_NN_Categories);

    if Assigned (pomListNode) then
    begin
      p_List.Clear;
      for var i := 0 to pomListNode.ChildNodes.Count - 1 do
      begin
        pomCategory := TCategory.Create;
        pomCategoryNode := pomListNode.ChildNodes.Get (i);

        pomCategory.CategoryIndex := pomCategoryNode.ChildNodes.FindNode (rs_NN_Index).NodeValue;
        pomCategory.CategoryName  := pomCategoryNode.ChildNodes.FindNode (rs_NN_Name).NodeValue;

        p_List.Add (pomCategory);
      end;
    end;
  end;

  Result := true;
end;

function TXMLCategoriesLoaderSaver.SaveCategories(p_List: TObjectList<TCategory>;
  p_Path: string): boolean;
var
  pomDocument      : IXMLDocument;
  pomCategory      : IXMLNode;
  pomCategoryNodes : IXMLNode;
begin
  pomDocument := TXMLDocument.Create(nil);
  pomDocument.Active := True;

  pomDocument.DocumentElement := pomDocument.CreateNode (rs_NN_Categories, ntElement, '');
  for var i := 0 to p_List.Count - 1 do
  begin
    pomCategory := pomDocument.DocumentElement.AddChild(rs_NN_Category);

    pomCategoryNodes := pomCategory.AddChild(rs_NN_Index);
    pomCategoryNodes.NodeValue := p_List [i].CategoryIndex;

    pomCategoryNodes := pomCategory.AddChild(rs_NN_Name);
    pomCategoryNodes.NodeValue := p_List [i].CategoryName;
  end;

  if not FileExists (p_Path) then
    FileClose (FileCreate (p_Path));

  pomDocument.SaveToFile(p_Path);

  Result := true
end;

function TXMLCategoriesLoaderSaver.LoadCategories(
  p_List: TObjectList<TCategory>): boolean;
var
  pomSettings : IModuleSettings;
  pomFolderPath : string;
begin
  pomSettings := MainKernel.GiveObjectByInterface (IModuleSettings) as IModuleSettings;
  if Assigned (pomSettings) then
    pomFolderPath := pomSettings.Settings.MainFolderPath
  else
    pomFolderPath := '';

  Result := LoadCategories(p_List, pomFolderPath + rs_FileName);
end;

function TXMLCategoriesLoaderSaver.Load(p_List: TObjectList<TObject>;
  p_Path: string): boolean;
begin
  Result := LoadCategories (TObjectList <TCategory> (p_List), p_Path);
end;

function TXMLCategoriesLoaderSaver.Save(p_List: TObjectList<TObject>;
  p_Path: string): boolean;
begin
  Result := SaveCategories (TObjectList <TCategory> (p_List), p_Path);
end;

function TXMLCategoriesLoaderSaver.SaveCategories(
  p_List: TObjectList<TCategory>): boolean;
var
  pomSettings : IModuleSettings;
  pomFolderPath : string;
begin
  pomSettings := MainKernel.GiveObjectByInterface (IModuleSettings) as IModuleSettings;
  if Assigned (pomSettings) then
    pomFolderPath := pomSettings.Settings.MainFolderPath
  else
    pomFolderPath := '';

  Result := SaveCategories (p_List, pomFolderPath + rs_FileName);
end;

end.
