object frmTransactionAnalyzerSettings: TfrmTransactionAnalyzerSettings
  Left = 0
  Top = 0
  Width = 623
  Height = 282
  TabOrder = 0
  object GridPanel1: TGridPanel
    Left = 0
    Top = 0
    Width = 623
    Height = 282
    Align = alClient
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = GroupBox1
        Row = 0
      end
      item
        Column = 0
        Control = GroupBox2
        Row = 1
      end>
    RowCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    TabOrder = 0
    ExplicitWidth = 320
    ExplicitHeight = 240
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 621
      Height = 140
      Align = alClient
      Caption = 'GroupBox1'
      TabOrder = 0
      ExplicitTop = -5
      ExplicitWidth = 826
      ExplicitHeight = 291
      DesignSize = (
        621
        140)
      object Label1: TLabel
        Left = 213
        Top = 53
        Width = 6
        Height = 13
        Caption = 'a'
      end
      object chbTitleContains: TCheckBox
        Left = 16
        Top = 26
        Width = 97
        Height = 17
        Caption = 'Tytu'#322' zawiera:'
        TabOrder = 0
        OnClick = chbTitleContainsClick
      end
      object edtTitleContains: TEdit
        Left = 110
        Top = 22
        Width = 121
        Height = 21
        TabOrder = 1
        OnChange = edtTitleContainsChange
      end
      object chbDateBetween: TCheckBox
        Left = 16
        Top = 49
        Width = 97
        Height = 17
        Caption = 'Data pomi'#281'dzy:'
        TabOrder = 2
        OnClick = chbDateBetweenClick
      end
      object dtpFromDate: TDateTimePicker
        Left = 110
        Top = 49
        Width = 97
        Height = 21
        Date = 44344.000000000000000000
        Time = 0.655671111111587400
        TabOrder = 3
        OnChange = dtpFromDateChange
      end
      object dtpToDate: TDateTimePicker
        Left = 225
        Top = 49
        Width = 100
        Height = 21
        Date = 44344.000000000000000000
        Time = 0.656119016202865200
        TabOrder = 4
        OnChange = dtpToDateChange
      end
      object mmoConditionsVisualizer: TMemo
        Left = 358
        Top = 14
        Width = 260
        Height = 120
        Anchors = [akLeft, akTop, akRight, akBottom]
        Lines.Strings = (
          '')
        TabOrder = 5
        ExplicitWidth = 465
        ExplicitHeight = 271
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 141
      Width = 621
      Height = 140
      Align = alClient
      Caption = 'GroupBox2'
      TabOrder = 1
      ExplicitTop = 120
      ExplicitWidth = 318
      ExplicitHeight = 119
    end
  end
end
