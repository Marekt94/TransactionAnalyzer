unit ModuleRuleController;

interface

uses
  Module, InterfaceModuleRuleController, System.Generics.Collections, Rule,
  XMLRuleSaverLoader;

resourcestring
  rs_Core = 'Przypisz kategoriê ''%s'' dla transakcji, które zawieraj¹ %s.';
  rs_TitleConditions = 'tekst ''%s'' w tytule';
  rs_and = 'oraz';
  rs_DateConditions = 'zosta³y przeprowadzone pomiêdzy %s a %s';

type
  TModuleRuleController = class(TBaseModule, IModuleRuleController)
  strict private
    FRuleList : TObjectList <TRule>;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetRuleDescription (p_Index : integer) : string; overload;
    function GetRuleDescription (p_Rule  : TRule) : string; overload;
    procedure RegisterClasses; override;
    procedure SaveRuleList;
    procedure LoadRuleList;
    function GetSelfInterface : TGUID; override;
    function GetRuleList      : TObjectList<TRule>;
    property RuleList         : TObjectList<TRule> read GetRuleList;
  end;

implementation

uses
  InterfaceRuleSaver, Kernel, System.SysUtils, InterfaceModuleCategory,
  Category;


{ TModuleRuleController }

constructor TModuleRuleController.Create;
begin
  inherited;
  FRuleList := TObjectList<TRule>.Create;
end;

destructor TModuleRuleController.Destroy;
begin
  FreeAndNil (FRuleList);
  inherited;
end;

function TModuleRuleController.GetRuleDescription(p_Index: integer): string;
begin
  if p_Index < 0 then
    Exit ('');

  Result := GetRuleDescription (FRuleList [p_Index]);
end;

function TModuleRuleController.GetRuleDescription(p_Rule: TRule): string;
var
  pomTitle : string;
  pomDate  : string;
  pomResultText : string;
  pomCategory : TCategory;
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

function TModuleRuleController.GetRuleList: TObjectList<TRule>;
begin
  Result := FRuleList;
end;

function TModuleRuleController.GetSelfInterface: TGUID;
begin
  Result := IModuleRuleController;
end;

procedure TModuleRuleController.LoadRuleList;
var
  pomRuleSaver : IRuleSaver;
begin
  pomRuleSaver := GiveObjectByInterface (IRuleSaver) as IRuleSaver;
  pomRuleSaver.LoadRules (FRuleList);
end;

procedure TModuleRuleController.RegisterClasses;
begin
  inherited;
  RegisterClass (TXMLRuleSaverLoader);
end;

procedure TModuleRuleController.SaveRuleList;
var
  pomRuleSaver : IRuleSaver;
begin
  pomRuleSaver := GiveObjectByInterface (IRuleSaver) as IRuleSaver;
  pomRuleSaver.SaveRules (FRuleList);
end;

end.
