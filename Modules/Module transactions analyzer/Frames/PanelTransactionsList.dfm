object frmTransasctionsList: TfrmTransasctionsList
  Left = 0
  Top = 0
  Width = 739
  Height = 240
  TabOrder = 0
  OnResize = FrameResize
  object pnlDescription: TPanel
    Left = 467
    Top = 0
    Width = 272
    Height = 240
    Align = alRight
    TabOrder = 0
    ExplicitLeft = 48
    object lblDescription: TLabel
      Left = 1
      Top = 1
      Width = 270
      Height = 225
      Align = alClient
      Alignment = taCenter
      Caption = 'lblDescription'
      WordWrap = True
      ExplicitWidth = 63
      ExplicitHeight = 13
    end
    object lblBilans: TLabel
      Left = 1
      Top = 226
      Width = 270
      Height = 13
      Align = alBottom
      Caption = 'lblBilans'
      ExplicitWidth = 37
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 0
    Width = 467
    Height = 240
    Align = alClient
    Caption = 'pnlGrid'
    TabOrder = 1
    ExplicitLeft = -31
    ExplicitWidth = 351
    object strTransaction: TStringGrid
      Left = 1
      Top = 1
      Width = 465
      Height = 238
      Align = alClient
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 0
      ExplicitWidth = 349
    end
  end
end
