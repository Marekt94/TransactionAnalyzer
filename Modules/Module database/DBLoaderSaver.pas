unit DBLoaderSaver;

interface

uses
  System.SysUtils, Data.Win.ADODB, System.Generics.Collections,
  System.Generics.Defaults;

type
  TOnDuplicates = reference to function  (    p_Table    : TADOTable;
                                              p_Obj      : TObject;
                                          var p_DupCount : Integer) : boolean;

  TDBLoaderSaver = class (TInterfacedObject)
    protected
      FTable : TADOTable;
    public
      function Load <TObjClass: class, constructor> (
        const p_Table : TADOTable;
        const p_List : TObjectList <TObjClass>;
        const p_PackToObj : TProc <TADOTable, TObjClass>) : boolean;
      function Save <TObjClass: class, constructor> (
        const p_Table : TADOTable;
        const p_List : TObjectList <TObjClass>;
        const p_Comparer : TComparer <TObjClass>;
        const p_PackToObj : TProc <TADOTable, TObjClass>;
        const p_PackToTable : TProc <TObjClass, TADOTable>;
        const p_ReturnFieldToLocate : TFunc <TObjClass, Integer>;
              p_OnDupliacates : TOnDuplicates = nil) : boolean;

  end;

implementation

{ TDBLoaderSaver }

function TDBLoaderSaver.Load<TObjClass>(
  const p_Table: TADOTable;
  const p_List: TObjectList<TObjClass>;
  const p_PackToObj: TProc<TADOTable, TObjClass>): boolean;
begin
  with p_Table do
  begin
    Active := True;
    First;
    while not Eof do
    begin
      var pomCat : TObjClass;
      pomCat := TObjClass.Create;
      p_PackToObj(p_Table, pomCat);
      p_List.Add(pomCat);
      Next;
    end;
    Active := False;
  end;
  Result := true;
end;

function TDBLoaderSaver.Save<TObjClass>(
  const p_Table: TADOTable;
  const p_List: TObjectList<TObjClass>;
  const p_Comparer: TComparer <TObjClass>;
  const p_PackToObj: TProc<TADOTable, TObjClass>;
  const p_PackToTable: TProc<TObjClass, TADOTable>;
  const p_ReturnFieldToLocate : TFunc <TObjClass, Integer>;
        p_OnDupliacates : TOnDuplicates = nil) : boolean;
var
  pomIndex : Integer;
begin
  p_List.Sort (p_Comparer);
  with p_Table do
  begin
    Active := true;
    First;
    Edit;
    while not Eof do
    begin
      var pomCat : TObjClass;
      pomCat := TObjClass.Create;
      try
        p_PackToObj(p_Table, pomCat);
        if not p_List.BinarySearch (pomCat, pomIndex, p_Comparer) then
          Delete
        else
          Next;
      finally
        FreeAndNil (pomCat);
      end;
    end;

    var pomDup := 0;
    for var pomObj in p_List do
    begin
      var pomContinueOnDuplicates := true;
      if Assigned (p_OnDupliacates) then
        pomContinueOnDuplicates := p_OnDupliacates (p_Table, pomObj, pomDup);
      if not pomContinueOnDuplicates then
        continue;

      if Locate('ID',p_ReturnFieldToLocate (pomObj),[]) then
        Edit
      else
        Insert;
      p_PackToTable (pomObj, p_Table);
      Post;
    end;
    Active := False;
  end;
  Result := true;
end;

end.
