unit TransactionAnalyzerKernelXML;

interface

uses
  TransactionAnalyzerKernel, ModuleSettings;

type
  TTransactionAnalyzerKernelXML = class (TTransactionAnalyzerKernel)
  public
    constructor Create;
  end;

implementation

uses
  ModuleDatabaseXML;

{ TTransactionAnalyzerKernelXML }

constructor TTransactionAnalyzerKernelXML.Create;
begin
  inherited;
  FObjectList.Add (TModuleDatabaseXML.Create);
  FObjectList.Add (TModuleSettings.Create);
end;

end.
