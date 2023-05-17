unit PanelBilans;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.ExtCtrls, Vcl.StdCtrls,
  System.Generics.Collections, Transaction;

type
  TfrmBilans = class(TFrame)
    grpBilans: TGroupBox;
    grdBilans: TGridPanel;
  strict private
    FLabelList : TList <TLabel>;
    procedure OnLabelListClear(p_Sender: TObject; const p_Item: TLabel;
      p_Action: TCollectionNotification);
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure UpdateBilans (p_Summary : TList <TSummary>);
    procedure AddLabel(p_Caption: string; p_Row, p_Column: Integer;
      p_ClearLabelList: boolean = false);
  end;

implementation

{$R *.dfm}

uses InterfaceKernel, System.Math, InterfaceModuleCategory;

procedure TfrmBilans.OnLabelListClear(p_Sender: TObject;
  const p_Item: TLabel; p_Action: TCollectionNotification);
begin
  if p_Action = cnRemoved then
    p_Item.Free;
end;

procedure TfrmBilans.AfterConstruction;
begin
  inherited;
  FLabelList := TList <TLabel>.Create;
  FLabelList.OnNotify := OnLabelListClear;
end;

procedure TfrmBilans.BeforeDestruction;
begin
  FreeAndNil (FLabelList);
  inherited;
end;

procedure TfrmBilans.UpdateBilans (p_Summary : TList <TSummary>);
  procedure InitGrdBilans;
  var
    pomHeight, pomWidth : Integer;
  begin
    grdBilans.ColumnCollection.Clear;
    grdBilans.RowCollection.Clear;
    pomHeight := grdBilans.Height;
    pomWidth  := grdBilans.Width;
    for var i := 1 to 3 do
    begin
      var pomCol := grdBilans.ColumnCollection.Add;
      pomCol.SizeStyle := ssAbsolute;
      pomCol.Value := Floor (pomWidth / 3);
    end;
    for var i := 1 to p_Summary.Count + 1 do
    begin
      var pomRow := grdBilans.RowCollection.Add;
      pomRow.SizeStyle := ssAbsolute;
      pomRow.Value := Floor (pomHeight / (p_Summary.Count + 1));
    end;

  end;

var
  pomRowIndex : Integer;
begin
  var pomStr : string;
  pomStr := '';
  pomRowIndex := 0;
  if Assigned (p_Summary) then
  begin
    FLabelList.Clear;
    InitGrdBilans;
    AddLabel ('',        0, 0);
    AddLabel ('Wp³yw',   0, 1);
    AddLabel ('Wydatek', 0, 2);
    for var pomSummary in p_Summary do
    begin
      Inc (pomRowIndex);
      var pomCategory := (MainKernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories).FindCategoryByIndex (pomSummary.CategoryIndex);

      AddLabel (pomCategory.CategoryName,        pomRowIndex, 0);
      AddLabel (FloatToStr (pomSummary.Impact),  pomRowIndex, 1);
      AddLabel (FloatToStr (pomSummary.Expense), pomRowIndex, 2);
    end;
  end;
end;

procedure TfrmBilans.AddLabel(p_Caption: string; p_Row,
  p_Column: Integer; p_ClearLabelList: boolean);
var
  pomLabel : TLabel;
begin
  FLabelList.Add (TLabel.Create (nil));
  pomLabel := FLabelList.Last;
  with pomLabel do
  begin
    pomLabel.Parent := grdBilans;
    pomLabel.Caption := p_Caption;
  end;
  grdBilans.ControlCollection [FLabelList.Count - 1].Row := p_Row;
  grdBilans.ControlCollection [FLabelList.Count - 1].Column := p_Column;
end;

end.
