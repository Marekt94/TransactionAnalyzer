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
    Left = 137
    Top = 0
    Width = 687
    Height = 240
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 137
    ExplicitWidth = 687
    ExplicitHeight = 240
    inherited pnlDescription: TPanel
      Left = 415
      Height = 240
      ExplicitLeft = 367
      ExplicitHeight = 240
      inherited grpDescription: TGroupBox
        Height = 238
        ExplicitHeight = 238
      end
      inherited frmBilans: TfrmBilans
        Top = -1
        ExplicitTop = -1
      end
    end
    inherited pnlGrid: TPanel
      Width = 415
      Height = 240
      ExplicitWidth = 415
      ExplicitHeight = 240
      inherited grpFoot: TGroupBox
        Top = 198
        Width = 413
        ExplicitTop = 198
        ExplicitWidth = 365
        DesignSize = (
          413
          41)
        inherited chbExpense: TCheckBox
          OnClick = frmTrnsactionsListchbImpactClick
        end
        inherited chbImpact: TCheckBox
          OnClick = frmTrnsactionsListchbImpactClick
        end
        inherited chbGraphically: TCheckBox
          Left = 332
          Visible = True
          OnClick = frmTrnsactionsListchbGraphicallyClick
          ExplicitLeft = 284
        end
      end
      inherited pgcTransactions: TPageControl
        Width = 413
        Height = 197
        ExplicitWidth = 413
        ExplicitHeight = 197
        inherited tabGrid: TTabSheet
          ExplicitWidth = 357
          ExplicitHeight = 169
          inherited strTransaction: TStringGrid
            Width = 357
            Height = 169
            ExplicitWidth = 357
            ExplicitHeight = 169
          end
        end
        inherited tabChart: TTabSheet
          ExplicitWidth = 457
          ExplicitHeight = 275
          inherited frmTransactionInGraphic: TfrmTransactionsInGraphic
            Width = 405
            Height = 169
            ExplicitWidth = 357
            ExplicitHeight = 275
            inherited Chart1: TChart
              Width = 405
              Height = 169
              Title.Text.Strings = ()
              ExplicitWidth = 357
              ExplicitHeight = 275
            end
          end
        end
      end
    end
  end
  object grpFilter: TGroupBox
    Left = 0
    Top = 0
    Width = 137
    Height = 240
    Align = alLeft
    Caption = 'Kategorie'
    TabOrder = 1
  end
  object ofdTransactions: TOpenTextFileDialog
    Filter = 'Transactions|*.xml'
    Left = 744
    Top = 184
  end
end
