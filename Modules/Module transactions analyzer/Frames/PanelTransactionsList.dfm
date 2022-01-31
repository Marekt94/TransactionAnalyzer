object frmTransasctionsList: TfrmTransasctionsList
  Left = 0
  Top = 0
  Width = 739
  Height = 346
  TabOrder = 0
  OnResize = FrameResize
  object pnlDescription: TPanel
    Left = 467
    Top = 29
    Width = 272
    Height = 317
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
      Height = 75
      Align = alClient
      Caption = 'Szczeg'#243#322'y transakcji'
      TabOrder = 0
      object lblDescription: TLabel
        Left = 2
        Top = 15
        Width = 266
        Height = 58
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
    inline frmBilans: TfrmBilans
      Left = 1
      Top = 76
      Width = 270
      Height = 240
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 76
      ExplicitWidth = 270
      inherited grpBilans: TGroupBox
        Width = 270
        ExplicitWidth = 270
        inherited grdBilans: TGridPanel
          Width = 266
          ExplicitWidth = 266
        end
      end
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 29
    Width = 467
    Height = 317
    Align = alClient
    Caption = 'pnlGrid'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object grpFoot: TGroupBox
      Left = 1
      Top = 275
      Width = 465
      Height = 41
      Align = alBottom
      Caption = 'Typ'
      TabOrder = 0
      DesignSize = (
        465
        41)
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
      object chbGraphically: TCheckBox
        Left = 384
        Top = 17
        Width = 77
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Graficznie'
        TabOrder = 2
        OnClick = chbGraphicallyClick
      end
    end
    object pgcTransactions: TPageControl
      Left = 1
      Top = 1
      Width = 465
      Height = 274
      ActivePage = tabGrid
      Align = alClient
      TabOrder = 1
      object tabGrid: TTabSheet
        Caption = 'tabGrid'
        object strTransaction: TStringGrid
          Left = 0
          Top = 0
          Width = 457
          Height = 246
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
        end
      end
      object tabChart: TTabSheet
        Caption = 'tabChart'
        ImageIndex = 1
        inline frmTransactionInGraphic: TfrmTransactionsInGraphic
          Left = 0
          Top = 0
          Width = 457
          Height = 246
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          ExplicitWidth = 457
          ExplicitHeight = 246
          inherited Chart1: TChart
            Width = 457
            Height = 246
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 457
            ExplicitHeight = 246
          end
        end
      end
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 739
    Height = 29
    ButtonHeight = 21
    ButtonWidth = 59
    Caption = 'ToolBar1'
    Menu = MainMenu1
    ShowCaptions = True
    TabOrder = 2
  end
  object MainMenu1: TMainMenu
    Left = 352
    Top = 160
    object mmTransactions: TMenuItem
      Caption = '&Transakcje'
      object mmLoad: TMenuItem
        Action = aWczytaj
        Caption = '&Wczytaj z pliku'
      end
    end
  end
  object aActions: TActionList
    Left = 352
    Top = 208
    object aWczytaj: TAction
      Caption = 'aWczytaj'
    end
  end
end
