inherited FrmTransactionAnalyzerBoosted2: TFrmTransactionAnalyzerBoosted2
  inherited pnlGrid: TPanel
    Left = 137
    Width = 330
    ExplicitLeft = 137
    ExplicitWidth = 330
    inherited grpFoot: TGroupBox
      Width = 328
      ExplicitWidth = 328
      inherited chbGraphically: TCheckBox
        Left = 245
        ExplicitLeft = 245
      end
    end
    inherited pgcTransactions: TPageControl
      Width = 328
      ExplicitWidth = 328
      inherited tabGrid: TTabSheet
        ExplicitWidth = 320
        inherited strTransaction: TStringGrid
          Width = 320
          OnDblClick = strTransactionDblClick
          OnKeyUp = strTransactionKeyUp
          ExplicitWidth = 320
        end
      end
      inherited tabChart: TTabSheet
        ExplicitWidth = 320
        inherited frmTransactionInGraphic: TfrmTransactionsInGraphic
          Width = 320
          ExplicitWidth = 320
          inherited Chart1: TChart
            Width = 320
            ExplicitWidth = 320
          end
        end
      end
    end
  end
  inline frmCategories: TfrmCategories
    Left = 0
    Top = 0
    Width = 137
    Height = 346
    Align = alLeft
    TabOrder = 2
    ExplicitWidth = 137
    ExplicitHeight = 346
    inherited grpFilter: TGroupBox
      Width = 137
      Height = 346
      ExplicitWidth = 137
      ExplicitHeight = 346
    end
  end
  object ofdTransactions: TOpenTextFileDialog
    Filter = 'Transactions|*.xml'
    Left = 711
    Top = 184
  end
end
