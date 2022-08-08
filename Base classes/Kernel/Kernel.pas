unit Kernel;

interface

uses
  InterfaceModule, System.Generics.Collections, WindowSkeleton, Vcl.Forms, InterfaceKernel;

type
  TKernel = class (TInterfacedObject, IKernel)
    protected
      FObjectList : TList<IModule>;
    public
      constructor Create;
      destructor Destroy; override;
      procedure OpenModules;
      procedure CloseModules;
      procedure ReloadModules;
      procedure Run(p_MainFrame : TFrameClass; p_FrameTitle : string);
      function GetObjectList : TList <IModule>;
      function GiveObjectByInterface (p_GUID : TGUID; p_Silent : boolean = false) : IInterface;
      property ObjectList: TList<IModule> read FObjectList;
  end;

var
  MainKernel : IKernel;

implementation

uses
  System.SysUtils;

{ TKernel }

procedure TKernel.CloseModules;
begin
  for var i := FObjectList.Count - 1 downto 0 do
    FObjectList [i].CloseModule;
end;

constructor TKernel.Create;
begin
  FObjectList := TList<IModule>.Create;
end;

destructor TKernel.Destroy;
begin
  FreeAndNil(FObjectList);
  inherited;
end;

function TKernel.GetObjectList: TList<IModule>;
begin
  Result := FObjectList;
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

procedure TKernel.Run (p_MainFrame : TFrameClass; p_FrameTitle : string);
var
  pomWind : TWndSkeleton;
begin
  OpenModules;

  //open main window
  pomWind := TWndSkeleton.Create(nil);
  try
    pomWind.Init (p_MainFrame.Create (pomWind), p_FrameTitle, false, false);
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
