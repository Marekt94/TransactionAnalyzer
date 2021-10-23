unit DBRulesLoaderSaver;

interface

uses
  DBLoaderSaver, InterfaceRuleSaver, System.Generics.Collections,
  Rule, Data.Win.ADODB;

const
  cTableName = '[RULE]';

type
  TDBRulesLoaderSaver = class (TDBLoaderSaver, IRuleSaver)
  strict private
    procedure PackToObject (p_Table : TADOTable;
                            p_Obj   : TRule);
    procedure PackToTable (p_Obj   : TRule;
                           p_Table : TADOTable);
    function ReturnFieldToLocate (p_Obj : TRule) : Integer;
  public
    procedure AfterConstruction; override;
    procedure SaveRules (const p_RuleList : TObjectList <TRule>);
    procedure LoadRules (var   p_RuleList : TObjectList <TRule>);
  end;

implementation

uses
  System.SysUtils, ConstXMLRuleSaverLoader, Kernel, InterfaceModuleDatabase;

{ TDBRulesLoaderSaver }

procedure TDBRulesLoaderSaver.AfterConstruction;
begin
  inherited;
  FTable := (Kernel.GiveObjectByInterface (IModuleDatabase) as IModuleDatabase).FindTable(cTableName);
end;

procedure TDBRulesLoaderSaver.LoadRules(
  var p_RuleList: TObjectList<TRule>);
begin
  inherited Load <TRule> (FTable, p_RuleList, PackToObject);
end;

procedure TDBRulesLoaderSaver.PackToObject(p_Table: TADOTable;
  p_Obj: TRule);
begin
  p_Obj.TitleContains  := p_Table [UpperCase (rs_NN_TitleContains)];
  p_Obj.DateBetween    := p_Table [UpperCase (rs_NN_DateBetween)];
  p_Obj.PriceBetween   := p_Table [UpperCase (rs_NN_PriceBetween)];
  p_Obj.DateFrom       := p_Table [UpperCase (rs_NN_DateFrom)];
  p_Obj.DateTo         := p_Table [UpperCase (rs_NN_DateTo)];
  p_Obj.TitleSubstring := p_Table [UpperCase (rs_NN_TitleSubstring)];
  p_Obj.CategoryIndex  := p_Table [UpperCase (rs_NN_CategoryIndex)];
  p_Obj.PriceLow       := p_Table [UpperCase (rs_NN_PriceLow)];
  p_Obj.PriceHigh      := p_Table [UpperCase (rs_NN_PriceHigh)];
  p_Obj.ID             := p_Table [UpperCase (rs_NN_ID)];
end;

procedure TDBRulesLoaderSaver.PackToTable(p_Obj: TRule;
  p_Table: TADOTable);
begin
  p_Table [UpperCase (rs_NN_TitleContains)]  := p_Obj.TitleContains;
  p_Table [UpperCase (rs_NN_DateBetween)]    := p_Obj.DateBetween;
  p_Table [UpperCase (rs_NN_PriceBetween)]   := p_Obj.PriceBetween;
  p_Table [UpperCase (rs_NN_DateFrom)]       := p_Obj.DateFrom;
  p_Table [UpperCase (rs_NN_DateTo)]         := p_Obj.DateTo;
  p_Table [UpperCase (rs_NN_TitleSubstring)] := p_Obj.TitleSubstring;
  p_Table [UpperCase (rs_NN_CategoryIndex)]  := p_Obj.CategoryIndex;
  p_Table [UpperCase (rs_NN_PriceLow)]       := p_Obj.PriceLow;
  p_Table [UpperCase (rs_NN_PriceHigh)]      := p_Obj.PriceHigh;
end;

function TDBRulesLoaderSaver.ReturnFieldToLocate(p_Obj: TRule): Integer;
begin
  Result := p_Obj.ID;
end;

procedure TDBRulesLoaderSaver.SaveRules(
  const p_RuleList: TObjectList<TRule>);
begin
  var pomComparer := TRuleComparer.Create;
  try
    inherited Save <TRule> (FTable,
                            p_RuleList,
                            pomComparer,
                            PackToObject,
                            PackToTable,
                            ReturnFieldToLocate);
  finally
    PomComparer.Free;
  end;
end;

end.
