unit InterfaceModuleRuleController;

interface

uses
  InterfaceModule, System.Generics.Collections, Rule;

type
  IModuleRuleController = interface (IModule)
  ['{388F0DB4-DFBD-4102-959D-493445CACA44}']
    procedure SaveRuleList;
    procedure LoadRuleList;
    function GetRuleDescription (p_Index : integer) : string; overload;
    function GetRuleDescription (p_Rule  : TRule) : string; overload;
    function GetRuleList : TObjectList<TRule>;
    property RuleList: TObjectList<TRule> read GetRuleList;
  end;

implementation

end.
