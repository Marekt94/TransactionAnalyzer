unit InterfaceKernel;

interface

uses
  VCL.Forms, InterfaceModule, System.Generics.Collections;

type
  TFrameClass = class of TFrame;
  TKernelState = (ks_Loading, ks_Ready);

  IBaseKernel = interface
  ['{3F76C9A4-0DA3-4EE4-AABC-F47A5C4C1D50}']
    procedure RegisterModules (p_ModuleList : TList<IModule>);
    procedure SetBaseKernel (p_Kernel : IBaseKernel);
    property BaseKernel : IBaseKernel write SetBaseKernel;
  end;

  IMainKernel = interface (IBaseKernel)
  ['{1E3557B2-0A30-4880-8639-3F8A57295AEE}']
    procedure OpenModules;
    procedure CloseModules;
    procedure ReloadModules;
    procedure Run(p_MainFrame : TFrameClass; p_FrameTitle : string);
    function GiveObjectByInterface (p_GUID : TGUID; p_Silent : boolean = false) : IInterface;
    function GetState : TKernelState;
    property State : TKernelState read GetState;
  end;

implementation

end.
