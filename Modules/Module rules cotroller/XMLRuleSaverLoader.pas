unit XMLRuleSaverLoader;

interface

uses
  InterfaceRuleSaver, System.Generics.Collections, Rule, System.SysUtils;

type
  TXMLRuleSaverLoader = class (TInterfacedObject, IRuleSaver)
  public
    procedure SaveRules (p_RuleList : TObjectList <TRule>);
    procedure LoadRules (var p_RuleList : TObjectList <TRule>);
  end;

implementation

uses
  Xml.XMLIntf, XMLDoc;

{ TXMLRuleSaverLoader }

procedure TXMLRuleSaverLoader.LoadRules (var p_RuleList: TObjectList<TRule>);
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
  if FileExists ('rules.xml') then
  begin
    pomDocument.LoadFromFile ('rules.xml');
    pomRuleListNode := pomDocument.ChildNodes.FindNode ('rules');

    if Assigned (pomRuleListNode) then
    begin
      p_RuleList.Clear;
      for var i := 0 to pomRuleListNode.ChildNodes.Count - 1 do
      begin
        pomRule := TRule.Create;
        pomRuleNode := pomRuleListNode.ChildNodes.Get (i);

        pomRule.TitleContains  := pomRuleNode.ChildNodes.FindNode ('titlecontains').NodeValue;
        if pomRule.TitleContains then
          pomRule.TitleSubstring := pomRuleNode.ChildNodes.FindNode ('titlesubstring').NodeValue;
        pomRule.DateBetween    := pomRuleNode.ChildNodes.FindNode ('datebetween').NodeValue;
        if pomRule.DateBetween then
        begin
          pomRule.DateFrom       := pomRuleNode.ChildNodes.FindNode ('datefrom').NodeValue;
          pomRule.DateTo         := pomRuleNode.ChildNodes.FindNode ('dateto').NodeValue;
        end;
        pomRule.CategoryIndex  := pomRuleNode.ChildNodes.FindNode ('categoryindex').NodeValue;

        p_RuleList.Add (pomRule);
      end;
    end;
  end;
end;

procedure TXMLRuleSaverLoader.SaveRules (p_RuleList: TObjectList<TRule>);
var
  pomDocument  : IXMLDocument;
  pomRule      : IXMLNode;
  pomRuleNodes : IXMLNode;
begin
  pomDocument := TXMLDocument.Create(nil);
  pomDocument.Active := True;

  pomDocument.DocumentElement := pomDocument.CreateNode ('rules', ntElement, '');
  for var i := 0 to p_RuleList.Count - 1 do
  begin
    pomRule := pomDocument.DocumentElement.AddChild('rule');

    pomRuleNodes := pomRule.AddChild('titlecontains');
    pomRuleNodes.NodeValue := p_RuleList [i].TitleContains;

    pomRuleNodes := pomRule.AddChild('titlesubstring');
    pomRuleNodes.NodeValue := p_RuleList [i].TitleSubstring;

    pomRuleNodes := pomRule.AddChild('datebetween');
    pomRuleNodes.NodeValue := p_RuleList [i].DateBetween;

    pomRuleNodes := pomRule.AddChild('datefrom');
    pomRuleNodes.NodeValue := p_RuleList [i].DateFrom;

    pomRuleNodes := pomRule.AddChild('dateto');
    pomRuleNodes.NodeValue := p_RuleList [i].DateTo;

    pomRuleNodes := pomRule.AddChild('categoryindex');
    pomRuleNodes.NodeValue := p_RuleList [i].CategoryIndex;
  end;

  pomDocument.SaveToFile('rules.xml');
end;

end.
