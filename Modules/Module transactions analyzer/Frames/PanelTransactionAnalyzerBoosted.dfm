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
    Left = 153
    Top = 0
    Width = 671
    Height = 240
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 153
    ExplicitWidth = 671
    ExplicitHeight = 240
    inherited pnlDescription: TPanel
      Left = 399
      Height = 240
      ExplicitLeft = 399
      ExplicitHeight = 240
      inherited grpDescription: TGroupBox
        Height = 238
        ExplicitHeight = 238
        inherited lblDescription: TLabel
          Height = 221
        end
      end
      inherited frmBilans: TfrmBilans
        Top = -1
        ExplicitTop = -1
      end
    end
    inherited pnlGrid: TPanel
      Width = 399
      Height = 240
      ExplicitWidth = 399
      ExplicitHeight = 240
      inherited grpFoot: TGroupBox
        Top = 198
        Width = 397
        ExplicitTop = 198
        ExplicitWidth = 397
        DesignSize = (
          397
          41)
        inherited chbExpense: TCheckBox
          OnClick = frmTrnsactionsListchbImpactClick
        end
        inherited chbImpact: TCheckBox
          OnClick = frmTrnsactionsListchbImpactClick
        end
        inherited chbGraphically: TCheckBox
          Left = 316
          Visible = True
          OnClick = frmTrnsactionsListchbGraphicallyClick
          ExplicitLeft = 316
        end
      end
      inherited pgcTransactions: TPageControl
        Width = 397
        Height = 197
        ExplicitWidth = 397
        ExplicitHeight = 197
        inherited tabGrid: TTabSheet
          ExplicitWidth = 389
          ExplicitHeight = 169
          inherited strTransaction: TStringGrid
            Width = 389
            Height = 169
            OnDblClick = frmTrnsactionsListstrTransactionDblClick
            ExplicitWidth = 389
            ExplicitHeight = 169
          end
        end
        inherited tabChart: TTabSheet
          inherited frmTransactionInGraphic: TfrmTransactionsInGraphic
            inherited Chart1: TChart
              Title.Text.Strings = ()
            end
          end
        end
      end
    end
  end
  inline frmCategories: TfrmCategories
    Left = 0
    Top = 0
    Width = 153
    Height = 240
    Align = alLeft
    TabOrder = 1
    ExplicitWidth = 153
    inherited grpFilter: TGroupBox
      Width = 153
      ExplicitWidth = 153
    end
  end
  object ofdTransactions: TOpenTextFileDialog
    Filter = 'Transactions|*.xml'
    Left = 744
    Top = 184
  end
end
