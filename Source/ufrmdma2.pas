unit UfrmDma2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Menus, Grids, ValEdit, UClsUniEmens;

type

  { TFrmDMA2 }

  TFrmDMA2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CBE0: TCheckBox;
    CBE1: TCheckBox;
    BQC: TCheckBox;
    CBF1: TCheckBox;
    CBV1: TCheckBox;
    Edit1: TEdit;
    Label6: TLabel;
    SG_D1: TStringGrid;
    SG_V1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ListView1: TListView;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    SG_D0: TStringGrid;
    SG_E0: TStringGrid;
    SG_F1: TStringGrid;
    Splitter1: TSplitter;
    SG_Sgravi: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TVQuadri: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CBE0Change(Sender: TObject);
    procedure CBE1Change(Sender: TObject);
    procedure CBF1Change(Sender: TObject);
    procedure CBV1Change(Sender: TObject);
    procedure ECodGestPensChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure F1_Tip_AmmChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LeD0CFChange(Sender: TObject);
    procedure ListView1Change(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure ScrollBox1Click(Sender: TObject);
    procedure SG_V1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect;
      aState: TGridDrawState);
    procedure TVQuadriClick(Sender: TObject);
  private
    { private declarations }
    Filename:String;
    PosPa   :TPosPa;
    CurD0   :TD0_DenunciaIndividuale;
    Procedure FillForm;
    Procedure FillD0(D0:TD0_DenunciaIndividuale);
    Procedure FillE0(E0:TE0_PeriodoNelMese);
    Procedure FillF1(F1:TF1_Ammortamento);
    Procedure FillV1(V1:TV1_PeriodoPrecedente);
    Procedure INITD0;
  public
    { public declarations }
    Constructor Create(TheOwner: TComponent;fn:String); Overload;
    Destructor Destroy;
  end;

var
  FrmDMA2: TFrmDMA2;

implementation

uses uParseXML,ufrmdma2Totali,UUtilFunz,UClsUniEmensTab;

{$R *.lfm}


{ TFrmDMA2 }

constructor TFrmDMA2.Create(TheOwner: TComponent; fn: String);
begin
  inherited Create(TheOwner);
  Filename:=fn;
end;

destructor TFrmDMA2.Destroy;
begin

end;
procedure TFrmDMA2.ECodGestPensChange(Sender: TObject);
var
   e:TEdit;
begin
  E := Sender as TEDIT;
  if E.Text=''
    then E.Color:=clwhite
    else E.Color:=clYellow;
end;

procedure TFrmDMA2.Edit1Change(Sender: TObject);
begin
  FillForm;
end;

procedure TFrmDMA2.Button1Click(Sender: TObject);
begin
  if FrmDMA2Totali=nil then
  begin
    FrmDMA2Totali:=TFrmDMA2Totali.Create(self);
    FrmDMA2Totali.LoadPosPa(PosPa);
    FrmDMA2Totali.Show;
  end;
end;

procedure TFrmDMA2.Button2Click(Sender: TObject);
begin
  Edit1.text:='';
end;

procedure TFrmDMA2.CBE0Change(Sender: TObject);
begin
  FillForm;
end;

procedure TFrmDMA2.CBE1Change(Sender: TObject);
begin
 FillForm
end;

procedure TFrmDMA2.CBF1Change(Sender: TObject);
begin
  FillForm
end;

procedure TFrmDMA2.CBV1Change(Sender: TObject);
begin
  FillForm
end;

procedure TFrmDMA2.F1_Tip_AmmChange(Sender: TObject);
begin

end;


procedure TFrmDMA2.FormCreate(Sender: TObject);
begin
  PosPa:=TPosPa.Create;
  Caption:='DMA2 - '+Filename;
  LoadDMA2(Filename,PosPa);
  FillForm;
  INITD0;
end;
procedure TFrmDMA2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;

end;
procedure TFrmDMA2.FormDestroy(Sender: TObject);
begin
  PosPa.free;
end;

procedure TFrmDMA2.LeD0CFChange(Sender: TObject);
var
  L:TLabeledEdit;
