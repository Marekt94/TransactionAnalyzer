object frmRuleList: TfrmRuleList
  Left = 0
  Top = 0
  Width = 630
  Height = 364
  TabOrder = 0
  object Panel1: TPanel
    Left = 89
    Top = 0
    Width = 541
    Height = 364
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object strRules: TStringGrid
      Left = 1
      Top = 1
      Width = 539
      Height = 362
      Align = alClient
      ColCount = 2
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 89
    Height = 364
    Align = alLeft
    TabOrder = 1
    object btnAdd: TButton
      Left = 6
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Dodaj'
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnRemove: TButton
      Left = 6
      Top = 67
      Width = 75
      Height = 25
      Caption = 'Usu'#324
      TabOrder = 1
      OnClick = btnRemoveClick
    end
    object btnEdit: TButton
      Left = 8
      Top = 36
      Width = 75
      Height = 25
      Caption = 'Edytuj'
      TabOrder = 2
      OnClick = btnEditClick
    end
  end
end
