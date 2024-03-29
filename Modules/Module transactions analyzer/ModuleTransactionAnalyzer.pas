unit ModuleTransactionAnalyzer;

interface

uses
  Module, InterfaceModuleTransactionAnalyzer,
  System.SysUtils, XMLDebitAccountTransactionLoader;

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
  WindowSkeleton, PanelTransactionAnalyzerBoosted,
  InterfaceTransactionsController,
  TransactionController,
  InterfaceXMLTransactionLoaderSaver, PanelProductChooser, Vcl.Controls,
  XMLCreditCardTransactionLoader;

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
  RegisterClass (ITransactionsController, TTransactionController);
end;

function TModuleTransactionAnalyzer.RegisterLoaderSaverClass : boolean;
begin
  Result := true;
  var pomWndSkeleton := TWndSkeleton.Create(nil);
  try
    var pomFrame := TfrmProductChooser.Create (pomWndSkeleton);
    pomWndSkeleton.Init(pomFrame, 'Wyb�r produktu');
    if pomWndSkeleton.ShowModal = mrCancel then
      Exit (false);
    UnregisterClass (IXMLTransactionLoaderSaver);
    case pomFrame.rgProductChooser.ItemIndex of
      0: RegisterClass (IXMLTransactionLoaderSaver, TXMLDebitAccountTransactionLoader);
      1: RegisterClass (IXMLTransactionLoaderSaver, TXMLCreditCardTransactionLoader);
    else
      raise Exception.Create('Nie oprogramowano metody wczytywania dla tego produktu');
    end;
  finally
    pomWndSkeleton.Free;
  end;
end;

end.
