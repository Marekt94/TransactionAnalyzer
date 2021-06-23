unit InterfaceRulesController;

interface

uses
  Rule;

type
  IRulesController = interface (IInterface)
    ['{1F7CB8D8-BD28-4F69-A0F7-256761C3164C}']
    function GetRuleDescription (p_Rule  : TRule) : string; overload;
  end;

implementation

end.
