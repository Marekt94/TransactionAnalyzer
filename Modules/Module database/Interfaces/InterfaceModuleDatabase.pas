unit InterfaceModuleDatabase;

interface

uses
  InterfaceModule;

type
  IModuleDatabase = interface (IModule)
    ['{1C48DA05-5A90-496B-88F8-956B9E21828A}']
    function GetConnectionString : string;
    property ConnectionString: string read GetConnectionString;
  end;

implementation

end.
