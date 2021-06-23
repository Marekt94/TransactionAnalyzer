unit PanelMain;

interface

uses
  Vcl.Forms, Vcl.Dialogs, Vcl.ExtDlgs, Vcl.StdCtrls, Vcl.ExtCtrls,
  System.Classes, Vcl.Controls, Vcl.Grids, System.Generics.Collections,
  Transaction, GUIMethods;

const
  cExecutionDate   = 'Execution date';
  cOrderDate       = 'Order date';
  cTransactionType = 'Transaction type';
  cDescription     = 'Description';
  cAmount          = 'Amount';
  cCategories      = 'Categories';

  cDefaultRowCount = 1;
  cDefaultColCount = 6;

type
  TfrmTransactionList = class(TFrame)
    ofdOpenTransactionFile: TOpenTextFileDialog;
    butShowCategories: TButton;
    btnRules: TButton;
    btnAnalyze: TButton;
    GridPanel1: TGridPanel;
    procedure butShowCategoriesClick(Sender: TObject);
    procedure btnRulesClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
  public
    constructor Create (AOwner: TComponent); override;
  end;

implementation

uses
  System.SysUtils, InterfaceModuleRules, Kernel,
  InterfaceModuleTransactionAnalyzer, InterfaceModuleCategory, UsefullMethods;

{$R *.dfm}

{ TfrmTransactionList }


procedure TfrmTransactionList.btnRulesClick(Sender: TObject);
var
  pomRulesModul : IModuleRules;
begin
  pomRulesModul := Kernel.GiveObjectByInterface (IModuleRules) as IModuleRules;
  pomRulesModul.OpenMainWindow;
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
