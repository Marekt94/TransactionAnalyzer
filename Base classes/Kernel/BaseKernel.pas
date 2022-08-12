unit BaseKernel;

interface

uses
  InterfaceKernel, InterfaceModule, System.Generics.Collections;

type
  TBasePlatform = class (TInterfacedObject, IPlatform)
  strict private
    FBaseKernel : IPlatform;
  public
    procedure RegisterModules (p_ModuleList : TList<IModule>); virtual;
    procedure SetBasePlatform (p_Platform: IPlatform);
  end;

implementation

{ TBasePlatform }

procedure TBasePlatform.RegisterModules(p_ModuleList: TList<IModule>);
begin
  if Assigned (FBaseKernel) then
    FBaseKernel.RegisterModules (p_ModuleList);
end;

procedure TBasePlatform.SetBasePlatform(p_Platform: IPlatform);
begin
  FBaseKernel := p_Platform;
end;

end.
