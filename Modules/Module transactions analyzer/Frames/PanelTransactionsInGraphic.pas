unit PanelTransactionsInGraphic;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms,
  VCLTee.Series, VCLTee.Chart,
  System.Generics.Collections, Transaction, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  Vcl.ExtCtrls, VCLTee.TeeProcs;

type
  TfrmTransactionsInGraphic = class(TFrame)
    Chart1: TChart;
    ssExpenses: TPieSeries;
    ssImpact: TPieSeries;
  public
    procedure UpdateData (p_ChoosenCategories : TList<Integer>;
                          p_Summary : TList <TSummary>);
  end;

implementation

uses
  InterfaceKernel, InterfaceModuleCategory, InterfaceTransactionsController;

{$R *.dfm}

procedure TfrmTransactionsInGraphic.UpdateData(p_ChoosenCategories : TList<Integer>;
                                         p_Summary: TList<TSummary>);
var
  pomCategoryModule : IModuleCategories;
  pomExpensePerc    : Integer;
  pomImpactPerc     : Integer;
  pomController     : ITransactionsController;
  pomExpensesSum    : Double;
  pomImpactSum      : Double;
begin
  ssExpenses.Clear;
  ssImpact.Clear;
  pomCategoryModule := (MainKernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories);
  pomController := (MainKernel.GiveObjectByInterface(ITransactionsController) as ITransactionsController);
  pomExpensesSum := pomController.EvaluateExpenseSum (p_Summary, p_ChoosenCategories);
  pomImpactSum   := pomController.EvaluateImpactSum (p_Summary, p_ChoosenCategories);
  for var pomSummary in p_Summary do
  begin
    if p_ChoosenCategories.Contains (pomSummary.CategoryIndex) then
    begin
      if pomExpensesSum <> 0 then
        pomExpensePerc := Round (Abs (pomSummary.Expense) / pomExpensesSum * 100)
      else
        pomExpensePerc := 0;
      if pomImpactSum <> 0 then
        pomImpactPerc  := Round (Abs (pomSummary.Impact)  / pomImpactSum   * 100)
      else
        pomImpactPerc := 0;
      ssExpenses.Add (pomSummary.Expense, pomCategoryModule.FindCategoryByIndex (pomSummary.CategoryIndex).CategoryName + ' - ' + IntToStr (pomExpensePerc) + '%');
      ssImpact.Add (pomSummary.Impact, pomCategoryModule.FindCategoryByIndex (pomSummary.CategoryIndex).CategoryName + ' - ' + IntToStr (pomImpactPerc) + '%');
    end;
  end;
end;

end.
