object FrmCategoriesList: TFrmCategoriesList
  Left = 0
  Top = 0
  Width = 623
  Height = 451
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 145
    Height = 451
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    object btnAdd: TButton
      Left = 32
      Top = 16
      Width = 75
      Height = 25
      Caption = 'btnAdd'
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnDelete: TButton
      Left = 32
      Top = 78
      Width = 75
      Height = 25
      Caption = 'btnDelete'
      TabOrder = 1
      OnClick = btnDeleteClick
    end
    object btnEdit: TButton
      Left = 32
      Top = 47
      Width = 75
      Height = 25
      Caption = 'btnEdit'
      TabOrder = 2
      OnClick = btnEditClick
    end
  end
  object Panel2: TPanel
    Left = 145
    Top = 0
    Width = 478
    Height = 451
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object strCategories: TStringGrid
      Left = 1
      Top = 1
      Width = 476
      Height = 449
      Align = alClient
      ColCount = 1
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      TabOrder = 0
    end
  end
end
