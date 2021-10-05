unit ModuleDatabase;

interface

uses
  Module, InterfaceModuleDatabase, DataModuleDatabase;

type
  TModuleDatabase = class (TBaseModule, IModuleDatabase)
    strict private
      FdtmModuleDatabase : TdtmModuleDatabase;
    public
      constructor Create; override;
      destructor Destroy; override;
      procedure AfterConstruction; override;
      procedure BeforeDestruction; override;
      function GetConnectionString : string;
      function GetSelfInterface : TGUID; override;
  end;

implementation

uses
  System.SysUtils;

{ TModuleDatabase }

procedure TModuleDatabase.AfterConstruction;
begin
  inherited;
  FdtmModuleDatabase.FConnection.Connected := true;
end;

procedure TModuleDatabase.BeforeDestruction;
begin
  FdtmModuleDatabase.FConnection.Connected := false;
  inherited;
end;

constructor TModuleDatabase.Create;
begin
  inherited;
  FdtmModuleDatabase := TdtmModuleDatabase.Create(nil);
end;

destructor TModuleDatabase.Destroy;
begin
  FreeAndNil (FdtmModuleDatabase);
  inherited;
end;

function TModuleDatabase.GetConnectionString: string;
begin
  Result := FdtmModuleDatabase.FConnection.ConnectionString;
end;

function TModuleDatabase.GetSelfInterface: TGUID;
begin
  Result := IModuleDatabase;
end;

end.
