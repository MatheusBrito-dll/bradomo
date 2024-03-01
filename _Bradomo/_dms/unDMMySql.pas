unit unDMMySql;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.FMXUI.Wait,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TdmServerMySQL = class(TDataModule)
    fcConnection: TFDConnection;
    SqlDriverLink: TFDPhysMySQLDriverLink;
    qryRS_MESA: TFDQuery;
    qryRS_MESAID_MESA: TStringField;
    qryRS_MESANUMERO: TIntegerField;
    qryRS_MESACAPACIDADE: TIntegerField;
    qryRS_MESASTATUS: TStringField;
    qryRS_MESALOCAL: TStringField;
    qryRS_MESADEFEITO: TBooleanField;
    qryRS_MESAATIVO: TBooleanField;
    qryRS_MESAUSR_ALT: TStringField;
    qryRS_MESADT_ALT: TSQLTimeStampField;
    qryRS_MESAUSR_CAD: TStringField;
    qryRS_MESADT_CAD: TSQLTimeStampField;
    qryRS_MESAPEND: TBooleanField;
    qryRS_MESALOG: TMemoField;
    DATAHORA: TFDQuery;
    DATAHORADATA_HORA: TDateTimeField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmServerMySQL: TdmServerMySQL;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
