unit ModuleSettings;

interface

uses
  Module, InterfaceModuleSettings, Settings, WindowSkeleton;

type
  TModuleSettings = class (TBaseModule, IModuleSettings)
  strict private
    FSettings : TSettings;
  public
    function OpenMainWindow : Integer; override;
    function GetSelfInterface : TGUID; override;
    procedure RegisterClasses; override;
    function OpenModule : boolean; override;
    function CloseModule : boolean; override;
    function GetSettings : TSettings;
    property Settings: TSettings read GetSettings;
  end;

implementation

uses
  XMLSettingsLoaderSaver, PanelSettings, Kernel,
  InterfaceSettingsLoaderSaver, Vcl.Controls, System.SysUtils;

{ TModuleSettings }

function TModuleSettings.CloseModule: boolean;
var
  pomLoaderSaver : ISettingsSaverLoader;
begin
  Result := inherited;
  pomLoaderSaver := (Kernel.GiveObjectByInterface(ISettingsSaverLoader) as ISettingsSaverLoader);
  pomLoaderSaver.SaveSettings (FSettings);
  FreeAndNil (FSettings);
end;

function TModuleSettings.GetSelfInterface: TGUID;
begin
  Result := IModuleSettings;
end;

function TModuleSettings.GetSettings: TSettings;
begin
  Result := FSettings;
end;

function TModuleSettings.OpenMainWindow: Integer;
var
  pomWnd : TWndSkeleton;
  pomFrm : TFrmSettings;
begin
  pomWnd := TWndSkeleton.Create(nil);
  try
    pomFrm := TFrmSettings.Create(pomWnd);
    pomWnd.Init (pomFrm, 'Ustawienia', true);
    pomFrm.Unpack(FSettings);
    Result := pomWnd.ShowModal;
    if Result = mrOK then
      pomFrm.Pack(FSettings);
  finally
    pomWnd.Free;
  end;
end;

function TModuleSettings.OpenModule: boolean;
var
  pomLoaderSaver : ISettingsSaverLoader;
begin
  Result := inherited;
  FSettings := TSettings.Create;
  pomLoaderSaver := (Kernel.GiveObjectByInterface(ISettingsSaverLoader) as ISettingsSaverLoader);
  pomLoaderSaver.LoadSettings (FSettings);
end;

procedure TModuleSettings.RegisterClasses;
begin
  inherited;
  RegisterClass (TXMLSettingsLoaderSaver);
end;

end.

