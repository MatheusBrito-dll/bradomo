unit uApi;

interface

uses
  IdHTTP, IdAuthentication, IdSSLOpenSSL, SysUtils, IdException,
  System.JSON, System.Classes, FMX.Dialogs, unGlobal;

type
  TApi = class
  private
    FIdHTTP: TIdHTTP;
    procedure ConfigurarHTTP;
    function PostDocs(const codigo, cpf, senhaNova: String): string;
  public
    constructor Create;
    destructor Destroy; override;
    function LoginGet(const codigoUsuario: string): string;
    function GetMesas(): string;
  end;

implementation

{ TApi }

constructor TApi.Create;
begin
  FIdHTTP := TIdHTTP.Create(nil);
  ConfigurarHTTP;
end;

destructor TApi.Destroy;
begin
  FIdHTTP.Free;
  inherited;
end;

procedure TApi.ConfigurarHTTP;
begin
  FIdHTTP.Request.Clear;
  FIdHTTP.Request.BasicAuthentication := True;
  FIdHTTP.Request.Username := 'adminMaster@bradomo@sis';
  FIdHTTP.Request.Password := '@B@str1ll0n@adminMaster@bradomo@sis';
end;


function TApi.GetMesas: string;
var
  URL: string;
begin
  try
    URL := 'http://'+ipApi+'/getMesas';
    Result := FIdHTTP.Get(URL);
  except
    on E: Exception do
      Result := 'Erro: ' + E.Message;
  end;
end;


function TApi.LoginGet(const codigoUsuario: string): string;
var
  URL: string;
begin
  try
    URL := 'http://'+ipApi+'/getLogin?codigoUsuario='+codigoUsuario;
    Result := FIdHTTP.Get(URL);
  except
    on E: Exception do
      Result := 'Erro: ' + E.Message;
  end;
end;




function TApi.PostDocs(const codigo, cpf, senhaNova : String): string;
var
  requestBody: TStringStream;
begin
  try

    FIdHTTP.Request.ContentType := 'application/json';
    //http://localhost:3000/atualizaSenha?codigoUsuario=000001&userCpf=04568305101&senhaNova=7ACE6328F06E0E4FD9E10DB7EC2CDA29
    Result := FIdHTTP.Post('http://'+ipApi+'/atualizaSenha?codigoUsuario='+ '' +'&userCpf='+ '' +'&senhaNova=' + '', requestBody);

  except
    on E: Exception do
      Result := 'Erro: ' + E.Message;
  end;
end;


end.
