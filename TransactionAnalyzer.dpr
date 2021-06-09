program TransactionAnalyzer;

uses
  Vcl.Forms,
  Module in 'Base classes\Module.pas',
  WindowSkeleton in 'Base classes\Frames\WindowSkeleton.pas' {WndSkeleton},
  InterfaceModule in 'Base classes\Interfaces\InterfaceModule.pas',
  Category in 'Modules\Module categories\Category.pas',
  ModuleCategories in 'Modules\Module categories\ModuleCategories.pas',
  InterfaceModuleCategory in 'Modules\Module categories\Interfaces\InterfaceModuleCategory.pas',
  ModuleRuleController in 'Modules\Module rules cotroller\ModuleRuleController.pas',
  Rule in 'Modules\Module rules cotroller\Rule.pas',
  XMLRuleSaverLoader in 'Modules\Module rules cotroller\XMLRuleSaverLoader.pas',
  InterfaceModuleRuleController in 'Modules\Module rules cotroller\Interfaces\InterfaceModuleRuleController.pas',
  InterfaceRuleSaver in 'Modules\Module rules cotroller\Interfaces\InterfaceRuleSaver.pas',
  PanelRule in 'Modules\Module rules cotroller\Frames\PanelRule.pas' {frmRule: TFrame},
  PanelRuleList in 'Modules\Module rules cotroller\Frames\PanelRuleList.pas' {frmRuleList: TFrame},
  ConstXMLLoader in 'Modules\Module transactions analyzer\ConstXMLLoader.pas',
  ModuleTransactionAnalyzer in 'Modules\Module transactions analyzer\ModuleTransactionAnalyzer.pas',
  Transaction in 'Modules\Module transactions analyzer\Transaction.pas',
  XMLTransactionLoader in 'Modules\Module transactions analyzer\XMLTransactionLoader.pas',
  InterfaceModuleTransactionAnalyzer in 'Modules\Module transactions analyzer\Interfaces\InterfaceModuleTransactionAnalyzer.pas',
  InterfaceTransaction in 'Modules\Module transactions analyzer\Interfaces\InterfaceTransaction.pas',
  InterfaceTransactionLoader in 'Modules\Module transactions analyzer\Interfaces\InterfaceTransactionLoader.pas',
  PanelTransactionList in 'Modules\Module transactions analyzer\Frames\PanelTransactionList.pas' {frmTransactionList: TFrame},
  Kernel in 'Kernel.pas',
  PanelCategoriesList in 'Modules\Module categories\Frames\PanelCategoriesList.pas' {FrmCategoriesList: TFrame},
  PanelCategory in 'Modules\Module categories\Frames\PanelCategory.pas' {FrmCategory: TFrame},
  XMLCategoriesLoaderSaver in 'Modules\Module categories\XMLCategoriesLoaderSaver.pas',
  InterfaceCategoriesLoaderSaver in 'Modules\Module categories\Interfaces\InterfaceCategoriesLoaderSaver.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.Run;
  MainKernel := TKernel.Create;
  (MainKernel as TKernel).Run;
end.
