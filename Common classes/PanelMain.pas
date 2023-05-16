unit PanelMain;

interface

uses
  Vcl.Forms, Vcl.ExtDlgs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Classes, Vcl.Controls,
  Vcl.ActnList, System.Actions, Vcl.Dialogs, InterfaceModuleSettings;

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
  strict private
    FSettings : IModuleSettings;
  public
    constructor Create (AOwner: TComponent); override;
  end;

implementation

uses
  InterfaceModuleRules, Kernel,
  InterfaceModuleTransactionAnalyzer, InterfaceModuleCategory;

{$R *.dfm}

{ TfrmTransactionList }


procedure TfrmTransactionList.btnRulesClick(Sender: TObject);
var
  pomRulesModule : IModuleRules;
begin
  pomRulesModule := MainKernel.GiveObjectByInterface (IModuleRules) as IModuleRules;
  pomRulesModule.OpenMainWindow;
end;

procedure TfrmTransactionList.actBtnSettingsExecute(Sender: TObject);
begin
  if not Assigned (FSettings) then
   FSettings := MainKernel.GiveObjectByInterface (IModuleSettings, true) as IModuleSettings;
  FSettings.OpenMainWindow;
end;

procedure TfrmTransactionList.actBtnSettingsUpdate(Sender: TObject);
begin
  btnSettings.Enabled := Assigned (FSettings);
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
  FSettings := MainKernel.GiveObjectByInterface (IModuleSettings, true) as IModuleSettings;
end;

end.
