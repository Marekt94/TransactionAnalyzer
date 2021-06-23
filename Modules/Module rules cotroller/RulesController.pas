unit RulesController;

interface

uses
  InterfaceRulesController, Rule;

type
  TRulesController = class (TInterfacedObject, IRulesController)
    function GetRuleDescription (p_Rule  : TRule) : string; overload;
  end;

implementation

uses
  Category, Kernel, InterfaceModuleCategory, ModuleRules, System.SysUtils;

{ TRulesController }

function TRulesController.GetRuleDescription(p_Rule: TRule): string;
var
  pomCategory   : TCategory;
  pomTitle      : string;
  pomDate       : string;
  pomResultText : string;
begin
  pomTitle := '';
  pomDate := '';
  pomResultText := '';

  if not Assigned (p_Rule) then
    Exit ('');

  pomCategory := (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories).FindCategoryByIndex(p_Rule.CategoryIndex);
  if not Assigned (pomCategory) then
    Exit ('');

  if p_Rule.TitleContains then
    pomTitle := Format (rs_TitleConditions, [p_Rule.TitleSubstring]);
  if p_Rule.DateBetween then
    pomDate := Format (rs_DateConditions, [DateToStr (p_Rule.DateFrom), DateToStr (p_Rule.DateTo)]);

  if not pomTitle.IsEmpty and not pomDate.IsEmpty then
    pomResultText := pomTitle + ' ' + rs_and + ' ' + pomDate
  else if not pomTitle.IsEmpty then
    pomResultText := pomTitle
  else if not pomDate.IsEmpty then
    pomResultText := pomDate
  else
    Exit ('');

  Result := Format (rs_Core, [pomCategory.CategoryName, pomResultText]);
end;

end.
