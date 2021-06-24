unit Settings;

interface

type
  TSettings = class
  strict private
    FMainFolderPath : string;
  public
    property MainFolderPath: string read FMainFolderPath write FMainFolderPath;
  end;

implementation

end.
