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

  function GuidCreate: string;
  function BrdTime(): string;

var

  ipApi : String = 'localhost:3000';
  nomeUsuario : String;


implementation


uses
  System.StrUtils, Soap.SOAPHTTPClient, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, IdSNTP, IdSSLOpenSSL, IdSMTP, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  unDMMySql;


function GuidCreate: string;
var
  ID : TGUID;
  Gui: string;
begin
  Result := '';
  if CoCreateGuid(ID) = S_OK then
    Gui := GUIDToString(ID);
    Gui := copy(Gui, 2, length(Gui)-2);
    Result := Gui;
end;


function BrdTime(): string;
var
  DataBD: TDateTime;
  DataAtual: string;
  H: integer;
begin
  dmServerMySQL.fcConnection.Connected := True;

  dmServerMySQL.DATAHORA.Active := True;
  DataBD := dmServerMySQL.DATAHORADATA_HORA.AsDateTime;
  dmServerMySQL.DATAHORA.Active := False;

  DataAtual := '';
  DataAtual:= FormatDateTime('YYYY-MM-DD HH:MM:SS', DataBD);
  DataAtual := DateTimeToStr(DataBD);
  Result := Trim(DataAtual);
end;


procedure GenBeforePost(cds : TFDQuery; TableName : String; PrimaryKey : TField;
    Connection : TFDConnection; Incrementa: Boolean = False; GerGuid: Boolean = False; ServPend: Boolean = False; ExibeMsg: Boolean = True);
var
  msg : string;
  i : integer;
  Qry : TFDQuery;
begin
  try
    if PrimaryKey.DataSet.State = dsInsert then
    begin
      //--Incrementa
      if Incrementa then
      begin
        Qry := TFDQuery.Create(nil);
        try
          Qry.Connection := Connection;
          Qry.SQL.Add('select max('+PrimaryKey.FieldName+') from '+TableName);
          Qry.Open;
          if Qry.Fields[0].IsNull then
            PrimaryKey.AsInteger := 1
          else PrimaryKey.AsInteger := Qry.Fields[0].AsInteger+1;
        finally
          FreeAndNil(Qry);
        end;
      end else if GerGuid then
      begin
        PrimaryKey.AsString := GuidCreate;
      end;
      //
      cds.FieldByName('DT_CAD').AsString := BrdTime();
      cds.FieldByName('USR_CAD').AsString  := copy(NomeUsuario,1, 30);
    end;
    if PrimaryKey.DataSet.State = dsEdit then
    begin
      cds.FieldByName('DT_ALT').AsString := BrdTime();
      cds.FieldByName('USR_ALT').AsString  := copy(NomeUsuario,1,30);
    end;

    //Caso tenha atualização da base via SERVIDOR
    if ServPend = True then
    begin
      cds.FieldByName('PEND').AsString  := 'X';
      cds.FieldByName('LOG').AsString  := '';
    end;

    msg := 'Campo(s) com preenchimento obrigatório:' + #13;
    //--Monta mensagem de campos obrigatórios
    for i := 0 to cds.FieldCount - 1 do
      if cds.Fields[i].Required then
        if (cds.Fields[i].IsNull) Or (cds.Fields[i].AsString = '') then
        begin
          msg := msg + '   -' + cds.Fields[i].DisplayLabel + '.' + #13 +#10;
        end;
    //-- Checa Inserção
    if not (msg = 'Campo(s) com preenchimento obrigatório:' + #13) and (ExibeMsg) then
    begin
      ShowMessage(msg);
      Abort;
    end;
  except on e:exception do

    ShowMessage('unGlobal - ' + ' - GenBeforePost' + ' - ' + e.Message);

  end;
end;

end.

