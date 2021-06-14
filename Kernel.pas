unit Kernel;

interface

uses
  InterfaceModule, System.Generics.Collections, InterfaceTransactionLoader,
  Transaction, WindowSkeleton, ModuleTransactionAnalyzer;

type
  TKernel = class (TInterfacedObject)
    strict private
      FObjectList : TList<IModule>;
    public
      constructor Create;
      destructor Destroy; override;
      procedure OpenModules;
      procedure CloseModules;
      procedure Run;
      property ObjectList: TList<IModule> read FObjectList;
  end;

  function GiveObjectByInterface (p_GUID : TGUID) : IInterface;
var
  MainKernel : IInterface;

implementation

uses
  System.SysUtils, Winapi.Windows,
  PanelMain, ModuleCategories,
  ModuleRuleController;

{ TKernel }

procedure TKernel.CloseModules;
begin
  for var i := 0 to FObjectList.Count - 1 do
    FObjectList [i].CloseModule;
end;

constructor TKernel.Create;
begin
  FObjectList := TList<IModule>.Create;

  FObjectList.Add (TModuleCategories.Create);
  FObjectList.Add (TModuleTransactionAnalyzer.Create);
  FObjectList.Add (TModuleRuleController.Create)
end;

destructor TKernel.Destroy;
begin
  FreeAndNil(FObjectList);
  inherited;
end;

procedure TKernel.OpenModules;
begin
  for var i := 0 to FObjectList.Count - 1 do
    FObjectList [i].OpenModule;
end;

procedure TKernel.Run;
resourcestring
  rs_MainTitle = 'Analiza transakcji';
var
  pomWind : TWndSkeleton;
begin
  OpenModules;

  //open main window
  pomWind := TWndSkeleton.Create(nil);
  try
    pomWind.Init (TfrmTransactionList.Create(pomWind), rs_MainTitle, false, false);
    pomWind.ShowModal;
  finally
    FreeAndNil (pomWind);
  end;

  CloseModules;
end;
//------------------------------------------------------------------------------
function GiveObjectByInterface(p_GUID: TGUID): IInterface;
resourcestring
  rs_no_interface = 'Brak interfejsu';
var
  pomKernel : TKernel;
  pomInterface : IInterface;
begin
  Result := nil;
  pomInterface := nil;
  pomKernel := MainKernel as TKernel;

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
