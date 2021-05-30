object Frame1: TFrame1
  Left = 0
  Top = 0
  Width = 630
  Height = 364
  TabOrder = 0
  object StringGrid1: TStringGrid
    Left = 0
    Top = 64
    Width = 320
    Height = 120
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 89
    Top = 0
    Width = 541
    Height = 364
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    ExplicitLeft = 87
    object StringGrid2: TStringGrid
      Left = 1
      Top = 1
      Width = 539
      Height = 362
      Align = alClient
      TabOrder = 0
      ExplicitLeft = -2
      ExplicitTop = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 89
    Height = 364
    Align = alLeft
    Caption = 'Panel2'
    TabOrder = 2
    object btnAdd: TButton
      Left = 6
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Dodaj'
      TabOrder = 0
    end
    object btnRemove: TButton
      Left = 6
      Top = 67
      Width = 75
      Height = 25
      Caption = 'Usu'#324
      TabOrder = 1
    end
    object btnEdit: TButton
      Left = 6
      Top = 36
      Width = 75
      Height = 25
      Caption = 'Edytuj'
      TabOrder = 2
    end
  end
end
