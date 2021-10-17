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
    Left = 144
    Top = 72
  end
  object FCategories: TADOTable
    Active = True
    Connection = FConnection
    CursorType = ctStatic
    TableName = 'CATEGORY'
    Left = 144
    Top = 16
  end
end
