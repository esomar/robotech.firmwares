program Panzer;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  unComPort in 'unComPort.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
