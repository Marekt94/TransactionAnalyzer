inherited FrmTransactionAnalyzerBoosted2: TFrmTransactionAnalyzerBoosted2
  inherited pnlDescription: TPanel
    inherited grpDescription: TGroupBox
      inherited lblDescription: TLabel
        Width = 266
        Height = 58
      end
    end
  end
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
          OnMouseUp = strTransactionMouseUp
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
  inline frmCategories: TfrmCategories [2]
    Left = 0
    Top = 29
    Width = 137
    Height = 317
    Align = alLeft
    TabOrder = 2
    ExplicitTop = 29
    ExplicitWidth = 137
    ExplicitHeight = 317
    inherited grpFilter: TGroupBox
      Width = 137
      Height = 317
      ExplicitWidth = 137
      ExplicitHeight = 317
    end
  end
  inherited ToolBar1: TToolBar [3]
    ButtonHeight = 21
    ButtonWidth = 59
    TabOrder = 3
  end
  inherited MainMenu1: TMainMenu [4]
    inherited mmTransactions: TMenuItem
      object mmLoadFromDB: TMenuItem
        Action = aLoadFromDB
      end
    end
  end
  inherited aActions: TActionList
    inherited aWczytaj: TAction
      OnExecute = aWczytajExecute
    end
    inherited aSaveToDB: TAction
      OnExecute = aSaveToDBExecute
      OnUpdate = aSaveToDBUpdate
    end
    object aLoadFromDB: TAction
      Caption = 'W&czytaj z bazy danych'
      OnExecute = aLoadFromDBExecute
      OnUpdate = aLoadFromDBUpdate
    end
    object aAddRule: TAction
      Caption = '&Dodaj regu'#322#281' na podstawie transakcji i przeanalizuj'
      OnExecute = aAddRuleExecute
    end
  end
  object ofdTransactions: TOpenTextFileDialog
    Filter = 'Transactions|*.xml'
    Left = 711
    Top = 184
  end
  object pmTransactionRightClick: TPopupMenu
    Left = 96
    Top = 152
    object pmAddRule: TMenuItem
      Action = aAddRule
    end
  end
end
