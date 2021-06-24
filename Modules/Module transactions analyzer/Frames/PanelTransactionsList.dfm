object frmTransasctionsList: TfrmTransasctionsList
  Left = 0
  Top = 0
  Width = 739
  Height = 346
  TabOrder = 0
  OnResize = FrameResize
  object pnlDescription: TPanel
    Left = 467
    Top = 0
    Width = 272
    Height = 346
    Align = alRight
    TabOrder = 0
    ExplicitHeight = 240
    object lblDescription: TLabel
      Left = 1
      Top = 1
      Width = 270
      Height = 331
      Align = alClient
      Alignment = taCenter
      Caption = 'lblDescription'
      WordWrap = True
      ExplicitWidth = 63
      ExplicitHeight = 13
    end
    object lblBilans: TLabel
      Left = 1
      Top = 332
      Width = 270
      Height = 13
      Align = alBottom
      ExplicitWidth = 3
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 0
    Width = 467
    Height = 346
    Align = alClient
    Caption = 'pnlGrid'
    TabOrder = 1
    ExplicitHeight = 240
    object strTransaction: TStringGrid
      Left = 1
      Top = 1
      Width = 465
      Height = 344
      Align = alClient
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 0
      OnClick = strTransactionClick
      ExplicitHeight = 238
    end
  end
end
