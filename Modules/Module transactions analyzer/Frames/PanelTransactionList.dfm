object frmTransactionList: TfrmTransactionList
  Left = 0
  Top = 0
  Width = 464
  Height = 240
  TabOrder = 0
  OnResize = FrameResize
  object strTransaction: TStringGrid
    Left = 129
    Top = 0
    Width = 335
    Height = 240
    Align = alClient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 0
  end
  object pnlNavigation: TPanel
    Left = 0
    Top = 0
    Width = 129
    Height = 240
    Align = alLeft
    TabOrder = 1
    object btnLoad: TButton
      Left = 10
      Top = 10
      Width = 111
      Height = 25
      Caption = 'Load'
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object butShowCategories: TButton
      Left = 10
      Top = 41
      Width = 111
      Height = 25
      Caption = 'Categories'
      TabOrder = 1
      OnClick = butShowCategoriesClick
    end
    object btnRules: TButton
      Left = 10
      Top = 72
      Width = 111
      Height = 25
      Caption = 'Rules'
      TabOrder = 2
      OnClick = btnRulesClick
    end
    object btnAnalyze: TButton
      Left = 10
      Top = 103
      Width = 111
      Height = 25
      Caption = 'Analizuj'
      TabOrder = 3
      OnClick = btnAnalyzeClick
    end
  end
  object ofdOpenTransactionFile: TOpenTextFileDialog
    DefaultExt = '*.xml'
    Left = 400
    Top = 16
  end
end
