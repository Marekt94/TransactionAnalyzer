unit Rule;

interface

type
  TRule = class
  strict private
    FTitleContains  : boolean;
    FDateBetween    : boolean;
    FDateFrom       : TDate;
    FDateTo         : TDate;
    FTitleSubstring : string;
    FCategoryIndex  : integer;
  public
    property TitleContains: boolean read FTitleContains write FTitleContains;
    property DateBetween: boolean read FDateBetween write FDateBetween;
    property DateFrom : TDate read FDateFrom  write FDateFrom;
    property DateTo: TDate read FDateTo write FDateTo;
    property TitleSubstring: string read FTitleSubstring write FTitleSubstring;
    property CategoryIndex: integer read FCategoryIndex write FCategoryIndex;
  end;

implementation

end.
