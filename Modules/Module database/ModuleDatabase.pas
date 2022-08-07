unit ModuleDatabase;

interface

uses
  Module, InterfaceModuleDatabase, DataModuleDatabase, Data.Win.ADODB,
  System.Classes;

type
  TModuleDatabase = class (TBaseModule, IModuleDatabase)
    strict private
      FdtmModuleDatabase : TdtmModuleDatabase;
      function FindTable (p_TableName  : string;
                          p_DataModule : TDataModule) : TADOTable; overload;
    public
      constructor Create; override;
      destructor Destroy; override;
      procedure AfterConstruction; override;
      procedure BeforeDestruction; override;
      function GetConnectionString : string;
      function GetSelfInterface : TGUID; override;
      function FindTable (p_TableName : string) : TADOTable; overload;
      function GetHighestIndex (p_TableName : string; p_IndeksName : string): Integer;
      procedure RegisterClasses; override;

  end;

implementation

uses
  System.SysUtils, InterfaceRuleSaver, InterfaceCategoriesLoaderSaver, InterfaceTransactionLoader,
  DBTransactionLoaderSaver,
  DBRulesLoaderSaver, DBCategoriesLoaderSaver;

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

function TModuleDatabase.FindTable(p_TableName: string;
  p_DataModule: TDataModule): TADOTable;
begin
  Result := nil;
  for var i := 0 to p_DataModule.ComponentCount - 1 do
  begin
    var pomComponent := p_DataModule.Components [i];
    if pomComponent is TADOTable then
    begin
      if TADOTable (pomComponent).TableName = p_TableName then
        Result := TADOTable (pomComponent);
    end;
  end;
end;

function TModuleDatabase.FindTable (p_TableName: string): TADOTable;
begin
  Result := FindTable (p_TableName, FdtmModuleDatabase);
end;

function TModuleDatabase.GetConnectionString: string;
begin
  Result := FdtmModuleDatabase.FConnection.ConnectionString;
end;

function TModuleDatabase.GetHighestIndex (p_TableName : string; p_IndeksName : string): Integer;
const
 cMaxIndex = 'MAXINDEX';
begin
  with FdtmModuleDatabase.FQuery do
  begin
    SQL.Clear;
    SQL.Add (Format ('SELECT MAX(%s) as MAXINDEX FROM %s', [p_IndeksName, p_TableName]));
    Prepared := True;
    Open;
    Result := FieldByName (cMaxIndex).AsInteger;
    Close;
  end;
end;

function TModuleDatabase.GetSelfInterface: TGUID;
begin
  Result := IModuleDatabase;
end;

procedure TModuleDatabase.RegisterClasses;
begin
  RegisterClass (IRuleSaver, TDBRulesLoaderSaver);
  RegisterClass (ICategoriesLoaderSaver, TDBCategoriesLoaderSaver);
  RegisterClass (ITransactionLoader, TDBTransactionLoaderSaver);
end;

end.
