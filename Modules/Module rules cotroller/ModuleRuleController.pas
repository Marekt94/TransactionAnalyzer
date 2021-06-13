unit ModuleRuleController;

interface

uses
  Module, InterfaceModuleRuleController, System.Generics.Collections, Rule,
  XMLRuleSaverLoader, WindowObjectControllerSteeringClass;

resourcestring
  rs_Core = 'Przypisz kategoriê ''%s'' dla transakcji, które zawieraj¹ %s.';
  rs_TitleConditions = '''%s'' w tytule';
  rs_and = 'oraz';
  rs_DateConditions = 'zosta³y przeprowadzone pomiêdzy %s a %s';

type
  TModuleRuleController = class(TBaseModule, IModuleRuleController)
  strict private
    FRuleList : TObjectList <TRule>;
  public
    constructor Create; override;
    destructor Destroy; override;
    function OpenMainWindow : Integer; override;
    function OpenModule : boolean; override;
    function CloseModule : boolean; override;
    function GetRuleDescription (p_Index : integer) : string; overload;
    function GetRuleDescription (p_Rule  : TRule) : string; overload;
    function GetSelfInterface : TGUID; override;
    function GetRuleList      : TObjectList<TRule>;
    procedure RegisterClasses; override;
    procedure SaveRuleList;
    procedure LoadRuleList;
    property RuleList : TObjectList<TRule> read GetRuleList;
  end;

implementation

uses
  InterfaceRuleSaver, Kernel, System.SysUtils, InterfaceModuleCategory,
  Category, PanelRule, Vcl.Grids, WindowSkeleton;


{ TModuleRuleController }

function TModuleRuleController.CloseModule: boolean;
begin
  SaveRuleList;
  Result := inherited;
end;

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
  pomRuleSaver.LoadRules (FRuleList, '');
end;

function TModuleRuleController.OpenMainWindow: Integer;
resourcestring
  rs_CategoriesPanelTitle = 'Kategorie';
var
  pomSteeringObj : TWndObjControllerSteeringClass;
begin
  pomSteeringObj := TWndObjControllerSteeringClass.Create;
  try
    with pomSteeringObj do
    begin
      ObjectClass := TRule;
      ObjectFrame := TfrmRule.Create (nil);
      UpdateView := procedure (p_Grid : TStringGrid)
                    var
                      pomRuleController : IModuleRuleController;
                    begin
                      p_Grid.ColCount := 2;
                      p_Grid.RowCount := 1;
                      p_Grid.Cells [0,0] := 'L.p.';
                      p_Grid.Cells [1,0] := 'Opis';
                      p_Grid.RowCount := FRuleList.Count + 1;
                      pomRuleController := Kernel.GiveObjectByInterface (IModuleRuleController) as IModuleRuleController;
                      if FRuleList.Count > 0 then
                      begin
                        for var i := 0 to FRuleList.Count - 1 do
                        begin
                          p_Grid.Cells [0, i + 1] := IntToStr (i + 1);
                          p_Grid.Cells [1, i + 1] := pomRuleController.GetRuleDescription (FRuleList [i]);
                        end;
                        p_Grid.FixedRows := 1;
                      end;
                    end;
      ObjectList := FRuleList;
      WndListTitle := 'Regu³y';
      WndObjTitle  := 'Regu³a';
      NavigationKeys := False;
      FullScreen := True;
    end;
    Result := WindowSkeleton.OpenObjControllerWindow (pomSteeringObj);
  finally
    pomSteeringObj.Free;
  end
end;

function TModuleRuleController.OpenModule: boolean;
begin
  Result := inherited;
  LoadRuleList;
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
  pomRuleSaver.SaveRules (FRuleList, '');
end;

end.
