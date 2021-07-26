object FrmTransactionAnalyzerBoosted: TFrmTransactionAnalyzerBoosted
  Left = 0
  Top = 0
  Width = 824
  Height = 240
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  ParentFont = False
  TabOrder = 0
  inline frmTrnsactionsList: TfrmTransasctionsList
    Left = 185
    Top = 0
    Width = 639
    Height = 240
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 185
    ExplicitWidth = 639
    ExplicitHeight = 240
    inherited pnlDescription: TPanel
      Left = 367
      Height = 240
      ExplicitLeft = 367
      ExplicitHeight = 240
      inherited grpDescription: TGroupBox
        Height = 77
        ExplicitLeft = 1
        ExplicitTop = 1
        ExplicitWidth = 270
        ExplicitHeight = 77
        inherited lblDescription: TLabel
          Height = 60
        end
      end
      inherited grpBilans: TGroupBox
        Top = 78
        ExplicitTop = 78
        inherited lblBilans: TLabel
          ExplicitTop = 15
        end
      end
    end
    inherited pnlGrid: TPanel
      Width = 367
      Height = 240
      ExplicitWidth = 367
      ExplicitHeight = 240
      inherited strTransaction: TStringGrid
        Width = 365
        Height = 197
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 365
        ExplicitHeight = 203
      end
      inherited grpFoot: TGroupBox
        Top = 198
        Width = 365
        ExplicitTop = 198
        ExplicitWidth = 365
      end
    end
  end
  object grpFilter: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 240
    Align = alLeft
    Caption = 'Kategorie'
    TabOrder = 1
    ExplicitTop = 72
    ExplicitHeight = 105
  end
  object ofdTransactions: TOpenTextFileDialog
    Filter = 'Transactions|*.xml'
    Left = 744
    Top = 184
  end
end
