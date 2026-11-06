object DataModule1: TDataModule1
  Height = 302
  Width = 452
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=TurnoAgil'
      'User_Name=root'
      'Password=Ariana2023+'
      'Server=localhost'
      'DriverID=MySQL')
    Left = 40
    Top = 16
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from estados_turno')
    Left = 152
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\inetpub\wwwroot\MicroServicioTurnoAgil\libmysql.dll'
    Left = 32
    Top = 88
  end
end
