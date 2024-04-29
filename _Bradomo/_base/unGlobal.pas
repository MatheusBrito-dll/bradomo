unit unGlobal;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  Vcl.Forms, System.IniFiles, Vcl.Dialogs,
  Datasnap.DBClient, Vcl.DBCtrls, Vcl.DBGrids,
  Vcl.Controls, Vcl.StdCtrls, IdTCPClient,
  FireDAC.Comp.Client, Winapi.Windows,
  Vcl.Graphics, System.UITypes, Winapi.ActiveX,
  IdIcmpClient, System.Math;

var
  ipApi : String = 'localhost:3000';
  nomeUsuario : String;
  codUsuario : String;

function RemoverAcentos(const Str: string): string;

implementation

uses
  System.StrUtils, Soap.SOAPHTTPClient, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, IdSNTP, IdSSLOpenSSL, IdSMTP, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  unDMMySql;

function RemoverAcentos(const Str: string): string;
const
  ComAcento = 'ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖØÙÚÛÜİŞàáâãäåæçèéêëìíîïğñòóôõöøùúûüışÿ';
  SemAcento = 'AAAAAAACEEEEIIIIDNOOOOOOUUUUYBaaaaaaaceeeeiiiionoooooouuuuyby';
var
  i: Integer;
begin
  Result := Str;
  for i := 1 to Length(ComAcento) do
    Result := StringReplace(Result, ComAcento[i], SemAcento[i], [rfReplaceAll]);
end;

end.

