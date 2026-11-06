unit WebModuleUnit1;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, System.JSON;

type
  TWebModule1 = class(TWebModule)
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
    procedure WebModuleCreate(Sender: TObject);
  private
    { Private declarations }
    { Métodos para atender los endpoints }
    procedure HandleConsultarTurno(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
    procedure HandleCrearTurno(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse; var Handled: Boolean);
  public
    { Public declarations }
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  UDmTurnos;

procedure TWebModule1.HandleConsultarTurno(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  JSON: TJSONObject;
  IdTurno: string;
begin
  IdTurno := Request.QueryFields.Values['id']; // Lee parámetro URL: ?id=105

  JSON := TJSONObject.Create;
  try
    JSON.AddPair('id', IdTurno);
    JSON.AddPair('estado', 'En Espera');
    JSON.AddPair('mensaje', 'Turno consultado con éxito');

    Response.ContentType := 'application/json; charset=utf-8';
    Response.Content := JSON.ToString;
  finally
    JSON.Free;
  end;
  Handled := True;
end;

procedure TWebModule1.HandleCrearTurno(Sender: TObject; Request: TWebRequest;
  Response: TWebResponse; var Handled: Boolean);
var
  JSONResp: TJSONObject;
  BodyRecibido: string;
begin
  BodyRecibido := Request.Content; // Lee el cuerpo JSON enviado desde el cliente

  JSONResp := TJSONObject.Create;
  try
    JSONResp.AddPair('status', 'OK');
    JSONResp.AddPair('recibido', BodyRecibido);

    Response.ContentType := 'application/json; charset=utf-8';
    Response.Content := JSONResp.ToString;
  finally
    JSONResp.Free;
  end;
  Handled := True;
end;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.ContentType := 'application/json';
  Response.Content := '{"mensaje": "Servicio ISAPI TurnoAgil Activo"}';
  Handled := True;
end;

procedure TWebModule1.WebModuleCreate(Sender: TObject);
var
  Action: TWebActionItem;
begin
  // Endpoint 1: GET /TurnoAgilsApi.dll/consultar
  Action := Actions.Add;
  Action.Name := 'ActConsultarTurno';
  Action.PathInfo := '/consultar';
  Action.MethodType := mtGet;
  Action.OnAction := HandleConsultarTurno;

  // Endpoint 2: POST /TurnoAgilsApi.dll/crear
  Action := Actions.Add;
  Action.Name := 'ActCrearTurno';
  Action.PathInfo := '/crear';
  Action.MethodType := mtPost;
  Action.OnAction := HandleCrearTurno;
end;

end.
