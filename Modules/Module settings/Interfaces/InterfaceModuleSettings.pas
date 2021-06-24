unit InterfaceModuleSettings;

interface

uses
  InterfaceModule, Settings;

type
  IModuleSettings = interface (IModule)
    ['{AE94A835-B7C9-442C-9DB2-572075C07324}']
    function GetSettings : TSettings;
    property Settings: TSettings read GetSettings;
  end;

implementation

end.
