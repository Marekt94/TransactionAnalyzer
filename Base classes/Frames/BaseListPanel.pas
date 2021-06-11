unit BaseListPanel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  System.Generics.Collections, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
  WindowSkeleton, BasePanel;

type
  TFrmBaseListPanel = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    btnAdd: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    strList: TStringGrid;
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  strict private
    FObjectList     : TObjectList<TObject>;
    FObjectClass    : TClass;
    FBasePanel      : TFrmBasePanel;
    FUpdateView     : TProc <TStringGrid>;
    procedure UpdateView;
  public
    procedure Init (p_ObjectClass : TClass; p_ObjectPanel : TFrmBasePanel; p_FunUpdateView : TProc <TStringGrid>);
    function UnpackFrame (p_ObjectList : TObject) : boolean;
  end;

implementation

{$R *.dfm}

{ TFrame1 }

procedure TFrmBaseListPanel.btnAddClick (Sender: TObject);
var
  pomWnd : TWndSkeleton;
  pomObject : TObject;
begin
  pomWnd := TWndSkeleton.Create(nil);
  try
    pomWnd.Init (FBasePanel, '');
    FBasePanel.Unpack (nil);
    if pomWnd.ShowModal = mrOk then
    begin
      pomObject := FObjectClass.Create;
      FBasePanel.Pack (pomObject);
      FObjectList.Add (pomObject)
    end
  finally
    pomWnd.Free;
  end;
  UpdateView;
end;

procedure TFrmBaseListPanel.btnDeleteClick (Sender: TObject);
begin
  FObjectList.Delete(strList.Row - 1);
  UpdateView;
end;

procedure TFrmBaseListPanel.btnEditClick (Sender: TObject);
var
  pomWnd    : TWndSkeleton;
  pomObject : TObject;
begin
  pomWnd := TWndSkeleton.Create(nil);
  try
    pomObject := FObjectList.Items [strList.Row - 1];
    pomWnd.Init (FBasePanel, '');
    FBasePanel.Unpack (pomObject);
    if pomWnd.ShowModal = mrOk then
      FBasePanel.Pack (pomObject);
  finally
    pomWnd.Free;
  end;
  UpdateView;
end;

procedure TFrmBaseListPanel.Init (p_ObjectClass: TClass;
                                  p_ObjectPanel : TFrmBasePanel;
                                  p_FunUpdateView : TProc <TStringGrid>);
begin
  FObjectClass := p_ObjectClass;
  FBasePanel   := p_ObjectPanel;
  FUpdateView  := p_FunUpdateView;
end;

function TFrmBaseListPanel.UnpackFrame (p_ObjectList: TObject): boolean;
begin
  FObjectList := TObjectList<TObject> (p_ObjectList);
  Result := True;
  UpdateView;
end;

procedure TFrmBaseListPanel.UpdateView;
begin
  FUpdateView (strList);
end;

end.
