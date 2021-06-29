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
  Category, Kernel, InterfaceModuleCategory, ModuleRules, System.SysUtils,
  System.StrUtils;

{ TRulesController }

function TRulesController.GetRuleDescription(p_Rule: TRule): string;
var
  pomCategory   : TCategory;
  pomTitle      : string;
  pomDate       : string;
  pomResultText : string;
  pomPrice      : string;
  pomIndex      : Integer;
begin
  pomTitle := '';
  pomDate := '';
  pomResultText := '';

  if not Assigned (p_Rule) then
    Exit ('');

  pomCategory := (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories).FindCategoryByIndex(p_Rule.CategoryIndex);
  if not Assigned (pomCategory) then
    Exit ('');

  if p_Rule.PriceBetween then
    pomPrice := Format (rs_PriceCondition, [p_Rule.PriceLow, p_Rule.PriceHigh]);
  if p_Rule.TitleContains then
    pomTitle := Format (rs_TitleConditions, [p_Rule.TitleSubstring]);
  if p_Rule.DateBetween then
    pomDate := Format (rs_DateConditions, [DateToStr (p_Rule.DateFrom), DateToStr (p_Rule.DateTo)]);

  if not pomTitle.IsEmpty then
    pomResultText := pomResultText + pomTitle + ' ' + rs_and + ' ';
  if not pomDate.IsEmpty then
    pomResultText := pomResultText + pomDate + ' ' + rs_and + ' ';
  if not pomPrice.IsEmpty then
    pomResultText := pomResultText + pomPrice + ' ' + rs_and + ' ';

  if pomResultText.IsEmpty then
    Exit ('')
  else
  begin
    pomIndex := LastDelimiter (rs_and, pomResultText) - Length (rs_and);
    System.Delete(pomResultText, pomIndex, Length (rs_and)+2);
  end;

  Result := Format (rs_Core, [pomCategory.CategoryName, pomResultText]);
end;

end.
