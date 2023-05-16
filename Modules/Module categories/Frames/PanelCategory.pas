unit PanelCategory;

interface

uses
  System.SysUtils, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Category,
  InterfaceBasePanel;

type
  TFrmCategory = class(TFrame, IBasePanel)
    lblCategory: TLabel;
    edtCategory: TEdit;
  public
   procedure Clean;
   function Unpack (const p_Object : TObject) : boolean;
   function Pack   (var p_Object : TObject) : boolean;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrmCategory }

procedure TFrmCategory.Clean;
begin
  inherited;
  edtCategory.Text := '';
end;

function TFrmCategory.Pack(var p_Object: TObject): boolean;
begin
  if not Assigned (p_Object) then
    Exit (True);
  (p_Object as TCategory).CategoryName := edtCategory.Text;
  Result := True;
end;

function TFrmCategory.Unpack(const p_Object: TObject): boolean;
begin
  Clean;
  if not Assigned (p_Object) then
    Exit (True);
  edtCategory.Text := (p_Object as TCategory).CategoryName;
  Result := True;
end;

end.
