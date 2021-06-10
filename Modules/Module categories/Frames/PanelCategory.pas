unit PanelCategory;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Category;

type
  TFrmCategory = class(TFrame)
    lblCategory: TLabel;
    edtCategory: TEdit;
  private
    { Private declarations }
  public
    procedure Unpack (p_Category : TCategory);
    procedure Pack   (p_Category : TCategory);
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TFrmCategory }

procedure TFrmCategory.Pack(p_Category: TCategory);
begin
  p_Category.CategoryName := edtCategory.Text;
end;

procedure TFrmCategory.Unpack(p_Category: TCategory);
begin
  edtCategory.Text := p_Category.CategoryName;
end;

end.
