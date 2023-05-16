unit WindowObjectControllerSteeringClass;

interface

uses
  System.SysUtils, Vcl.Grids, InterfaceBasePanel, InterfaceXMLSaverLoader;

type
  TWndObjControllerSteeringClass = class
  private
    FObjectClass    : TClass;
    FObjectFrame    : IBasePanel;
    FUpdateView     : TProc<TStringGrid, TObject>;
    FXMLLoaderSaver : IXMLSaverLoader;
    FObjectList     : TObject;
    FWndListTitle   : string;
    FWndObjTitle    : string;
    FFullScreen     : boolean;
    FNavigationKeys : boolean;
    FAddMode        : boolean;
  public
    property ObjectClass: TClass read FObjectClass write FObjectClass;
    property ObjectFrame: IBasePanel read FObjectFrame write FObjectFrame;
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

end.
