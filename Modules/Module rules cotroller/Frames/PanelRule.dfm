object frmRule: TfrmRule
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 651
  Height = 166
  Margins.Left = 10
  Margins.Top = 10
  Margins.Right = 10
  Margins.Bottom = 10
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  object Label2: TLabel
    Left = 9
    Top = 19
    Width = 50
    Height = 13
    Caption = 'Kategoria:'
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 41
    Width = 365
    Height = 122
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Regu'#322'a'
    TabOrder = 2
    object Label1: TLabel
      Left = 215
      Top = 50
      Width = 6
      Height = 13
      Caption = 'a'
    end
    object Label3: TLabel
      Left = 215
      Top = 70
      Width = 6
      Height = 13
      Caption = 'a'
    end
    object chbTitleContains: TCheckBox
      Left = 9
      Top = 23
      Width = 97
      Height = 17
      Caption = 'Tytu'#322' zawiera:'
      TabOrder = 1
      OnClick = chbTitleContainsClick
    end
    object edtTitleContains: TEdit
      Left = 112
      Top = 19
      Width = 121
      Height = 21
      TabOrder = 0
      OnChange = edtTitleContainsChange
    end
    object chbDateBetween: TCheckBox
      Left = 9
      Top = 46
      Width = 97
      Height = 17
      Caption = 'Data pomi'#281'dzy:'
      TabOrder = 4
      OnClick = chbDateBetweenClick
    end
    object dtpFromDate: TDateTimePicker
      Left = 112
      Top = 43
      Width = 97
      Height = 21
      Date = 44344.000000000000000000
      Time = 0.655671111111587400
      TabOrder = 2
      OnChange = dtpFromDateChange
    end
    object dtpToDate: TDateTimePicker
      Left = 227
      Top = 44
      Width = 100
      Height = 21
      Date = 44344.000000000000000000
      Time = 0.656119016202865200
      TabOrder = 3
      OnChange = dtpToDateChange
    end
    object chbPrice: TCheckBox
      Left = 9
      Top = 69
      Width = 97
      Height = 17
      Caption = 'Kwota pomi'#281'dzy: '
      TabOrder = 5
      OnClick = chbPriceClick
    end
    object edtPriceLow: TEdit
      Left = 112
      Top = 69
      Width = 97
      Height = 21
      NumbersOnly = True
      TabOrder = 6
      Text = '0'
      OnChange = edtPriceLowChange
    end
    object edtPriceMax: TEdit
      Left = 227
      Top = 69
      Width = 100
      Height = 21
      NumbersOnly = True
      TabOrder = 7
      Text = '0'
      OnChange = edtPriceMaxChange
    end
  end
  object cmbCategories: TComboBox
    Left = 65
    Top = 14
    Width = 168
    Height = 21
    Style = csDropDownList
    TabOrder = 1
    OnChange = cmbCategoriesChange
  end
  object mmoConditionsVisualizer: TMemo
    Left = 371
    Top = 0
    Width = 280
    Height = 166
    Align = alRight
    Lines.Strings = (
      '')
    TabOrder = 0
  end
end
