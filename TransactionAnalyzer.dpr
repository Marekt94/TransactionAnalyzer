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
  ConstXMLLoader in 'Modules\Module transactions analyzer\ConstXMLLoader.pas',
  ModuleTransactionAnalyzer in 'Modules\Module transactions analyzer\ModuleTransactionAnalyzer.pas',
  Transaction in 'Modules\Module transactions analyzer\Transaction.pas',
  XMLTransactionLoader in 'Modules\Module transactions analyzer\XMLTransactionLoader.pas',
  InterfaceModuleTransactionAnalyzer in 'Modules\Module transactions analyzer\Interfaces\InterfaceModuleTransactionAnalyzer.pas',
  InterfaceTransaction in 'Modules\Module transactions analyzer\Interfaces\InterfaceTransaction.pas',
  InterfaceTransactionLoader in 'Modules\Module transactions analyzer\Interfaces\InterfaceTransactionLoader.pas',
  PanelTransactionList in 'Modules\Module transactions analyzer\Frames\PanelTransactionList.pas' {frmTransactionList: TFrame},
  Kernel in 'Kernel.pas',
  PanelCategory in 'Modules\Module categories\Frames\PanelCategory.pas' {FrmCategory: TFrame},
  XMLCategoriesLoaderSaver in 'Modules\Module categories\XMLCategoriesLoaderSaver.pas',
  InterfaceCategoriesLoaderSaver in 'Modules\Module categories\Interfaces\InterfaceCategoriesLoaderSaver.pas',
  BaseListPanel in 'Base classes\Frames\BaseListPanel.pas' {FrmBaseListPanel: TFrame},
  BasePanel in 'Base classes\Frames\BasePanel.pas' {FrmBasePanel: TFrame},
  WindowObjectControllerSteeringClass in 'Base classes\WindowObjectControllerSteeringClass.pas',
  ConstXMLCategoriesLoaderSaver in 'Modules\Module categories\ConstXMLCategoriesLoaderSaver.pas',
  ConstXMLRuleSaverLoader in 'Modules\Module rules cotroller\ConstXMLRuleSaverLoader.pas',
  GUIMethods in 'Base classes\GUIMethods.pas',
  UsefullMethods in 'Base classes\UsefullMethods.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.Run;
  MainKernel := TKernel.Create;
  (MainKernel as TKernel).Run;
end.
