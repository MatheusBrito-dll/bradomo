program Bradomo;

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.TabControl,
  System.Actions,
  FMX.ActnList,
  FMX.Layouts,
  unMenuPrincipal in '_base\unMenuPrincipal.pas' {frmMenuPrincipal},
  uApi in '_api\uApi.pas',
  unGlobal in '_base\unGlobal.pas',
  unMD5 in '_criptografia\unMD5.pas',
  fmMesaReservada in '_frames\fmMesaReservada.pas' {frameMesaReservada: TFrame},
  unControleDeMesa in '_base\unControleDeMesa.pas' {frmControleDeMesa},
  unGerenciarMesas in '_base\unGerenciarMesas.pas' {fmrGerenciarMesas},
  unDMMySql in '_dms\unDMMySql.pas' {dmServerMySQL: TDataModule},
  fmControledeMesas in '_frames\fmControledeMesas.pas' {FrameControleDeMesa: TFrame},
  unLogin in 'unLogin.pas' {frmLogin},
  fmAnimationLoading in '_frames\fmAnimationLoading.pas' {FrameLoading: TFrame};

{$R *.res}
begin
  Application.Initialize;
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.
