object dmServerMySQL: TdmServerMySQL
  Height = 480
  Width = 640
  object fcConnection: TFDConnection
    Params.Strings = (
      'Database=brd_master'
      'User_Name=castrillon'
      'Password=castri123'
      'Server=172.16.3.180'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object SqlDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'D:\_Bradomo\_Bradomo\libmysql.dll'
    Left = 120
    Top = 24
  end
  object qryRS_MESA: TFDQuery
    Connection = fcConnection
    SQL.Strings = (
      'SELECT * FROM brd_master.rs_mesa;')
    Left = 40
    Top = 152
    object qryRS_MESAID_MESA: TStringField
      FieldName = 'ID_MESA'
      Origin = 'ID_MESA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 40
    end
    object qryRS_MESANUMERO: TIntegerField
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Required = True
    end
    object qryRS_MESACAPACIDADE: TIntegerField
      FieldName = 'CAPACIDADE'
      Origin = 'CAPACIDADE'
      Required = True
    end
    object qryRS_MESASTATUS: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'STATUS'
      Origin = '`STATUS`'
    end
    object qryRS_MESALOCAL: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'LOCAL'
      Origin = '`LOCAL`'
      Size = 50
    end
    object qryRS_MESADEFEITO: TBooleanField
      AutoGenerateValue = arDefault
      FieldName = 'DEFEITO'
      Origin = 'DEFEITO'
    end
    object qryRS_MESAATIVO: TBooleanField
      FieldName = 'ATIVO'
      Origin = 'ATIVO'
      Required = True
    end
    object qryRS_MESAUSR_ALT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'USR_ALT'
      Origin = 'USR_ALT'
      Size = 6
    end
    object qryRS_MESADT_ALT: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'DT_ALT'
      Origin = 'DT_ALT'
    end
    object qryRS_MESAUSR_CAD: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'USR_CAD'
      Origin = 'USR_CAD'
      Size = 6
    end
    object qryRS_MESADT_CAD: TSQLTimeStampField
      AutoGenerateValue = arDefault
      FieldName = 'DT_CAD'
      Origin = 'DT_CAD'
    end
    object qryRS_MESAPEND: TBooleanField
      FieldName = 'PEND'
      Origin = 'PEND'
      Required = True
    end
    object qryRS_MESALOG: TMemoField
      AutoGenerateValue = arDefault
      FieldName = 'LOG'
      Origin = 'LOG'
      BlobType = ftMemo
    end
  end
  object DATAHORA: TFDQuery
    Connection = fcConnection
    SQL.Strings = (
      'SELECT now() DATA_HORA')
    Left = 208
    Top = 24
    object DATAHORADATA_HORA: TDateTimeField
      AutoGenerateValue = arDefault
      FieldName = 'DATA_HORA'
      Origin = 'DATA_HORA'
      ProviderFlags = []
      ReadOnly = True
    end
  end
end
