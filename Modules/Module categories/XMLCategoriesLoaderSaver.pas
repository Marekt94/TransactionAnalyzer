unit XMLCategoriesLoaderSaver;

interface

uses
  InterfaceCategoriesLoaderSaver, System.Generics.Collections, Category;

const
  rs_FileName = 'categories.xml';

type
  TXMLCategoriesLoaderSaver = class (TInterfacedObject, ICategoriesLoaderSaver)
  public
    function Load (p_List : TObjectList <TCategory>; p_Path : string) : boolean;
    function Save (p_List : TObjectList <TCategory>; p_Path : string) : boolean;
  end;

implementation

uses
  Xml.XMLIntf, Xml.XMLDoc, System.SysUtils, ConstXMLCategoriesLoaderSaver;

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
  p_Path := p_Path + rs_FileName;
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

function TXMLCategoriesLoaderSaver.Save(p_List: TObjectList<TCategory>;
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

  pomDocument.SaveToFile(p_Path + rs_FileName);

  Result := true
end;

end.
