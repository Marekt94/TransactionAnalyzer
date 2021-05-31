unit XMLRuleSaverLoader;

interface

uses
  InterfaceRuleSaver, System.Generics.Collections, Rule;

type
  TXMLRuleSaverLoader = class (TInterfacedObject, IRuleSaver)
  public
    procedure SaveRules (p_RuleList : TObjectList <TRule>);
    procedure LoadRules (var p_RuleList : TObjectList <TRule>);
  end;

implementation

uses
  System.SysUtils;

{ TXMLRuleSaverLoader }

procedure TXMLRuleSaverLoader.LoadRules (var p_RuleList: TObjectList<TRule>);
var
  pomRule : TRule;
begin
  if not Assigned (p_RuleList) then
    Exit;

  p_RuleList.Clear;
  pomRule := TRule.Create;
  with pomRule do
  begin
    pomRule.CategoryIndex := 0;
    pomRule.TitleContains := True;
    pomRule.TitleSubstring := 'biedronka';
  end;
  p_RuleList.Add (pomRule);

  pomRule := TRule.Create;
  with pomRule do
  begin
    pomRule.CategoryIndex := 1;
    pomRule.DateBetween := True;
    pomRule.DateFrom := StrToDate ('28.05.2020');
    pomRule.DateTo   := StrToDate ('29.05.2020');
  end;
  p_RuleList.Add (pomRule);
end;

procedure TXMLRuleSaverLoader.SaveRules (p_RuleList: TObjectList<TRule>);
begin

end;

end.
