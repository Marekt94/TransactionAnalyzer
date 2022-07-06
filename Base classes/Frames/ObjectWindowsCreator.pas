unit ObjectWindowsCreator;

interface

uses
  WindowObjectControllerSteeringClass;

type
  TObjectWindowsCreator = class
    class function OpenObjControllerWindow (p_SteeringObj : TWndObjControllerSteeringClass) : Integer;
  end;

implementation

uses
  WindowSkeleton, BaseListPanel, System.SysUtils;

{ TObjectWindowsCreator }

class function TObjectWindowsCreator.OpenObjControllerWindow (p_SteeringObj: TWndObjControllerSteeringClass) : integer;
var
  pomWindow : TWndSkeleton;
  pomFrame  : TFrmBaseListPanel;
begin
  pomWindow := TWndSkeleton.Create(nil);
  try
    pomFrame := TFrmBaseListPanel.Create(pomWindow);
    pomFrame.Init (p_SteeringObj.ObjectClass,
                   p_SteeringObj.ObjectFrame,
                   p_SteeringObj.UpdateView,
                   p_SteeringObj.XMLLoaderSaver,
                   p_SteeringObj.WndObjTitle);
    pomFrame.UnpackFrame (p_SteeringObj.ObjectList);
    if p_SteeringObj.AddMode then
      pomWindow.AfterShow := procedure
                             begin
                               pomFrame.btnAddClick (nil);
                             end;
    pomWindow.Init (pomFrame, p_SteeringObj.WndListTitle, p_SteeringObj.NavigationKeys, p_SteeringObj.FullScreen);
    Result := pomWindow.ShowModal;
  finally
    FreeAndNil (pomWindow);
  end
end;

end.
