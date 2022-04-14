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
    function RegisterLoaderSaverClass : boolean;
  end;

implementation

uses
  WindowSkeleton, InterfaceModuleRules, Kernel, PanelTransactionAnalyzerBoosted,
  InterfaceModuleCategory, InterfaceTransactionsController,
  TransactionController, DBTransactionLoaderSaver,
  InterfaceXMLTransactionLoaderSaver, PanelProductChooser, Vcl.Controls;

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

function TModuleTransactionAnalyzer.RegisterLoaderSaverClass : boolean;
begin
  Result := true;
  var pomWndSkeleton := TWndSkeleton.Create(nil);
  try
    var pomFrame := TfrmProductChooser.Create (pomWndSkeleton);
    pomWndSkeleton.Init(pomFrame, 'Wybierz product, z kt�rego wyci�g b�dzie wczytywany');
    if pomWndSkeleton.ShowModal = mrCancel then
      Exit (false);
    case pomFrame.rgProductChooser.ItemIndex of
    0:
    ;
    1:
    ;
    end;
  finally
    pomWndSkeleton.Free;
  end;
end;

end.
