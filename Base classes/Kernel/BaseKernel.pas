unit BaseKernel;

interface

uses
  InterfaceKernel, InterfaceModule, System.Generics.Collections;

type
  TBaseKernel = class (TInterfacedObject, IBaseKernel)
  strict private
    FBaseKernel : IBaseKernel;
  public
    procedure RegisterModules (p_ModuleList : TList<IModule>); virtual;
    procedure SetBaseKernel (p_Kernel : IBaseKernel);
  end;

implementation

{ TBaseKernel }

procedure TBaseKernel.RegisterModules(p_ModuleList: TList<IModule>);
begin
  if Assigned (FBaseKernel) then
    FBaseKernel.RegisterModules (p_ModuleList);
end;

procedure TBaseKernel.SetBaseKernel(p_Kernel: IBaseKernel);
begin
  FBaseKernel := p_Kernel;
end;

end.
