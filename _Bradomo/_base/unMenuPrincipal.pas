unit unMenuPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.WebBrowser, FMX.StdCtrls, FMX.Layouts,
  FMX.ImgList, System.ImageList, FMX.Objects, FMX.Ani;

type
  TfrmMenuPrincipal = class(TForm)
    LayoutMenu: TLayout;
    recAppBar: TRectangle;
    recSideBar: TRectangle;
    recPainelVisu: TRectangle;
    imgBusca: TImage;
    recBuscar: TRectangle;
    edtBusca: TEdit;
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
    btnAjuda: TSpeedButton;
    anmConfiguracao: TFloatAnimation;
    anmPrivacidade: TFloatAnimation;
    anmAssinatura: TFloatAnimation;
    anmAjuda: TFloatAnimation;
    recLogo: TRectangle;
    lblLogo: TLabel;
    StyleBook1: TStyleBook;
    Image1: TImage;
    a: TRectangle;
    Label3: TLabel;
    imgIcons: TImageList;
    Glyph2: TGlyph;
    h: TRectangle;
    Label2: TLabel;
    Glyph3: TGlyph;
    g: TRectangle;
    Label4: TLabel;
    Glyph4: TGlyph;
    f: TRectangle;
    Label5: TLabel;
    Glyph5: TGlyph;
    e: TRectangle;
    Label6: TLabel;
    Glyph6: TGlyph;
    d: TRectangle;
    Label7: TLabel;
    Glyph7: TGlyph;
    c: TRectangle;
    Label8: TLabel;
    Glyph8: TGlyph;
    b: TRectangle;
    Label9: TLabel;
    Glyph9: TGlyph;
    i: TRectangle;
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
    StatusBar1: TStatusBar;
    Label11: TLabel;
    Label12: TLabel;
    FloatAnimation10: TFloatAnimation;
    Timer1: TTimer;
    procedure btnMenuPequenoClick(Sender: TObject);
    procedure anmConfiguracaoFinish(Sender: TObject);
    procedure anmPrivacidadeFinish(Sender: TObject);
    procedure anmAssinaturaFinish(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure anmAjudaFinish(Sender: TObject);
    procedure gMouseEnter(Sender: TObject);
    procedure gMouseLeave(Sender: TObject);
    procedure aMouseEnter(Sender: TObject);
    procedure aMouseLeave(Sender: TObject);
    procedure bMouseEnter(Sender: TObject);
    procedure bMouseLeave(Sender: TObject);
    procedure cMouseEnter(Sender: TObject);
    procedure cMouseLeave(Sender: TObject);
    procedure iMouseEnter(Sender: TObject);
    procedure iMouseLeave(Sender: TObject);
    procedure dMouseEnter(Sender: TObject);
    procedure dMouseLeave(Sender: TObject);
    procedure eMouseEnter(Sender: TObject);
    procedure eMouseLeave(Sender: TObject);
    procedure fMouseEnter(Sender: TObject);
    procedure fMouseLeave(Sender: TObject);
    procedure hMouseEnter(Sender: TObject);
    procedure hMouseLeave(Sender: TObject);
    procedure recAHomeMouseEnter(Sender: TObject);
    procedure recAHomeMouseLeave(Sender: TObject);
    procedure recAVendaMouseEnter(Sender: TObject);
    procedure recAVendaMouseLeave(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private
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

procedure TfrmMenuPrincipal.FormCreate(Sender: TObject);
begin
  btnConfiguracao .Height := 0;
  btnPrivacidade  .Height := 0;
  btnAssinatura   .Height := 0;
  btnAjuda        .Height := 0;

  FloatAnimation1 .Duration := 0.5;
  FloatAnimation2 .Duration := 0.5;
  FloatAnimation3 .Duration := 0.5;
  FloatAnimation4 .Duration := 0.5;
  FloatAnimation5 .Duration := 0.5;
  FloatAnimation6 .Duration := 0.5;
  FloatAnimation7 .Duration := 0.5;
  FloatAnimation8 .Duration := 0.5;
  FloatAnimation9 .Duration := 0.5;

  Timer1.Enabled := True;
end;

procedure TfrmMenuPrincipal.gMouseEnter(Sender: TObject);
begin
  g.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation1.Inverse := False;
  FloatAnimation1.Start;
end;

procedure TfrmMenuPrincipal.gMouseLeave(Sender: TObject);
begin
  g.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation1.Inverse := True;
  FloatAnimation1.Start;
end;

procedure TfrmMenuPrincipal.hMouseEnter(Sender: TObject);
begin
  h.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation9.Inverse := false;
  FloatAnimation9.Start;
end;

procedure TfrmMenuPrincipal.hMouseLeave(Sender: TObject);
begin
  h.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation9.Inverse := True;
  FloatAnimation9.Start;
end;

procedure TfrmMenuPrincipal.aMouseEnter(Sender: TObject);
begin
  a.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation2.Inverse := False;
  FloatAnimation2.Start;
end;

procedure TfrmMenuPrincipal.aMouseLeave(Sender: TObject);
begin
  a.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation2.Inverse := True;
  FloatAnimation2.Start;
end;


procedure TfrmMenuPrincipal.bMouseEnter(Sender: TObject);
begin
  b.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation3.Inverse := False;
  FloatAnimation3.Start;
end;

procedure TfrmMenuPrincipal.bMouseLeave(Sender: TObject);
begin
  b.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation3.Inverse := True;
  FloatAnimation3.Start;
end;

procedure TfrmMenuPrincipal.cMouseEnter(Sender: TObject);
begin
  c.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation4.Inverse := False;
  FloatAnimation4.Start;
end;

procedure TfrmMenuPrincipal.cMouseLeave(Sender: TObject);
begin
  c.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation4.Inverse := True;
  FloatAnimation4.Start;
end;

procedure TfrmMenuPrincipal.dMouseEnter(Sender: TObject);
begin
  d.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation6.Inverse := False;
  FloatAnimation6.Start;
end;

procedure TfrmMenuPrincipal.dMouseLeave(Sender: TObject);
begin
  d.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation6.Inverse := True;
  FloatAnimation6.Start;
end;

procedure TfrmMenuPrincipal.eMouseEnter(Sender: TObject);
begin
  e.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation7.Inverse := False;
  FloatAnimation7.Start;
end;

procedure TfrmMenuPrincipal.eMouseLeave(Sender: TObject);
begin
  e.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation7.Inverse := True;
  FloatAnimation7.Start;
end;

procedure TfrmMenuPrincipal.fMouseEnter(Sender: TObject);
begin
  f.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation8.Inverse := false;
  FloatAnimation8.Start;
end;

procedure TfrmMenuPrincipal.fMouseLeave(Sender: TObject);
begin
  f.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation8.Inverse := True;
  FloatAnimation8.Start;
end;

procedure TfrmMenuPrincipal.iMouseEnter(Sender: TObject);
begin
  i.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation5.Inverse := False;
  FloatAnimation5.Start;
end;

procedure TfrmMenuPrincipal.iMouseLeave(Sender: TObject);
begin
  i.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation4.Inverse := True;
  FloatAnimation4.Start;
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

end.
