unit unCadastroDeMesa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.Edit, FMX.Objects,
  FMX.StdCtrls, FMX.EditBox, FMX.SpinBox, FMX.Ani,
  uApi;

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
  private
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

    ThreadCadMesa := TThread.CreateAnonymousThread(procedure
    begin
      Api := TApi.Create();
      DadosMesa := Api.CadMesas(SpingNumMesa.Value.ToString.ToInteger,
                                SpinNumCapacidade.Value.ToString.ToInteger,
                                edtLocal.Text);
    end);
  end;

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
