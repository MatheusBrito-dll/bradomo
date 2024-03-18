unit uApi;

interface

uses
  IdHTTP, IdAuthentication, IdSSLOpenSSL, SysUtils, IdException,
  System.JSON, System.Classes, FMX.Dialogs, unGlobal, System.NetEncoding;

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
  HTTP: TIdHTTP;
  SSL: TIdSSLIOHandlerSocketOpenSSL;
  Body: TStringStream;
  Response: string;
  JSONObj: TJSONObject;
  JSONPair: TJSONPair;
begin
    HTTP := TIdHTTP.Create(nil);
  //SSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  Body := TStringStream.Create;

  try
    // Configuração do objeto TIdHTTP
    //HTTP.IOHandler := SSL;
    HTTP.HandleRedirects := True;
    HTTP.Request.ContentType := 'application/json';
    HTTP.Request.BasicAuthentication := True;
    HTTP.Request.Username := 'adminMaster@bradomo@sis';
    HTTP.Request.Password := '@B@str1ll0n@adminMaster@bradomo@sis';

    // Criando o objeto JSON e adicionando os pares de valores
    JSONObj := TJSONObject.Create;
    JSONObj.AddPair('NUMERO', numero);
    JSONObj.AddPair('CAPACIDADE', capacidade);
    JSONObj.AddPair('STATUS', 0 );
    JSONObj.AddPair('LOCAL', local);
    JSONObj.AddPair('DEFEITO', 0);
    JSONObj.AddPair('ATIVO', 0);
    JSONObj.AddPair('USUARIO', codUsuario);

    // Convertendo o objeto JSON para uma string e escrevendo no stream
    Body.WriteString(JSONObj.ToString);

    // Fazendo a requisição POST
    Response := HTTP.Post('http://'+ipApi+'/CadMesas', Body);

    // Exibindo a resposta
    Result := Response;

  finally
    HTTP.Free;
    SSL.Free;
    Body.Free;
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

