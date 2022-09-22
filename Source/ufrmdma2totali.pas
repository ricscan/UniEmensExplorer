unit ufrmdma2Totali;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids, Menus,
  StdCtrls, U2ClsUniEmens;

type

  { TFrmDMA2Totali }

  TFrmDMA2Totali = class(TForm)
    Button1: TButton;
    SGZ: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure SGZDrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect;
      aState: TGridDrawState);
    procedure SGZPrepareCanvas(sender: TObject; aCol, aRow: Integer;
      aState: TGridDrawState);
  private
    { private declarations }
    PosPA:TPosPA;
  public
    { public declarations }
    Procedure LoadPosPa(aPosPa:TPosPa);
  end;

var
  FrmDMA2Totali: TFrmDMA2Totali;

implementation

uses UUtilFunz;

{$R *.lfm}

{ TFrmDMA2Totali }

procedure TFrmDMA2Totali.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree;
  FrmDMA2Totali :=nil;
end;

procedure TFrmDMA2Totali.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmDMA2Totali.SGZDrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
var
  s : string;
  LDelta : integer;
begin
  if (ACol>0) and (ARow>0) then
  begin
    s     := SGZ.Cells[ACol, ARow];
    LDelta := SGZ.ColWidths[ACol] - Canvas.TextWidth(s);
    Canvas.TextRect(ARect, ARect.Left+LDelta, ARect.Top+2, s);
  end
  else
  Canvas.TextRect(ARect, ARect.Left+2, ARect.Top+2, SGZ.Cells[ACol, ARow]);
end;

procedure TFrmDMA2Totali.SGZPrepareCanvas(sender: TObject; aCol, aRow: Integer;
  aState: TGridDrawState);
var
  ts: TTextStyle;
begin
  if ARow=0 then
    SGZ.Canvas.Font.Style := [fsBold];        // bold for header row
  if (ACol > 0) then begin                     // centered alignment for all data cells
    ts := SGZ.Canvas.TextStyle;
    ts.Alignment := taRightJustify;
    SGZ.Canvas.TextStyle := ts;
    if SGZ.Cells[ACol, ARow] = '00:00' then   // not interesting cells in silver
      SGZ.Canvas.Font.Color := clSilver;
  end;
end;

procedure TFrmDMA2Totali.LoadPosPa(aPosPa: TPosPa);
var
   t,t1,tsgravi,n:integer;
   QE0:TQuadriE0;
   QF1:TQuadriF1;
   QV1:TQuadriV1;
   G:TGestioni;
   F:TF1_Ammortamento;
   TotDipC1:Integer;
   TotImpC1:Currency = 0;
   TotContrC1:Currency = 0;
   TotSgravi :Currency = 0;
   TotDipE0:Integer;
   TotDipC2:Integer;
   TotQuadriC2,TotImpC2,TotContrC2,TotImpContrAdd1:Currency;
   TotDipC2Risc,TotContRisc:Currency;
   TotDipC2Rico,TotContRico:Currency;
   TotDipC6,TotDipC6TFR,TotDipC6TFS:Integer;
   TotQuadriC6,TotImpTFRC6,TotContrTFRC6,TotImpTFSC6,TotContrTFSC6:Currency;
   TotDipC8ENPDEP:Integer;
   TotImpENPDEPC8,TotContrENPDEPC8:Currency;
   TotDipC9CREDITI:Integer;
   TotImpCREDITIC9,TotContrCREDITIC9:Currency;

   TotDipRisc,TotDipRico:Integer;
   riga :Integer;
