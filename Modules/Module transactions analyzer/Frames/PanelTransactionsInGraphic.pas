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
    frmBilans: TfrmBilans;
    Panel1: TPanel;
    rbgExpensesImpact: TRadioGroup;
    procedure rbgExpensesImpactClick(Sender: TObject);
  private
  public
    procedure Init (p_ChoosenCategories : TList<Integer>;
                    p_Summary : TList <TSummary>);
  end;

implementation

uses
  Kernel, InterfaceModuleCategory;

{$R *.dfm}

procedure TfrmTransactionsInGraphic.Init(p_ChoosenCategories : TList<Integer>;
                                         p_Summary: TList<TSummary>);
var
  pomCategoryModule : IModuleCategories;
begin
  ssExpenses.Clear;
  ssImpact.Clear;
  pomCategoryModule := (Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories);
  for var pomSummary in p_Summary do
  begin
    if p_ChoosenCategories.Contains (pomSummary.CategoryIndex) then
    begin
      ssExpenses.Add (pomSummary.Expense, pomCategoryModule.FindCategoryByIndex (pomSummary.CategoryIndex).CategoryName);
      ssImpact.Add (pomSummary.Impact, pomCategoryModule.FindCategoryByIndex (pomSummary.CategoryIndex).CategoryName);
    end;
  end;

  frmBilans.UpdateBilans (p_Summary);
  rbgExpensesImpactClick(nil);
end;

procedure TfrmTransactionsInGraphic.rbgExpensesImpactClick(Sender: TObject);
begin
  ssExpenses.Visible := rbgExpensesImpact.ItemIndex = 0;
  ssImpact.  Visible := rbgExpensesImpact.ItemIndex = 1;
end;

end.
