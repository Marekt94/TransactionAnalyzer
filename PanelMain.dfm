object frmTransactionList: TfrmTransactionList
  Left = 0
  Top = 0
  Width = 354
  Height = 73
  TabOrder = 0
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 354
    Height = 73
    Align = alClient
    Caption = 'GridPanel1'
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
      end>
    RowCollection = <
      item
        Value = 33.501554856890690000
      end
      item
        Value = 33.501554856890690000
      end
      item
        Value = 32.996890286218630000
      end>
    TabOrder = 0
    DesignSize = (
      354
      73)
    object butShowCategories: TButton
      Left = 121
      Top = 24
      Width = 111
      Height = 23
      Anchors = []
      Caption = 'Kategorie'
      TabOrder = 0
      OnClick = butShowCategoriesClick
    end
    object btnRules: TButton
      Left = 121
      Top = 47
      Width = 111
      Height = 25
      Anchors = []
      Caption = 'Zasady'
      TabOrder = 1
      OnClick = btnRulesClick
    end
    object btnAnalyze: TButton
      Left = 121
      Top = 1
      Width = 111
      Height = 23
      Anchors = []
      Caption = 'Transakcje'
      TabOrder = 2
      OnClick = btnAnalyzeClick
    end
  end
  object ofdOpenTransactionFile: TOpenTextFileDialog
    DefaultExt = '*.xml'
    Left = 400
    Top = 16
  end
end
