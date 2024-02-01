unit unMD5;

interface

uses
  IdHashMessageDigest, Classes, System.SysUtils, System.DateUtils, FMX.Dialogs;

  function MD5String(const Value: string): string;
  function MD5Arquivo(const Value: string): string;
  function Autenticacao(const Value: TDateTime): boolean;
implementation

function MD5String(const Value: string): string;
var
  xMD5: TIdHashMessageDigest5;
begin
  xMD5 := TIdHashMessageDigest5.Create;
  try
    Result := xMD5.HashStringAsHex(Value);
  finally
    xMD5.Free;
  end;
end;

function MD5Arquivo(const Value: string): string;
var
  xMD5: TIdHashMessageDigest5;
  xArquivo: TFileStream;
begin
  xMD5 := TIdHashMessageDigest5.Create;
  xArquivo := TFileStream.Create(Value, fmOpenRead or fmShareDenyWrite);
  try
    Result := xMD5.HashStreamAsHex(xArquivo);
  finally
    xArquivo.Free;
    xMD5.Free;
  end;
end;

function Autenticacao(const Value: TDateTime): boolean;
begin
  if (Value >= now) then
  begin
    result := true;
  end else
  begin
   result := false;
  end;
end;

end.
