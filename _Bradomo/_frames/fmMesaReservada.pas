unit fmMesaReservada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, System.ImageList, FMX.ImgList;

type
  TframeMesaReservada = class(TFrame)
    Rectangle1: TRectangle;
    Glyph1: TGlyph;
    ImageList1: TImageList;
    Label1: TLabel;
    Rectangle2: TRectangle;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
