unit Loading;

interface

uses
  System.SysUtils, System.UITypes, FMX.Types, FMX.Controls, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Layouts, FMX.Forms, FMX.Graphics, FMX.Ani,
  FMX.VirtualKeyboard, FMX.Platform;

type
  TLoading = class
  private
    class var
      Fundo: TRectangle;
      Arco: TArc;
      Mensagem: TLabel;
      Animacao: TFloatAnimation;
  public
    class procedure Show(const ParentRect: TRectangle; const msg: string);
    class procedure Hide;
  end;

implementation

{ TLoading }

class procedure TLoading.Hide;
begin
  if Assigned(Fundo) then
  begin
    try
      Fundo.DisposeOf;
      Arco.DisposeOf;
      Mensagem.DisposeOf;
      Animacao.DisposeOf;
    except
    end;
  end;
end;

class procedure TLoading.Show(const ParentRect: TRectangle; const msg: string);
var
  Layout: TLayout;
begin
  if Assigned(ParentRect) then
  begin
    // Layout contendo a animação e a mensagem...
    Layout := TLayout.Create(ParentRect.Parent);
    Layout.Parent := ParentRect.Parent;
    Layout.Align := TAlignLayout.Contents;

    // Adiciona a animação e a mensagem ao layout...
    Arco := TArc.Create(Layout);
    Arco.Parent := Layout;
    Arco.Align := TAlignLayout.Center;
    Arco.Width := 25;
    Arco.Height := 25;
    Arco.EndAngle := 280;
    Arco.Stroke.Color := $FFFEFFFF;
    Arco.Stroke.Thickness := 2;

    Animacao := TFloatAnimation.Create(Layout);
    Animacao.Parent := Arco;
    Animacao.StartValue := 0;
    Animacao.StopValue := 360;
    Animacao.Duration := 0.8;
    Animacao.Loop := True;
    Animacao.PropertyName := 'RotationAngle';
    Animacao.AnimationType := TAnimationType.InOut;
    Animacao.Interpolation := TInterpolationType.Linear;
    Animacao.Start;

    Mensagem := TLabel.Create(Layout);
    Mensagem.Parent := Layout;
    Mensagem.Align := TAlignLayout.Center;
    Mensagem.Margins.Top := 60;
    Mensagem.Font.Size := 13;
    Mensagem.Height := 70;
    Mensagem.Width := ParentRect.Width - 100;
    Mensagem.FontColor := $FFFEFFFF;
    Mensagem.TextSettings.HorzAlign := TTextAlign.Center;
    Mensagem.TextSettings.VertAlign := TTextAlign.Leading;
    Mensagem.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
    Mensagem.Text := msg;
    Mensagem.VertTextAlign := TTextAlign.Leading;
    Mensagem.Trimming := TTextTrimming.None;
    Mensagem.TabStop := False;
    Mensagem.SetFocus;

    // Exibe o layout e fundo...
    Layout.BringToFront;
  end;
end;

end.

