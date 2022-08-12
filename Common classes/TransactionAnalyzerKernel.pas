unit TransactionAnalyzerKernel;

interface

uses
  InterfaceModule, System.Generics.Collections, InterfaceKernel, BaseKernel;

type
  TTransactionAnalyzerKernel = class(TContainer, IContainer)
    procedure RegisterModules (p_ModuleList : TList<IModule>); override;
  end;

implementation

uses
  ModuleTransactionAnalyzer, ModuleCategories,
  ModuleRules;

{ TTransactionAnalyzerKernel }

procedure TTransactionAnalyzerKernel.RegisterModules(
  p_ModuleList: TList<IModule>);
begin
  inherited;
  p_ModuleList.Add (TModuleCategories.Create);
  p_ModuleList.Add (TModuleTransactionAnalyzer.Create);
  p_ModuleList.Add (TModuleRules.Create);
end;

end.
