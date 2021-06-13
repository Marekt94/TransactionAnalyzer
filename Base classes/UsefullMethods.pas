unit UsefullMethods;

interface

uses
  System.Generics.Collections, System.SysUtils;

function ListToLine (p_List : TList <Integer>) : string;

implementation

function ListToLine (p_List : TList <Integer>) : string;
begin
  if not Assigned (p_List) then
    Exit ('');

  Result := '';
  for var i := 0 to p_List.Count - 2 do
    Result := Result + IntToStr (p_List [i]) + ',';
  Result := Result + IntToStr (p_List.Last);
end;

end.
