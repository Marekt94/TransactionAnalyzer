unit WindowObjectControllerSteeringClass;

interface

uses
  System.SysUtils, Vcl.Grids, BasePanel, InterfaceXMLSaverLoader;

type
  TWndObjControllerSteeringClass = class
  private
    FObjectClass    : TClass;
    FObjectFrame    : TFrmBasePanel;
    FUpdateView     : TProc<TStringGrid, TObject>;
    FXMLLoaderSaver : IXMLSaverLoader;
    FObjectList     : TObject;
    FWndListTitle   : string;
    FWndObjTitle    : string;
    FFullScreen     : boolean;
    FNavigationKeys : boolean;
    FAddMode        : boolean;
  public
    destructor Destroy; override;
    property ObjectClass: TClass read FObjectClass write FObjectClass;
    property ObjectFrame: TFrmBasePanel read FObjectFrame write FObjectFrame;
    property UpdateView: TProc<TStringGrid, TObject> read FUpdateView write FUpdateView;
    property ObjectList: TObject read FObjectList write FObjectList;
    property WndListTitle: string read FWndListTitle write FWndListTitle;
    property FullScreen: boolean read FFullScreen write FFullScreen;
    property NavigationKeys: boolean read FNavigationKeys write FNavigationKeys;
    property WndObjTitle: string read FWndObjTitle write FWndObjTitle;
    property XMLLoaderSaver: IXMLSaverLoader read FXMLLoaderSaver write FXMLLoaderSaver;
    property AddMode: Boolean read FAddMode write FAddMode;
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
