unit InterfaceSettingsLoaderSaver;

interface

uses
  Settings;

type
  ISettingsSaverLoader = interface (IInterface)
    ['{AC51C3AC-220D-40AA-BA29-C7B2AC43A009}']
    procedure LoadSettings (var p_Settings : TSettings);
    procedure SaveSettings (const p_Settings : TSettings);
  end;

implementation

end.
