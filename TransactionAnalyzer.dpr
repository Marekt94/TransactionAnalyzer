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
  InterfaceModuleTransactionLoader in 'Interfaces\InterfaceModuleTransactionLoader.pas',
  Category in 'Classes\Category.pas',
  ModuleCategories in 'Classes\ModuleCategories.pas',
  InterfaceModuleCategory in 'Interfaces\InterfaceModuleCategory.pas',
  ModuleTransactionAnalyzer in 'Classes\ModuleTransactionAnalyzer.pas',
  InterfaceModuleTransactionAnalyzer in 'Interfaces\InterfaceModuleTransactionAnalyzer.pas',
  PanelRule in 'Windows\PanelRule.pas' {frmRule: TFrame},
  PanelRuleList in 'Windows\PanelRuleList.pas' {frmRuleList: TFrame},
  Rule in 'Classes\Rule.pas',
  InterfaceModuleRuleController in 'Interfaces\InterfaceModuleRuleController.pas',
  ModuleRuleController in 'Classes\ModuleRuleController.pas',
  InterfaceRuleSaver in 'Interfaces\InterfaceRuleSaver.pas',
  XMLRuleSaverLoader in 'Classes\XMLRuleSaverLoader.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.Run;
  MainKernel := TMain.Create;
  (MainKernel as TMain).Run;
end.
