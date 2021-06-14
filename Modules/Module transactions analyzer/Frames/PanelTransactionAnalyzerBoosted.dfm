object FrmTransactionAnalyzerBoosted: TFrmTransactionAnalyzerBoosted
  Left = 0
  Top = 0
  Width = 808
  Height = 240
  TabOrder = 0
  OnResize = FrameResize
  object pnlGrid: TPanel
    Left = 185
    Top = 0
    Width = 351
    Height = 240
    Align = alClient
    Caption = 'pnlGrid'
    TabOrder = 0
    object strTransaction: TStringGrid
      Left = 1
      Top = 1
      Width = 349
      Height = 238
      Align = alClient
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 0
      OnClick = strTransactionClick
    end
  end
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 240
    Align = alLeft
    TabOrder = 1
  end
  object pnlDescription: TPanel
    Left = 536
    Top = 0
    Width = 272
    Height = 240
    Align = alRight
    TabOrder = 2
    object lblDescription: TLabel
      Left = 1
      Top = 1
      Width = 270
      Height = 238
      Align = alClient
      Alignment = taCenter
      Caption = 'lblDescription'
      WordWrap = True
      ExplicitWidth = 63
      ExplicitHeight = 13
    end
  end
  object ofdTransactions: TOpenTextFileDialog
    Filter = 'Transactions|*.xml'
    Left = 392
    Top = 104
  end
end