begin
  PosPa:=aPosPa;
  TotDipE0   :=0;
  TotImpC2   :=0;
  TotContrC2 :=0;
  TotImpContrAdd1 :=0;
  TotSgravi       :=0;

  TotDipC2Risc :=0;
  TotContRisc  :=0;

  TotDipC2Rico:=0;
  TotContRico :=0;

  TotDipRisc  :=0;
  TotDipRico  :=0;

  TotDipC6      :=0;
  TotDipC6TFR   :=0;
  TotDipC6TFS   :=0;
  TotQuadriC6   :=0;
  TotImpTFRC6   :=0;
  TotContrTFRC6 :=0;
  TotImpTFSC6   :=0;
  TotContrTFSC6 :=0;

  TotDipC8ENPDEP:=0;
  TotImpENPDEPC8:=0;
  TotContrENPDEPC8:=0;

  TotDipC9CREDITI:=0;
  TotImpCREDITIC9:=0;
  TotContrCREDITIC9:=0;

  //Cicla tra i dipendenti
  SGZ.Cells[1,2]:=inttostr(posPa.Count-1);
  for t:=0 to posPa.Count-1 do
  begin

    QE0:=PosPa.Items[t].QuadriE0;
    //TotDipE0 := QE0.Count;
    for t1:=0 to QE0.Count-1 do
    begin

      TOTDipE0:=TotDipE0+1;
      G:=QE0.items[t1].Gestioni;
      //CPDEL
      TotImpC2        :=TotImpC2+G.GestPensionistica.Imponibile;
      TotContrC2      :=TotContrC2+G.GestPensionistica.Contributo;
      TotImpContrAdd1 :=TotImpContrAdd1+g.GestPensionistica.Contrib1PerCento;
      n:=Length(G.GestPensionistica.RecuperoSgravi);
      for tsgravi:=0 to n-1 do begin
        TotSgravi:=TotSgravi+G.GestPensionistica.RecuperoSgravi[tsgravi].importo
      end;

      //TFR
      if g.GestPrevidenziale.ContributoTFR>0
        then TotDipC6TFR:=TotDipC6TFR+1;
      TotImpTFRC6 := TotImpTFRC6+G.GestPrevidenziale.ImponibileTFR;
      TotContrTFRC6 :=TotContrTFRC6+G.GestPrevidenziale.ContributoTFR;

      //TFS
      if g.GestPrevidenziale.ContributoTFS>0
        then TotDipC6TFS:=TotDipC6TFS+1;
      TotImpTFSC6 :=TotImpTFSC6+G.GestPrevidenziale.ImponibileTFS;
      TotContrTFSC6 :=TotContrTFSC6+G.GestPrevidenziale.ContributoTFS;

      //ENPDEP
      if g.ENPDEP.Contributo>0
        then TotDipC8ENPDEP:=TotDipC8ENPDEP+1;
      TotImpENPDEPC8 :=TotImpENPDEPC8+G.ENPDEP.Imponibile;
      TotContrENPDEPC8 :=TotContrENPDEPC8+G.ENPDEP.Contributo;

      //CREDITI
     if g.GestCredito.Contributo>0
        then TotDipC9CREDITI:=TotDipC9CREDITI+1;
      TotImpCREDITIC9 :=TotImpCREDITIC9+G.GestCredito.Imponibile;
      TotContrCREDITIC9 :=TotContrCREDITIC9+G.GestCredito.Contributo;
    end;

    //SGRAVIO


    QF1:=PosPa.Items[t].QuadriF1;
    for t1:=0 to QF1.Count-1 do
    begin
      F:=QF1.items[t1];
      if f.TipoPiano=11 then
      begin
       TotDipRisc:=TotDipRisc+1;
       TotContRisc:=TotContRisc+F.Importo;
      end;

      if f.TipoPiano=12 then
      begin
       TotDipRico:=TotDipRico+1;
       TotContRico:=TotContRico+F.Importo;
      end;
    end;

    QV1:=PosPa.Items[t].QuadriV1;
    for t1:=0 to QV1.Count-1 do
    begin
      G:=QV1.items[t1].Gestioni;
      TotImpC2        :=TotImpC2+G.GestPensionistica.Imponibile;
      TotContrC2      :=TotContrC2+G.GestPensionistica.Contributo;
      TotImpContrAdd1 :=TotImpContrAdd1+g.GestPensionistica.Contrib1PerCento;

      if g.GestPrevidenziale.ContributoTFR>0
        then TotDipC6TFR:=TotDipC6TFR+1;
      TotImpTFRC6 :=TotImpTFRC6+G.GestPrevidenziale.ImponibileTFR;
      TotContrTFRC6 :=TotContrTFRC6+G.GestPrevidenziale.ContributoTFR;

      if g.GestPrevidenziale.ContributoTFS>0
        then TotDipC6TFS:=TotDipC6TFS+1;
      TotImpTFSC6 :=TotImpTFSC6+G.GestPrevidenziale.ImponibileTFS;
      TotContrTFSC6 :=TotContrTFSC6+G.GestPrevidenziale.ContributoTFS;

       //ENPDEP
       if g.ENPDEP.Contributo>0
        then TotDipC8ENPDEP:=TotDipC8ENPDEP+1;
      TotImpENPDEPC8 :=TotImpENPDEPC8+G.ENPDEP.Imponibile;
      TotContrENPDEPC8 :=TotContrENPDEPC8+G.ENPDEP.Contributo;

      //CREDITI
     if g.GestCredito.Contributo>0
        then TotDipC9CREDITI:=TotDipC9CREDITI+1;
      TotImpCREDITIC9 :=TotImpCREDITIC9+G.GestCredito.Imponibile;
      TotContrCREDITIC9 :=TotContrCREDITIC9+G.GestCredito.Contributo;
    end;


  end;
  riga:=0;
  SGZ.Cells[0,riga]:='CASSA';
  SGZ.Cells[1,riga]:='Contributo';
  SGZ.Cells[2,riga]:='Num.Dip';
  SGZ.Cells[3,riga]:='Imponibile';
  SGZ.Cells[4,riga]:='Conto Ente';
  SGZ.Cells[5,riga]:='Conto Dip';
  SGZ.Cells[9,riga]:='TOTALE';

  riga:=riga+2;
  SGZ.Cells[0,riga]:='1';
  SGZ.Cells[1,riga]:='CPTPS';
  SGZ.Cells[3,riga]:=IntToStr(TotDipC1);
  SGZ.Cells[3,riga]:=CurrToStrPt(TotImpC1);
  SGZ.Cells[4,riga]:=CurrToStrPt(TotContrC1);
