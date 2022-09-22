unit UFrmMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, ComCtrls;

type

  { TFrmMain }

  TFrmMain = class(TForm)
    CoolBar1: TCoolBar;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    OpenDialog1: TOpenDialog;
    procedure CoolBar1Change(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }

  end;

var
  FrmMain: TFrmMain;

implementation

uses UFrmDma2;
{$R *.lfm}

{ TFrmMain }

procedure TFrmMain.CoolBar1Change(Sender: TObject);
begin

end;

procedure TFrmMain.MenuItem2Click(Sender: TObject);
var
  Filename:String;
begin
  if opendialog1.Execute then
  begin
    filename:=opendialog1.FileName;
    FrmDma2:=TFrmDMA2.Create(self,Filename);
    FrmDMA2.Show;
   end;
end;

procedure TFrmMain.MenuItem3Click(Sender: TObject);
begin
  Close;
end;

end.

