unit TransactionAnalyzerKernelFB;

interface

uses
  TransactionAnalyzerKernel;

type
  TTransactionAnalyzerKernelFB = class (TTransactionAnalyzerKernel)
    constructor Create;
  end;

implementation

uses
  ModuleDatabase;

{ TTransactionAnalyzerKernelFB }

constructor TTransactionAnalyzerKernelFB.Create;
begin
  inherited;
  FObjectList.Add (TModuleDatabase.Create);
end;

end.
