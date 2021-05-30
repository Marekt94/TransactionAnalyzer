unit PanelRuleList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids;

type
  TFrame1 = class(TFrame)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    btnAdd: TButton;
    btnRemove: TButton;
    StringGrid2: TStringGrid;
    btnEdit: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
