object frmSettings: TfrmSettings
  Left = 0
  Top = 0
  Width = 457
  Height = 57
  TabOrder = 0
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 457
    Height = 57
    Align = alClient
    Caption = 'Ustawienia'
    TabOrder = 0
    ExplicitWidth = 320
    ExplicitHeight = 89
    DesignSize = (
      457
      57)
    object edtMainFolderPAth: TLabeledEdit
      Left = 88
      Top = 24
      Width = 274
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 75
      EditLabel.Height = 13
      EditLabel.Caption = 'Folder g'#322#243'wny: '
      LabelPosition = lpLeft
      TabOrder = 0
      ExplicitWidth = 121
    end
    object btnLoad: TButton
      Left = 368
      Top = 24
      Width = 75
      Height = 21
      Anchors = [akTop, akRight]
      Caption = 'Wybierz...'
      TabOrder = 1
      OnClick = btnLoadClick
      ExplicitLeft = 215
    end
  end
  object ofdMainFolderSelector: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 192
    Top = 24
  end
end
