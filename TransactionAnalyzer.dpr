program TransactionAnalyzer;

uses
  Vcl.Forms,
  Module in 'Base classes\Module.pas',
  WindowSkeleton in 'Base classes\Frames\WindowSkeleton.pas' {WndSkeleton},
  InterfaceModule in 'Base classes\Interfaces\InterfaceModule.pas',
  Category in 'Modules\Module categories\Category.pas',
  ModuleCategories in 'Modules\Module categories\ModuleCategories.pas',
  InterfaceModuleCategory in 'Modules\Module categories\Interfaces\InterfaceModuleCategory.pas',
  ModuleRules in 'Modules\Module rules cotroller\ModuleRules.pas',
  Rule in 'Modules\Module rules cotroller\Rule.pas',
  XMLRuleSaverLoader in 'Modules\Module rules cotroller\XMLRuleSaverLoader.pas',
  InterfaceModuleRules in 'Modules\Module rules cotroller\Interfaces\InterfaceModuleRules.pas',
  InterfaceRuleSaver in 'Modules\Module rules cotroller\Interfaces\InterfaceRuleSaver.pas',
  PanelRule in 'Modules\Module rules cotroller\Frames\PanelRule.pas' {frmRule: TFrame},
  ConstXMLLoader in 'Modules\Module transactions analyzer\ConstXMLLoader.pas',
  ModuleTransactionAnalyzer in 'Modules\Module transactions analyzer\ModuleTransactionAnalyzer.pas',
  Transaction in 'Modules\Module transactions analyzer\Transaction.pas',
  XMLTransactionLoader in 'Modules\Module transactions analyzer\XMLTransactionLoader.pas',
  InterfaceModuleTransactionAnalyzer in 'Modules\Module transactions analyzer\Interfaces\InterfaceModuleTransactionAnalyzer.pas',
  InterfaceTransaction in 'Modules\Module transactions analyzer\Interfaces\InterfaceTransaction.pas',
  InterfaceTransactionLoader in 'Modules\Module transactions analyzer\Interfaces\InterfaceTransactionLoader.pas',
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
  UsefullMethods in 'Base classes\UsefullMethods.pas',
  PanelTransactionAnalyzerBoosted in 'Modules\Module transactions analyzer\Frames\PanelTransactionAnalyzerBoosted.pas' {FrmTransactionAnalyzerBoosted: TFrame},
  PanelMain in 'PanelMain.pas' {frmTransactionList: TFrame},
  InterfaceTransactionsController in 'Modules\Module transactions analyzer\Interfaces\InterfaceTransactionsController.pas',
  TransactionController in 'Modules\Module transactions analyzer\TransactionController.pas',
  InterfaceRulesController in 'Modules\Module rules cotroller\Interfaces\InterfaceRulesController.pas',
  RulesController in 'Modules\Module rules cotroller\RulesController.pas',
  PanelTransactionsList in 'Modules\Module transactions analyzer\Frames\PanelTransactionsList.pas' {frmTransasctionsList: TFrame},
  InterfaceModuleSettings in 'Modules\Module settings\Interfaces\InterfaceModuleSettings.pas',
  ModuleSettings in 'Modules\Module settings\ModuleSettings.pas',
  InterfaceSettingsLoaderSaver in 'Modules\Module settings\Interfaces\InterfaceSettingsLoaderSaver.pas',
  Settings in 'Modules\Module settings\Settings.pas',
  XMLSettingsLoaderSaver in 'Modules\Module settings\XMLSettingsLoaderSaver.pas',
  ConstXMLSettingsLoaderSaver in 'Modules\Module settings\ConstXMLSettingsLoaderSaver.pas',
  PanelSettings in 'Modules\Module settings\Frames\PanelSettings.pas' {frmSettings: TFrame},
  PanelTransactionsInGraphic in 'Modules\Module transactions analyzer\Frames\PanelTransactionsInGraphic.pas' {frmTransactionsInGraphic: TFrame},
  PanelBilans in 'Modules\Module transactions analyzer\Frames\PanelBilans.pas' {frmBilans: TFrame};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.Run;
  MainKernel := TKernel.Create;
  (MainKernel as TKernel).Run;
end.