begin
  L:=Sender as TLabeledEdit;
  if L.Text=''
    then L.Color:=clwhite
    else L.Color:=clYellow;
end;

procedure TFrmDMA2.ListView1Change(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  D0:TD0_DenunciaIndividuale;
  i:integer;

begin
  i:=ListView1.ItemIndex;
  if i<>-1 then
  begin
    D0:= TD0_DenunciaIndividuale(ListView1.Items[i].data);
    CurD0:=D0;
    FillD0(D0)
  end;
  if not BQC.Checked then Pagecontrol1.ActivePageIndex:=0;
end;

procedure TFrmDMA2.PageControl1Change(Sender: TObject);
begin

end;

procedure TFrmDMA2.PageControl2Change(Sender: TObject);
begin

end;

procedure TFrmDMA2.ScrollBox1Click(Sender: TObject);
begin

end;

procedure TFrmDMA2.SG_V1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
  txt:String;
  SG:TStringGrid;
  s : string;
  LDelta : integer;
begin
  SG:=Sender as TSTringGrid;
  txt := SG.Cells[1,aRow];
  s := SG.Cells[ACol, ARow];

  if aCol=1 then
  begin
    SG.Canvas.Brush.Color:=RGBToColor(240,240,240);
    SG.Canvas.fillRect(arect);
  end;
  if (txt<>'') and (txt[1]='/') then
   begin
    SG.Canvas.Brush.Color:=CLBLUE;
    SG.Canvas.fillRect(arect);
    SG.Font.Bold:=True;
    SG.Font.Color:=clYellow;
   end;
   if ACol=2 then
   begin
       LDelta := SG.ColWidths[ACol] - SG.Canvas.TextWidth(s)-2;
       SG.Canvas.TextRect(ARect, ARect.Left+LDelta, ARect.Top+2, s);
   end
   else SG.Canvas.TextOut(aRect.Left + 2, aRect.Top + 1, SG.Cells[ACol,ARow]);

    SG.Font.Bold:=False;
    SG.Font.Color:=clBlack;
end;

procedure TFrmDMA2.TVQuadriClick(Sender: TObject);
var Nodo,child:TTreenode;
   indice,quadro:integer;
begin
  Nodo:=TVQuadri.Selected;
  quadro:=Integer(Nodo.Data) div 1000;
  Indice:=integer(Nodo.Data) mod 1000;
  Pagecontrol1.ActivePageIndex:= quadro;
  if quadro = 1 then FillE0(CurD0.QuadriE0[indice]);
  //if quadro = 2 then FillE1(CurD0.QuadriE1[indice]);
  if quadro = 3 then FillF1(CurD0.QuadriF1[indice]);
  if quadro = 4 then FillV1(CurD0.QuadriV1[indice]);
end;

procedure TFrmDMA2.FillD0(D0: TD0_DenunciaIndividuale);
var
    Nodo,child:TTreenode;
    t:Integer;
begin
  SG_D0.Cells[2,0]:=D0.CFLavoratore;
  SG_D0.Cells[2,1]:=D0.Cognome;
  SG_D0.Cells[2,2]:=D0.Nome;
  SG_D0.Cells[2,4]:=D0.DatiSedeLavoro.CodiceComune;
  SG_D0.Cells[2,5]:=D0.DatiSedeLavoro.CAP;

  if D0.QuadriE0.Count>0 then FillE0(D0.QuadriE0[0]);
  if D0.QuadriF1.Count>0 then FillF1(D0.QuadriF1[0]);
  if D0.QuadriV1.Count>0 then FillV1(D0.QuadriV1[0]);

  TVQuadri.Items.Clear;
  nodo :=TVQuadri.Items.Add(nil,'Quadri E0');
  for t:=0 to D0.QuadriE0.Count-1 do
  begin
    child:=TVQuadri.Items.AddChild(nodo,D0.QuadriE0[t].Periodo);
    child.Data:=Pointer(1000+t);
  end;
  nodo.Expanded:=true;

  nodo:=TVQuadri.Items.Add(nil,'Quadri E1');
  for t:=0 to D0.QuadriE1.Count-1 do
  begin
    child:=TVQuadri.Items.AddChild(nodo,D0.QuadriE1[t].Periodo);
    child.Data:=Pointer(2000+t);
  end;
  nodo.Expanded:=true;

  nodo:=TVQuadri.Items.Add(nil,'Quadri F1');
  for t:=0 to D0.QuadriF1.Count-1 do
  begin
    child:=TVQuadri.Items.AddChild(nodo,D0.QuadriF1[t].Periodo);
    child.Data:=Pointer(3000+t);
  end;
  nodo.Expanded:=true;

  nodo:=TVQuadri.Items.Add(nil,'Quadri V1');
  for t:=0 to D0.QuadriV1.Count-1 do
  begin
    child:=TVQuadri.Items.AddChild(nodo,D0.QuadriV1[t].Periodo);
    child.Data:=Pointer(4000+t);
  end;
  nodo.Expanded:=true;
end;

procedure TFrmDMA2.FillForm;
var
  t:Integer;
  D0:TD0_DenunciaIndividuale;
  e:TListItem;
  n:Integer;
  Showi:boolean;
  s:string;
begin
  s:=Edit1.text;
  ListView1.Items.clear;
  for t:=0 to PosPa.Count-1 do
    begin
      D0 := PosPa.items[t];
      showi:=False;
      if CBE0.Checked and (D0.QuadriE0.Count>0)then showi:=True;
      if CBE1.Checked and (D0.QuadriE1.Count>0)then showi:=True;
      if CBF1.Checked and (D0.QuadriF1.Count>0)then showi:=True;
      if CBV1.Checked and (D0.QuadriV1.Count>0)then showi:=True;
      if s<>'' then
      begin
        if Pos(s,D0.Nominativo)>0
          then showi:=True
          else showi:=false;
      end;

      if Showi then
      begin
      e:=ListView1.Items.Add;
      e.Caption:=inttostr(t+1);
      e.subitems.add(D0.Nominativo);
      e.subitems.Add(D0.CFLavoratore);
      n:=D0.QuadriE0.Count;
      if n>1
        then e.SubItems.add('E0+')
        else if n>0 then e.SubItems.add('E0')
          else e.SubItems.add('');

      n:=D0.QuadriE1.Count;
      if n>1
        then e.SubItems.add('E1+')
        else if n>0 then e.SubItems.add('E1')
          else e.SubItems.add('');

      n:=D0.QuadriF1.Count;
      if n>1
        then e.SubItems.add('F1+')
        else if n>0 then e.SubItems.add('F1')
          else e.SubItems.add('');

      n:=D0.QuadriV1.Count;
      if n>1
        then e.SubItems.add('V1+')
        else if n>0 then e.SubItems.add('V1')
          else e.SubItems.add('');

      e.Data:=D0;
      end;
    end;
end;

procedure TFrmDMA2.FillE0(E0:TE0_PeriodoNelMese);
begin
  E0.FillSG(SG_E0,SG_Sgravi);
end;

procedure TFrmDMA2.FillF1(F1: TF1_Ammortamento);
begin
  F1.FillSG(SG_F1);
end;

procedure TFrmDMA2.FillV1(V1: TV1_PeriodoPrecedente);
begin
  V1.FillSG(SG_V1);
end;

procedure TFrmDMA2.INITD0;
var rowpos:Integer;
 procedure AddLine(s:string);
 begin
   SG_D0.cells[1,RowPos]:=s;
   SG_D0.cells[0,RowPos]:=IntToStr(RowPos);
   inc(RowPos)
 end;
begin
  //SG_E0.Clear;
  SG_D0.ColWidths[0]:=20;
  SG_D0.ColWidths[1]:=150;
  SG_D0.ColWidths[2]:=200;
  SG_D0.ColWidths[3]:=100;
  rowpos:=0;
  addLine('Codice Fiscale');
  addLine('Cognome');
  addLine('Nome');
  addLine('/DATI SEDE LAVORO');
  addLine('Codice Comune');
  addLine('CAP');
end;

end.

