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
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object grpDescription: TGroupBox
      Left = 1
      Top = 1
      Width = 270
      Height = 183
      Align = alClient
      Caption = 'Szczeg'#243#322'y transakcji'
      TabOrder = 0
      ExplicitLeft = 48
      ExplicitTop = 120
      ExplicitWidth = 185
      ExplicitHeight = 105
      object lblDescription: TLabel
        Left = 2
        Top = 15
        Width = 266
        Height = 166
        Align = alClient
        Alignment = taCenter
        Caption = 'lblDescription'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        WordWrap = True
        ExplicitWidth = 63
        ExplicitHeight = 13
      end
    end
    object grpBilans: TGroupBox
      Left = 1
      Top = 184
      Width = 270
      Height = 161
      Align = alBottom
      Caption = 'Bilans'
      TabOrder = 1
      object grdBilans: TGridPanel
        Left = 2
        Top = 15
        Width = 266
        Height = 144
        Align = alClient
        ColumnCollection = <
          item
            SizeStyle = ssAuto
            Value = 50.000000000000000000
          end
          item
            SizeStyle = ssAuto
            Value = 50.000000000000000000
          end>
        ControlCollection = <>
        RowCollection = <
          item
            SizeStyle = ssAuto
            Value = 50.000000000000000000
          end
          item
            SizeStyle = ssAuto
            Value = 50.000000000000000000
          end>
        TabOrder = 0
        ExplicitLeft = 40
        ExplicitTop = 64
        ExplicitWidth = 185
        ExplicitHeight = 41
      end
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 0
    Width = 467
    Height = 346
    Align = alClient
    Caption = 'pnlGrid'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object strTransaction: TStringGrid
      Left = 1
      Top = 1
      Width = 465
      Height = 303
      Align = alClient
      FixedCols = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      ParentFont = False
      TabOrder = 0
      OnClick = strTransactionClick
      ExplicitHeight = 309
    end
    object grpFoot: TGroupBox
      Left = 1
      Top = 304
      Width = 465
      Height = 41
      Align = alBottom
      Caption = 'Typ'
      TabOrder = 1
      object chbExpense: TCheckBox
        Left = 79
        Top = 17
        Width = 58
        Height = 17
        Caption = 'Wydatki'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        OnClick = chbExpenseClick
      end
      object chbImpact: TCheckBox
        Left = 3
        Top = 17
        Width = 57
        Height = 17
        Caption = 'Wp'#322'ywy'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
        OnClick = chbExpenseClick
      end
    end
  end
end
