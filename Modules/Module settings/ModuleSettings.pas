unit ModuleSettings;

interface

uses
  Module, InterfaceModuleSettings, Settings, WindowSkeleton;

type
  TModuleSettings = class (TBaseModule, IModuleSettings)
  strict private
    FSettings : TSettings;
    function OpenSettingsWindow (p_ReloadModules : boolean): Integer;
  public
    function OpenMainWindow : Integer; override;
    function GetSelfInterface : TGUID; override;
    procedure RegisterClasses; override;
    function CloseModule : boolean; override;
    function GetSettings : TSettings;
    function OpenModule: Boolean; override;
    property Settings: TSettings read GetSettings;
  end;

implementation

uses
  XMLSettingsLoaderSaver, PanelSettings, InterfaceKernel,
  InterfaceSettingsLoaderSaver, Vcl.Controls, System.SysUtils;

{ TModuleSettings }

function TModuleSettings.CloseModule: boolean;
var
  pomLoaderSaver : ISettingsSaverLoader;
begin
  Result := inherited;
  pomLoaderSaver := (MainKernel.GiveObjectByInterface(ISettingsSaverLoader) as ISettingsSaverLoader);
  pomLoaderSaver.SaveSettings (FSettings);
end;

function TModuleSettings.GetSelfInterface: TGUID;
begin
  Result := IModuleSettings;
end;

function TModuleSettings.GetSettings: TSettings;
begin
  Result := FSettings;
end;

function TModuleSettings.OpenSettingsWindow (p_ReloadModules : boolean): Integer;
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
    begin
      pomFrm.Pack(FSettings);
      if p_ReloadModules then
        MainKernel.ReloadModules;
    end;
  finally
    pomWnd.Free;
  end;
end;

function TModuleSettings.OpenMainWindow: Integer;
begin
  Result := OpenSettingsWindow (true);
end;

function TModuleSettings.OpenModule: Boolean;
var
  pomLoaderSaver : ISettingsSaverLoader;
begin
  pomLoaderSaver := (MainKernel.GiveObjectByInterface(ISettingsSaverLoader) as ISettingsSaverLoader);
  pomLoaderSaver.LoadSettings (FSettings);
  if MainKernel.State = ks_Loading then
    OpenSettingsWindow (false);
  Result := True;
end;

procedure TModuleSettings.RegisterClasses;
begin
  inherited;
  RegisterClass (ISettingsSaverLoader, TXMLSettingsLoaderSaver);
end;

end.

