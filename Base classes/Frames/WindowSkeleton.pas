unit WindowSkeleton;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, WindowObjectControllerSteeringClass;

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
    function Init (p_ChildPanel : TFrame; p_Title : string; p_WithNavigationKeys : boolean = true; p_FullScreen : Boolean = false) : TForm; virtual;
    { Public declarations }
  end;

function OpenObjControllerWindow (p_SteeringObj : TWndObjControllerSteeringClass) : Integer;

implementation

uses
  BaseListPanel;

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

function TWndSkeleton.Init (p_ChildPanel: TFrame; p_Title : string; p_WithNavigationKeys : boolean; p_FullScreen : Boolean) : TForm;
begin
  if not p_WithNavigationKeys then
    pnlNavigationKeys.Height := 0;
  FChildPanel := p_ChildPanel;
  FChildPanel.Parent := pnlMain;
  FChildPanel.Align := alClient;
  lblTitle.Caption := p_Title;
  if p_FullScreen then
    WindowState := wsMaximized;
  Result := self;
end;

function OpenObjControllerWindow (p_SteeringObj: TWndObjControllerSteeringClass) : integer;
var
  pomWindow : TWndSkeleton;
  pomFrame  : TFrmBaseListPanel;
begin
  pomWindow := TWndSkeleton.Create(nil);
  try
    pomFrame := TFrmBaseListPanel.Create(pomWindow);
    pomFrame.Init (p_SteeringObj.ObjectClass, p_SteeringObj.ObjectFrame, p_SteeringObj.UpdateView);
    pomFrame.UnpackFrame (p_SteeringObj.ObjectList);
    pomWindow.Init (pomFrame, p_SteeringObj.WndTitle, p_SteeringObj.NavigationKeys, p_SteeringObj.FullScreen);
    Result := pomWindow.ShowModal;
  finally
    FreeAndNil (pomWindow);
  end
end;

end.
