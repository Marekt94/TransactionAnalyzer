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
    object Label1: TLabel
      Left = 200
      Top = 56
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
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
      Width = 63
      Height = 13
      Align = alClient
      Alignment = taCenter
      Caption = 'lblDescription'
      WordWrap = True
    end
    object lblBilans: TLabel
      Left = 1
      Top = 226
      Width = 37
      Height = 13
      Align = alBottom
      Caption = 'lblBilans'
    end
  end
  object ofdTransactions: TOpenTextFileDialog
    Filter = 'Transactions|*.xml'
    Left = 744
    Top = 184
  end
end
