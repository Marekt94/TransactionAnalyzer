object dtmCategories: TdtmCategories
  OldCreateOrder = False
  Height = 150
  Width = 215
  object FTable: TADOTable
    ConnectionString = 
      'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=Transactions;Data Source=DE' +
      'SKTOP-EPJBH34\SQLEXPRESS;Initial File Name="";Server SPN=""'
    CursorType = ctStatic
    TableName = 'CATEGORY'
    Left = 80
    Top = 72
  end
end
