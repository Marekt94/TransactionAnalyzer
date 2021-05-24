unit Main;

interface

uses
  InterfaceModule, System.Generics.Collections, InterfaceTransactionLoader,
  Transaction, WindowSkeleton;

type
  TMain = class (TInterfacedObject)
    strict private
      FObjectList : TList<IModule>;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Run;
      property ObjectList: TList<IModule> read FObjectList;
  end;

  function GiveObjectByInterface (p_GUID : TGUID) : IInterface;
var
  MainKernel : IInterface;

implementation

uses
  System.SysUtils, ModuleTransactionLoader, Winapi.Windows,
  PanelTransactionList, InterfaceModuleTransactionLoader;

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

procedure TMain.Run;
var
  pomWind : TWndSkeleton;
begin
  pomWind := TWndSkeleton.Create(nil);
  try
    pomWind.Init (TfrmTransactionList.Create(pomWind));
    pomWind.ShowModal;
  finally
    FreeAndNil (pomWind);
  end;
end;
//------------------------------------------------------------------------------
function GiveObjectByInterface(p_GUID: TGUID): IInterface;
resourcestring
  rs_no_interface = 'Brak interfejsu';
var
  pomKernel : TMain;
  pomInterface : IInterface;
begin
  Result := nil;
  pomInterface := nil;
  pomKernel := MainKernel as TMain;

  for var i := 0 to pomKernel.ObjectList.Count - 1 do
  begin
    if pomKernel.ObjectList.Items [i].SelfInterface = p_GUID then
      Exit (pomKernel.ObjectList.Items [i])
    else
    begin
      Result := pomKernel.ObjectList.Items [i].GiveObjectByInterface (p_GUID);
      if Assigned (Result) then
        Exit;
    end
  end;

  raise Exception.Create(rs_no_interface);
end;

end.
