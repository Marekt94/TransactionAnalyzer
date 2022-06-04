program Project8;

uses
  Vcl.Forms,
  Unit6 in '..\..\..\..\..\..\Desktop\Unit6.pas' {Form6},
  InterfaceKernel in '..\Kernel\InterfaceKernel.pas',
  Kernel in '..\Kernel\Kernel.pas',
  WindowSkeleton in '..\Kernel\WindowSkeleton.pas' {WndSkeleton},
  InterfaceModule in 'InterfaceModule.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.
