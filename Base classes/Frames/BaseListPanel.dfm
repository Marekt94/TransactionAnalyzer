object FrmBaseListPanel: TFrmBaseListPanel
  Left = 0
  Top = 0
  Width = 717
  Height = 436
  TabOrder = 0
  OnResize = FrameResize
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 137
    Height = 436
    Align = alLeft
    TabOrder = 0
    object btnAdd: TButton
      Left = 16
      Top = 8
      Width = 105
      Height = 25
      Caption = '&Dodaj'
      TabOrder = 0
      OnClick = btnAddClick
    end
    object btnEdit: TButton
      Left = 16
      Top = 39
      Width = 105
      Height = 25
      Caption = '&Edytuj'
      TabOrder = 1
      OnClick = btnEditClick
    end
    object btnDelete: TButton
      Left = 16
      Top = 70
      Width = 105
      Height = 25
      Caption = '&Usu'#324
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object btnXMLLoader: TButton
      Left = 16
      Top = 101
      Width = 105
      Height = 25
      Caption = '&Importuj'
      TabOrder = 3
      OnClick = btnXMLLoaderClick
    end
    object btnXMLSaver: TButton
      Left = 16
      Top = 132
      Width = 105
      Height = 25
      Caption = 'E&ksportuj'
      TabOrder = 4
      OnClick = btnXMLSaverClick
    end
  end
  object Panel2: TPanel
    Left = 137
    Top = 0
    Width = 580
    Height = 436
    Align = alClient
    Caption = 'Panel2'
    TabOrder = 1
    object strList: TStringGrid
      Left = 1
      Top = 1
      Width = 578
      Height = 434
      Align = alClient
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect]
      TabOrder = 0
    end
  end
  object ofdXML: TOpenTextFileDialog
    DefaultExt = '.xml'
    Filter = 'XML|*.xml'
    Left = 344
    Top = 208
  end
end
