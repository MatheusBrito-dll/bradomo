unit fmControledeMesas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, System.ImageList, FMX.ImgList, FMX.Controls.Presentation,
  FMX.Edit, FMX.EditBox, FMX.SpinBox;

type
  TFrameControleDeMesa = class(TFrame)
    ListaMesas: TImageList;
    Rectangle1: TRectangle;
    Glyph1: TGlyph;
    Rectangle2: TRectangle;
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
    procedure btnSalvarEditarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrameControleDeMesa.btnSalvarEditarClick(Sender: TObject);
begin
  if (btnSalvarEditar.Text = 'Editar') then btnSalvarEditar.Text := 'Salvar' else btnSalvarEditar.Text := 'Editar';

  CheckAtivo.Enabled     := NOT CheckAtivo.Enabled;
  CheckDefeito.Enabled   := NOT CheckDefeito.Enabled;

  btnExcluir.Enabled     := NOT btnExcluir.Enabled;
  btnCancelar.Enabled    := NOT btnCancelar.Enabled;

  lblCapacidade.Enabled  := NOT lblCapacidade.Enabled;
  SpinCapacidade.Enabled := NOT SpinCapacidade.Enabled;
end;

end.
