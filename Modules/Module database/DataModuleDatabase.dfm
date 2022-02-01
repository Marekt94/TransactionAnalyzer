object dtmModuleDatabase: TdtmModuleDatabase
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FConnection: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=Transactions;Data Source=DE' +
      'SKTOP-EPJBH34\SQLEXPRESS;Initial File Name="";Server SPN=""'
    Provider = 'SQLNCLI11.1'
    Left = 160
    Top = 96
  end
  object FCategories: TADOTable
    Active = True
    Connection = FConnection
    CursorType = ctStatic
    TableName = 'CATEGORY'
    Left = 104
    Top = 8
  end
  object FRule: TADOTable
    Active = True
    Connection = FConnection
    CursorType = ctStatic
    TableName = '[RULE]'
    Left = 160
    Top = 8
  end
  object FTransaction: TADOTable
    Connection = FConnection
    TableName = '[TRANSACTION]'
    Left = 32
    Top = 8
  end
end
