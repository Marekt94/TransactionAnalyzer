unit ModuleTransactionAnalyzer;

interface

uses
  Module, InterfaceModuleTransactionAnalyzer, System.Generics.Collections, Transaction,
  System.SysUtils, PanelRuleList;

type
  TModuleTransactionAnalyzer = class (TBaseModule, IModuleTransactionAnalyzer)
  public
    function AnalyzeTransactions (p_Transactions : TObjectList <TTransaction>) : boolean;
    function GetSelfInterface : TGUID; override;
    procedure SetConditions;
  end;

implementation

uses
  WindowSkeleton, InterfaceModuleRuleController;

{ TModuleTransactionAnalyzer }

function TModuleTransactionAnalyzer.AnalyzeTransactions(
  p_Transactions: TObjectList<TTransaction>): boolean;
var
  pomRuleController : IModuleRuleController;
begin
  pomRuleController := GiveObjectByInterface (IModuleRuleController) as IModuleRuleController;
  for var i := 0 to p_Transactions.Count - 1 do
  begin
    for var j := 0 to pomRuleController.RuleList.Count - 1 do
      if pomRuleController.RuleList.Items [i].FullfilConditions (p_Transactions [i]) then
      begin
        p_Transactions [i].CategoryIndex := pomRuleController.RuleList.Items [i].CategoryIndex;
        break;
      end;
  end;
  Result := true;
end;

function TModuleTransactionAnalyzer.GetSelfInterface: TGUID;
begin
  Result := IModuleTransactionAnalyzer;
end;

procedure TModuleTransactionAnalyzer.SetConditions;
resourcestring
  rs_TransactionAnalyzerSettings = 'Regu³y';
var
  pomWindow : TWndSkeleton;
begin
  pomWindow := TWndSkeleton.Create(nil);
  try
    pomWindow.Init (TfrmRuleList.Create (pomWindow), rs_TransactionAnalyzerSettings);
    pomWindow.ShowModal;
  finally
    FreeAndNil (pomWindow);
  end
end;

end.
