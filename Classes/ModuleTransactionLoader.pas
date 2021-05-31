unit ModuleTransactionLoader;

interface

uses
  System.Generics.Collections, InterfaceTransactionLoader,
  InterfaceModuleTransactionLoader, Module, Transaction;

type
  TModuleTransactionLoader = class(TBaseModule, IModuleTransactionLoader)
  strict private
    FTransactionList : TObjectList <TTransaction>;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetTransactionList : TObjectList <TTransaction>;
    function GetSelfInterface: TGUID; override;
    function LoadTransactions (p_Path : string) : boolean;
    procedure RegisterClasses; override;
  end;

implementation

uses
  XMLLoader, Main, System.SysUtils;

{ TModuleTransactionLoader }

function TModuleTransactionLoader.GetTransactionList: TObjectList<TTransaction>;
begin
  Result := FTransactionList;
end;

function TModuleTransactionLoader.LoadTransactions (p_Path : string) : boolean;
var
  pomLoader : ITransactionLoader;
begin
  pomLoader := GiveObjectByInterface (ITransactionLoader) as ITransactionLoader;
  if not Assigned (pomLoader) then
    Exit (false);

  FTransactionList.Clear;
  Result := pomLoader.Load(FTransactionList, p_Path);
end;

procedure TModuleTransactionLoader.RegisterClasses;
begin
  inherited;
  RegisterClass (TXMLLoader);
end;

constructor TModuleTransactionLoader.Create;
begin
  inherited;
  FTransactionList := TObjectList <TTransaction>.Create;
end;

destructor TModuleTransactionLoader.Destroy;
begin
  FreeAndNil (FTransactionList);
  inherited;
end;

function TModuleTransactionLoader.GetSelfInterface: TGUID;
begin
  inherited;
  Result := IModuleTransactionLoader;
end;

end.
