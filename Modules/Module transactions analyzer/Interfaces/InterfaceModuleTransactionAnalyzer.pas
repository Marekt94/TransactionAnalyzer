unit InterfaceModuleTransactionAnalyzer;

interface

uses
  InterfaceModule;

type
  IModuleTransactionAnalyzer = interface(IModule)
    ['{47A3E3C6-9A8F-435F-8617-D1D6F3E14891}']
    function RegisterLoaderSaverClass : boolean;
  end;

implementation

end.
