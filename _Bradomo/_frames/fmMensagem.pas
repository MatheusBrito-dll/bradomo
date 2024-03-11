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
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label1: TLabel;
    Rectangle3: TRectangle;
    lblAviso: TLabel;
    Label3: TLabel;
    recPrincipal: TRectangle;
    procedure Rectangle3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrameMensagem.Rectangle3Click(Sender: TObject);
begin
  FreeAndNil(self);
end;

end.
