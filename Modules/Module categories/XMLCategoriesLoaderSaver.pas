unit XMLCategoriesLoaderSaver;

interface

uses
  InterfaceCategoriesLoaderSaver, System.Generics.Collections, Category,
  Xml.XMLIntf, Xml.XMLDoc;

type
  TXMLCategoriesLoaderSaver = class (TInterfacedObject, ICategoriesLoaderSaver)
  public
    function Load (p_List : TObjectList <TCategory>; p_Path : string) : boolean;
    function Save (p_List : TObjectList <TCategory>; p_Path : string) : boolean;
  end;

implementation

uses
  System.SysUtils;

{ TXMLCategoriesLoaderSaver }

function TXMLCategoriesLoaderSaver.Load(p_List: TObjectList<TCategory>;
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
  if FileExists ('categories.xml') then
  begin
    pomDocument.LoadFromFile ('categories.xml');
    pomListNode := pomDocument.ChildNodes.FindNode ('categories');

    if Assigned (pomListNode) then
    begin
      p_List.Clear;
      for var i := 0 to pomListNode.ChildNodes.Count - 1 do
      begin
        pomCategory := TCategory.Create;
        pomCategoryNode := pomListNode.ChildNodes.Get (i);

        pomCategory.CategoryIndex := pomCategoryNode.ChildNodes.FindNode ('index').NodeValue;
        pomCategory.CategoryName  := pomCategoryNode.ChildNodes.FindNode ('name').NodeValue;

        p_List.Add (pomCategory);
      end;
    end;
  end;

  Result := true;
end;

function TXMLCategoriesLoaderSaver.Save(p_List: TObjectList<TCategory>;
  p_Path: string): boolean;
var
  pomDocument      : IXMLDocument;
  pomCategory      : IXMLNode;
  pomCategoryNodes : IXMLNode;
begin
  pomDocument := TXMLDocument.Create(nil);
  pomDocument.Active := True;

  pomDocument.DocumentElement := pomDocument.CreateNode ('categories', ntElement, '');
  for var i := 0 to p_List.Count - 1 do
  begin
    pomCategory := pomDocument.DocumentElement.AddChild('category');

    pomCategoryNodes := pomCategory.AddChild('index');
    pomCategoryNodes.NodeValue := p_List [i].CategoryIndex;

    pomCategoryNodes := pomCategory.AddChild('name');
    pomCategoryNodes.NodeValue := p_List [i].CategoryName;
  end;

  pomDocument.SaveToFile('categories.xml');

  Result := true
end;

end.
