unit ModuleTransactionAnalyzer;

interface

uses
  Module, InterfaceModuleTransactionAnalyzer, System.Generics.Collections, Transaction,
  System.SysUtils, XMLTransactionLoader,
  InterfaceTransactionLoader;

type
  TModuleTransactionAnalyzer = class (TBaseModule, IModuleTransactionAnalyzer)
  strict private
    FTransactionList : TObjectList<TTransaction>;
  public
    constructor Create; override;
    destructor Destroy; override;
    function LoadTransactions (p_Path : string) : boolean;
    function SaveTransactions (p_Path : string) : boolean;
    procedure RegisterClasses; override;
    function AnalyzeTransactions (p_Transactions : TObjectList <TTransaction>) : boolean;
    function GetSelfInterface : TGUID; override;
    function GetTransactionList : TObjectList<TTransaction>;
  end;

implementation

uses
  WindowSkeleton, InterfaceModuleRuleController, Kernel;

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

constructor TModuleTransactionAnalyzer.Create;
begin
  inherited;
  FTransactionList := TObjectList<TTransaction>.Create;
end;

destructor TModuleTransactionAnalyzer.Destroy;
begin
  FreeAndNil (FTransactionList);
  inherited;
end;

function TModuleTransactionAnalyzer.GetSelfInterface: TGUID;
begin
  Result := IModuleTransactionAnalyzer;
end;

function TModuleTransactionAnalyzer.GetTransactionList: TObjectList<TTransaction>;
begin
  Result := FTransactionList;
end;

function TModuleTransactionAnalyzer.LoadTransactions (p_Path : string) : boolean;
begin
  Result := (Kernel.GiveObjectByInterface(ITransactionLoader) as ITransactionLoader).Load(FTransactionList, p_Path)
end;

procedure TModuleTransactionAnalyzer.RegisterClasses;
begin
  inherited;
  RegisterClass (TXMLTransactionLoader);
end;

function TModuleTransactionAnalyzer.SaveTransactions (p_Path : string) : boolean;
begin
  Result := true;
end;

end.
