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
    object strTransaction: TStringGrid
      Left = 1
      Top = 1
      Width = 465
      Height = 309
      Align = alClient
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 0
      OnClick = strTransactionClick
      ExplicitHeight = 344
    end
    object pnlFoot: TPanel
      Left = 1
      Top = 310
      Width = 465
      Height = 35
      Align = alBottom
      TabOrder = 1
      ExplicitLeft = 0
      ExplicitTop = 311
      ExplicitWidth = 739
      object chbImpact: TCheckBox
        Left = 16
        Top = 6
        Width = 57
        Height = 17
        Caption = 'Wp'#322'ywy'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = chbExpenseClick
      end
      object chbExpense: TCheckBox
        Left = 79
        Top = 6
        Width = 58
        Height = 17
        Caption = 'Wydatki'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = chbExpenseClick
      end
    end
  end
end
