unit UsefullMethods;

interface

uses
  System.Generics.Collections, System.SysUtils;

function ListToLine (p_List : TList <Integer>) : string;
procedure SetIndexes (const p_List : TObjectList <TObject>;
                      const p_GetIndex : TFunc <Integer, TObjectList <TObject>, Integer>;
                      const p_SetIndex : TProc <Integer, TObjectList <TObject>, Integer>); overload;
procedure SetIndexes (const p_LastUsedIndex : integer;
                      const p_List : TObjectList <TObject>;
                      const p_GetIndex : TFunc <Integer, TObjectList <TObject>, Integer>;
                      const p_SetIndex : TProc <Integer, TObjectList <TObject>, Integer>); overload;

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

procedure SetIndexes (const p_List : TObjectList <TObject>;
                      const p_GetIndex : TFunc <Integer, TObjectList <TObject>, Integer>;
                      const p_SetIndex : TProc <Integer, TObjectList <TObject>, Integer>);
var
  pomHighestIndex : Integer;
begin
  pomHighestIndex := 0;
  for var i := 0 to p_List.Count - 1 do
    if pomHighestIndex < p_GetIndex (i, p_List) then
      pomHighestIndex := p_GetIndex (i, p_List);

  SetIndexes (pomHighestIndex, p_List, p_GetIndex, p_SetIndex);
end;

procedure SetIndexes (const p_LastUsedIndex : integer;
                      const p_List : TObjectList <TObject>;
                      const p_GetIndex : TFunc <Integer, TObjectList <TObject>, Integer>;
                      const p_SetIndex : TProc <Integer, TObjectList <TObject>, Integer>);
begin
  var pomIndex := p_LastUsedIndex;
  for var i := 0 to p_List.Count - 1 do
  begin
    if p_GetIndex (i, p_List) < 0 then
    begin
      Inc (pomIndex);
      p_SetIndex (i, p_List, pomIndex);
    end;
  end;
end;

end.
