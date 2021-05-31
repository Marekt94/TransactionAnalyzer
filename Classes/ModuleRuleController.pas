unit ModuleRuleController;

interface

uses
  Module, InterfaceModuleRuleController, System.Generics.Collections, Rule,
  XMLRuleSaverLoader;

type
  TModuleRuleController = class(TBaseModule, IModuleRuleController)
  strict private
    FRuleList : TObjectList <TRule>;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure RegisterClasses; override;
    procedure SaveRuleList;
    procedure LoadRuleList;
    function GetSelfInterface : TGUID; override;
    function GetRuleList      : TObjectList<TRule>;
    property RuleList         : TObjectList<TRule> read GetRuleList;
  end;

implementation

uses
  InterfaceRuleSaver, Main, System.SysUtils;


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
begin

end;

end.
