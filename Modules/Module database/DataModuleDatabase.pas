unit DataModuleDatabase;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TdtmModuleDatabase = class(TDataModule)
    FConnection: TADOConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
