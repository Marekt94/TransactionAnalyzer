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
  Main in 'Main.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
  MainKernel := TMain.Create;
  (MainKernel as TMain).Run;
end.
