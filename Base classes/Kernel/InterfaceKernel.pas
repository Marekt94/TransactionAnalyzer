unit InterfaceKernel;

interface

uses
  VCL.Forms, InterfaceModule, System.Generics.Collections;

type
  TFrameClass = class of TFrame;
  TKernelState = (ks_Loading, ks_Ready);

  IPlatform = interface
  ['{3F76C9A4-0DA3-4EE4-AABC-F47A5C4C1D50}']
    procedure RegisterModules (p_ModuleList : TList<IModule>);
    procedure SetBasePlatform (p_Platform : IPlatform);
    property BasePlatform : IPlatform write SetBasePlatform;
  end;

  IMainKernel = interface
  ['{1E3557B2-0A30-4880-8639-3F8A57295AEE}']
    procedure OpenModules;
    procedure CloseModules;
    procedure ReloadModules;
    procedure Open(p_MainFrame : TFrameClass; p_FrameTitle : string);
    function GiveObjectByInterface (p_GUID : TGUID; p_Silent : boolean = false) : IInterface;
    function GetState : TKernelState;
    function GetBasePlatform : IPlatform;
    property State : TKernelState read GetState;
    property BasePlatform : IPlatform read GetBasePlatform;
  end;

implementation

end.
