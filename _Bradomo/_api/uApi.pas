unit uApi;

interface

uses
  IdHTTP, IdAuthentication, IdSSLOpenSSL, SysUtils, IdException,
  System.JSON, System.Classes, FMX.Dialogs, unGlobal, System.NetEncoding,
  REST.Client, REST.Types, REST.Authenticator.Basic;



type
  TApi = class
  private
    FIdHTTP: TIdHTTP;
    procedure ConfigurarHTTP;
  public
    constructor Create;
    destructor Destroy; override;
    function LoginGet(const codigoUsuario: string): string;
    function GetMesas(): string;
    function PostAltMesas(const id, usuario: String; const defeito, ativo, capacidade: integer): string;
    function CadMesas(const numero, capacidade: integer; local : string): string;

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

function TApi.CadMesas(const numero, capacidade: integer; local: string): string;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSONObj: TJSONObject;
  BasicAuth: THTTPBasicAuthenticator;
begin
  RESTClient := TRESTClient.Create(nil);
  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);
  BasicAuth := THTTPBasicAuthenticator.Create(nil);

  try
    // Configuração do cliente REST
    RESTClient.BaseURL := 'http://' + ipApi;
    RESTRequest.Client := RESTClient;
    RESTRequest.Method := rmPOST;
    RESTRequest.Resource := '/CadMesas';
    RESTRequest.AddParameter('application/json', '', TRESTRequestParameterKind.pkREQUESTBODY);

    // Configuração da autenticação básica
    BasicAuth.Username := 'adminMaster@bradomo@sis';
    BasicAuth.Password := '@B@str1ll0n@adminMaster@bradomo@sis';
    RESTClient.Authenticator := BasicAuth;

    // Associa os componentes
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;

    // Criando o objeto JSON e adicionando os pares de valores
    JSONObj := TJSONObject.Create;
    JSONObj.AddPair('NUMERO', TJSONNumber.Create(numero));
    JSONObj.AddPair('CAPACIDADE', TJSONNumber.Create(capacidade));
    JSONObj.AddPair('STATUS', TJSONNumber.Create(0));
    JSONObj.AddPair('LOCAL', local);
    JSONObj.AddPair('DEFEITO', TJSONNumber.Create(0));
    JSONObj.AddPair('ATIVO', TJSONBool.Create(False));
    JSONObj.AddPair('USUARIO', codUsuario);

    // Adicionando o objeto JSON ao corpo da requisição
    RESTRequest.Body.Add(JSONObj.ToString, TRESTContentType.ctAPPLICATION_JSON);

    // Realizando a requisição
    try
       RESTRequest.Execute;
    except
      // Capturando a resposta
      Result := RESTResponse.Content;
    end;

  finally
    Result := RESTResponse.Content;
    RESTClient.Free;
    JSONObj.Free;
  end;
end;

function TApi.PostAltMesas(const id, usuario: string; const defeito, ativo, capacidade: integer): string;
var
  HTTP: TIdHTTP;
  Body: TStringStream;
  Response: string;
  JSONObj: TJSONObject;
begin
  HTTP := TIdHTTP.Create(nil);
  Body := TStringStream.Create;

  try
    // Configuração do objeto TIdHTTP
    HTTP.HandleRedirects := True;
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.BasicAuthentication := True;
    HTTP.Request.Username := 'adminMaster@bradomo@sis';
    HTTP.Request.Password := '@B@str1ll0n@adminMaster@bradomo@sis';

    // Criando o objeto JSON e adicionando os pares de valores
    JSONObj := TJSONObject.Create;
    JSONObj.AddPair('id', id);
    JSONObj.AddPair('defeito', defeito);
    JSONObj.AddPair('ativo', ativo);
    JSONObj.AddPair('usuario', usuario);
    JSONObj.AddPair('capacidade', capacidade);
    // Certifique-se de codificar o valor do campo 'LOCAL' corretamente em UTF-8
    JSONObj.AddPair('local', TNetEncoding.URL.Encode(UTF8Encode('Área externa lateral')));

    // Convertendo o objeto JSON para uma string e escrevendo no stream
    Body.WriteString(JSONObj.ToString);

    // Fazendo a requisição POST
    Response := HTTP.Post('http://' + ipApi + '/PostAltMesas', Body);

    // Exibindo a resposta
    Result := Response;

  finally
    HTTP.Free;
    Body.Free;
    JSONObj.Free;
  end;
end;

end.

