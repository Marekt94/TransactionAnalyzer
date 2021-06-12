unit InterfaceRuleSaver;

interface

uses
  System.Generics.Collections, Rule;

type
  IRuleSaver = interface (IInterface)
  ['{514BD503-C314-43EA-8ED1-B9C3BBFFCC5D}']
    procedure SaveRules (const p_RuleList : TObjectList <TRule>; p_Path : string);
    procedure LoadRules (var   p_RuleList : TObjectList <TRule>; p_Path : string);
  end;

implementation

end.
