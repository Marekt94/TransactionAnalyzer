unit TransactionAnalyzerKernelXML;

interface

uses
  InterfaceKernel, InterfaceModule, System.Generics.Collections, BaseKernel;

type
  TTransactionAnalyzerKernelXML = class (TBasePlatform, IPlatform)
   public
    procedure RegisterModules (p_ModuleList : TList<IModule>); override;
  end;

implementation

uses
  ModuleDatabaseXML, ModuleSettings;

{ TTransactionAnalyzerKernelXML }

procedure TTransactionAnalyzerKernelXML.RegisterModules(
  p_ModuleList: TList<IModule>);
begin
  inherited;
  p_ModuleList.Add (TModuleDatabaseXML.Create);
  p_ModuleList.Add (TModuleSettings.Create);
end;

end.
