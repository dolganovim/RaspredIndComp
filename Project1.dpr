program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  URasp in 'URasp.pas',
  UFaseSos in 'UFaseSos.pas',
  UClasses in 'UClasses.pas',
  UBaseConzRecalc in 'UBaseConzRecalc.pas',
  GenMethod in 'GenMethod.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
