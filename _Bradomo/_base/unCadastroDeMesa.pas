unit unCadastroDeMesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.Edit, FMX.Objects,
  FMX.StdCtrls, FMX.EditBox, FMX.SpinBox, FMX.Ani, System.JSON,
  uApi,
  fmMensagem,
  fmAnimationLoading;

type
  TfrmCadastroDeMesa = class(TForm)
    recPrincipal: TRectangle;
    Label1: TLabel;
    SpingNumMesa: TSpinBox;
    Label2: TLabel;
    Label3: TLabel;
    SpinNumCapacidade: TSpinBox;
    Label4: TLabel;
    edtLocal: TEdit;
    btnEnviarPost: TRectangle;
    OK: TLabel;
    procedure btnEnviarPostMouseEnter(Sender: TObject);
    procedure btnEnviarPostMouseLeave(Sender: TObject);
    procedure btnEnviarPostClick(Sender: TObject);
    procedure TerminateThreadMesa(Sender: TObject);
  private

    frameLoading : TFrameLoading;

    DadosMesa : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroDeMesa: TfrmCadastroDeMesa;

implementation

{$R *.fmx}

procedure TfrmCadastroDeMesa.btnEnviarPostClick(Sender: TObject);
var
  ThreadCadMesa : TThread;
  Api : TApi;
begin

  if VarIsNumeric(SpingNumMesa.Value){/////}and
     VarIsNumeric(SpinNumCapacidade.Value){}and
     (edtLocal.Text <> ''){////////////////}then
  begin

    frameLoading := TFrameLoading.Create(nil);

    Ok.Visible := False;
    frameLoading.Rectangle1.Parent := btnEnviarPost;
    frameLoading.Rectangle1.Width := 20;
    frameLoading.Rectangle1.Height := 20;
    frameLoading.Arc1.Stroke.Thickness := 3;
    frameLoading.Arc1.Stroke.Dash := TStrokeDash.Dot;
    frameLoading.FloatAnimation1.Start;

    ThreadCadMesa := TThread.CreateAnonymousThread(procedure
    begin
      Sleep(500);
      Api := TApi.Create();
      DadosMesa := Api.CadMesas(SpingNumMesa.Value.ToString.ToInteger,
                                SpinNumCapacidade.Value.ToString.ToInteger,
                                edtLocal.Text);
    end);

    ThreadCadMesa.OnTerminate := TerminateThreadMesa;
    ThreadCadMesa.Start;
  end;
end;

procedure TfrmCadastroDeMesa.TerminateThreadMesa(Sender: TObject);
var
  frameMensagem : TFrameMensagem;
  ObjCad        : TJSONObject;
  Value         : TJSONValue;
begin

  Ok.Visible := True;

  if Assigned(frameLoading) then
    frameLoading.Free;

  frameMensagem := TFrameMensagem.Create(nil);

  if not (Trim(DadosMesa) = '') then
  begin
    if (Pos('Ops', DadosMesa) > 0) then
    begin
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
        frameMensagem.lblAviso.Text := 'Ops! Erro desconhecido.'
    end else
    begin
      frameMensagem.lblAviso.Text := 'Mesa Adicionada com sucesso!';
    end;
  end else
  begin
    frameMensagem.recBordaCorpo.Stroke.Color := $FFF38F5B;
    frameMensagem.recOk.Fill.Color           := $FFF38F5B;
    frameMensagem.recTitulo.Fill.Color       := $FFF38F5B;
    frameMensagem.lblAviso.Text := 'Ocorreu um erro ao adicionar mesa!';
  end;

  frameMensagem.recPrincipal.Width  := 500;
  frameMensagem.recPrincipal.Height := 125;
  frameMensagem.recPrincipal.Parent := recPrincipal;
end;

procedure TfrmCadastroDeMesa.btnEnviarPostMouseEnter(Sender: TObject);
begin
  btnEnviarPost.Fill.Color := $FF9ADCF2;
end;

procedure TfrmCadastroDeMesa.btnEnviarPostMouseLeave(Sender: TObject);
begin
  btnEnviarPost.Fill.Color := $FFCACACA;
end;



end.
