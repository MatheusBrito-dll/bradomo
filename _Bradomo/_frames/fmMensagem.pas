unit fmMensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation,
  FMX.Objects;

type
  TFrameMensagem = class(TFrame)
    recPrincipal2: TRectangle;
    recTitulo: TRectangle;
    recBordaCorpo: TRectangle;
    lblTitulo: TLabel;
    recOk: TRectangle;
    lblAviso: TLabel;
    Label3: TLabel;
    recPrincipal: TRectangle;
    procedure recOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrameMensagem.recOkClick(Sender: TObject);
begin
  FreeAndNil(self);
end;

end.
