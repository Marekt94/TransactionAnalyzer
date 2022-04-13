unit InterfaceLoaderSaver;

interface

uses
  System.Generics.Collections;

type
  ILoaderSaver = interface (IInterface)
  ['{5113927A-C5C7-4078-97C1-F40AA03CDA1E}']
    function Save (p_List : TObjectList <TObject>; p_Path : string) : boolean;
    function Load (p_List : TObjectList <TObject>; p_Path : string) : boolean;
  end;

implementation

end.
