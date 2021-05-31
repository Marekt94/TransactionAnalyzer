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
  private
    { Private declarations }
  public
    function Init (p_ChildPanel : TFrame; p_Title : string; p_WithNavigationKeys : boolean = true) : TForm;
    { Public declarations }
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

function TWndSkeleton.Init (p_ChildPanel: TFrame; p_Title : string; p_WithNavigationKeys : boolean) : TForm;
begin
  if not p_WithNavigationKeys then
    pnlNavigationKeys.Height := 0;
  p_ChildPanel.Parent := pnlMain;
  p_ChildPanel.Align := alClient;
  lblTitle.Caption := p_Title;
  Result := self;
end;

end.
