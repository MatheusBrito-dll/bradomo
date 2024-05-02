unit fmControledeMesas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, System.ImageList, FMX.ImgList, FMX.Controls.Presentation,
  FMX.Edit, FMX.EditBox, FMX.SpinBox,
  uApi, System.JSON, unGlobal;

type
  TFrameControleDeMesa = class(TFrame)
    ListaMesas: TImageList;
    Rectangle1: TRectangle;
    Glyph1: TGlyph;
    RecFundo: TRectangle;
    btnCancelar: TSpeedButton;
    ListaIcons: TImageList;
    CheckAtivo: TCheckBox;
    CheckDefeito: TCheckBox;
    btnExcluir: TSpeedButton;
    btnSalvarEditar: TSpeedButton;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    lblNumeroMesa: TLabel;
    Rectangle6: TRectangle;
    lblCapacidade: TLabel;
    SpinCapacidade: TSpinBox;
    lblLocal: TLabel;
    Rectangle2: TRectangle;
  private
    FTextoControle: string;
    { Private declarations }
  public

    idMesa, DadosMesa : String;
    status : Integer;

    property TextoControle: string read FTextoControle write FTextoControle;
    { Public declarations }
  end;

implementation

{$R *.fmx}


end.
