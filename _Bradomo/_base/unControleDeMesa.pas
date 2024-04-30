unit unControleDeMesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  System.JSON,
  fmControleDeMesas,
  uApi,
  unGLobal,
  fmAnimationLoading,
  fmMensagem,
  unCadastroDeMesa,
  FMX.Edit,
  FMX.ScrollBox,
  System.UIConsts,
  FMX.InertialMovement,
  System.IOUtils, FMX.ComboEdit;
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
    imgBusca: TImage;
    recBuscar: TRectangle;
    edtBusca: TEdit;
    recTopo: TRectangle;
    imgBuscaExataNao: TImage;
    lblBuscaExata: TLabel;
    recBuscaExata: TRectangle;
    Rectangle2: TRectangle;
    imgBuscaExataSim: TImage;
    Image4: TImage;
    recFiltro: TRectangle;
    recFiltroPrincial: TRectangle;
    ListBox1: TListBox;
    AnimationFiltro: TFloatAnimation;
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
    procedure edtBuscaKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure recBuscaExataClick(Sender: TObject);
    procedure recFiltroMouseEnter(Sender: TObject);
    procedure recFiltroMouseLeave(Sender: TObject);
    procedure recFiltroClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private

      DadosMesa         : String;
      DadosMesaInsert   : String;

      isBuscaExata      : Boolean;

      frameLoading      : TFrameLoading;
      frameMensage      : TFrameMensagem;
      frmCadastroDeMesa : TfrmCadastroDeMesa;

    procedure ClickMore2(Sender: TObject);
    procedure BuscaMesa(ehBusca: Boolean = False);
    procedure SoftScroll(AScroll: TFmxObject);
    procedure CarregaFiltroMesa;

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
var
  largura : double;

begin

  recGerenciarMesas.Width   := 0;
  recReservaAndVendas.Width := 0;
  recAdicionarMesa.Width    := 0;

  FloatAnimation1.Duration := 0.1;
  FloatAnimation2.Duration := 0.1;
  FloatAnimation3.Duration := 0.1;
  FloatAnimation1.Start;

  Continua := True;

  SoftScroll(VertScrollBox1);

  isBuscaExata := False;

end;

procedure TfrmControleDeMesa.edtBuscaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 13 then
  begin
      Case VertScrollBox1.Tag of
        0 : BuscaMesa(True);
      end;
  end;
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

procedure TfrmControleDeMesa.ListBox1Click(Sender: TObject);
begin
  edtBusca.Text := ListBox1.Items[ListBox1.ItemIndex];
  AnimationFiltro.StartValue := ListBox1.Items.Count * 20;;
  AnimationFiltro.StopValue  := 0;
  AnimationFiltro.Start;

  Case VertScrollBox1.Tag of
   0 : BuscaMesa(True);
  end;
end;

procedure TfrmControleDeMesa.ListBox1KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin

  if Key = 13 then
  begin
    edtBusca.Text := ListBox1.Items[ListBox1.ItemIndex];
    AnimationFiltro.StartValue := ListBox1.Items.Count * 20;;
    AnimationFiltro.StopValue  := 0;
    AnimationFiltro.Start;

    Case VertScrollBox1.Tag of
     0 : BuscaMesa(True);
    end;
  end;
end;

procedure TfrmControleDeMesa.recAdicionarMesaClick(Sender: TObject);
begin
  if Assigned(frmCadastroDeMesa) then
    frmCadastroDeMesa.Free;

  VertScrollBox1.Tag := 2;
  edtBusca.Enabled := False;

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

procedure TfrmControleDeMesa.recBuscaExataClick(Sender: TObject);
begin

  If isBuscaExata then
  begin
    lblBuscaExata.FontColor  :=  TAlphaColor($FFA4A4A4);
    imgBuscaExataNao.Visible := True;
    imgBuscaExataSim.Visible := False;
    isBuscaExata := False;
  end else
  begin
    lblBuscaExata.FontColor  := TAlphaColor($FF89CF5E);
    imgBuscaExataNao.Visible := False;
    imgBuscaExataSim.Visible := True;
    isBuscaExata := True;
  end;

