unit DataModuleDatabase;

interface

uses
  System.Classes, Data.Win.ADODB, Data.DB;

type
  TdtmModuleDatabase = class(TDataModule)
    FConnection: TADOConnection;
    FCategories: TADOTable;
    FRule: TADOTable;
    FTransaction: TADOTable;
    FQuery: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
