unit Module;

interface

uses
  InterfaceModule, System.Generics.Collections;

type
  TBaseModule = class(TInterfacedObject, IModule)
  strict private
    FObjectList : TList<TInterfacedClass>;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function OpenMainWindow : Integer; virtual;
    function OpenModule : boolean; virtual;
    function CloseModule : boolean; virtual;
    procedure RegisterClass (p_Class : TInterfacedClass);
    procedure RegisterClasses; virtual;
    function GetObjectList : TList<TInterfacedClass>;
    function GiveObjectByInterface (p_GUID : TGUID) : IInterface;
    function GetSelfInterface : TGUID; virtual;
    function InterfaceExists (p_GUID : TGUID) : boolean;
  end;

implementation

uses
  System.SysUtils, Vcl.Controls;

{ TBaseModule }

function TBaseModule.CloseModule: boolean;
begin
  Result := True;
end;

constructor TBaseModule.Create;
begin
  FObjectList := TList<TInterfacedClass>.Create;

  RegisterClasses;
end;

destructor TBaseModule.Destroy;
begin
  FreeAndNil (FObjectList);
  inherited;
end;

function TBaseModule.GetObjectList: TList<TInterfacedClass>;
begin
  Result := FObjectList;
end;

function TBaseModule.GetSelfInterface: TGUID;
begin
  //to be covered in descendant
end;

function TBaseModule.GiveObjectByInterface(
  p_GUID: TGUID): IInterface;
begin
  for var i := 0 to FObjectList.Count - 1 do
    if Assigned (FObjectList.Items [i].GetInterfaceEntry(p_GUID)) then
      Exit (FObjectList.Items [i].Create);

  Result := nil;
end;

function TBaseModule.InterfaceExists(p_GUID: TGUID): boolean;
begin
  Result := False;
  for var i := 0 to FObjectList.Count - 1 do
    if Assigned (FObjectList.Items [i].GetInterfaceEntry(p_GUID)) then
      Exit (True);
end;

function TBaseModule.OpenMainWindow: Integer;
begin
  Result := mrOk
end;

function TBaseModule.OpenModule: boolean;
begin
  Result := true;
end;

procedure TBaseModule.RegisterClass(p_Class : TInterfacedClass);
begin
  FObjectList.Add (p_Class)
end;

procedure TBaseModule.RegisterClasses;
begin
  //to be covered in descendant
end;

end.
