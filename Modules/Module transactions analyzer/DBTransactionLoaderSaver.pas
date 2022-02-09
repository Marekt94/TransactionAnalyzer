unit DBTransactionLoaderSaver;

interface

uses
  System.Generics.Collections, Transaction, DBLoaderSaver, InterfaceTransactionLoader,
  Data.Win.ADODB;

const
  cTableName = '[TRANSACTION]';

type
  TDBTransactionLoaderSaver = class (TDBLoaderSaver, ITransactionLoader)
  strict private
  strict private
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
  end;

implementation

uses
  ConstXMLLoader, Kernel, InterfaceModuleDatabase, SysUtils;

{ TDBTransactionLoaderSaver }

procedure TDBTransactionLoaderSaver.AfterConstruction;
begin
  inherited;
  FTable := (Kernel.GiveObjectByInterface (IModuleDatabase) as IModuleDatabase).FindTable(cTableName);
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
  var pomComparer := TTransactionComparer.Create;
  try
    Result := inherited Save <TTransaction> (FTable, p_TransactionList, pomComparer,
                                             PackToObject, PackToTable,
                                             ReturnFieldToLocate)
  finally
    pomComparer.Free;
  end;
end;

end.
