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
    FTransactionListFiltered : TList<TTransaction>;
  public
    constructor Create; override;
    destructor Destroy; override;
    function OpenMainWindow : Integer; override;
    function LoadTransactions (p_Path : string) : boolean;
    function SaveTransactions (p_Path : string) : boolean;
    procedure RegisterClasses; override;
    function AnalyzeTransactions (p_Transactions : TObjectList <TTransaction>) : boolean;
    function GetSelfInterface : TGUID; override;
    function GetTransactionList : TObjectList<TTransaction>; overload;
    function GetTransactionList (p_ChoosenCategories : TList<Integer>;
                                 p_WithEmpty : boolean = true) : TList<TTransaction>; overload;
  end;

implementation

uses
  WindowSkeleton, InterfaceModuleRuleController, Kernel, PanelTransactionAnalyzerBoosted;

{ TModuleTransactionAnalyzer }

function TModuleTransactionAnalyzer.AnalyzeTransactions(
  p_Transactions: TObjectList<TTransaction>): boolean;
var
  pomRuleController : IModuleRuleController;
  pomArrayOfCategoriesIndex : TList<Integer>;
begin
  pomRuleController := Kernel.GiveObjectByInterface (IModuleRuleController) as IModuleRuleController;
  for var i := 0 to p_Transactions.Count - 1 do
  begin
    p_Transactions [i].ArrayCategoryIndex.Clear;
    for var j := 0 to pomRuleController.RuleList.Count - 1 do
    begin
      if pomRuleController.RuleList.Items [j].FullfilConditions (p_Transactions [i]) then
      begin
        pomArrayOfCategoriesIndex := p_Transactions [i].ArrayCategoryIndex;
        pomArrayOfCategoriesIndex.Add (pomRuleController.RuleList.Items [j].CategoryIndex);
      end;
    end;

    if p_Transactions [i].DocAmount >= 0 then
      p_Transactions [i].TransactionType := cImpact
    else
      p_Transactions [i].TransactionType := cExpense
  end;
  Result := true;
end;

constructor TModuleTransactionAnalyzer.Create;
begin
  inherited;
  FTransactionList := TObjectList<TTransaction>.Create;
  FTransactionListFiltered := TList<TTransaction>.Create;
end;

destructor TModuleTransactionAnalyzer.Destroy;
begin
  FreeAndNil(FTransactionListFiltered);
  FreeAndNil(FTransactionList);
  inherited;
end;

function TModuleTransactionAnalyzer.GetSelfInterface: TGUID;
begin
  Result := IModuleTransactionAnalyzer;
end;

function TModuleTransactionAnalyzer.GetTransactionList(
  p_ChoosenCategories: TList<Integer>; p_WithEmpty : boolean): TList<TTransaction>;
begin
  FTransactionListFiltered.Clear;
  for var i := 0 to FTransactionList.Count - 1 do
  begin
    if (FTransactionList [i].ArrayCategoryIndex.Count = 0) then
    begin
      if p_WithEmpty then
        FTransactionListFiltered.Add (FTransactionList [i]);
    end
    else
      for var pomCategory in p_ChoosenCategories do
      begin
        if FTransactionList [i].ArrayCategoryIndex.Contains (pomCategory) then
        begin
          FTransactionListFiltered.Add (FTransactionList [i]);
          break;
        end;
      end;
  end;
  Result := FTransactionListFiltered;
end;

function TModuleTransactionAnalyzer.GetTransactionList: TObjectList<TTransaction>;
begin
  Result := FTransactionList;
end;

function TModuleTransactionAnalyzer.LoadTransactions (p_Path : string) : boolean;
begin
  Result := (Kernel.GiveObjectByInterface(ITransactionLoader) as ITransactionLoader).Load(FTransactionList, p_Path)
end;

function TModuleTransactionAnalyzer.OpenMainWindow: Integer;
var
  pomWndSkeleton : TWndSkeleton;
begin
  pomWndSkeleton := TWndSkeleton.Create(nil);
  try
    pomWndSkeleton.Init(TFrmTransactionAnalyzerBoosted.Create (pomWndSkeleton), 'Analiza', false, true);
    Result := pomWndSkeleton.ShowModal;
  finally
    pomWndSkeleton.Free;
  end;
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
