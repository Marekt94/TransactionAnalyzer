unit ModuleTransactionLoader;

interface

uses
  InterfaceModule, System.Generics.Collections, Module;

type
  TModuleTransactionLoader = class(TBaseModule, IModule)
    procedure RegisterClasses; override;
  end;

implementation

uses
  XMLLoader;

{ TModuleTransactionLoader }

procedure TModuleTransactionLoader.RegisterClasses;
begin
  inherited;
  RegisterClass (TXMLLoader);
end;

end.
