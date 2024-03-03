                 {.,,uod8B8bou,,.
              ..,uod8BBBBBBBBBBBBBBBBRPFT?l!i:.
         ,=m8BBBBBBBBBBBBBBBRPFT?!||||||||||||||
         !...:!TVBBBRPFT||||||||||!!^^""'   ||||
         !.......:!?|||||!!^^""'            ||||
         !.........||||                     ||||
         !.........||||  ##                 ||||
         !.........||||                     ||||
         !.........||||                     ||||
         !.........||||                     ||||
         !.........||||                     ||||
         `.........||||                    ,||||
          .;.......||||               _.-!!|||||
   .,uodWBBBBb.....||||       _.-!!|||||||||!:'
!YBBBBBBBBBBBBBBb..!|||:..-!!|||||||!iof68BBBBBb....
!..YBBBBBBBBBBBBBBb!!||||||||!iof68BBBBBBRPFT?!::   `.
!....YBBBBBBBBBBBBBBbaaitf68BBBBBBRPFT?!:::::::::     `.
!......YBBBBBBBBBBBBBBBBBBBRPFT?!::::::;:!^"`;:::       `.
!........YBBBBBBBBBBRPFT?!::::::::::^''...::::::;         iBBbo.
`..........YBRPFT?!::::::::::::::::::::::::;iof68bo.      WBBBBbo.
  `..........:::::::::::::::::::::::;iof688888888888b.     `YBBBP^'
    `........::::::::::::::::;iof688888888888888888888b.     `
      `......:::::::::;iof688888888888888888888888888888b.
        `....:::;iof688888888888888888888888888888888899fT!
          `..::!8888888888888888888888888888888899fT|!^"'
            `' !!988888888888888888888888899fT|!^"'
                `!!8888888888888888899fT|!^"'
                  `!988888888899fT|!^"'
                    `!9899fT|!^"'
                      `!^"'}
unit unLogin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ImgList,
  System.ImageList, FMX.Platform, Winapi.ShellAPI, Winapi.Windows,
  unMenuPrincipal, FMX.Layouts,
  uApi,
  System.JSON,
  unmd5;

type
  TfrmLogin = class(TForm)
    picImageLogo: TImage;
    recDireitaLogin: TRectangle;
    lblLogin: TLabel;
    edtUsuario: TEdit;
    recUsuario: TRectangle;
    recLinhaUsuario: TRectangle;
    recSenha: TRectangle;
    edtSenha: TEdit;
    recLinhaSenha: TRectangle;
    picImageUser: TImage;
    picImageKey: TImage;
    recEntrar: TRectangle;
    lblEntrar: TLabel;
    recEsqueceuSenha: TRectangle;
    lblEsqueceu: TLabel;
    lblCliqueAqui: TLabel;
    recSair: TRectangle;
    Label1: TLabel;
    imgEye: TImageList;
    imgVerSenha: TGlyph;
    recImageEye: TRectangle;
    recSocialMedia: TRectangle;
    imgInstagram: TImage;
    imgX: TImage;
    imgLinkedin: TImage;
    imgSite: TImage;
    Image1: TImage;
    lblAviso: TLabel;
    recAviso: TRectangle;
    LayoutPadrao: TLayout;
    procedure recEntrarMouseEnter(Sender: TObject);
    procedure recEntrarMouseLeave(Sender: TObject);
    procedure recSairClick(Sender: TObject);
    procedure recSairMouseLeave(Sender: TObject);
    procedure recSairMouseEnter(Sender: TObject);
    procedure recImageEyeMouseEnter(Sender: TObject);
    procedure recImageEyeMouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtUsuarioKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: WideChar; Shift: TShiftState);
    procedure imgInstagramDblClick(Sender: TObject);
    procedure Image2DblClick(Sender: TObject);
    procedure imgLinkedinDblClick(Sender: TObject);
    procedure imgXDblClick(Sender: TObject);
    procedure recEntrarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.fmx}




//--------------------CREATE--------------------
procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  lblAviso.Visible := False;
  edtUsuario.SetFocus;

  edtUsuario.Text := '000001';
  edtSenha.Text := '856732aC';

end;
//-----------------------------------------------


procedure TfrmLogin.recEntrarClick(Sender: TObject);
var
  ApiLogin      : TApi;
  Dados         : String;
  LayoutPadraoC : TComponent;
  JSONValue     : TJSONValue;
  JSONObject    : TJSONObject;
  JSONArray     : TJSONArray;
  senha         : String;

