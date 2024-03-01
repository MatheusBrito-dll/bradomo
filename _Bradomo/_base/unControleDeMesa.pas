unit unControleDeMesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  System.Skia, FMX.Skia, FMX.Ani;

type
  TfrmControleDeMesa = class(TForm)
    recPrincipal: TRectangle;
    recGerenciarMesas: TRectangle;
    recReservaAndVendas: TRectangle;
    Rectangle4: TRectangle;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    Image1: TImage;
    Image2: TImage;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    procedure FloatAnimation1Finish(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmControleDeMesa: TfrmControleDeMesa;

implementation

{$R *.fmx}

procedure TfrmControleDeMesa.FloatAnimation1Finish(Sender: TObject);
begin
    FloatAnimation2.Start;
end;

end.
