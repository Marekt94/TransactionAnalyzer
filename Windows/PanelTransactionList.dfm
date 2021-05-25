object frmTransactionList: TfrmTransactionList
  Left = 0
  Top = 0
  Width = 464
  Height = 240
  TabOrder = 0
  object strTransaction: TStringGrid
    Left = 97
    Top = 0
    Width = 367
    Height = 240
    Align = alClient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 0
    ExplicitLeft = 0
    ExplicitTop = 45
    ExplicitWidth = 464
    ExplicitHeight = 195
  end
  object pnlNavigation: TPanel
    Left = 0
    Top = 0
    Width = 97
    Height = 240
    Align = alLeft
    TabOrder = 1
    object btnLoad: TButton
      Left = 10
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Load'
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object butShowCategories: TButton
      Left = 10
      Top = 41
      Width = 75
      Height = 25
      Caption = 'Categories'
      TabOrder = 1
      OnClick = butShowCategoriesClick
    end
  end
  object ofdOpenTransactionFile: TOpenTextFileDialog
    DefaultExt = '*.xml'
    Left = 400
    Top = 16
  end
end
