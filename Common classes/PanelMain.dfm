object frmTransactionList: TfrmTransactionList
  Left = 0
  Top = 0
  Width = 321
  Height = 138
  TabOrder = 0
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 321
    Height = 138
    Align = alClient
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = butShowCategories
        Row = 1
      end
      item
        Column = 0
        Control = btnRules
        Row = 2
      end
      item
        Column = 0
        Control = btnAnalyze
        Row = 0
      end
      item
        Column = 0
        Control = btnSettings
        Row = 3
      end>
    RowCollection = <
      item
        Value = 25.126190104870190000
      end
      item
        Value = 25.126190104870190000
      end
      item
        Value = 24.747691315901570000
      end
      item
        Value = 24.999928474358060000
      end>
    TabOrder = 0
    DesignSize = (
      321
      138)
    object butShowCategories: TButton
      Left = 105
      Top = 37
      Width = 111
      Height = 30
      Anchors = [akTop, akBottom]
      Caption = 'Kategorie'
      TabOrder = 1
      OnClick = butShowCategoriesClick
    end
    object btnRules: TButton
      Left = 105
      Top = 71
      Width = 111
      Height = 30
      Anchors = [akTop, akBottom]
      Caption = 'Zasady'
      TabOrder = 2
      OnClick = btnRulesClick
    end
    object btnAnalyze: TButton
      Left = 105
      Top = 3
      Width = 111
      Height = 30
      Anchors = [akTop, akBottom]
      Caption = 'Transakcje'
      TabOrder = 0
      OnClick = btnAnalyzeClick
    end
    object btnSettings: TButton
      Left = 105
      Top = 105
      Width = 111
      Height = 30
      Action = actBtnSettings
      Anchors = [akTop, akBottom]
      TabOrder = 3
    end
  end
  object ofdOpenTransactionFile: TOpenTextFileDialog
    DefaultExt = '*.xml'
    Left = 400
    Top = 16
  end
  object actlstButtons: TActionList
    Left = 144
    Top = 56
    object actBtnSettings: TAction
      Caption = '&Ustawienia'
      OnExecute = actBtnSettingsExecute
      OnUpdate = actBtnSettingsUpdate
    end
  end
end
