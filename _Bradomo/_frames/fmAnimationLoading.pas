unit fmAnimationLoading;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Ani;

type
  TFrameLoading = class(TFrame)
    Arc1: TArc;
    Rectangle1: TRectangle;
    FloatAnimation1: TFloatAnimation;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TFrameLoading.Timer1Timer(Sender: TObject);
begin
  FloatAnimation1.Start;
end;

end.
