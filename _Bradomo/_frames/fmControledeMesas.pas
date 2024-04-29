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
    procedure btnSalvarEditarClick(Sender: TObject);
  private
    FTextoControle: string;
    { Private declarations }
  public

    idMesa, DadosMesa : String;
    status : Integer;

    property TextoControle: string read FTextoControle write FTextoControle;
    procedure TerminateThreadMesa(Sender: TObject);
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrameControleDeMesa.btnSalvarEditarClick(Sender: TObject);
var
  Api : TApi;
  ThreadMesa : TTHread;
begin
  {
  if btnSalvarEditar.Text = 'Salvar' then
  begin
    ThreadMesa := TThread.CreateAnonymousThread(procedure
    begin
      Api := TApi.Create();
      DadosMesa := Api.PostAltMesas(idMesa, CodUsuario, CheckDefeito.IsChecked.ToInteger ,CheckAtivo.IsChecked.ToInteger, SpinCapacidade.Value.ToString.ToInteger);
    end);

    ThreadMesa.OnTerminate := TerminateThreadMesa;
    ThreadMesa.Start;
  end;

  if (btnSalvarEditar.Text = 'Editar') then btnSalvarEditar.Text := 'Salvar' else btnSalvarEditar.Text := 'Editar';

  CheckAtivo.Enabled     := NOT CheckAtivo.Enabled;
  CheckDefeito.Enabled   := NOT CheckDefeito.Enabled;

  btnExcluir.Enabled     := NOT btnExcluir.Enabled;
  btnCancelar.Enabled    := NOT btnCancelar.Enabled;

  lblCapacidade.Enabled  := NOT lblCapacidade.Enabled;
  SpinCapacidade.Enabled := NOT SpinCapacidade.Enabled;}
end;

procedure TFrameControleDeMesa.TerminateThreadMesa(Sender: TObject);
var
  Status        : String;
  //item          : TListBoxItem;
  frame         : TFrameControleDeMesa;
  JSONValue     : TJSONValue;
  JSONObject    : TJSONObject;
  JSONArray     : TJSONArray;
begin
{
  if (Pos('Erro', DadosMesa) > 0) then
  begin
    //
  end else
  begin
    //
  end;
  }
end;

end.
