unit WindowObjectControllerSteeringClass;

interface

uses
  System.SysUtils, Vcl.Grids, Vcl.Forms, BasePanel;

type
  TWndObjControllerSteeringClass = class
  private
    FObjectClass : TClass;
    FObjectFrame : TFrmBasePanel;
    FUpdateView : TProc<TStringGrid>;
    FObjectList : TObject;
    FWndTitle : string;
    FFullScreen : boolean;
    FNavigationKeys : boolean;
  public
    destructor Destroy; override;
    property ObjectClass: TClass read FObjectClass write FObjectClass;
    property ObjectFrame: TFrmBasePanel read FObjectFrame write FObjectFrame;
    property UpdateView: TProc<TStringGrid> read FUpdateView write FUpdateView;
    property ObjectList: TObject read FObjectList write FObjectList;
    property WndTitle: string read FWndTitle write FWndTitle;
    property FullScreen: boolean read FFullScreen write FFullScreen;
    property NavigationKeys: boolean read FNavigationKeys write FNavigationKeys;
  end;

implementation

{ TWndObjControllerSteeringClass }

destructor TWndObjControllerSteeringClass.Destroy;
begin
  if Assigned (FObjectFrame) then
    FObjectFrame.Free;
  inherited;
end;

end.
