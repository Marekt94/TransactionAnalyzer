unit InterfaceLoaderSaver;

interface

uses
  System.Generics.Collections;

type
  ILoaderSaver = interface (IInterface)
    function Load <TObjClass> (p_List : TObjectList <TObjClass>);
    function Save <TObjClass> (p_List : TObjectList <TObjClass>);
  end;

implementation

end.
