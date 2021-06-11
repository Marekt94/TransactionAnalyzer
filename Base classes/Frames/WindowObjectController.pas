unit WindowObjectController;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WindowSkeleton, Vcl.StdCtrls,
  Vcl.ExtCtrls, WindowObjectControllerSteeringClass;

type
  TWndObjController = class(TWndSkeleton)

  end;

procedure OpenObjControllerWindow (p_SteeringObj : TWndObjControllerSteeringClass);

implementation

uses
  BaseListPanel;

{$R *.dfm}

{ TWndSkeleton1 }

procedure OpenObjControllerWindow (p_SteeringObj: TWndObjControllerSteeringClass);
var
  pomWindow : TWndSkeleton;
  pomFrame  : TFrmBaseListPanel;
begin
  pomWindow := TWndObjController.Create(nil);
  try
    pomFrame := TFrmBaseListPanel.Create(pomWindow);
    pomFrame.Init (p_SteeringObj.ObjectClass, p_SteeringObj.ObjectFrame, p_SteeringObj.UpdateView);
    pomFrame.UnpackFrame (p_SteeringObj.ObjectList);
    pomWindow.Init (pomFrame, p_SteeringObj.WndTitle, p_SteeringObj.NavigationKeys);
    pomWindow.ShowModal;
  finally
    FreeAndNil (pomWindow);
  end
end;

end.
