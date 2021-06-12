unit BasePanel;

interface

uses
  Vcl.Forms;

type
  TFrmBasePanel = class(TFrame)
  public
    procedure Clean; virtual;
    function Unpack (const p_Object : TObject) : boolean; virtual;
    function Pack   (var   p_Object : TObject) : boolean; virtual;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TFrmBasePanel.Clean;
begin
  //to be covered in descendant
end;

function TFrmBasePanel.Pack (var p_Object: TObject): boolean;
begin
  Result := True;
end;

function TFrmBasePanel.Unpack (const p_Object: TObject): boolean;
begin
  Result := True;
end;

end.
