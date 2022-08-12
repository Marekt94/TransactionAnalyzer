unit TransactionAnalyzerKernelMS;

interface

uses
  TransactionAnalyzerKernel, BaseKernel, InterfaceKernel, System.Generics.Collections, InterfaceModule;

type
  TTransactionAnalyzerKernelMS = class (TBaseKernel, IBaseKernel)
    procedure RegisterModules (p_ModuleList : TList<IModule>); override;
  end;

implementation

uses
  ModuleDatabase;

{ TTransactionAnalyzerKernelMS }

procedure TTransactionAnalyzerKernelMS.RegisterModules(
  p_ModuleList: TList<IModule>);
begin
  inherited;
  p_ModuleList.Add (TModuleDatabase.Create);
end;

end.
