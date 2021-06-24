object FrmTransactionAnalyzerBoosted: TFrmTransactionAnalyzerBoosted
  Left = 0
  Top = 0
  Width = 824
  Height = 240
  TabOrder = 0
  object pnlFilter: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 240
    Align = alLeft
    TabOrder = 0
  end
  inline frmTrnsactionsList: TfrmTransasctionsList
    Left = 185
    Top = 0
    Width = 639
    Height = 240
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 185
    ExplicitWidth = 639
    ExplicitHeight = 240
    inherited pnlDescription: TPanel
      Left = 367
      ExplicitLeft = 367
    end
    inherited pnlGrid: TPanel
      Width = 367
      ExplicitWidth = 367
      inherited strTransaction: TStringGrid
        Width = 365
        ExplicitWidth = 365
      end
    end
  end
  object ofdTransactions: TOpenTextFileDialog
    Filter = 'Transactions|*.xml'
    Left = 744
    Top = 184
  end
end
