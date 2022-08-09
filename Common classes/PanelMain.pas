unit PanelMain;

interface

uses
  Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Classes, Vcl.Controls, Vcl.Grids, System.Generics.Collections,
  System.Actions, Vcl.ActnList;

type
  TfrmTransactionList = class(TFrame)
    ofdOpenTransactionFile: TOpenTextFileDialog;
    butShowCategories: TButton;
    btnRules: TButton;
    btnAnalyze: TButton;
    GridPanel1: TGridPanel;
    btnSettings: TButton;
    actlstButtons: TActionList;
    actBtnSettings: TAction;
    procedure butShowCategoriesClick(Sender: TObject);
    procedure btnRulesClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure actBtnSettingsExecute(Sender: TObject);
    procedure actBtnSettingsUpdate(Sender: TObject);
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
  pomRulesModul := MainKernel.GiveObjectByInterface (IModuleRules) as IModuleRules;
  pomRulesModul.OpenMainWindow;
end;

procedure TfrmTransactionList.actBtnSettingsExecute(Sender: TObject);
var
  pomSettings : IModuleSettings;
begin
  pomSettings := MainKernel.GiveObjectByInterface (IModuleSettings) as IModuleSettings;
  pomSettings.OpenMainWindow;
end;

procedure TfrmTransactionList.actBtnSettingsUpdate(Sender: TObject);
begin
  btnSettings.Enabled := Assigned (MainKernel.GiveObjectByInterface (IModuleSettings, true) as IModuleSettings);
end;

procedure TfrmTransactionList.btnAnalyzeClick(Sender: TObject);
var
  pomTransactionAnalyzer : IModuleTransactionAnalyzer;
begin
  pomTransactionAnalyzer := (MainKernel.GiveObjectByInterface (IModuleTransactionAnalyzer) as IModuleTransactionAnalyzer);
  pomTransactionAnalyzer.OpenMainWindow;
end;

procedure TfrmTransactionList.butShowCategoriesClick(Sender: TObject);
var
  pomCategoriesModul : IModuleCategories;
begin
  pomCategoriesModul := MainKernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
  pomCategoriesModul.OpenMainWindow;
end;

constructor TfrmTransactionList.Create (AOwner: TComponent);
begin
  inherited Create (AOwner);
end;

end.
