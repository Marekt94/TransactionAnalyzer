unit DBTransactionLoaderSaver;

interface

uses
  System.Generics.Collections, Rule, Transaction, DBLoaderSaver, InterfaceTransactionLoader,
  Data.Win.ADODB;

type
  TDBTransactionLoaderSaver = class (TDBLoaderSaver, ITransactionLoader)
  strict private
  strict private
    procedure PackToObject (p_Table : TADOTable;
                            p_Obj   : TRule);
    procedure PackToTable (p_Obj   : TRule;
                           p_Table : TADOTable);
    function ReturnFieldToLocate (p_Obj : TRule) : Integer;
  public
    function Load (p_TransactionList : TObjectList <TTransaction>;
                   p_Path            : string) : boolean;
  end;

implementation

{ TDBTransactionLoaderSaver }

function TDBTransactionLoaderSaver.Load(
  p_TransactionList: TObjectList<TTransaction>; p_Path: string): boolean;
begin

end;

procedure TDBTransactionLoaderSaver.PackToObject(p_Table: TADOTable;
  p_Obj: TRule);
begin

end;

procedure TDBTransactionLoaderSaver.PackToTable(p_Obj: TRule;
  p_Table: TADOTable);
begin

end;

function TDBTransactionLoaderSaver.ReturnFieldToLocate(p_Obj: TRule): Integer;
begin

end;

end.
