unit unControleDeMesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox,
  System.JSON,
  fmControleDeMesas, uApi;

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
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure recGerenciarMesasMouseEnter(Sender: TObject);
    procedure recGerenciarMesasMouseLeave(Sender: TObject);
    procedure recReservaAndVendasMouseEnter(Sender: TObject);
    procedure recReservaAndVendasMouseLeave(Sender: TObject);
    procedure recGerenciarMesasClick(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure TerminateThreadMesa(Sender: TObject);
    procedure LimparScrollBox(ScrollBox: TVertScrollBox);
  private
      DadosMesa : String;
    { Private declarations }
  public
    continua : Boolean;
    { Public declarations }
  end;

var
  frmControleDeMesa: TfrmControleDeMesa;

implementation

{$R *.fmx}


procedure TfrmControleDeMesa.FloatAnimation2Finish(Sender: TObject);
begin
  FloatAnimation1.Duration := 0.2;
  FloatAnimation2.Duration := 0.2;
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

procedure TfrmControleDeMesa.recGerenciarMesasClick(Sender: TObject);
var
  ThreadMesa : TTHread;
  Api        : TApi;
begin

  ThreadMesa := TThread.CreateAnonymousThread(procedure
  begin
    Api := TApi.Create();
    DadosMesa := Api.GetMesas();
  end);

  ThreadMesa.OnTerminate := TerminateThreadMesa;
  ThreadMesa.Start;
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
  if (Pos('Erro', DadosMesa) > 0) then
  begin
      ShowMessage(DadosMesa);
  end else
  begin
    JSONValue  := TJSONObject.ParseJSONValue(DadosMesa);
    JSONArray  := JSONValue as TJSONArray;
    LimparScrollBox(VertScrollBox1);
    VertScrollBox1.BeginUpdate;
    for var i := 0 to JSONArray.Count - 1 do
    begin
      JSONObject := JSONArray[i] as TJSONObject;

      frame := TFrameControleDeMesa.Create(nil);

       if JSONObject.GetValue('STATUS').Value = '0' then
      begin
        Status := 'Dispon�vel';
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


      frame.lblNumeroMesa.Text     := JSONObject.GetValue('NUMERO').Value;
      frame.SpinCapacidade.Value   := JSONObject.GetValue('CAPACIDADE').Value.ToInteger;
      frame.CheckAtivo.IsChecked   := JSONObject.GetValue('ATIVO').Value.ToBoolean();
      frame.CheckDefeito.IsChecked := JSONObject.GetValue('DEFEITO').Value.ToBoolean();

      frame.Height := 100;
      frame.Position.Y := 999999999;
      frame.Align     := TAlignLayout.top;

      VertScrollBox1.AddObject(frame);
    end;
    VertScrollBox1.EndUpdate;
  end;
end;



procedure TfrmControleDeMesa.FloatAnimation1Finish(Sender: TObject);
begin
    if (continua) or (recReservaAndVendas.Width = 0) then FloatAnimation2.Start;
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