unit ModuleRules;

interface

uses
  Module, InterfaceModuleRules, System.Generics.Collections, Rule,
  XMLRuleSaverLoader, WindowObjectControllerSteeringClass;

resourcestring
  rs_Core = 'Przypisz kategori� ''%s'' dla transakcji, kt�re zawieraj� %s.';
  rs_TitleConditions = '''%s'' w tytule';
  rs_and = 'oraz';
  rs_DateConditions = 'zosta�y przeprowadzone pomi�dzy %s a %s';
  rs_PriceCondition = 'zawieraj� si� w kwocie %f a %f';

type
  TModuleRules = class(TBaseModule, IModuleRules)
  public
    function OpenMainWindow : Integer; override;
    function GetSelfInterface : TGUID; override;
    procedure RegisterClasses; override;
  end;

implementation

uses
  InterfaceRuleSaver, Kernel, System.SysUtils, InterfaceModuleCategory,
  Category, PanelRule, Vcl.Grids, WindowSkeleton, InterfaceRulesController,
  Vcl.Controls, RulesController;


{ TModuleRules }

function TModuleRules.GetSelfInterface: TGUID;
begin
  Result := IModuleRules;
end;

function TModuleRules.OpenMainWindow: Integer;
resourcestring
  rs_CategoriesPanelTitle = 'Kategorie';
var
  pomSteeringObj : TWndObjControllerSteeringClass;
  pomRulesList   : TObjectList<TRule>;
  pomRuleSaver   : IRuleSaver;
begin
  pomSteeringObj := TWndObjControllerSteeringClass.Create;
  try
    pomRulesList := TObjectList <TRule>.Create;
    pomRuleSaver := (Kernel.GiveObjectByInterface (IRuleSaver) as IRuleSaver);
    pomRuleSaver.LoadRules (pomRulesList);
    with pomSteeringObj do
    begin
      ObjectClass := TRule;
      ObjectFrame := TfrmRule.Create (nil);
      UpdateView := procedure (p_Grid : TStringGrid; p_Obj : TObject)
                    var
                      pomRuleController : IRulesController;
                    begin

                      p_Grid.ColCount := 2;
                      p_Grid.RowCount := 1;
                      p_Grid.Cells [0,0] := 'L.p.';
                      p_Grid.Cells [1,0] := 'Opis';
                      p_Grid.RowCount := TList<TRule>(p_Obj).Count + 1;
                      pomRuleController := Kernel.GiveObjectByInterface (IRulesController) as IRulesController;
                      if TList<TRule>(p_Obj).Count > 0 then
                      begin
                        for var i := 0 to TList<TRule>(p_Obj).Count - 1 do
                        begin
                          p_Grid.Cells [0, i + 1] := IntToStr (i + 1);
                          p_Grid.Cells [1, i + 1] := pomRuleController.GetRuleDescription (TList<TRule>(p_Obj) [i]);
                        end;
                        p_Grid.FixedRows := 1;
                      end;
                    end;
      ObjectList := pomRulesList;
      WndListTitle := 'Regu�y';
      WndObjTitle  := 'Regu�a';
      NavigationKeys := true;
      FullScreen := false;
    end;
    Result := WindowSkeleton.OpenObjControllerWindow (pomSteeringObj);
    if Result = mrOk then
      pomRuleSaver.SaveRules (pomRulesList);
  finally
    pomSteeringObj.Free;
    pomRulesList.Free;
  end
end;


procedure TModuleRules.RegisterClasses;
begin
  inherited;
  RegisterClass (TXMLRuleSaverLoader);
  RegisterClass (TRulesController);
end;

end.