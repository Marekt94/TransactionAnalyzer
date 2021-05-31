unit PanelRuleList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, System.Generics.Collections, Rule, WindowSkeleton;

type
  TfrmRuleList = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    btnAdd: TButton;
    btnRemove: TButton;
    strRules: TStringGrid;
    btnEdit: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
  strict private
    FRuleList : TObjectList <TRule>;
    procedure UpdateView;
  public
    constructor Create (AOwner: TComponent); override;
  end;

implementation

uses
  InterfaceModuleRuleController, Main, PanelRule;

{$R *.dfm}

{ TFrame1 }

procedure TfrmRuleList.btnAddClick(Sender: TObject);
var
  pomWindow : TWndSkeleton;
  pomPanel  : TfrmRule;
  pomRule : TRule;
begin
  pomWindow := TWndSkeleton.Create(nil);
  try
    pomPanel := TfrmRule.Create (pomWindow);
    pomWindow.Init (pomPanel, 'Regu³a');

    FRuleList.Add (TRule.Create);
    pomRule := FRuleList.Items [FRuleList.Count - 1];
    pomPanel.Unpack (pomRule);
    if pomWindow.ShowModal = mrOk then
      pomPanel.Pack (pomRule)
    else
      FRuleList.Delete (FRuleList.Count - 1);
  finally
    FreeAndNil (pomWindow);
  end;
  UpdateView;
end;

procedure TfrmRuleList.btnEditClick(Sender: TObject);
var
  pomWindow : TWndSkeleton;
  pomPanel  : TfrmRule;
  pomRule : TRule;
begin
  pomWindow := TWndSkeleton.Create(nil);
  try
    pomPanel := TfrmRule.Create (pomWindow);
    pomWindow.Init (pomPanel, 'Regu³a');

    pomRule := FRuleList.Items [strRules.Row - 1];
    pomPanel.Unpack (pomRule);
    if pomWindow.ShowModal = mrOk then
      pomPanel.Pack (pomRule)
  finally
    FreeAndNil (pomWindow);
  end;
  UpdateView
end;

procedure TfrmRuleList.btnRemoveClick(Sender: TObject);
begin
  FRuleList.Delete (FRuleList.Count - 1);
  UpdateView;
end;

constructor TfrmRuleList.Create(AOwner: TComponent);
var
  pomRuleController : IModuleRuleController;
begin
  inherited Create (AOwner);
  pomRuleController := GiveObjectByInterface (IModuleRuleController) as IModuleRuleController;
  pomRuleController.LoadRuleList;
  FRuleList := pomRuleController.RuleList;
  UpdateView;
end;

procedure TfrmRuleList.UpdateView;
begin
  strRules.Cells [0,0] := 'L.p.';
  strRules.RowCount := 1;
  for var i := 0 to FRuleList.Count - 1 do
  begin
    strRules.RowCount := strRules.RowCount + 1;
    strRules.Cells [0, strRules.RowCount - 1] := IntToStr (i + 1);
  end;
end;

end.
