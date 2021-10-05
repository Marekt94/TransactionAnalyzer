unit PanelTransactionsInGraphic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus,
  VCLTee.TeEngine, VCLTee.Series, Vcl.ExtCtrls, VCLTee.TeeProcs, VCLTee.Chart,
  Vcl.StdCtrls, PanelBilans, System.Generics.Collections, Transaction;

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
  Kernel, InterfaceModuleCategory, InterfaceTransactionsController, System.Math;

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
  pomCategoryModule := (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories);
  pomController := (GiveObjectByInterface(ITransactionsController) as ITransactionsController);
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
