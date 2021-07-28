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
        Height = 238
        ExplicitHeight = 238
        inherited lblDescription: TLabel
          Width = 266
          Height = 221
        end
      end
      inherited frmBilans: TfrmBilans
        Top = -1
        ExplicitLeft = 1
        ExplicitTop = -1
        inherited grpBilans: TGroupBox
          ExplicitWidth = 270
          inherited grdBilans: TGridPanel
            ExplicitWidth = 266
          end
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
        ExplicitWidth = 365
        ExplicitHeight = 197
      end
      inherited grpFoot: TGroupBox
        Top = 198
        Width = 365
        ExplicitTop = 198
        ExplicitWidth = 365
      end
    end
  end
  object pnlCateogries: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 240
    Align = alLeft
    TabOrder = 1
    object grpFilter: TGroupBox
      Left = 1
      Top = 1
      Width = 183
      Height = 203
      Align = alClient
      Caption = 'Kategorie'
      TabOrder = 0
    end
    object btnGraphically: TButton
      Left = 1
      Top = 204
      Width = 183
      Height = 35
      Align = alBottom
      Caption = 'Graficznie'
      TabOrder = 1
      OnClick = btnGraphicallyClick
    end
  end
  object ofdTransactions: TOpenTextFileDialog
    Filter = 'Transactions|*.xml'
    Left = 744
    Top = 184
  end
end