begin
  lblAviso.Visible := False;
  if (Trim(edtUsuario.Text) <> '') and (Trim(edtSenha.Text) <> '') then
  begin
    ApiLogin := TApi.Create;
    Dados := ApiLogin.LoginGet(edtUsuario.Text);

    if (Pos('Erro', Dados) > 0) then
    begin
        ShowMessage(Dados);
    end else
    begin
      if Dados <> '[]' then
      begin
        JSONValue  := TJSONObject.ParseJSONValue(Dados);
        JSONArray  := JSONValue as TJSONArray;
        JSONObject := JSONArray[0] as TJSONObject;

        senha := JSONObject.GetValue('SENHA').Value;

        if (JSONObject.GetValue('BLOQ').Value = '0') then
        begin
            if (senha.ToUpper = MD5String(edtSenha.Text).ToUpper)  then
            begin
              recDireitaLogin.Free;
              picImageLogo.Free;

              frmLogin.WindowState := TWindowState.wsMaximized;

              Application.CreateForm(TfrmMenuPrincipal, frmMenuPrincipal);

              LayoutPadraoC := frmMenuPrincipal.FindComponent('LayoutMenu');

              frmLogin.LayoutPadrao.AddObject(TLayout(LayoutPadraoC));
            end else
            begin
              lblAviso.Text := 'Senha Incorreta!';
              lblAviso.Visible := True;
            end;
        end else
        begin
          lblAviso.Text := 'Usuario Bloqueado!';
          lblAviso.Visible := True;
        end;
      end else
      begin
        lblAviso.Text := 'Usuáro não encontrado!';
        lblAviso.Visible := True;
      end;
    end;
  end else
  begin
     lblAviso.Text := 'Existem campos obrigatórios!';
     lblAviso.Visible := True;
  end;
end;


//§§§§§§§§§§§§§§§§ - SOCIAL CLICK - §§§§§§§§§§§§§§§§§
procedure TfrmLogin.imgInstagramDblClick(Sender: TObject);
var
  URL: string;
begin
  URL := 'https://www.instagram.com';

  ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLogin.imgLinkedinDblClick(Sender: TObject);
var
  URL: string;
begin
  URL := 'https://www.linkedin.com/';

  ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLogin.imgXDblClick(Sender: TObject);
var
  URL: string;
begin
  URL := 'https://www.x.com';

  ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmLogin.Image2DblClick(Sender: TObject);
var
  URL: string;
begin
  URL := 'https://www.corbeno.com';

  ShellExecute(0, 'open', PChar(URL), nil, nil, SW_SHOWNORMAL);
end;

//§§§§§§§§§§§§§§§§ - FIM SOCIAL CLICK - §§§§§§§§§§§§§§§§§




//§§§§§§§§§§§§§§§§ - TAB ORDER IMPORVISO - §§§§§§§§§§§§§§§§§
procedure TfrmLogin.edtUsuarioKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: WideChar; Shift: TShiftState);
begin
   if Key = vkTab then
  begin
    edtSenha.SetFocus;
    Key := 0;
  end;
end;
//§§§§§§§§§§§§§§ - FIM TAB ORDER IMPORVISO - §§§§§§§§§§§§§§§




//§§§§§§§§§§§§§§§§§§§§ - COR BOTÕES - §§§§§§§§§§§§§§§§§§§§
procedure TfrmLogin.recEntrarMouseEnter(Sender: TObject);
begin
  recEntrar.Fill.Color := TAlphaColor($FF00445E);
end;

procedure TfrmLogin.recEntrarMouseLeave(Sender: TObject);
begin
  recEntrar.Fill.Color := TAlphaColor($FF00678D);
end;

procedure TfrmLogin.recImageEyeMouseEnter(Sender: TObject);
begin
  imgVerSenha.ImageIndex := 0;
  edtSenha.Password := False;
end;

procedure TfrmLogin.recImageEyeMouseLeave(Sender: TObject);
begin
  imgVerSenha.ImageIndex := 1;
  edtSenha.Password := True;
end;

procedure TfrmLogin.recSairMouseEnter(Sender: TObject);
begin
  recSair.Fill.Color := TAlphaColor($FF4C4C4C);
end;

procedure TfrmLogin.recSairMouseLeave(Sender: TObject);
begin
  recSair.Fill.Color := TAlphaCOlor($FF655D5D);
end;
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§




//§§§§§§§§§§§§§§§§§§§§ - SAIR - §§§§§§§§§§§§§§§§§§§§§§§§§§
procedure TfrmLogin.recSairClick(Sender: TObject);
begin
  Application.Terminate;
end;
//§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§

end.

{

if Not Assigned(frmMenuPrincipal) then
                Application.CreateForm(TfrmMenuPrincipal, frmMenuPrincipal);

        frmMenuPrincipal.ShowModal(procedure(ModalResult: TModalResult)
                        begin
                                if ModalResult = mrOk then
                                begin
                                  Showmessage('Clicou OK...');
                                end;
                        end);

}
