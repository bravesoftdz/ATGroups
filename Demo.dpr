program Demo;

uses
  Forms,
  {$ifdef FPC}
  Interfaces,
  {$endif}
  Unit1 in 'Unit1.pas' {Form1},
  ATGroups in 'ATGroups.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
