unit TransactionAnalyzerKernel;

interface

uses
  Kernel;

type
  TTransactionAnalyzerKernel = class(TKernel)
    constructor Create;
  end;

implementation

uses
  ModuleTransactionAnalyzer, ModuleCategories,
  ModuleRules;

{ TTransactionAnalyzerKernel }

constructor TTransactionAnalyzerKernel.Create;
begin
  inherited;
  FObjectList.Add (TModuleCategories.Create);
  FObjectList.Add (TModuleTransactionAnalyzer.Create);
  FObjectList.Add (TModuleRules.Create);
end;

end.
