unit BasePanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFrmBasePanel = class(TFrame)
  public
    procedure Clean; virtual;
    function Unpack (p_Object : TObject) : boolean; virtual;
    function Pack   (p_Object : TObject) : boolean; virtual;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TFrmBasePanel.Clean;
begin
  //to be covered in descendant
end;

function TFrmBasePanel.Pack (p_Object: TObject): boolean;
begin
  Result := True;
end;

function TFrmBasePanel.Unpack (p_Object: TObject): boolean;
begin
  Result := True;
end;

end.
