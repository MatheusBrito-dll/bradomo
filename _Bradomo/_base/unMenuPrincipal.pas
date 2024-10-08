unit unMenuPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.WebBrowser, FMX.StdCtrls, FMX.Layouts,
  FMX.ImgList, System.ImageList, FMX.Objects, FMX.Ani,
  unControleDeMesa;

type
  TfrmMenuPrincipal = class(TForm)
    LayoutMenu: TLayout;
    recAppBar: TRectangle;
    recSideBar: TRectangle;
    recPainelVisu: TRectangle;
    recBuscar: TRectangle;
    Image2: TImage;
    Label1: TLabel;
    imgS: TImageList;
    Glyph1: TGlyph;
    btnMenuPequeno: TRectangle;
    recABtutton: TRectangle;
    MenuAnamation: TRectangle;
    recDButton: TRectangle;
    recCButton: TRectangle;
    recBButton: TRectangle;
    btnConfiguracao: TSpeedButton;
    btnPrivacidade: TSpeedButton;
    btnAssinatura: TSpeedButton;
    btnSair: TSpeedButton;
    anmConfiguracao: TFloatAnimation;
    anmPrivacidade: TFloatAnimation;
    anmAssinatura: TFloatAnimation;
    anmAjuda: TFloatAnimation;
    recLogo: TRectangle;
    lblLogo: TLabel;
    StyleBook1: TStyleBook;
    Image1: TImage;
    btnEntradas: TRectangle;
    Label3: TLabel;
    imgIcons: TImageList;
    Glyph2: TGlyph;
    btnRelatorios: TRectangle;
    Label2: TLabel;
    Glyph3: TGlyph;
    btnEstoque: TRectangle;
    Label4: TLabel;
    Glyph4: TGlyph;
    btnDevolucao: TRectangle;
    Label5: TLabel;
    Glyph5: TGlyph;
    btnFornecedores: TRectangle;
    Label6: TLabel;
    Glyph6: TGlyph;
    btnClientes: TRectangle;
    Label7: TLabel;
    Glyph7: TGlyph;
    btnDescontos: TRectangle;
    Label8: TLabel;
    Glyph8: TGlyph;
    btnSaidas: TRectangle;
    Label9: TLabel;
    Glyph9: TGlyph;
    btnFaturamento: TRectangle;
    Label10: TLabel;
    Glyph10: TGlyph;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation3: TFloatAnimation;
    FloatAnimation4: TFloatAnimation;
    FloatAnimation5: TFloatAnimation;
    FloatAnimation6: TFloatAnimation;
    FloatAnimation7: TFloatAnimation;
    FloatAnimation8: TFloatAnimation;
    FloatAnimation9: TFloatAnimation;
    VertScrollBox1: TVertScrollBox;
    recAVenda: TRectangle;
    recAHome: TRectangle;
    Image3: TImage;
    Image4: TImage;
    Label11: TLabel;
    Label12: TLabel;
    FloatAnimation10: TFloatAnimation;
    Timer1: TTimer;
    btnMesas: TRectangle;
    Label13: TLabel;
    Glyph11: TGlyph;
    FloatAnimation11: TFloatAnimation;
    procedure btnMenuPequenoClick(Sender: TObject);
    procedure anmConfiguracaoFinish(Sender: TObject);
    procedure anmPrivacidadeFinish(Sender: TObject);
    procedure anmAssinaturaFinish(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure anmAjudaFinish(Sender: TObject);
    procedure btnEstoqueMouseEnter(Sender: TObject);
    procedure btnEstoqueMouseLeave(Sender: TObject);
    procedure btnEntradasMouseEnter(Sender: TObject);
    procedure btnEntradasMouseLeave(Sender: TObject);
    procedure btnSaidasMouseEnter(Sender: TObject);
    procedure btnSaidasMouseLeave(Sender: TObject);
    procedure btnDescontosMouseEnter(Sender: TObject);
    procedure btnDescontosMouseLeave(Sender: TObject);
    procedure btnFaturamentoMouseEnter(Sender: TObject);
    procedure btnFaturamentoMouseLeave(Sender: TObject);
    procedure btnClientesMouseEnter(Sender: TObject);
    procedure btnClientesMouseLeave(Sender: TObject);
    procedure btnFornecedoresMouseEnter(Sender: TObject);
    procedure btnFornecedoresMouseLeave(Sender: TObject);
    procedure btnDevolucaoMouseEnter(Sender: TObject);
    procedure btnDevolucaoMouseLeave(Sender: TObject);
    procedure btnRelatoriosMouseEnter(Sender: TObject);
    procedure btnRelatoriosMouseLeave(Sender: TObject);
    procedure recAHomeMouseEnter(Sender: TObject);
    procedure recAHomeMouseLeave(Sender: TObject);
    procedure recAVendaMouseEnter(Sender: TObject);
    procedure recAVendaMouseLeave(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnMesasMouseEnter(Sender: TObject);
    procedure btnMesasMouseLeave(Sender: TObject);
    procedure btnMesasClick(Sender: TObject);
    procedure recAHomeClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);

  private

    frmControleDeMesa: TfrmControleDeMesa;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenuPrincipal: TfrmMenuPrincipal;

implementation


{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}
{$R *.Surface.fmx MSWINDOWS}


procedure TfrmMenuPrincipal.btnMesasClick(Sender: TObject);
begin

  try
    FreeAndNil(frmControleDeMesa);
  except
    // Ignora erros
  end;

 frmControleDeMesa := TfrmControleDeMesa.Create(nil);
 frmControleDeMesa.recPrincipal.Parent := recPainelVisu;

 VertScrollBox1.Visible := false;
end;

//ENFEITES BORT�ES--------------------------------------------------------------
{
  PARA CRIAR UM NOVO BOT�O NO MENU SIGA ESSES PASSOS
  1 - CRIE O BOT�O COMO OS OUTRO (COPIAR COLAR)
  2 - RENOMEIOS E SO MUDE O FLOATINGANAMATION PARA O ULTIMO NUMERO DISPONIVEL
  3 - NO FORMCREATE DEFINE A DURATION DAS ANIMATIONS
}

procedure TfrmMenuPrincipal.FormCreate(Sender: TObject);
begin
  btnConfiguracao .Height := 0;
  btnPrivacidade  .Height := 0;
  btnAssinatura   .Height := 0;
  btnSair         .Height := 0;

  FloatAnimation1 .Duration := 0.5;
  FloatAnimation2 .Duration := 0.5;
  FloatAnimation3 .Duration := 0.5;
  FloatAnimation4 .Duration := 0.5;
  FloatAnimation5 .Duration := 0.5;
  FloatAnimation6 .Duration := 0.5;
  FloatAnimation7 .Duration := 0.5;
  FloatAnimation8 .Duration := 0.5;
  FloatAnimation9 .Duration := 0.5;
  FloatAnimation11 .Duration := 0.5;

  Timer1.Enabled := True;
end;

procedure TfrmMenuPrincipal.btnEstoqueMouseEnter(Sender: TObject);
begin
  btnEstoque.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation1.Inverse := False;
  FloatAnimation1.Start;
end;

procedure TfrmMenuPrincipal.btnEstoqueMouseLeave(Sender: TObject);
begin
  btnEstoque.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation1.Inverse := True;
  FloatAnimation1.Start;
end;

procedure TfrmMenuPrincipal.btnRelatoriosMouseEnter(Sender: TObject);
begin
  btnRelatorios.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation9.Inverse := false;
  FloatAnimation9.Start;
end;

procedure TfrmMenuPrincipal.btnRelatoriosMouseLeave(Sender: TObject);
begin
  btnRelatorios.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation9.Inverse := True;
  FloatAnimation9.Start;
end;

procedure TfrmMenuPrincipal.btnEntradasMouseEnter(Sender: TObject);
begin
  btnEntradas.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation2.Inverse := False;
  FloatAnimation2.Start;
end;

procedure TfrmMenuPrincipal.btnEntradasMouseLeave(Sender: TObject);
begin
  btnEntradas.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation2.Inverse := True;
  FloatAnimation2.Start;
end;


procedure TfrmMenuPrincipal.btnSaidasMouseEnter(Sender: TObject);
begin
  btnSaidas.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation3.Inverse := False;
  FloatAnimation3.Start;
end;

procedure TfrmMenuPrincipal.btnSaidasMouseLeave(Sender: TObject);
begin
  btnSaidas.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation3.Inverse := True;
  FloatAnimation3.Start;
end;

procedure TfrmMenuPrincipal.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMenuPrincipal.btnDescontosMouseEnter(Sender: TObject);
begin
  btnDescontos.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation4.Inverse := False;
  FloatAnimation4.Start;
end;

procedure TfrmMenuPrincipal.btnDescontosMouseLeave(Sender: TObject);
begin
  btnDescontos.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation4.Inverse := True;
  FloatAnimation4.Start;
end;

procedure TfrmMenuPrincipal.btnClientesMouseEnter(Sender: TObject);
begin
  btnClientes.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation6.Inverse := False;
  FloatAnimation6.Start;
end;

procedure TfrmMenuPrincipal.btnClientesMouseLeave(Sender: TObject);
begin
  btnClientes.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation6.Inverse := True;
  FloatAnimation6.Start;
end;

procedure TfrmMenuPrincipal.btnFornecedoresMouseEnter(Sender: TObject);
begin
  btnFornecedores.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation7.Inverse := False;
  FloatAnimation7.Start;
end;

procedure TfrmMenuPrincipal.btnFornecedoresMouseLeave(Sender: TObject);
begin
  btnFornecedores.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation7.Inverse := True;
  FloatAnimation7.Start;
end;

procedure TfrmMenuPrincipal.btnDevolucaoMouseEnter(Sender: TObject);
begin
  btnDevolucao.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation8.Inverse := false;
  FloatAnimation8.Start;
end;

procedure TfrmMenuPrincipal.btnDevolucaoMouseLeave(Sender: TObject);
begin
  btnDevolucao.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation8.Inverse := True;
  FloatAnimation8.Start;
end;

procedure TfrmMenuPrincipal.btnFaturamentoMouseEnter(Sender: TObject);
begin
  btnFaturamento.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation5.Inverse := False;
  FloatAnimation5.Start;
end;

procedure TfrmMenuPrincipal.btnFaturamentoMouseLeave(Sender: TObject);
begin
  btnFaturamento.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation5.Inverse := True;
  FloatAnimation5.Start;
end;

procedure TfrmMenuPrincipal.btnMesasMouseEnter(Sender: TObject);
begin
  btnMesas.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation11.Inverse := False;
  FloatAnimation11.Start;
end;

procedure TfrmMenuPrincipal.btnMesasMouseLeave(Sender: TObject);
begin
  btnMesas.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation11.Inverse := True;
  FloatAnimation11.Start;
end;

procedure TfrmMenuPrincipal.recAHomeClick(Sender: TObject);
var
  i: Integer;
begin
  VertScrollBox1.Visible := True;

  // Verifica se h� controles filhos em recPainelVisu
  if recPainelVisu.ControlsCount > 0 then
  begin
    // Loop reverso para garantir que os controles sejam removidos corretamente
    for i := recPainelVisu.ControlsCount - 1 downto 0 do
    begin
      // Verifica se o controle atual � um TRectangle
      if recPainelVisu.Controls[i] is TRectangle then
      begin
        // Define o parent do TRectangle como nil para remover a refer�ncia ao formul�rio
        TRectangle(recPainelVisu.Controls[i]).Parent := nil;
      end;
    end;
  end;

  // Destroi os formul�rios que eram pais dos TRectangles
  for i := 0 to Screen.FormCount - 1 do
  begin
    // Verifica se o formul�rio � uma inst�ncia de TForm
    if Screen.Forms[i] is TForm then
    begin
      // Verifica se o parent do formul�rio � recPainelVisu
      if (Screen.Forms[i].Parent = recPainelVisu) then
      begin
        // Destr�i o formul�rio
        Screen.Forms[i].Free;
      end;
    end;
  end;
end;


procedure TfrmMenuPrincipal.recAHomeMouseEnter(Sender: TObject);
begin
  recAHome.Fill.Color := TAlphaColor($FF676767);
end;

procedure TfrmMenuPrincipal.recAHomeMouseLeave(Sender: TObject);
begin
  recAHome.Fill.Color := TAlphaColor($FF9E9E9E);
end;

procedure TfrmMenuPrincipal.recAVendaMouseEnter(Sender: TObject);
begin
  recAVenda.Fill.Color := TAlphaColor($FF004964);
end;

procedure TfrmMenuPrincipal.recAVendaMouseLeave(Sender: TObject);
begin
  recAVenda.Fill.Color := TAlphaColor($FF017CA9);
end;

procedure TfrmMenuPrincipal.Timer1Timer(Sender: TObject);
begin
  FloatAnimation10.Start;
end;

procedure TfrmMenuPrincipal.btnMenuPequenoClick(Sender: TObject);
begin
  if Glyph1.ImageIndex = 0 then
  begin

    anmConfiguracao .Duration := 0.1;
    anmPrivacidade  .Duration := 0.1;
    anmAssinatura   .Duration := 0.2;
    anmAjuda        .Duration := 0.3;

    anmConfiguracao.Inverse   := False;
    anmPrivacidade.Inverse    := False;
    anmAssinatura.Inverse     := False;
    anmAjuda.Inverse          := False;

    MenuAnamation.Visible     := True;
    Glyph1.ImageIndex         := 1;

    anmConfiguracao.Start;

  end else
  begin

    anmConfiguracao.Inverse   := True;
    anmPrivacidade.Inverse    := True;
    anmAssinatura.Inverse     := True;
    anmAjuda.Inverse          := True;

    Glyph1.ImageIndex         := 0;

    anmAjuda.Start;

  end;
end;

procedure TfrmMenuPrincipal.anmConfiguracaoFinish(Sender: TObject);
begin
  if not (Glyph1.ImageIndex = 0) then
  begin
    anmPrivacidade.Start;
  end else
  begin
    MenuAnamation.Visible := False;
  end;
end;

procedure TfrmMenuPrincipal.anmPrivacidadeFinish(Sender: TObject);
begin
  if Glyph1.ImageIndex = 0 then
  begin
    anmConfiguracao.Start;
  end else
  begin
    anmAssinatura.Start;
  end;
end;

procedure TfrmMenuPrincipal.anmAssinaturaFinish(Sender: TObject);
begin
  if Glyph1.ImageIndex = 0 then
  begin
    anmPrivacidade.Start;
  end else
  begin
    anmAjuda.Start;
  end;
end;

procedure TfrmMenuPrincipal.anmAjudaFinish(Sender: TObject);
begin
  if Glyph1.ImageIndex = 0 then
  begin
    anmAssinatura.Start;
  end;
end;
//------------------------------------------------------------------------------

end.
