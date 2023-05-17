unit DBTransactionLoaderSaver;

interface

uses
  System.Generics.Collections, Transaction, DBLoaderSaver, InterfaceTransactionLoader,
  Data.Win.ADODB, InterfaceModuleDatabase;

const
  cTableName = '[TRANSACTION]';

type
  TDBTransactionLoaderSaver = class (TDBLoaderSaver, ITransactionLoader)
  strict private
    FModuleDatabase : IModuleDatabase;
    procedure PackToObject (p_Table : TADOTable;
                            p_Obj   : TTransaction);
    procedure PackToTable (p_Obj   : TTransaction;
                           p_Table : TADOTable);
    function ReturnFieldToLocate (p_Obj : TTransaction) : Integer;
  public
    procedure AfterConstruction; override;
    function Load (p_TransactionList : TObjectList <TTransaction>;
                   p_Path            : string) : boolean;
    function Save (p_TransactionList : TObjectList <TTransaction>;
                   p_Path            : string) : boolean;
    function GetHighestIndex : Integer;
  end;

implementation

uses
  ConstXMLLoader, InterfaceKernel, SysUtils;

{ TDBTransactionLoaderSaver }

procedure TDBTransactionLoaderSaver.AfterConstruction;
begin
  inherited;
  FModuleDatabase := (MainKernel.GiveObjectByInterface (IModuleDatabase) as IModuleDatabase);
  FTable := FModuleDatabase.FindTable(cTableName);
end;

function TDBTransactionLoaderSaver.GetHighestIndex: Integer;
begin
  Result := FModuleDatabase.GetHighestIndex (cTableName, 'ID');
end;

function TDBTransactionLoaderSaver.Load(
  p_TransactionList: TObjectList<TTransaction>; p_Path: string): boolean;
begin
  Result := inherited Load <TTransaction> (FTable, p_TransactionList, PackToObject);
end;

procedure TDBTransactionLoaderSaver.PackToObject(p_Table: TADOTable;
  p_Obj: TTransaction);
begin
  p_Obj.DocExecutionDate   := p_Table [UpperCase (c_NN_ExecDate)];
  p_Obj.DocOrderDate       := p_Table [UpperCase (c_NN_OrderDate)];
  p_Obj.DocTransactionType := p_Table [UpperCase (c_NN_Type)];
  p_Obj.DocDescription     := p_Table [UpperCase (c_NN_Description)];
  p_Obj.DocAmount          := p_Table [UpperCase (c_NN_AmountCurr)];
  p_Obj.AccountState       := p_Table [UpperCase (c_NN_EndingBalanceCurr)];
  p_Obj.ID                 := p_Table [UpperCase (c_NN_id)];
  p_Obj.Hash               := p_Table [UpperCase (c_NN_hash)];
end;

procedure TDBTransactionLoaderSaver.PackToTable(p_Obj: TTransaction;
  p_Table: TADOTable);
begin
  p_Table [UpperCase (c_NN_ExecDate)]          := p_Obj.DocExecutionDate;
  p_Table [UpperCase (c_NN_OrderDate)]         := p_Obj.DocOrderDate;
  p_Table [UpperCase (c_NN_Type)]              := p_Obj.DocTransactionType;
  p_Table [UpperCase (c_NN_Description)]       := p_Obj.DocDescription;
  p_Table [UpperCase (c_NN_AmountCurr)]        := p_Obj.DocAmount;
  p_Table [UpperCase (c_NN_EndingBalanceCurr)] := p_Obj.AccountState;
  p_Table [UpperCase (c_NN_id)]                := p_Obj.ID;
  p_Table [UpperCase (c_NN_Hash)]              := p_Obj.Hash;
end;

function TDBTransactionLoaderSaver.ReturnFieldToLocate(p_Obj: TTransaction): Integer;
begin
  Result := p_Obj.ID;
end;

function TDBTransactionLoaderSaver.Save(
  p_TransactionList: TObjectList<TTransaction>; p_Path: string): boolean;
begin
  try
    with FTable do
    begin
      Active := true;
      First;
      Edit;
      for var pomObj in p_TransactionList do
      begin
        if FTable.Locate (UpperCase (c_NN_Hash), TTransaction (pomObj).Hash, [])
        then Continue;

        if Locate('ID', ReturnFieldToLocate (pomObj),[]) then
          Edit
        else
          Insert;
        PackToTable (pomObj, FTable);
        Post;
      end;
      Result := True;
    end;
  finally
    FTable.Active := False;
  end;
end;

end.
