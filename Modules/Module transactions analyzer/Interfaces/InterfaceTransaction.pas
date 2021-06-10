unit InterfaceTransaction;

interface

type
  ITransaction = interface (IInterface)
  ['{5AC67728-326C-45F4-B2A6-983527182F47}']
    function GetName : string;
    procedure SetName (p_Name : string);
    property Name: string read GetName write SetName;
  end;

implementation

end.
