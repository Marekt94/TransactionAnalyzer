unit ModuleDatabaseXML;

interface

uses
  Module, InterfaceModuleDatabaseXML;

type
  TModuleDatabaseXML = class (TBaseModule, IModuleDatabaseXML)
  public
    procedure RegisterClasses; override;
  end;



implementation

uses
  XMLCategoriesLoaderSaver, XMLRuleSaverLoader, InterfaceRuleSaver, InterfaceCategoriesLoaderSaver;

{ TModuleDatabaseXML }

procedure TModuleDatabaseXML.RegisterClasses;
begin
  inherited;
  RegisterClass (ICategoriesLoaderSaver, TXMLCategoriesLoaderSaver);
  RegisterClass (IRuleSaver, TXMLRuleSaverLoader);
end;

end.