//  SGZ.Cells[5,riga]:=CurrToStrPt(TotImpContrAdd1);
//  SGZ.Cells[9,riga]:=CurrToStrPt(TotContrC2+TotImpContrAdd1);

  riga:=riga+2;
  SGZ.Cells[0,riga]:='2';
  SGZ.Cells[1,riga]:='CPDEL';
  SGZ.Cells[2,riga]:=IntToStr(TotDipE0);
  SGZ.Cells[3,riga]:=CurrToStrPt(TotImpC2);
  SGZ.Cells[4,riga]:=CurrToStrPt(TotContrC2);
  SGZ.Cells[5,riga]:=CurrToStrPt(TotImpContrAdd1);
  SGZ.Cells[9,riga]:=CurrToStrPt(TotContrC2+TotImpContrAdd1);

  riga:=Riga+1;
  SGZ.Cells[0,riga]:=' ';
  SGZ.Cells[1,riga]:='SGRAVI';
  SGZ.Cells[9,riga]:=CurrToStrPt(TotSgravi);
  riga:=Riga+1;
  SGZ.Cells[0,riga]:=' ';
  SGZ.Cells[1,riga]:='Totale CPDEL';
  SGZ.Cells[9,riga]:=CurrToStrPt(TotContrC2+TotImpContrAdd1-TotSgravi);

  riga:=riga+2;
  SGZ.Cells[0,riga]:='2';
  SGZ.Cells[1,riga]:='Riscatti';
  SGZ.Cells[2,riga]:=IntToStr(TotDipRisc);
  SGZ.Cells[5,riga]:=CurrToStrPt(TotContRisc);
  SGZ.Cells[9,riga]:=CurrToStrPt(TotContRisc);
  riga:=riga+1;
  SGZ.Cells[0,riga]:='2';
  SGZ.Cells[1,riga]:='Ricongiunzioni';
  SGZ.Cells[2,riga]:=IntToStr(TotDipRico);
  SGZ.Cells[5,riga]:=CurrToStrPt(TotContRico);
  SGZ.Cells[9,riga]:=CurrToStrPt(TotContRico);
  riga:=riga+2;
  SGZ.Cells[0,riga]:='6';
  SGZ.Cells[1,riga]:='TFR';
  SGZ.Cells[2,riga]:=IntToStr(TotDipC6TFR);
  SGZ.Cells[3,riga]:=CurrToStrPt(TotImpTFRC6);
  SGZ.Cells[4,riga]:=CurrToStrPt(TotContrTFRC6);
  SGZ.Cells[9,riga]:=CurrToStrPt(TotContrTFRC6);
  riga:=riga+1;
  SGZ.Cells[0,riga]:='6';
  SGZ.Cells[1,riga]:='TFS';
  SGZ.Cells[2,riga]:=IntToStr(TotDipC6TFS);
  SGZ.Cells[3,riga]:=CurrToStrPt(TotImpTFSC6);
  SGZ.Cells[4,riga]:=CurrToStrPt(TotContrTFSC6);
  SGZ.Cells[9,riga]:=CurrToStrPt(TotContrTFSC6);
  riga:=riga+2;
  SGZ.Cells[0,riga]:='8';
  SGZ.Cells[1,riga]:='ENPDEP';

   SGZ.Cells[2,riga]:=IntToStr(TotDipC8ENPDEP);
   SGZ.cells[3,riga]:=CurrToStrPt(TotImpENPDEPC8);
   SGZ.cells[4,riga]:=CurrToStrPt(TotContrENPDEPC8);
   SGZ.Cells[9,riga]:=CurrToStrPt(TotContrENPDEPC8);

  riga:=riga+2;
  SGZ.Cells[0,riga]:='9';
  SGZ.Cells[1,riga]:='Crediti';
  SGZ.Cells[2,riga]:=IntToStr(TotDipC9CREDITI);
   SGZ.cells[3,riga]:=CurrToStrPt(TotImpCREDITIC9);
   SGZ.cells[4,riga]:=CurrToStrPt(TotContrCREDITIC9);
   SGZ.Cells[9,riga]:=CurrToStrPt(TotContrCREDITIC9);



end;

end.

