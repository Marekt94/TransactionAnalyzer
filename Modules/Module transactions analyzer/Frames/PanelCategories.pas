unit PanelCategories;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasePanel, Vcl.StdCtrls,
  System.Generics.Collections, InterfaceModuleCategory;

type
  TfrmCategories = class(TFrmBasePanel)
    grpFilter: TGroupBox;
  private
    FCategoriesAndChbDict : TDictionary <Integer, TCheckBox>;
    FCategories : IModuleCategories;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Unpack (const p_Object : TObject) : boolean; override;
    function Pack   (var   p_Object : TObject) : boolean; override;
    procedure InitCategories(p_OnClick : TNotifyEvent; p_DefState : boolean = true);
    property CategoriesAndChbDict: TDictionary <Integer, TCheckBox> read FCategoriesAndChbDict;
  end;


implementation

{$R *.dfm}

uses Kernel;

constructor TfrmCategories.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  FCategoriesAndChbDict := TDictionary <Integer, TCheckBox>.Create;
end;

destructor TfrmCategories.Destroy;
begin
  FreeAndNil (FCategoriesAndChbDict);
  inherited;
end;

procedure TfrmCategories.InitCategories(p_OnClick  : TNotifyEvent;
                                        p_DefState : boolean);
begin
  FCategoriesAndChbDict.Clear;
  FCategories := Kernel.GiveObjectByInterface (IModuleCategories) as IModuleCategories;
  for var i := 0 to FCategories.CategoriesList.Count - 1 do
  begin
    var pomChb : TCheckbox;
    var pomCategory := FCategories.CategoriesList [i];
    pomChb := TCheckBox.Create(Self);
    with pomChb do
    begin
      Name       := 'chb' + IntToStr (pomCategory.CategoryIndex);
      Caption    := pomCategory.CategoryName;
      Left       := 10;
      Top        := 20 * (i + 1);
      AutoSize   := true;
      ParentFont := False;
      Parent     := grpFilter;
      Checked    := p_DefState;
      OnClick    := p_OnClick;
      Anchors    := [akRight, akLeft, akTop];
      Width      := grpFilter.Width-10;
    end;
    FCategoriesAndChbDict.Add (pomCategory.CategoryIndex, pomChb);
  end;
end;

function TfrmCategories.Pack(var p_Object: TObject): boolean;
var
  pomObject : TList<Integer>;
  pomChb : TCheckBox;
begin
  pomObject := p_Object as TList<Integer>;
  pomObject.Clear;
  var pomCategories := FCategories.CategoriesList;
  for var i := 0 to pomCategories.Count - 1 do
  begin
    pomChb := nil;
    FCategoriesAndChbDict.TryGetValue (pomCategories [i].CategoryIndex, pomChb);
    if pomChb.Checked then
      pomObject.Add (pomCategories [i].CategoryIndex);
  end;
  Result := true;
end;

function TfrmCategories.Unpack(const p_Object: TObject): boolean;
var
  pomObject : TList<Integer>;
  pomChb : TCheckBox;
begin
  pomObject := p_Object as TList<Integer>;
  for var i := 0 to pomObject.Count - 1 do
  begin
    pomChb := nil;
    if FCategoriesAndChbDict.TryGetValue (pomObject [i], pomChb) then
      pomChb.Checked := true;
  end;
  Result := true;
end;

end.
