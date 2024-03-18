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


implementation


uses
  System.StrUtils, Soap.SOAPHTTPClient, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, IdSNTP, IdSSLOpenSSL, IdSMTP, IdMessage, IdText, IdAttachmentFile,
  IdExplicitTLSClientServerBase, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  unDMMySql;


end.

