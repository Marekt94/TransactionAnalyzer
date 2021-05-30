object frmRule: TfrmRule
  Left = 0
  Top = 0
  Width = 623
  Height = 282
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 623
    Height = 282
    Align = alClient
    Caption = 'Regu'#322'a'
    TabOrder = 0
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 621
    ExplicitHeight = 140
    DesignSize = (
      623
      282)
    object Label1: TLabel
      Left = 215
      Top = 98
      Width = 6
      Height = 13
      Caption = 'a'
    end
    object Label2: TLabel
      Left = 32
      Top = 19
      Width = 50
      Height = 13
      Caption = 'Kategoria:'
    end
    object chbTitleContains: TCheckBox
      Left = 9
      Top = 71
      Width = 97
      Height = 17
      Caption = 'Tytu'#322' zawiera:'
      TabOrder = 0
      OnClick = chbTitleContainsClick
    end
    object edtTitleContains: TEdit
      Left = 112
      Top = 67
      Width = 121
      Height = 21
      TabOrder = 1
      OnChange = edtTitleContainsChange
    end
    object chbDateBetween: TCheckBox
      Left = 9
      Top = 94
      Width = 97
      Height = 17
      Caption = 'Data pomi'#281'dzy:'
      TabOrder = 2
      OnClick = chbDateBetweenClick
    end
    object dtpFromDate: TDateTimePicker
      Left = 112
      Top = 94
      Width = 97
      Height = 21
      Date = 44344.000000000000000000
      Time = 0.655671111111587400
      TabOrder = 3
      OnChange = dtpFromDateChange
    end
    object dtpToDate: TDateTimePicker
      Left = 227
      Top = 94
      Width = 100
      Height = 21
      Date = 44344.000000000000000000
      Time = 0.656119016202865200
      TabOrder = 4
      OnChange = dtpToDateChange
    end
    object mmoConditionsVisualizer: TMemo
      Left = 356
      Top = 11
      Width = 262
      Height = 264
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        '')
      TabOrder = 5
    end
    object cmbCategories: TComboBox
      Left = 112
      Top = 14
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 6
      OnChange = cmbCategoriesChange
    end
  end
end
