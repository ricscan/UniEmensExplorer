program UniEmensExplorer;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, UfrmDma2, UFrmMain,
ufrmdma2Totali, UUtilFunz, UClsUniEmensTab, U2ClsUniemens, UFrmLog, UXMLUtil
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmLog, FrmLog);
  Application.Run;
end.

