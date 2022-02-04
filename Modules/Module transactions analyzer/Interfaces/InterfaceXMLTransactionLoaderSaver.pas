unit InterfaceXMLTransactionLoaderSaver;

interface

uses
  System.Generics.Collections, Transaction, InterfaceXMLSaverLoader;

type
  IXMLTransactionLoaderSaver = interface (IXMLSaverLoader)
    ['{3D88C81B-FF46-4D0C-9C7D-CCBA2405C5B1}']
      function Save (p_List : TObjectList <TTransaction>; p_Path : string) : boolean;
      function Load (p_List : TObjectList <TTransaction>; p_Path : string) : boolean;
  end;

implementation

end.
