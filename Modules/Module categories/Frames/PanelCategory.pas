unit PanelCategory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Category,
  BasePanel;

type
  TFrmCategory = class(TFrmBasePanel)
    lblCategory: TLabel;
    edtCategory: TEdit;
  private
    { Private declarations }
  public
   procedure Clean; override;
   function Unpack (p_Object : TObject) : boolean; override;
   function Pack   (p_Object : TObject) : boolean; override;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrmCategory }

{ TFrmCategory }

procedure TFrmCategory.Clean;
begin
  inherited;
  edtCategory.Text := '';
end;

function TFrmCategory.Pack(p_Object: TObject): boolean;
begin
  if not Assigned (p_Object) then
    Exit (True);
  (p_Object as TCategory).CategoryName := edtCategory.Text;
  Result := True;
end;

function TFrmCategory.Unpack(p_Object: TObject): boolean;
begin
  Clean;
  if not Assigned (p_Object) then
    Exit (True);
  edtCategory.Text := (p_Object as TCategory).CategoryName;
  Result := True;
end;

end.
