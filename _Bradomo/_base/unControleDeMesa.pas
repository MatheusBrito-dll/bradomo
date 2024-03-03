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
    ListBox1: TListBox;
    procedure FloatAnimation1Finish(Sender: TObject);
    procedure recGerenciarMesasMouseEnter(Sender: TObject);
    procedure recGerenciarMesasMouseLeave(Sender: TObject);
    procedure recReservaAndVendasMouseEnter(Sender: TObject);
    procedure recReservaAndVendasMouseLeave(Sender: TObject);
    procedure recGerenciarMesasClick(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure TerminateThreadMesa(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TfrmControleDeMesa.FormCreate(Sender: TObject);
begin
  ListBox1.DefaultItemStyles.ItemStyle := 'listboxitem';
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
  item          : TListBoxItem;
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

    ListBox1.Clear;
    ListBox1.BeginUpdate;
      for var i := 0 to JSONArray.Count - 1 do
      begin
        JSONObject := JSONArray[i] as TJSONObject;

        if JSONObject.GetValue('STATUS').Value = '0' then
          Status := 'Disponível'
        else if JSONObject.GetValue('STATUS').Value = '1' then
          Status := 'Reservada'
        else if JSONObject.GetValue('STATUS').Value = '2' then
          Status := 'Ocupada'
        else
          Status := 'Inativa';

        item            := TListBoxItem.Create(nil);
        item.Text       := JSONObject.GetValue('NUMERO').Value + ' ' + Status;
        item.Height     := 100;
        item.Selectable := false;

        //Cria o Frame com o visual
        frame           := TFrameControleDeMesa.Create(item);

        frame.lblNumeroMesa.Text     := JSONObject.GetValue('NUMERO').Value;
        frame.SpinCapacidade.Value   := JSONObject.GetValue('CAPACIDADE').Value.ToInteger;
        frame.CheckAtivo.IsChecked   := JSONObject.GetValue('ATIVO').Value.ToBoolean();
        frame.CheckDefeito.IsChecked := JSONObject.GetValue('DEFEITO').Value.ToBoolean();

        frame.Parent    := item;
        frame.Align     := TAlignLayout.Client;

        ListBox1.AddObject(item);
      end;
    ListBox1.EndUpdate;

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
  FloatAnimation1.StopValue := 350;
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
  FloatAnimation2.StopValue := 350;
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
