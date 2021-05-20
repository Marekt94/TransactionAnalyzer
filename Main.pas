unit Main;

interface

uses
  InterfaceModule, System.Generics.Collections, InterfaceTransactionLoader;

type
  TMain = class (TInterfacedObject)
    strict private
      FObjectList : TList<IModule>;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Run;
      class function GiveObjectByInterface (p_GUID : TGUID) : IInterface;
      property ObjectList: TList<IModule> read FObjectList;
  end;

var
  MainKernel : IInterface;

implementation

uses
  System.SysUtils, ModuleTransactionLoader;

{ TMain }

constructor TMain.Create;
begin
  FObjectList := TList<IModule>.Create;

  FObjectList.Add(TModuleTransactionLoader.Create);
end;

destructor TMain.Destroy;
begin
  FreeAndNil(FObjectList);
  inherited;
end;

class function TMain.GiveObjectByInterface(p_GUID: TGUID): IInterface;
resourcestring
  rs_no_interface = 'Brak interfejsu';
var
  pomKernel : TMain;
begin
  Result := nil;
  pomKernel := MainKernel as TMain;

  for var i := 0 to pomKernel.ObjectList.Count - 1 do
  begin
    Result := pomKernel.ObjectList.Items [i].GiveObjectByInterface (p_GUID);
    if Assigned (Result) then
      Exit;
  end;

  raise Exception.Create(rs_no_interface);
end;

procedure TMain.Run;
var
  pomLoader : ITransactionLoader;
begin
  pomLoader := GiveObjectByInterface (ITransactionLoader) as ITransactionLoader;
  pomLoader.Load(nil, 'example.xml')
end;

end.