end;

procedure TfrmControleDeMesa.recFiltroClick(Sender: TObject);
begin
  Case VertScrollBox1.Tag of
        0 : begin
              CarregaFiltroMesa;
              ListBox1.SetFocus;
            end;
  end;
end;

procedure TfrmControleDeMesa.CarregaFiltroMesa;
begin
  BuscaMesa;

  if not (recFiltroPrincial.Height > 0) then
  begin
    if ListBox1.Items.Count > 0 then
    begin
      AnimationFiltro.StartValue := 0;
      AnimationFiltro.StopValue  := ListBox1.Items.Count * 20;
      AnimationFiltro.Start;
      ListBox1.ItemIndex := 0;
    end;
  end else
  begin
    AnimationFiltro.StartValue := ListBox1.Items.Count * 20;
    AnimationFiltro.StopValue  := 0;
    AnimationFiltro.Start;
  end;
end;

procedure TfrmControleDeMesa.recFiltroMouseEnter(Sender: TObject);
begin
  recFiltro.Fill.Color := $FF616161;
end;

procedure TfrmControleDeMesa.recFiltroMouseLeave(Sender: TObject);
begin
  recFiltro.Fill.Color := $FFA4A4A4;
end;

procedure TfrmControleDeMesa.recGerenciarMesasClick(Sender: TObject);
begin

  if Assigned(frmCadastroDeMesa) then
    frmCadastroDeMesa.Free;

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
  VertScrollBox1.Tag := 0;

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
  frameMensagem : TFrameMensagem;
  ObjCad        : TJSONObject;
  Value         : TJSONValue;
begin
  if Assigned(frameLoading) then
    frameLoading.Free;

  if (Pos('Erro', DadosMesa) > 0) then
  begin
    edtBusca.Enabled := False;
    frameMensagem := TFrameMensagem.Create(nil);

    ObjCad  := TJSONObject.Create();
    Value   := TJSONValue.Create();

    Value   := TJSONObject.ParseJSONValue(DadosMesa) as TJSONValue;
    ObjCad  := Value as TJSONObject;

    var msg : String;

    frameMensagem.recBordaCorpo.Stroke.Color := $FFF38F5B;
    frameMensagem.recOk.Fill.Color           := $FFF38F5B;
    frameMensagem.recTitulo.Fill.Color       := $FFF38F5B;

    if ObjCad.TryGetValue<string>('error', msg) then
      frameMensagem.lblAviso.Text := msg
    else
      frameMensagem.lblAviso.Text := 'Ops! Erro desconhecido.';


    frameMensagem.recPrincipal.Width  := 500;
    frameMensagem.recPrincipal.Height := 125;
    frameMensagem.recPrincipal.Parent := recPrincipal;

  end else
  begin
    try
      BuscaMesa(false);
    finally
      edtBusca.Enabled := True;
    end;
  end;
end;


procedure TfrmControleDeMesa.BuscaMesa(ehBusca: Boolean);
var
  Status           : String;
  frame            : TFrameControleDeMesa;
  JSONValue        : TJSONValue;
  JSONObject       : TJSONObject;
  JSONArray        : TJSONArray;
  Mostra           : Boolean;
  local            : string;
  localJaAdicionado: Boolean;
