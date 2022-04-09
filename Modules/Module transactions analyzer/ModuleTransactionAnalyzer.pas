unit ModuleTransactionAnalyzer;

interface

uses
  Module, InterfaceModuleTransactionAnalyzer, System.Generics.Collections, Transaction,
  System.SysUtils, XMLTransactionLoader,
  InterfaceTransactionLoader;

type
  TModuleTransactionAnalyzer = class (TBaseModule, IModuleTransactionAnalyzer)
  public
    function OpenMainWindow : Integer; override;
    procedure RegisterClasses; override;
    function GetSelfInterface : TGUID; override;
  end;

implementation

uses
  WindowSkeleton, InterfaceModuleRules, Kernel, PanelTransactionAnalyzerBoosted,
  InterfaceModuleCategory, InterfaceTransactionsController,
  TransactionController, DBTransactionLoaderSaver,
  InterfaceXMLTransactionLoaderSaver;

{ TModuleTransactionAnalyzer }

function TModuleTransactionAnalyzer.GetSelfInterface: TGUID;
begin
  Result := IModuleTransactionAnalyzer;
end;

function TModuleTransactionAnalyzer.OpenMainWindow: Integer;
var
  pomWndSkeleton : TWndSkeleton;
begin
  pomWndSkeleton := TWndSkeleton.Create(nil);
  try
    pomWndSkeleton.Init(TFrmTransactionAnalyzerBoosted2.Create (pomWndSkeleton), 'Analiza', false, true);
    Result := pomWndSkeleton.ShowModal;
  finally
    pomWndSkeleton.Free;
  end;
end;

procedure TModuleTransactionAnalyzer.RegisterClasses;
begin
  inherited;
  RegisterClass (IXMLTransactionLoaderSaver, TXMLTransactionLoader);
  RegisterClass (ITransactionsController,    TTransactionController);
  RegisterClass (ITransactionLoader,         TDBTransactionLoaderSaver);
end;

end.
