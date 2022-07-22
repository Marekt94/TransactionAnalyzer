unit ModuleRules;

interface

uses
  Module, InterfaceModuleRules, System.Generics.Collections, Rule,
  XMLRuleSaverLoader, WindowObjectControllerSteeringClass;

resourcestring
  rs_Core = 'Przypisz kategoriê ''%s'' dla transakcji, które zawieraj¹ %s.';
  rs_TitleConditions = '''%s'' w tytule';
  rs_and = 'oraz';
  rs_DateConditions = 'zosta³y przeprowadzone pomiêdzy %s a %s';
  rs_PriceCondition = 'zawieraj¹ siê w kwocie %f a %f';

type
  TModuleRules = class(TBaseModule, IModuleRules)
  public
    function OpenMainWindowInMode (p_AddMode : Boolean) : Integer; overload;
    function OpenMainWindowInAddMode : Integer; override;
    function OpenMainWindow : Integer; overload; override;
    function GetSelfInterface : TGUID; override;
    procedure RegisterClasses; override;
  end;

implementation

uses
  InterfaceRuleSaver, Kernel, System.SysUtils, InterfaceModuleCategory,
  Category, PanelRule, Vcl.Grids, WindowSkeleton, InterfaceRulesController,
  Vcl.Controls, RulesController, InterfaceXMLRuleLoaderSaver,
  ObjectWindowsCreator;


{ TModuleRules }

function TModuleRules.GetSelfInterface: TGUID;
begin
  Result := IModuleRules;
end;

function TModuleRules.OpenMainWindow: Integer;
begin
  Result := OpenMainWindowInMode (false);
end;

function TModuleRules.OpenMainWindowInMode(p_AddMode: Boolean): Integer;
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
    pomRuleSaver := (MainKernel.GiveObjectByInterface (IRuleSaver) as IRuleSaver);
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
                      pomRuleController := MainKernel.GiveObjectByInterface (IRulesController) as IRulesController;
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
      WndListTitle := 'Regu³y';
      WndObjTitle  := 'Regu³a';
      NavigationKeys := true;
      FullScreen := false;
      AddMode := p_AddMode;
      XMLLoaderSaver := (MainKernel.GiveObjectByInterface (IXMLRuleLoaderSaver) as IXMLRuleLoaderSaver);
    end;
    Result := TObjectWindowsCreator.OpenObjControllerWindow (pomSteeringObj);
    if Result = mrOk then
      pomRuleSaver.SaveRules (pomRulesList);
  finally
    pomSteeringObj.Free;
    pomRulesList.Free;
  end
end;

function TModuleRules.OpenMainWindowInAddMode: Integer;
begin
  Result := OpenMainWindowInMode (true);
end;

procedure TModuleRules.RegisterClasses;
begin
  inherited;
  RegisterClass (IXMLRuleLoaderSaver, TXMLRuleSaverLoader);
  RegisterClass (IRulesController,    TRulesController);
end;

end.
