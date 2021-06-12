unit GUIMethods;

interface

uses
  Vcl.Grids;

procedure FitGridAlClient (p_Grid : TStringGrid);

implementation

uses
  System.Math;

procedure FitGridAlClient (p_Grid: TStringGrid);
var
  pomColLength : Integer;
  pomRatio     : Double;
begin
  pomColLength := 0;
  for var i := 0 to p_Grid.ColCount - 1 do
    pomColLength := pomColLength + p_Grid.ColWidths [i];
  pomRatio := p_Grid.ClientWidth / pomColLength;

  for var i := 0 to p_Grid.ColCount - 1 do
    p_Grid.ColWidths [i] := Floor (p_Grid.ColWidths [i] * pomRatio);
end;

end.
