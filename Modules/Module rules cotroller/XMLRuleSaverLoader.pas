unit XMLRuleSaverLoader;

interface

uses
  InterfaceRuleSaver, System.Generics.Collections, Rule, System.SysUtils,
  InterfaceModuleSettings, Kernel;

type
  TXMLRuleSaverLoader = class (TInterfacedObject, IRuleSaver)
  public
    procedure SaveRules (const p_RuleList : TObjectList <TRule>; p_Path : string); overload;
    procedure LoadRules (var   p_RuleList : TObjectList <TRule>; p_Path : string); overload;
    procedure SaveRules (const p_RuleList : TObjectList <TRule>); overload;
    procedure LoadRules (var   p_RuleList : TObjectList <TRule>); overload;
  end;

implementation

uses
  Xml.XMLIntf, XMLDoc, ConstXMLRuleSaverLoader;

{ TXMLRuleSaverLoader }

procedure TXMLRuleSaverLoader.LoadRules (var p_RuleList: TObjectList<TRule>;
                                             p_Path : string);
var
  pomRule         : TRule;
  pomDocument     : IXMLDocument;
  pomRuleListNode : IXMLNode;
  pomRuleNode     : IXMLNode;
begin
  if not Assigned (p_RuleList) then
    Exit;

  pomRuleListNode := nil;
  pomDocument := TXMLDocument.Create(nil);
  p_Path := p_Path + '\' + rs_FileName;
  if FileExists (p_Path) then
  begin
    pomDocument.LoadFromFile (p_Path);
    pomRuleListNode := pomDocument.ChildNodes.FindNode (rs_NN_Rules);

    if Assigned (pomRuleListNode) then
    begin
      p_RuleList.Clear;
      for var i := 0 to pomRuleListNode.ChildNodes.Count - 1 do
      begin
        pomRule := TRule.Create;
        pomRuleNode := pomRuleListNode.ChildNodes.Get (i);

        pomRule.TitleContains  := pomRuleNode.ChildNodes.FindNode (rs_NN_TitleContains).NodeValue;
        if pomRule.TitleContains then
          pomRule.TitleSubstring := pomRuleNode.ChildNodes.FindNode (rs_NN_TitleSubstring).NodeValue;
        pomRule.DateBetween    := pomRuleNode.ChildNodes.FindNode (rs_NN_DateBetween).NodeValue;
        if pomRule.DateBetween then
        begin
          pomRule.DateFrom       := pomRuleNode.ChildNodes.FindNode (rs_NN_DateFrom).NodeValue;
          pomRule.DateTo         := pomRuleNode.ChildNodes.FindNode (rs_NN_DateTo).NodeValue;
        end;
        pomRule.CategoryIndex  := pomRuleNode.ChildNodes.FindNode (rs_NN_CategoryIndex).NodeValue;

        p_RuleList.Add (pomRule);
      end;
    end;
  end;
end;

procedure TXMLRuleSaverLoader.SaveRules (const p_RuleList: TObjectList<TRule>;
                                               p_Path : string );
var
  pomDocument  : IXMLDocument;
  pomRule      : IXMLNode;
  pomRuleNodes : IXMLNode;
begin
  pomDocument := TXMLDocument.Create(nil);
  pomDocument.Active := True;

  pomDocument.DocumentElement := pomDocument.CreateNode (rs_NN_Rules, ntElement, '');
  for var i := 0 to p_RuleList.Count - 1 do
  begin
    pomRule := pomDocument.DocumentElement.AddChild(rs_NN_Rule);

    pomRuleNodes := pomRule.AddChild(rs_NN_TitleContains);
    pomRuleNodes.NodeValue := p_RuleList [i].TitleContains;

    pomRuleNodes := pomRule.AddChild(rs_NN_TitleSubstring);
    pomRuleNodes.NodeValue := p_RuleList [i].TitleSubstring;

    pomRuleNodes := pomRule.AddChild(rs_NN_DateBetween);
    pomRuleNodes.NodeValue := p_RuleList [i].DateBetween;

    pomRuleNodes := pomRule.AddChild(rs_NN_DateFrom);
    pomRuleNodes.NodeValue := p_RuleList [i].DateFrom;

    pomRuleNodes := pomRule.AddChild(rs_NN_DateTo);
    pomRuleNodes.NodeValue := p_RuleList [i].DateTo;

    pomRuleNodes := pomRule.AddChild(rs_NN_CategoryIndex);
    pomRuleNodes.NodeValue := p_RuleList [i].CategoryIndex;
  end;

  pomDocument.SaveToFile(p_Path + '\' + rs_FileName);
end;

procedure TXMLRuleSaverLoader.LoadRules(var p_RuleList: TObjectList<TRule>);
var
  pomSettings : IModuleSettings;
  pomFolderPath : string;
begin
  pomSettings := Kernel.GiveObjectByInterface (IModuleSettings) as IModuleSettings;
  if Assigned (pomSettings) then
    pomFolderPath := pomSettings.Settings.MainFolderPath
  else
    pomFolderPath := '';

  LoadRules (p_RuleList, pomFolderPath);
end;

procedure TXMLRuleSaverLoader.SaveRules(const p_RuleList: TObjectList<TRule>);
var
  pomSettings : IModuleSettings;
  pomFolderPath : string;
begin
  pomSettings := Kernel.GiveObjectByInterface (IModuleSettings) as IModuleSettings;
  if Assigned (pomSettings) then
    pomFolderPath := pomSettings.Settings.MainFolderPath
  else
    pomFolderPath := '';

  SaveRules (p_RuleList, pomFolderPath);
end;

end.
