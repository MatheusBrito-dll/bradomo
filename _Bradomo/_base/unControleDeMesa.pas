unit unControleDeMesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  System.JSON,
  fmControleDeMesas, uApi, unGLobal, fmAnimationLoading, fmMensagem,
  unCadastroDeMesa;
type
  TfrmControleDeMesa = class(TForm)
    recPrincipal: TRectangle;
    recGerenciarMesas: TRectangle;
    recReservaAndVendas: TRectangle;
    Rectangle4: TRectangle;
    //SkLabel1: TSkLabel;
    //SkLabel2: TSkLabel;
    Image1: TImage;
    Image2: TImage;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    VertScrollBox1: TVertScrollBox;
    recAdicionarMesa: TRectangle;
    Image3: TImage;
    FloatAnimation3: TFloatAnimation;
    Label5: TLabel;
    Label6: TLabel;
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure recGerenciarMesasMouseEnter(Sender: TObject);
    procedure recGerenciarMesasMouseLeave(Sender: TObject);
    procedure recReservaAndVendasMouseEnter(Sender: TObject);
    procedure recReservaAndVendasMouseLeave(Sender: TObject);
    procedure recGerenciarMesasClick(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure TerminateThreadMesa(Sender: TObject);
    procedure TerminateThreadMesaAlt(Sender: TObject);
    procedure LimparScrollBox(ScrollBox: TVertScrollBox);
    procedure GetMesas;
    procedure FormCreate(Sender: TObject);
    procedure recAdicionarMesaMouseEnter(Sender: TObject);
    procedure recAdicionarMesaMouseLeave(Sender: TObject);
    procedure FloatAnimation3Finish(Sender: TObject);
    procedure recAdicionarMesaClick(Sender: TObject);
  private

      DadosMesa : String;
      DadosMesaInsert : String;

      frameLoading : TFrameLoading;
      frameMensage : TFrameMensagem;
      frmCadastroDeMesa : TfrmCadastroDeMesa;

    procedure ClickMore2(Sender: TObject);

    { Private declarations }
  public
    continua : Boolean;
    { Public declarations }
  end;

var
  frmControleDeMesa: TfrmControleDeMesa;

implementation

{$R *.fmx}

procedure TfrmControleDeMesa.FormCreate(Sender: TObject);
begin
  recGerenciarMesas.Width   := 0;
  recReservaAndVendas.Width := 0;
  recAdicionarMesa.Width    := 0;

  FloatAnimation1.Duration := 0.1;
  FloatAnimation2.Duration := 0.1;
  FloatAnimation3.Duration := 0.1;
  FloatAnimation1.Start;

  Continua := True;

end;

procedure TfrmControleDeMesa.FloatAnimation1Finish(Sender: TObject);
begin
    if (continua) or (recReservaAndVendas.Width = 0) then
      FloatAnimation2.Start;
end;

procedure TfrmControleDeMesa.FloatAnimation2Finish(Sender: TObject);
begin

   if (continua) or (recAdicionarMesa.Width = 0) then
    FloatAnimation3.Start;
end;

procedure TfrmControleDeMesa.FloatAnimation3Finish(Sender: TObject);
begin
  FloatAnimation1.Duration := 0.2;
  FloatAnimation2.Duration := 0.2;
  FloatAnimation3.Duration := 0.2;
end;

procedure TfrmControleDeMesa.LimparScrollBox(ScrollBox: TVertScrollBox);
var
  i : integer;
begin
  try
    VertScrollBox1.BeginUpdate;
    for i := ScrollBox.Content.ChildrenCount - 1 downto 0 do
    begin
      if ScrollBox.Content.Children[i] is TFrame then
      begin
        TFrame(ScrollBox.Content.Children[i]).DisposeOf;
      end;
    end;
  finally
    VertScrollBox1.EndUpdate;
  end;
end;

procedure TfrmControleDeMesa.recAdicionarMesaClick(Sender: TObject);
begin
  LimparScrollBox(VertScrollBox1);
  frmCadastroDeMesa := TfrmCadastroDeMesa.Create(nil);
  frmCadastroDeMesa.recPrincipal.Parent := recPrincipal;
end;

procedure TfrmControleDeMesa.recAdicionarMesaMouseEnter(Sender: TObject);
begin
  recAdicionarMesa.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation3.StartValue := 360;
  FloatAnimation3.StopValue := 370;
  FloatAnimation3.Inverse := False;
  FloatAnimation3.Start;
end;

procedure TfrmControleDeMesa.recAdicionarMesaMouseLeave(Sender: TObject);
begin
  recAdicionarMesa.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation3.Inverse := True;
  FloatAnimation3.Start;
end;

procedure TfrmControleDeMesa.recGerenciarMesasClick(Sender: TObject);
begin

  GetMesas();

end;

procedure TfrmControleDeMesa.GetMesas;
var
  ThreadMesa : TTHread;
  Api        : TApi;
  //Nvl1       : TRecTangle;
  //Nvl2       : TLayout;
  //Nvl3       : TLayout;
  //Nvl4       : TForm;
begin

  //Nvl1 := recPrincipal.Parent as TRecTangle;
  //Nvl2 := Nvl1.Parent         as TLayout;
  //Nvl3 := Nvl2.Parent         as TLayout;
  //Nvl4 := Nvl3.Parent         as TForm;

  LimparScrollBox(VertScrollBox1);

  frameLoading := TFrameLoading.Create(nil);

  frameLoading.Rectangle1.Parent := recPrincipal;
  frameLoading.Rectangle1.Width := 100;
  frameLoading.Rectangle1.Height := 100;
  frameLoading.FloatAnimation1.Start;

  ThreadMesa := TThread.CreateAnonymousThread(procedure
  begin
    Sleep(500);
    Api := TApi.Create();
    DadosMesa := Api.GetMesas();
  end);

  ThreadMesa.OnTerminate := TerminateThreadMesa;
  ThreadMesa.Start;
end;


procedure TfrmControleDeMesa.ClickMore2(Sender: TObject);
var
  frame : TFrameControleDeMesa;
  frameMensagem : TFrameMensagem;

  btn   : TSpeedButton;
  rec   : TRectangle;

  Api : TApi;
  ThreadMesa : TTHread;

begin
  //PEGANDO O FRAME CLICADO
  btn   := Sender as TSpeedButton;
  rec := btn.Parent as TRectangle;
  rec := rec.Parent as TRectangle;
  rec := rec.Parent as TRectangle;
  //PEGANDO O FRAME CLICADO


  Frame := rec.Parent as TFrameControleDeMesa;
  if (frame.status = 0) or (frame.status = 3) then
  begin
    if Frame.btnSalvarEditar.Text = 'Salvar' then
    begin
      ThreadMesa := TThread.CreateAnonymousThread(procedure
      begin
        Api := TApi.Create();
        DadosMesaInsert := Api.PostAltMesas(Frame.idMesa, CodUsuario,
                                      Frame.CheckDefeito.IsChecked.ToInteger ,
                                      Frame.CheckAtivo.IsChecked.ToInteger,
                                      Frame.SpinCapacidade.Value.ToString.ToInteger);
      end);

      ThreadMesa.OnTerminate := TerminateThreadMesaAlt;
      ThreadMesa.Start;
    end;

    Frame.CheckAtivo.Enabled     := NOT   Frame.CheckAtivo.Enabled;
    Frame.CheckDefeito.Enabled   := NOT   Frame.CheckDefeito.Enabled;

    Frame.btnExcluir.Enabled     := NOT   Frame.btnExcluir.Enabled;
    Frame.btnCancelar.Enabled    := NOT   Frame.btnCancelar.Enabled;

    Frame.lblCapacidade.Enabled  := NOT   Frame.lblCapacidade.Enabled;
    Frame.SpinCapacidade.Enabled := NOT   Frame.SpinCapacidade.Enabled;

    if (Frame.btnSalvarEditar.Text = 'Editar') then
    begin
      Frame.btnSalvarEditar.Text := 'Salvar';
    end else
    begin
      Frame.btnSalvarEditar.Text := 'Editar';
      GetMesas();
    end;
  end else
  begin
    frameMensagem := TFrameMensagem.Create(nil);
    frameMensagem.recPrincipal.Parent := recPrincipal;
    frameMensagem.lblAviso.Text       := 'Só é possível alterar mesas com Status = Disponível ou Defeito';
    frameMensagem.recPrincipal.Width  := 500;
    frameMensagem.recPrincipal.Height := 125;
  end;
end;

procedure TfrmControleDeMesa.TerminateThreadMesa(Sender: TObject);
var
  Status        : String;
  //item          : TListBoxItem;
  frame         : TFrameControleDeMesa;
  JSONValue     : TJSONValue;
  JSONObject    : TJSONObject;
  JSONArray     : TJSONArray;
begin
  if Assigned(frameLoading) then
    frameLoading.Free;

  if (Pos('Erro', DadosMesa) > 0) then
  begin
      ShowMessage(DadosMesa);
  end else
  begin
    JSONValue  := TJSONObject.ParseJSONValue(DadosMesa);
    JSONArray  := JSONValue as TJSONArray;
    VertScrollBox1.BeginUpdate;
    for var i := 0 to JSONArray.Count - 1 do
    begin
      JSONObject := JSONArray[i] as TJSONObject;

      frame := TFrameControleDeMesa.Create(nil);
      frame.btnSalvarEditar.OnClick := ClickMore2;

      if JSONObject.GetValue('STATUS').Value = '0' then
      begin
        Status := 'Disponível';
      end else if JSONObject.GetValue('STATUS').Value = '1' then
      begin
        Status := 'Reservada';
        Frame.Glyph1.ImageIndex := 1;

        Frame.lblNumeroMesa.FontColor   := $ff440A4D;
        Frame.recFundo.Fill.Color       := $FFDBADE2;
        Frame.btnCancelar.FontColor     := $ff440A4D;
        Frame.btnExcluir.FontColor      := $ff440A4D;
        Frame.btnSalvarEditar.FontColor := $ff440A4D;
        Frame.lblCapacidade.FontColor   := $ff440A4D;
        Frame.CheckAtivo.FontColor      := $ff440A4D;
        Frame.CheckDefeito.FontColor    := $ff440A4D;

      end else if JSONObject.GetValue('STATUS').Value = '2' then
      begin
        Status := 'Ocupada';
        Frame.Glyph1.ImageIndex := 2;

        Frame.lblNumeroMesa.FontColor   := $FF00678D;
        Frame.recFundo.Fill.Color       := $FFA9D1E0;
        Frame.btnCancelar.FontColor     := $FF00678D;
        Frame.btnExcluir.FontColor      := $FF00678D;
        Frame.btnSalvarEditar.FontColor := $FF00678D;
        Frame.lblCapacidade.FontColor   := $FF00678D;
        Frame.CheckAtivo.FontColor      := $FF00678D;
        Frame.CheckDefeito.FontColor    := $FF00678D;
      end else
      begin
        Status := 'Inativa';
        Frame.Glyph1.ImageIndex := 3;

        Frame.lblNumeroMesa.FontColor   := $ff510F0F;
        Frame.recFundo.Fill.Color       := $FFEBBEBE;
        Frame.btnCancelar.FontColor     := $ff510F0F;
        Frame.btnExcluir.FontColor      := $ff510F0F;
        Frame.btnSalvarEditar.FontColor := $ff510F0F;
        Frame.lblCapacidade.FontColor   := $ff510F0F;
        Frame.CheckAtivo.FontColor      := $ff510F0F;
        Frame.CheckDefeito.FontColor    := $ff510F0F;
      end;

      frame.status                 := JSONObject.GetValue('STATUS').Value.ToInteger();
      frame.idMesa                 := JSONObject.GetValue('ID_MESA').Value;
      frame.lblNumeroMesa.Text     := JSONObject.GetValue('NUMERO').Value;
      frame.SpinCapacidade.Value   := JSONObject.GetValue('CAPACIDADE').Value.ToInteger;
      frame.CheckAtivo.IsChecked   := JSONObject.GetValue('ATIVO').Value.ToBoolean();
      frame.CheckDefeito.IsChecked := JSONObject.GetValue('DEFEITO').Value.ToBoolean();

       if JSONObject.GetValue('DEFEITO').Value.ToBoolean() then
        frame.Rectangle1.Fill.Color := $FFF3E88D;

      frame.Height := 100;
      frame.Position.Y := 999999999;
      frame.Align     := TAlignLayout.top;

      VertScrollBox1.AddObject(frame);
    end;
    VertScrollBox1.EndUpdate;
  end;

end;


procedure TfrmControleDeMesa.TerminateThreadMesaAlt(Sender: TObject);
var
  Status        : String;
  //item          : TListBoxItem;
  frame         : TFrameControleDeMesa;
  JSONValue     : TJSONValue;
  JSONObject    : TJSONObject;
  JSONArray     : TJSONArray;
begin
  if (Pos('Erro', DadosMesa) > 0) then
  begin
    ShowMessage(DadosMesaInsert);
  end else
  begin
    ShowMessage(DadosMesaInsert);
  end;
end;

procedure TfrmControleDeMesa.recGerenciarMesasMouseEnter(Sender: TObject);
begin
  continua := False;
  recGerenciarMesas.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation1.StartValue := 360;
  FloatAnimation1.StopValue := 370;
  FloatAnimation1.Inverse := False;
  FloatAnimation1.Start;
end;

procedure TfrmControleDeMesa.recGerenciarMesasMouseLeave(Sender: TObject);
begin
  recGerenciarMesas.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation1.Inverse := True;
  FloatAnimation1.Start;
end;

procedure TfrmControleDeMesa.recReservaAndVendasMouseEnter(Sender: TObject);
begin
  recReservaAndVendas.Fill.Color := TAlphaColor($FF004964);
  FloatAnimation2.StartValue := 360;
  FloatAnimation2.StopValue := 370;
  FloatAnimation2.Inverse := False;
  FloatAnimation2.Start;
end;

procedure TfrmControleDeMesa.recReservaAndVendasMouseLeave(Sender: TObject);
begin
  recReservaAndVendas.Fill.Color := TAlphaColor($FF017CA9);
  FloatAnimation2.Inverse := True;
  FloatAnimation2.Start;
end;

end.

