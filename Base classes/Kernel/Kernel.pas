unit Kernel;

interface

uses
  InterfaceModule, System.Generics.Collections, WindowSkeleton, Vcl.Forms, InterfaceKernel, BaseKernel;

type
  TKernel = class (TInterfacedObject, IMainKernel)
    strict private
      FObjectList : TList<IModule>;
      FContainer : IContainer;
    protected
      FState : TKernelState;
    public
      constructor Create (p_BaseKernel : IContainer);
      destructor Destroy; override;
      procedure OpenModules; virtual;
      procedure CloseModules; virtual;
      procedure ReloadModules; virtual;
      procedure Open (p_MainFrame : TFrameClass; p_FrameTitle : string);
      function GiveObjectByInterface (p_GUID : TGUID; p_Silent : boolean = false) : IInterface;
      function GetState : TKernelState;
      function GetMainContainer : IContainer;
  end;

var
  MainKernel : IMainKernel;

implementation

uses
  System.SysUtils;

{ TKernel }

procedure TKernel.CloseModules;
begin
  for var i := FObjectList.Count - 1 downto 0 do
    FObjectList [i].CloseModule;
end;

constructor TKernel.Create (p_BaseKernel : IContainer);
begin
  FObjectList := TList<IModule>.Create;
  FContainer := p_BaseKernel;
end;

destructor TKernel.Destroy;
begin
  FreeAndNil(FObjectList);
  inherited;
end;

function TKernel.GetMainContainer: IContainer;
begin
  Result := FContainer;
end;

function TKernel.GetState: TKernelState;
begin
  Result := FState;
end;

procedure TKernel.OpenModules;
begin
  for var i := 0 to FObjectList.Count - 1 do
    FObjectList [i].OpenModule;
end;

procedure TKernel.ReloadModules;
begin
  CloseModules;
  OpenModules;
end;

procedure TKernel.Open (p_MainFrame : TFrameClass; p_FrameTitle : string);
var
  pomWind : TWndSkeleton;
begin
  FState := ks_Loading;

  if not Assigned (FContainer) then
    Exit;
  FContainer.RegisterModules (FObjectList);

  OpenModules;

  //open main window
  pomWind := TWndSkeleton.Create(nil);
  try
    pomWind.Init (p_MainFrame.Create (pomWind), p_FrameTitle, false, false);
    FState := ks_Ready;
    pomWind.ShowModal;
  finally
    FreeAndNil (pomWind);
  end;

  CloseModules;
end;
//------------------------------------------------------------------------------
function TKernel.GiveObjectByInterface(p_GUID: TGUID; p_Silent : boolean): IInterface;
resourcestring
  rs_no_interface = 'Brak interfejsu';
begin
  Result := nil;

  for var pomModule in FObjectList do
  begin
    if pomModule.SelfInterface = p_GUID then
      Exit (pomModule)
    else
    begin
      Result := pomModule.GiveObjectByInterface (p_GUID);
      if Assigned (Result) then
        Exit;
    end
  end;

  Result := nil;
  if not p_Silent then
    raise Exception.Create(rs_no_interface);
end;

end.