begin
  JSONValue  := TJSONObject.ParseJSONValue(DadosMesa);
  JSONArray  := JSONValue as TJSONArray;

  if ehBusca then
  begin
    LimparScrollBox(VertScrollBox1);
  end else
  begin
    ListBox1.Clear;
  end;

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
      Frame.lblLocal.FontColor        := $ff440A4D;

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
      Frame.lblLocal.FontColor        := $FF00678D;
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
      Frame.lblLocal.FontColor   := $ff510F0F;
    end;

    frame.status                 := JSONObject.GetValue('STATUS').Value.ToInteger();
    frame.idMesa                 := JSONObject.GetValue('ID_MESA').Value;
    frame.lblNumeroMesa.Text     := JSONObject.GetValue('NUMERO').Value;
    frame.SpinCapacidade.Value   := JSONObject.GetValue('CAPACIDADE').Value.ToInteger;
    frame.CheckAtivo.IsChecked   := JSONObject.GetValue('ATIVO').Value.ToBoolean();
    frame.CheckDefeito.IsChecked := JSONObject.GetValue('DEFEITO').Value.ToBoolean();
    frame.lblLocal.Text          := 'Local: ' + JSONObject.GetValue('LOCAL').Value;

    if not ehBusca then
    begin

      local := JSONObject.GetValue('LOCAL').Value;
      localJaAdicionado := False;

      // Verifica se o local já foi adicionado na ListBox
      for var x := 0 to ListBox1.Items.Count - 1 do
      begin
        if ListBox1.Items[x] = local then
        begin
          localJaAdicionado := True;
          Break;
        end;
      end;

      // Se o local não foi adicionado ainda, adiciona à ListBox
      if not localJaAdicionado then
      begin
        ListBox1.Items.Add(local);
        ListBox1.ItemHeight := 20;
      end;

    end;

     if JSONObject.GetValue('DEFEITO').Value.ToBoolean() then
      frame.Rectangle1.Fill.Color := $FFF3E88D;

    frame.Height := 110;
    frame.Position.Y := 999999999;
    frame.Align     := TAlignLayout.top;

    frame.TextoControle := JSONObject.GetValue('NUMERO').Value;
    frame.Visible := true;

    if ehBusca then
    begin
      if not isBuscaExata then
      begin
        if (Pos(edtBusca.Text, frame.lblNumeroMesa.Text) > 0) or (trim(edtBusca.Text) = '') then
          Mostra := True
        else if (Pos(LowerCase(edtBusca.Text), LowerCase(RemoverAcentos(frame.lblLocal.Text))) > 0) then
          Mostra := True
        else if (trim(LowerCase('Local: ' + edtBusca.Text)) = trim(LowerCase(frame.lblLocal.Text))) then
          Mostra := True
        else
          Mostra := False;

        if Mostra then
          VertScrollBox1.AddObject(frame);
      end else
      begin
        if (trim(edtBusca.Text) =  trim(frame.lblNumeroMesa.Text)) or (trim(edtBusca.Text) = '') then
          Mostra := True
        else if (trim(LowerCase('Local: ' + edtBusca.Text)) = trim(LowerCase(RemoverAcentos(frame.lblLocal.Text)))) then
          Mostra := True
        else if (trim(LowerCase('Local: ' + edtBusca.Text)) = trim(LowerCase(frame.lblLocal.Text))) then
          Mostra := True
        else
          Mostra := False;

        if Mostra then
          VertScrollBox1.AddObject(frame);
      end;

    end else
     VertScrollBox1.AddObject(frame);

  end;
  VertScrollBox1.EndUpdate;
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

procedure TfrmControleDeMesa.SoftScroll(AScroll: TFmxObject);
var
  AniCalculations: TAniCalculations;
begin
  AniCalculations := TAniCalculations.Create(nil);
  try
    AniCalculations.Animation := True;
    AniCalculations.BoundsAnimation := True;
    AniCalculations.Averaging := True;
    AniCalculations.DecelerationRate := 0.5;
    AniCalculations.Elasticity := 50;

    if AScroll is TVertScrollBox then
    begin
      TVertScrollBox(AScroll).AniCalculations.Assign(AniCalculations);
      TVertScrollBox(AScroll).ShowScrollBars := True; // Torna as barras de rolagem visíveis
    end
    else if AScroll is THorzScrollBox then
    begin
      THorzScrollBox(AScroll).AniCalculations.Assign(AniCalculations);
      THorzScrollBox(AScroll).ShowScrollBars := True; // Torna as barras de rolagem visíveis
    end;
  finally
    AniCalculations.DisposeOf;
  end;
end;


end.

