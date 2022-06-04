unit WindowSkeleton;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TWndSkeleton = class(TForm)
    pnlMain: TPanel;
    lblTitle: TLabel;
    pnlNavigationKeys: TPanel;
    btnCancel: TButton;
    btnOk: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  strict private
    FChildPanel : TFrame;
  public
    destructor Destroy; override;
    function Init (p_ChildPanel : TFrame;
                   p_Title      : string;
                   p_WithNavigationKeys : boolean = true;
                   p_FullScreen : Boolean = false) : TForm; virtual;
  end;

implementation

{$R *.dfm}

{ TWndSkeleton }

procedure TWndSkeleton.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  CloseModal;
end;

procedure TWndSkeleton.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
  CloseModal;
end;

destructor TWndSkeleton.Destroy;
begin
  FChildPanel.Parent := nil;
  inherited;
end;

//function creating basic window
function TWndSkeleton.Init (p_ChildPanel: TFrame; p_Title : string; p_WithNavigationKeys : boolean; p_FullScreen : Boolean) : TForm;
var
  pomWidth : Integer;
begin
  FChildPanel := p_ChildPanel;
  FChildPanel.Parent := pnlMain;
  FChildPanel.Align  := alClient;
  Caption := p_Title;
  if p_FullScreen then
    WindowState := wsMaximized
  else
  begin
    var pomLblTextWidth := lblTitle.Canvas.TextWidth (p_Title) + 100;
    if FChildPanel.Width > pomLblTextWidth then
      pomWidth := FChildPanel.Width
    else
      pomWidth := pomLblTextWidth;
    pnlMain.Height := FChildPanel.Height;
    ClientWidth    := pomWidth;
    ClientHeight   := lblTitle.Height + FChildPanel.Height + pnlNavigationKeys.Height;
  end;
  if not p_WithNavigationKeys then
    pnlNavigationKeys.Height := 0;
  lblTitle.Caption   := p_Title;

  Result := self;
end;

end.
