unit InterfaceKernel;

interface

uses
  VCL.Forms, InterfaceModule, System.Generics.Collections;

type
  TFrameClass = class of TFrame;

  IKernel = interface
  ['{3F76C9A4-0DA3-4EE4-AABC-F47A5C4C1D50}']
    procedure OpenModules;
    procedure CloseModules;
    procedure Run(p_MainFrame : TFrameClass; p_FrameTitle : string);
    function GiveObjectByInterface (p_GUID : TGUID; p_Silent : boolean = false) : IInterface;
    function GetObjectList : TList<IModule>;
    property ObjectList: TList<IModule> read GetObjectList;
  end;

implementation

end.
