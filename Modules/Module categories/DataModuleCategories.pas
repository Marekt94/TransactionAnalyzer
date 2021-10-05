unit DataModuleCategories;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

const
  cTableName = 'CATEGORY';

type
  TdtmCategories = class(TDataModule)
    FTable: TADOTable;
  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses
  Kernel, InterfaceModuleDatabase;

{ TdtmCategories }

procedure TdtmCategories.AfterConstruction;
begin
  FTable.ConnectionString := (Kernel.GiveObjectByInterface (IModuleDatabase) as IModuleDatabase).ConnectionString;
  FTable.TableName := cTableName;
  FTable.Active := true;
end;

end.
