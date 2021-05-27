unit ModuleTransactionAnalyzer;

interface

uses
  Module, InterfaceModuleTransactionAnalyzer, System.Generics.Collections, Transaction,
  PanelTransactionAnalyzerSettings, System.SysUtils;

type
  TModuleTransactionAnalyzer = class (TBaseModule, IModuleTransactionAnalyzer)
  public
    function AnalyzeTransactions (p_Transaction : TObjectList <TTransaction>) : boolean;
    function GetSelfInterface : TGUID; override;
    procedure SetConditions;
  end;

implementation

uses
  WindowSkeleton;

{ TModuleTransactionAnalyzer }

function TModuleTransactionAnalyzer.AnalyzeTransactions(
  p_Transaction: TObjectList<TTransaction>): boolean;
begin
  Result := true;
end;

function TModuleTransactionAnalyzer.GetSelfInterface: TGUID;
begin
  Result := IModuleTransactionAnalyzer;
end;

procedure TModuleTransactionAnalyzer.SetConditions;
resourcestring
  rs_TransactionAnalyzerSettings = 'Warunki';
var
  pomWindow : TWndSkeleton;
begin
  pomWindow := TWndSkeleton.Create(nil);
  try
    pomWindow.Init (TfrmTransactionAnalyzerSettings.Create (pomWindow), rs_TransactionAnalyzerSettings);
    pomWindow.ShowModal;
  finally
    FreeAndNil (pomWindow);
  end
end;

end.
