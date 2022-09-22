unit UFrmLog;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TFrmLog }

  TFrmLog = class(TForm)
    Memo1: TMemo;
  private

  public
    Procedure Log(aStr:String);
  end;

var
  FrmLog: TFrmLog;

implementation

{$R *.lfm}

{ TFrmLog }

procedure TFrmLog.Log(aStr: String);
begin
  Memo1.Lines.Add(aStr);
end;

end.

