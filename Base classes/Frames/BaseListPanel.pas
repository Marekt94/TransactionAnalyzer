unit BaseListPanel;

interface

uses
  Vcl.Forms, Vcl.Grids, Vcl.StdCtrls, System.Classes, Vcl.Controls, Vcl.ExtCtrls,
  System.Generics.Collections, BasePanel, System.SysUtils;


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
    procedure FrameResize(Sender: TObject);
  strict private
    FObjectList     : TObjectList<TObject>;
    FObjectClass    : TClass;
    FBasePanel      : TFrmBasePanel;
    FUpdateView     : TProc <TStringGrid>;
    FWndObjectTitle : string;
    procedure UpdateView;
  public
    function UnpackFrame (p_ObjectList : TObject) : boolean;
    procedure Init (p_ObjectClass    : TClass;
                    p_ObjectPanel    : TFrmBasePanel;
                    p_FunUpdateView  : TProc <TStringGrid>;
                    p_WndObjectTitle : String);
  end;

implementation

uses
  WindowSkeleton, System.Math, GUIMethods;

{$R *.dfm}

{ TFrame1 }

procedure TFrmBaseListPanel.btnAddClick (Sender: TObject);
var
  pomWnd    : TWndSkeleton;
  pomObject : TObject;
begin
  pomWnd := TWndSkeleton.Create(nil);
  try
    pomWnd.Init (FBasePanel, FWndObjectTitle);
    FBasePanel.Unpack (nil);
    if pomWnd.ShowModal = mrOk then
    begin
      pomObject := FObjectClass.Create;
      try
        FBasePanel.Pack (pomObject);
        FObjectList.Add (pomObject)
      except
        pomObject.Free;
      end;
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
    pomWnd.Init (FBasePanel, FWndObjectTitle);
    FBasePanel.Unpack (pomObject);
    if pomWnd.ShowModal = mrOk then
      FBasePanel.Pack (pomObject);
  finally
    pomWnd.Free;
  end;
  UpdateView;
end;

procedure TFrmBaseListPanel.FrameResize(Sender: TObject);
begin
  GUIMethods.FitGridAlClient (strList);
end;

procedure TFrmBaseListPanel.Init (p_ObjectClass    : TClass;
                                  p_ObjectPanel    : TFrmBasePanel;
                                  p_FunUpdateView  : TProc <TStringGrid>;
                                  p_WndObjectTitle : String);
begin
  FObjectClass    := p_ObjectClass;
  FBasePanel      := p_ObjectPanel;
  FWndObjectTitle := p_WndObjectTitle;
  FUpdateView     := p_FunUpdateView;
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
