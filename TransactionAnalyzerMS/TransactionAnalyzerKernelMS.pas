unit TransactionAnalyzerKernelMS;

interface

uses
  TransactionAnalyzerKernel;

type
  TTransactionAnalyzerKernelMS = class (TTransactionAnalyzerKernel)
    constructor Create;
  end;

implementation

uses
  ModuleDatabase;

{ TTransactionAnalyzerKernelMS }

constructor TTransactionAnalyzerKernelMS.Create;
begin
  inherited;
  FObjectList.Add (TModuleDatabase.Create);
end;

end.
