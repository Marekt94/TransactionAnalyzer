unit InterfaceModule;

interface

uses
  System.Generics.Collections;

type
  IModule = interface (IInterface)
  ['{1C342A88-4427-435B-82EF-737C925AFE7F}']
    function GetSelfInterface : TGUID;
    function GetObjectList : TList<TInterfacedClass>;
    function GiveObjectByInterface (p_GUID : TGUID) : IInterface;
    function InterfaceExists (p_GUID : TGUID) : boolean;
    function OpenModule : boolean;
    function CloseModule : boolean;
    function OpenMainWindow : Integer;
    procedure RegisterClass (p_Class : TInterfacedClass);
    procedure RegisterClasses;
    property ObjectList: TList<TInterfacedClass> read GetObjectList;
    property SelfInterface : TGUID read GetSelfInterface;
  end;

implementation

end.
