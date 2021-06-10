unit PanelCategoriesList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.ExtCtrls, WindowSkeleton, System.Generics.Collections, Category;

type
  TFrmCategoriesList = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    btnAdd: TButton;
    btnDelete: TButton;
    btnEdit: TButton;
    strCategories: TStringGrid;
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  strict private
    FCategories : TObjectList <TCategory>;
    procedure UpdateView;
  public
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

uses
  PanelCategory, InterfaceModuleCategory, Kernel;

{$R *.dfm}

procedure TFrmCategoriesList.btnAddClick(Sender: TObject);
var
  pomWindow : TWndSkeleton;
  pomPanel  : TFrmCategory;
  pomCategory : TCategory;
begin
  pomWindow := TWndSkeleton.Create(nil);
  try
    pomPanel := TFrmCategory.Create (pomWindow);
    pomWindow.Init (pomPanel, 'Regu³a');

    pomCategory := TCategory.Create;
    try
      pomPanel.Unpack (pomCategory);
      if pomWindow.ShowModal = mrOk then
      begin
        pomPanel.Pack (pomCategory);
        FCategories.Add (pomCategory)
      end
      else
        pomCategory.Free
    except
      pomCategory.Free;
      raise;
    end;
  finally
    FreeAndNil (pomWindow);
  end;
  UpdateView;
end;

procedure TFrmCategoriesList.btnDeleteClick(Sender: TObject);
begin
  FCategories.Delete (strCategories.Row - 1);
  UpdateView;
end;

procedure TFrmCategoriesList.btnEditClick(Sender: TObject);
var
  pomWindow   : TWndSkeleton;
  pomPanel    : TFrmCategory;
  pomCategory : TCategory;
begin
  pomWindow := TWndSkeleton.Create(nil);
  try
    pomPanel := TFrmCategory.Create (pomWindow);
    pomWindow.Init (pomPanel, 'Kategoria');

    pomCategory := FCategories [strCategories.Row - 1];
    pomPanel.Unpack (pomCategory);
    if pomWindow.ShowModal = mrOk then
      pomPanel.Pack (pomCategory);
  finally
    FreeAndNil (pomWindow);
  end;
  UpdateView;
end;

constructor TFrmCategoriesList.Create(AOwner: TComponent);
var
  pomModule : IModuleCategories;
begin
  inherited Create (AOwner);
  pomModule := Kernel.GiveObjectByInterface(IModuleCategories) as IModuleCategories;
  pomModule.LoadCategories('');
  FCategories := pomModule.CategoriesList;
  UpdateView;
end;

destructor TFrmCategoriesList.Destroy;
var
  pomModule : IModuleCategories;
begin
  pomModule := Kernel.GiveObjectByInterface(IModuleCategories) as IModuleCategories;
  pomModule.SaveCategories ('');
  inherited;
end;

procedure TFrmCategoriesList.UpdateView;
begin
  strCategories.RowCount := 1;
  strCategories.Cells[0,0] := 'Kategoria';
  strCategories.RowCount := FCategories.Count + 1;
  for var i := 0 to FCategories.Count - 1 do
    strCategories.Cells [0,i + 1] := FCategories [i].CategoryName;
  strCategories.FixedRows := 1;
end;

end.
