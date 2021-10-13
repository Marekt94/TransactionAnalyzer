unit InterfaceModuleDatabase;

interface

uses
  InterfaceModule, Data.Win.ADODB;

type
  IModuleDatabase = interface (IModule)
    ['{1C48DA05-5A90-496B-88F8-956B9E21828A}']
    function GetConnectionString : string;
    function FindTable (p_TableName : string) : TADOTable;
    property ConnectionString: string read GetConnectionString;
  end;

implementation

end.
