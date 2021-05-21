unit WindowSkeleton;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TWndSkeleton = class(TForm)
    pnlMain: TPanel;
    pnlNavigation: TPanel;
    pnlFooter: TPanel;
  private
    { Private declarations }
  public
    function Init (p_ChildPanel : TFrame) : TForm;
    { Public declarations }
  end;

implementation

{$R *.dfm}

{ TWndSkeleton }

function TWndSkeleton.Init (p_ChildPanel: TFrame) : TForm;
begin
  p_ChildPanel.Parent := pnlMain;
  p_ChildPanel.Align := alClient;
  Result := self;
end;

end.
