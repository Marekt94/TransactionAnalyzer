unit Transaction;

interface

uses
  InterfaceTransaction;

type
  TTransaction = class (TInterfacedObject, ITransaction)
  strict private
    FName : String;
  public
    function GetName : string;
    procedure SetName (p_Name : string);
    property Name: string read GetName write SetName;
  end;

implementation

{ TTransaction }

function TTransaction.GetName: string;
begin
  Result := FName;
end;

procedure TTransaction.SetName(p_Name: string);
begin
  FName := p_Name;
end;

end.
