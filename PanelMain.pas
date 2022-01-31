unit PanelMain;

interface

uses
  Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Classes, Vcl.Controls, Vcl.Grids, System.Generics.Collections;

type
  TfrmTransactionList = class(TFrame)
    ofdOpenTransactionFile: TOpenTextFileDialog;
    butShowCategories: TButton;
    btnRules: TButton;
    btnAnalyze: TButton;
    GridPanel1: TGridPanel;
    btnSettings: TButton;
    procedure butShowCategoriesClick(Sender: TObject);
    procedure btnRulesClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
  public
    constructor Create (AOwner: TComponent); override;
  end;

implementation

uses
  System.SysUtils, InterfaceModuleRules, Kernel,
  InterfaceModuleTransactionAnalyzer, InterfaceModuleCategory, UsefullMethods,
  InterfaceModuleSettings;

{$R *.dfm}

{ TfrmTransactionList }


procedure TfrmTransactionList.btnRulesClick(Sender: TObject);
var
  pomRulesModul : IModuleRules;
begin
  pomRulesModul := Kernel.GiveObjectByInterface (IModuleRules) as IModuleRules;
  pomRulesModul.OpenMainWindow;
end;

procedure TfrmTransactionList.btnSettingsClick(Sender: TObject);
var
  pomSettings : IModuleSettings;
begin
  pomSettings := Kernel.GiveObjectByInterface (IModuleSettings) as IModuleSettings;
  pomSettings.OpenMainWindow;
end;

procedure TfrmTransactionList.btnAnalyzeClick(Sender: TObject);
var
  pomTransactionAnalyzer : IModuleTransactionAnalyzer;
begin
  pomTransactionAnalyzer := (GiveObjectByInterface (IModuleTransactionAnalyzer) as IModuleTransactionAnalyzer);
  pomTransactionAnalyzer.OpenMainWindow;
end;

procedure TfrmTransactionList.butShowCategoriesClick(Sender: TObject);
var
  pomCategoriesModul : IModuleCategories;
begin
  pomCategoriesModul := Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
  pomCategoriesModul.OpenMainWindow;
end;

constructor TfrmTransactionList.Create (AOwner: TComponent);
begin
  inherited Create (AOwner);
end;

end.
