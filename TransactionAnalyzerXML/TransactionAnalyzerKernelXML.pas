unit TransactionAnalyzerKernelXML;

interface

uses
  TransactionAnalyzerKernel;

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
end;

end.
