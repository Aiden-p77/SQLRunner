program SQLRunner;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {fMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Lavender Classico');
  Application.CreateForm(TfMain, fMain);
  Application.Run;
end.
