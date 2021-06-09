unit BaseFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TFrmBase = class(TFrame)
  private
    { Private declarations }
  public
    function Unpack<T> (p_Object : T) : boolean;
    function Pack<T> (p_Object : T) : boolean;
  end;

implementation

{$R *.dfm}

{ TBaseFrame }

function TFrmBase.Pack<T>(p_Object: T): boolean;
begin

end;

function TFrmBase.Unpack<T>(p_Object: T): boolean;
begin

end;

end.
