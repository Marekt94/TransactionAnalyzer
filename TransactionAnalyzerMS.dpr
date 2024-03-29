program TransactionAnalyzerMS;

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  Vcl.Forms,
  System.SysUtils,
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
  PanelCategory in 'Modules\Module categories\Frames\PanelCategory.pas' {FrmCategory: TFrame},
  XMLCategoriesLoaderSaver in 'Modules\Module categories\XMLCategoriesLoaderSaver.pas',
  InterfaceCategoriesLoaderSaver in 'Modules\Module categories\Interfaces\InterfaceCategoriesLoaderSaver.pas',
  BaseListPanel in 'Base classes\Frames\BaseListPanel.pas' {FrmBaseListPanel: TFrame},
  ConstXMLCategoriesLoaderSaver in 'Modules\Module categories\ConstXMLCategoriesLoaderSaver.pas',
  ConstXMLRuleSaverLoader in 'Modules\Module rules cotroller\ConstXMLRuleSaverLoader.pas',
  GUIMethods in 'Base classes\GUIMethods.pas',
  UsefullMethods in 'Base classes\UsefullMethods.pas',
  InterfaceTransactionsController in 'Modules\Module transactions analyzer\Interfaces\InterfaceTransactionsController.pas',
  TransactionController in 'Modules\Module transactions analyzer\TransactionController.pas',
  InterfaceRulesController in 'Modules\Module rules cotroller\Interfaces\InterfaceRulesController.pas',
  RulesController in 'Modules\Module rules cotroller\RulesController.pas',
  PanelTransactionsList in 'Modules\Module transactions analyzer\Frames\PanelTransactionsList.pas' {frmTransasctionsList: TFrame},
  PanelTransactionsInGraphic in 'Modules\Module transactions analyzer\Frames\PanelTransactionsInGraphic.pas' {frmTransactionsInGraphic: TFrame},
  PanelBilans in 'Modules\Module transactions analyzer\Frames\PanelBilans.pas' {frmBilans: TFrame},
  InterfaceModuleDatabase in 'Modules\Module database\Interfaces\InterfaceModuleDatabase.pas',
  ModuleDatabase in 'Modules\Module database\ModuleDatabase.pas',
  DataModuleDatabase in 'Modules\Module database\DataModuleDatabase.pas' {dtmModuleDatabase: TDataModule},
  DBLoaderSaver in 'Modules\Module database\DBLoaderSaver.pas',
  InterfaceXMLRuleLoaderSaver in 'Modules\Module rules cotroller\Interfaces\InterfaceXMLRuleLoaderSaver.pas',
  InterfaceXMLCategoriesLoaderSaver in 'Modules\Module categories\Interfaces\InterfaceXMLCategoriesLoaderSaver.pas',
  PanelCategories in 'Modules\Module transactions analyzer\Frames\PanelCategories.pas' {frmCategories: TFrame},
  PanelTransactionAnalyzerBoosted in 'Modules\Module transactions analyzer\Frames\PanelTransactionAnalyzerBoosted.pas' {FrmTransactionAnalyzerBoosted2: TFrame},
  InterfaceXMLTransactionLoaderSaver in 'Modules\Module transactions analyzer\Interfaces\InterfaceXMLTransactionLoaderSaver.pas',
  InterfaceXMLSaverLoader in 'Base classes\Interfaces\InterfaceXMLSaverLoader.pas',
  InterfaceLoaderSaver in 'Base classes\Interfaces\InterfaceLoaderSaver.pas',
  PanelProductChooser in 'Modules\Module transactions analyzer\Frames\PanelProductChooser.pas' {frmProductChooser: TFrame},
  XMLCreditCardTransactionLoader in 'Modules\Module transactions analyzer\XMLCreditCardTransactionLoader.pas',
  XMLDebitAccountTransactionLoader in 'Modules\Module transactions analyzer\XMLDebitAccountTransactionLoader.pas',
  ObjectWindowsCreator in 'Base classes\Frames\ObjectWindowsCreator.pas',
  WindowObjectControllerSteeringClass in 'Base classes\Frames\WindowObjectControllerSteeringClass.pas',
  DBCategoriesLoaderSaver in 'Modules\Module database\DBCategoriesLoaderSaver.pas',
  DBRulesLoaderSaver in 'Modules\Module database\DBRulesLoaderSaver.pas',
  DBTransactionLoaderSaver in 'Modules\Module database\DBTransactionLoaderSaver.pas',
  PanelMain in 'Common classes\PanelMain.pas' {frmTransactionList: TFrame},
  TransactionAnalyzerKernel in 'Common classes\TransactionAnalyzerKernel.pas',
  TransactionAnalyzerKernelMS in 'TransactionAnalyzerMS\TransactionAnalyzerKernelMS.pas',
  InterfaceModuleSettings in 'Modules\Module settings\Interfaces\InterfaceModuleSettings.pas',
  Settings in 'Modules\Module settings\Settings.pas',
  InterfaceBasePanel in 'Base classes\Frames\InterfaceBasePanel.pas',
  InterfaceKernel in '..\..\Kernel\src\Interfaces\InterfaceKernel.pas',
  InterfaceVCLKernel in '..\..\Kernel\src\VCL\Interfaces\InterfaceVCLKernel.pas',
  VCLKernel in '..\..\Kernel\src\VCL\VCLKernel.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  MainKernel := TVCLKernel.Create (TTransactionAnalyzerKernel.Create);
  MainKernel.MainContainer.Container := TTransactionAnalyzerKernelMS.Create;
  if Supports(MainKernel, IVCLKernel) then
  begin
    (MainKernel as IVCLKernel).Open (TfrmTransactionList, 'Analiza trasakcji');
    MainKernel.Close;
  end
end.
