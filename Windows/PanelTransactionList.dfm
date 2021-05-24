object frmTransactionList: TfrmTransactionList
  Left = 0
  Top = 0
  Width = 464
  Height = 240
  TabOrder = 0
  object strTransaction: TStringGrid
    Left = 0
    Top = 45
    Width = 464
    Height = 195
    Align = alClient
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
    TabOrder = 0
  end
  object pnlNavigation: TPanel
    Left = 0
    Top = 0
    Width = 464
    Height = 45
    Align = alTop
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
  end
  object ofdOpenTransactionFile: TOpenTextFileDialog
    DefaultExt = '*.xml'
    Left = 400
    Top = 16
  end
end
