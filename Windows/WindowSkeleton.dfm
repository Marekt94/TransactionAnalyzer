object WndSkeleton: TWndSkeleton
  Left = 0
  Top = 0
  Caption = 'WndSkeleton'
  ClientHeight = 424
  ClientWidth = 785
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 680
    Height = 360
    Align = alClient
    TabOrder = 0
    ExplicitLeft = -6
  end
  object pnlNavigation: TPanel
    Left = 680
    Top = 0
    Width = 105
    Height = 360
    Align = alRight
    TabOrder = 1
    ExplicitLeft = 400
    ExplicitHeight = 190
  end
  object pnlFooter: TPanel
    Left = 0
    Top = 360
    Width = 785
    Height = 64
    Align = alBottom
    TabOrder = 2
  end
end
