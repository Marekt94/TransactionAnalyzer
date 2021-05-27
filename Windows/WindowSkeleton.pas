unit WindowSkeleton;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TWndSkeleton = class(TForm)
    pnlMain: TPanel;
    lblTitle: TLabel;
  private
    { Private declarations }
  public
    function Init (p_ChildPanel : TFrame; p_Title : string) : TForm;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TWndSkeleton }

function TWndSkeleton.Init (p_ChildPanel: TFrame; p_Title : string) : TForm;
begin
  p_ChildPanel.Parent := pnlMain;
  p_ChildPanel.Align := alClient;
  lblTitle.Caption := p_Title;
  Result := self;
end;

end.
