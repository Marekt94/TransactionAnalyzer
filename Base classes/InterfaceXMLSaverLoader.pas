unit InterfaceXMLSaverLoader;

interface

uses
  System.Generics.Collections;

type
  IXMLSaverLoader = interface (IInterface)
    ['{AC417426-32C3-4E60-8649-F52D55232B51}']
    function Save (p_List : TObjectList <TObject>; p_Path : string) : boolean;
    function Load (p_List : TObjectList <TObject>; p_Path : string) : boolean;
  end;

implementation

end.
