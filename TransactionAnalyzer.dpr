program TransactionAnalyzer;

uses
  Vcl.Forms,
  CSVLoader in 'Classes\CSVLoader.pas',
  Module in 'Classes\Module.pas',
  ModuleTransactionLoader in 'Classes\ModuleTransactionLoader.pas',
  Transaction in 'Classes\Transaction.pas',
  XMLLoader in 'Classes\XMLLoader.pas',
  InterfaceModule in 'Interfaces\InterfaceModule.pas',
  InterfaceTransaction in 'Interfaces\InterfaceTransaction.pas',
  InterfaceTransactionLoader in 'Interfaces\InterfaceTransactionLoader.pas',
  Main in 'Main.pas',
  ConstXMLLoader in 'Others\ConstXMLLoader.pas',
  WindowSkeleton in 'Windows\WindowSkeleton.pas' {WndSkeleton},
  PanelTransactionList in 'Windows\PanelTransactionList.pas' {frmTransactionList: TFrame},
  InterfaceModuleTransactionLoader in 'Interfaces\InterfaceModuleTransactionLoader.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.Run;
  MainKernel := TMain.Create;
  (MainKernel as TMain).Run;
end.
