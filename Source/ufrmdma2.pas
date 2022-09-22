unit UfrmDma2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Menus, Grids, ValEdit,U2ClsUniemens;

type

  { TFrmDMA2 }

  TFrmDMA2 = class(TForm)
    BQC: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    CBE0: TCheckBox;
    CBE1: TCheckBox;
    CBF1: TCheckBox;
    CBV1: TCheckBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    Panel2: TPanel;
    ListView1: TListView;
    PageControl2: TPageControl;
    Panel1: TPanel;
    SG_D0: TStringGrid;
    SG_E1: TStringGrid;
    SG_E0: TStringGrid;
    SG_F1: TStringGrid;
    SG_Sgravi: TStringGrid;
    SG_V1: TStringGrid;
    Splitter1: TSplitter;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
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
    UniEmens:TUniemens;
    //PosPa   :TPosPa0;
    CurD0   :TD0_DenunciaIndividuale;
    Procedure FillForm;
    Procedure FillD0(D0:TD0_DenunciaIndividuale);
    Procedure FillE0(E0:TE0_PeriodoNelMese);
    Procedure FillE1(E1:TE1_FondoPensioneCompl);
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

uses ufrmdma2Totali,UUtilFunz,UClsUniEmensTab;

{$R *.lfm}


{ TFrmDMA2 }

constructor TFrmDMA2.Create(TheOwner: TComponent; fn: String);
begin
  inherited Create(TheOwner);
  Filename:=fn;
  UniEmens:=TUniemens.Create;
  Uniemens.LoadXML(fn);
end;

destructor TFrmDMA2.Destroy;
begin
  Uniemens.Free;
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
    //FrmDMA2Totali.LoadPosPa(PosPa);
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
  Caption:='DMA2 - '+Filename;
  FillForm;
  INITD0;
end;
procedure TFrmDMA2.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;

end;
procedure TFrmDMA2.FormDestroy(Sender: TObject);
begin

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
  if quadro = 2 then FillE1(CurD0.QuadriE1[indice]);
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
  if D0.QuadriE1.Count>0 then FillE1(D0.QuadriE1[0]);
  if D0.QuadriF1.Count>0 then FillF1(D0.QuadriF1[0]);
  if D0.QuadriV1.Count>0 then FillV1(D0.QuadriV1[0]);

  //Riempie il treeview con l'elenco dei quadri
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
  PosPa:TposPA;
begin
  Memo1.Clear;
  //Memo1.Text:=PosPa.

  s:=Edit1.text;
  ListView1.Items.clear;
  PosPa:=Uniemens.DenunceMensili.Azienda.ListaPosPa.PosPA;
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
var
  t,n,r:Integer;
  Procedure AddLine(Campo,Valore,Descr:STring);
   begin
     SG_E0.cells[0,R]:=IntToStr(R);
     SG_E0.cells[1,R]:=Campo;
     SG_E0.cells[2,R]:=Valore;
     SG_E0.cells[3,R]:=Descr;
     inc(R)
    end;
begin
   r:=0;
   SG_E0.ColWidths[0]:=20;
   SG_E0.ColWidths[1]:=200;
   SG_E0.ColWidths[2]:=100;
   SG_E0.ColWidths[3]:=300;

   addLine('Giorno Inizio',DateToStr(E0.GiornoInizio),'');
   addLine('Giorno Fine',DateToStr(E0.GiornoFine),'');
   addLine('Codice Cessazione',inttostr(E0.CodiceCessazione),'');
   addLine('Numero Mensilità',inttostr(E0.NumeroMensilita),'');
   addLine('Retribuzione Teorica Tabellare TFR',CurrToStrpt(E0.RetribTeoricaTabellareTFR),'');
   addLine('Retribuzione Valutabile TFR',CurrToStrpt(E0.RetribValutabileTFR),'');
   addLine('Data fine beneficio calamità','','');
   addLine('Conguaglio Imponibile','','');
   addLine('AltriEnteVersante','','');

   addLine('/INQUADRAMENTO','','');
   addLine('Tipo Impiego',inttostr2(E0.InquadramentoLavPA.TipoImpiego),TipoImpiego.descr(E0.InquadramentoLavPA.TipoImpiego));
   addLine('Tipo Servizio',inttostr(E0.InquadramentoLavPA.TipoServizio),TipoServizio.descr(E0.InquadramentoLavPA.TipoServizio));
   addLine('% Retribuzione',inttostr(E0.InquadramentoLavPA.PercRetribuzione),'');
   addLine('Contratto',E0.InquadramentoLavPA.Contratto,'');
   addLine('Qualifica',E0.InquadramentoLavPA.Qualifica,_InquadramentoLavPA(E0.InquadramentoLavPA.Qualifica));
   addLine('Part-Time : Tipo',E0.InquadramentoLavPA.PartTimePa.TipoPartTime,TipoPartTime.Descr(E0.InquadramentoLavPA.PartTimePa.TipoPartTime));
   addLine('Part-Time : Percentuale',IntToStr(E0.InquadramentoLavPA.PartTimePa.PercPartTime),'');
   addLine('Orario Sett. Ridotto','','');
   addLine('Orario Sett. Comp.','','');
   addLine('Regime Fine',IntToStr(E0.InquadramentoLavPA.RegimeFineServizio),RegimeFineServizio.Descr(E0.InquadramentoLavPA.RegimeFineServizio));
   addLine('Perc. asp. (L.300/70)','','');
   addLine('/Servizio presso altra amministrazione','','');
   addLine('Tipo Servizio','','');
   addLine('C.F. altra amministrazione','','');
   addLine('Progressivo','','');

   addLine('/GESTIONE PENSIONISTICA','','');
   addLine('Codice Gestione',IntToStr(E0.Gestioni.GestPensionistica.CodGestione),_CodGestione.Descr(E0.Gestioni.GestPensionistica.CodGestione));
   addLine('Imponibile',CurrToStrPt(E0.Gestioni.GestPensionistica.Imponibile),'');
   addLine('Contributo',CurrToStrPt(E0.Gestioni.GestPensionistica.contributo),'');
   addLine('Contributo 1%',CurrToStrPt(E0.Gestioni.GestPensionistica.Contrib1PerCento),'');
   addLine('Imponibile eccedenza massimale',CurrToStrPt(E0.Gestioni.GestPensionistica.ImponibileEccMass),'');
   addLine('Giorni utili','','');
   addLine('Maggiorazione pens. D.lgs 165/2007','','');
   addLine('Retribuzione Virtuale','','');
   addLine('Eventi Calamitosi','','');
   addLine('Stipendio tabellare','','');
   addLine('Importo RIA','','');

   addLine('/GESTIONE PREVIDENZIALE','','');
   addLine('Codice Gestione',IntToStr2(E0.Gestioni.GestPrevidenziale.CodGestione),_CodGestione.Descr(E0.Gestioni.GestPrevidenziale.CodGestione));
   addLine('Imponibile TFR',CurrToStrPt(E0.Gestioni.GestPrevidenziale.ImponibileTFR),'');
   addLine('Contributo TFR',CurrToStrPt(E0.Gestioni.GestPrevidenziale.contributoTFR),'');
   addLine('Imponibile TFR Eccedena Massimale','','');
   addLine('Contributo TFS',CurrToStrPt(E0.Gestioni.GestPrevidenziale.ImponibileTFS),'');
   addLine('Imponibile TFS',CurrToStrPt(E0.Gestioni.GestPrevidenziale.contributoTFS),'');
   addLine('Imponibile TFS Eccedenza Massimale','','');
   addLine('Contributo Sospeso','','');

   addLine('/GESTIONE CREDITO','','');
   addLine('Codice Gestione',IntToStr2(E0.Gestioni.GestCredito.CodGestione),_CodGestione.Descr(E0.Gestioni.GestCredito.CodGestione));
   addLine('Imponibile',CurrToStrPt(E0.Gestioni.GestCredito.Imponibile),'');
   addLine('Contributo',CurrToStrPt(E0.Gestioni.GestCredito.contributo),'');
   addLine('Imponibile eccedenza massimale','','');
   addLine('Aderente Credito DM 45/2007','','');

   addLine('/ENPDEP','','');
   addLine('Codice',IntToStr2(E0.Gestioni.ENPDEP.CodGestione),_CodGestione.Descr(E0.Gestioni.ENPDEP.CodGestione));
   addLine('Imponibile',CurrToStrPt(E0.Gestioni.ENPDEP.Imponibile),'');
   addLine('Contributo',CurrToStrPt(E0.Gestioni.ENPDEP.contributo),'');

   addLine('/ENAM','','');
   addLine('Codice',IntToStr2(E0.Gestioni.ENAM.CodGestione),_CodGestione.Descr(E0.Gestioni.ENAM.CodGestione));
   addLine('Imponibile',CurrToStrPt(E0.Gestioni.ENAM.Imponibile),'');
   addLine('Contributo',CurrToStrPt(E0.Gestioni.ENAM.contributo),'');

   SG_Sgravi.Clean;
   SG_Sgravi.Cells[0,0]:='Anno';
   SG_Sgravi.Cells[1,0]:='Mese';
   SG_Sgravi.Cells[2,0]:='Codice';
   SG_Sgravi.Cells[3,0]:='Altro Imp';
   SG_Sgravi.Cells[4,0]:='Importo';
   n:=Length(E0.Gestioni.GestPensionistica.RecuperoSgravi);
   for t:=0 to n-1 do begin
     SG_Sgravi.Cells[0,t+1]:=IntToStr2(E0.Gestioni.GestPensionistica.RecuperoSgravi[t].Anno);
     SG_Sgravi.Cells[1,t+1]:=IntToStr2(E0.Gestioni.GestPensionistica.RecuperoSgravi[t].Mese);
     SG_Sgravi.Cells[2,t+1]:=E0.Gestioni.GestPensionistica.RecuperoSgravi[t].Codice;
     SG_Sgravi.Cells[3,t+1]:=CurrToStrPt(E0.Gestioni.GestPensionistica.RecuperoSgravi[t].AltroImponibile);
     SG_Sgravi.Cells[4,t+1]:=CurrToStrPt(E0.Gestioni.GestPensionistica.RecuperoSgravi[t].importo);
   end;


end;

procedure TFrmDMA2.FillE1(E1: TE1_FondoPensioneCompl);
var
   r:Integer;

  Procedure AddLine(Campo,Valore,Descr:STring);
  begin
    SG_E1.cells[0,R]:=IntToStr(R);
    SG_E1.cells[1,R]:=Campo;
    SG_E1.cells[2,R]:=Valore;
    SG_E1.cells[3,R]:=Descr;
    inc(R)
   end;
begin
   r:=0;
   SG_E1.ColWidths[0]:=20;
   SG_E1.ColWidths[1]:=200;
   SG_E1.ColWidths[2]:=100;
   SG_E1.ColWidths[3]:=300;
   SG_E1.RowCount:=20;

   AddLine('Codice Fondo',E1.DatiPosContribIscritto.CodFondo,'');
   AddLine('Comparto',E1.DatiPosContribIscritto.Comparto,'');
   AddLine('DataSottoscrizioneDomanda',DateToStr(E1.DatiPosContribIscritto.DataSottoscrizioneDomanda),'');
   AddLine('AnnoMeseDecorrenzaContrib',E1.DatiPosContribIscritto.AnnoMeseDecorrenzaContrib,'');
   AddLine('DataInizioPeriodo',DateToStr(E1.DatiPosContribIscritto.DataInizioPeriodo),'');
   AddLine('DataFinePeriodo',DateToStr(E1.DatiPosContribIscritto.DataFinePeriodo),'');
   AddLine('AliquotaLav',E1.DatiPosContribIscritto.AliquotaLav,'');
   AddLine('AliquotaDL',E1.DatiPosContribIscritto.AliquotaLav,'');
   AddLine('PercTFR',E1.DatiPosContribIscritto.PercTFR,'');
   AddLine('Cessazione',E1.DatiPosContribIscritto.Cessazione,'');
   AddLine('RetribSoggettaAContrib',E1.DatiPosContribIscritto.Cessazione,'');
   AddLine('ConguaglioFiscale',E1.DatiPosContribIscritto.ConguaglioFiscale,'');
   AddLine('ContribLav',E1.DatiPosContribIscritto.ContribLav,'');
   AddLine('ContribDL',E1.DatiPosContribIscritto.ContribDL,'');
   AddLine('ContribAgg',E1.DatiPosContribIscritto.ContribAgg,'');
   AddLine('QuotaReintegrazione',E1.DatiPosContribIscritto.QuotaReintegrazione,'');
   AddLine('QuotaIscrizioneLav',E1.DatiPosContribIscritto.QuotaIscrizioneLav,'');
   AddLine('QuotaIscrizioneDL',E1.DatiPosContribIscritto.QuotaIscrizioneDL,'');
   AddLine('VersTFRAPrevCompl',E1.DatiPosContribIscritto.VersTFRAPrevCompl,'');


end;

procedure TFrmDMA2.FillF1(F1: TF1_Ammortamento);
var
   r:Integer;

  Procedure AddLine(Campo,Valore,Descr:STring);
  begin
    SG_F1.cells[0,R]:=IntToStr(R);
    SG_F1.cells[1,R]:=Campo;
    SG_F1.cells[2,R]:=Valore;
    SG_F1.cells[3,R]:=Descr;
    inc(R)
   end;

begin
    r:=0;
    SG_F1.ColWidths[0]:=20;
    SG_F1.ColWidths[1]:=200;
    SG_F1.ColWidths[2]:=100;
    SG_F1.ColWidths[3]:=300;
    SG_F1.RowCount:=20;

    AddLine('Gestione Cassa',IntToStr(F1.CodGestione),_CodGestione.Descr(F1.CodGestione));
    AddLine('/Importo Versato non Dichiarato','','');
    AddLine('Mese',IntToStr(F1.AnnoMeseVersNonDich.Mese),'');
    AddLine('Anno',IntToStr(F1.AnnoMeseVersNonDich.Anno),'');
    AddLine('/Periodo di riferimento','','');
    AddLine('Mese',IntToStr(F1.AnnoMeseRif.Mese),'');
    AddLine('Anno',IntToStr(F1.AnnoMeseRif.Anno),'');
    AddLine('Tipologia del piano di ammortamento',IntToStr(F1.TipoPiano),_TipoPiano(F1.TipoPiano));
    AddLine('Data Inizio',DateToStr(F1.DataInizio),'');
    AddLine('Data Scadenza',DateToStr(F1.DataScadenza),'');
    AddLine('Progressivo Rata',IntToStr(F1.PrgRata),'');
    AddLine('Totale Rate',IntToStr(F1.TotaleRate),'');
    AddLine('Data ripristino',DateToStr(F1.DataRipristino),'');
    AddLine('Ante Subentro',F1.AnteSubentro,'');
    AddLine('Quota',CurrToStrPt(F1.Importo),'');
    AddLine('Tipo Operazione',F1.TipoOperazione,_TipoOperazione(F1.TipoOperazione));
    AddLine('/Altro Ente Versante','','');
    AddLine('Codice Fiscale',F1.AltroEnteVersante.CodiceFiscale,'');
    AddLine('Progressivo',F1.AltroEnteVersante.Progressivo,'');
end;

procedure TFrmDMA2.FillV1(V1: TV1_PeriodoPrecedente);
var
   r:Integer;
   Procedure AddLine(Campo,Valore,Descr:STring);
   begin
     SG_V1.cells[0,R]:=IntToStr(R);
     SG_V1.cells[1,R]:=Campo;
     SG_V1.cells[2,R]:=Valore;
     SG_V1.cells[3,R]:=Descr;
     inc(R)
    end;
begin
    r:=0;
    SG_V1.ColWidths[0]:=20;
    SG_V1.ColWidths[1]:=200;
    SG_V1.ColWidths[2]:=100;
    SG_V1.ColWidths[3]:=300;
    SG_V1.RowCount:=60;

    addLine('Causale Variazione',IntToStr(V1.CausaleVariazione),_CausaleVariazione.Descr(V1.CausaleVariazione));
    addLine('Codice motivo Utilizzo',IntToStr(V1.CodiceMotivoUtilizzo),'');
    addLine('Giorno Inizio',DateToStr(V1.GiornoInizio),'');
    addLine('Giorno Fine',DateToStr(V1.GiornoFine),'');
    addLine('Retribuzione Teorica Tabellare TFR',CurrToStrpt(V1.RetribTeoricaTabellareTFR),'');
    addLine('Data fine benefici calamità','','');
    addLine('/INQUADRAMENTO','','');
    addLine('Tipo Impiego',inttostr2(V1.InquadramentoLavPA.TipoImpiego),TipoImpiego.Descr(V1.InquadramentoLavPA.TipoImpiego));
    addLine('Tipo Servizio',inttostr(V1.InquadramentoLavPA.TipoServizio),TipoServizio.Descr(V1.InquadramentoLavPA.TipoServizio));
    addLine('% Retribuzione',inttostr(V1.InquadramentoLavPA.PercRetribuzione),'');
    addLine('Contratto',V1.InquadramentoLavPA.Contratto,'');
    addLine('Qualifica',V1.InquadramentoLavPA.Qualifica,_InquadramentoLavPA(V1.InquadramentoLavPA.Qualifica));
    addLine('Part-Time : Tipo',V1.InquadramentoLavPA.PartTimePa.TipoPartTime,'');
    addLine('Part-Time : Percentuale',IntToStr(V1.InquadramentoLavPA.PartTimePa.PercPartTime),'');
    addLine('Orario Sett. Ridotto','','');
    addLine('Orario Sett. Comp.','','');
    addLine('Regime Fine',IntToStr(V1.InquadramentoLavPA.RegimeFineServizio),RegimeFineServizio.Descr(V1.InquadramentoLavPA.RegimeFineServizio));
    addLine('Perc. asp. (L.300/70)','','');
    addLine('/Servizio presso altra amministrazione','','');
    addLine('Tipo Servizio','','');
    addLine('C.F. altra amministrazione','','');
    addLine('Progressivo','','');

    addLine('/GESTIONE PENSIONISTICA','','');
    addLine('Codice Gestione',IntToStr(V1.Gestioni.GestPensionistica.CodGestione),_CodGestione.Descr(V1.Gestioni.GestPensionistica.CodGestione));
    addLine('Imponibile',CurrToStrPt(V1.Gestioni.GestPensionistica.Imponibile),'');
    addLine('Contributo',CurrToStrPt(V1.Gestioni.GestPensionistica.contributo),'');
    addLine('Contributo 1%',CurrToStrPt(V1.Gestioni.GestPensionistica.Contrib1PerCento),'');
    addLine('Imponibile eccedenza massimale',CurrToStrPt(V1.Gestioni.GestPensionistica.ImponibileEccMass),'');
    addLine('Giorni utili','','');
    addLine('Maggiorazione pens. D.lgs 165/2007','','');
    addLine('Retribuzione Virtuale','','');
    addLine('Eventi Calamitosi','','');
    addLine('Stipendio tabellare','','');
    addLine('Importo RIA','','');

    addLine('/GESTIONE PREVIDENZIALE','','');
    addLine('Codice Gestione',IntToStr2(V1.Gestioni.GestPrevidenziale.CodGestione),_CodGestione.Descr(V1.Gestioni.GestPrevidenziale.CodGestione));
    addLine('Imponibile TFR',CurrToStrPt(V1.Gestioni.GestPrevidenziale.ImponibileTFR),'');
    addLine('Contributo TFR',CurrToStrPt(V1.Gestioni.GestPrevidenziale.contributoTFR),'');
    addLine('Imponibile TFR Eccedena Massimale','','');
    addLine('Imponibile TFS',CurrToStrPt(V1.Gestioni.GestPrevidenziale.ImponibileTFS),'');
    addLine('Contributo TFS',CurrToStrPt(V1.Gestioni.GestPrevidenziale.contributoTFS),'');
    addLine('Imponibile TFS Eccedenza Massimale','','');
    addLine('Contributo Sospeso','','');

    addLine('/GESTIONE CREDITO','','');
    addLine('Codice Gestione',IntToStr2(V1.Gestioni.GestCredito.CodGestione),_CodGestione.Descr(V1.Gestioni.GestCredito.CodGestione));
    addLine('Imponibile',CurrToStrPt(V1.Gestioni.GestCredito.Imponibile),'');
    addLine('Contributo',CurrToStrPt(V1.Gestioni.GestCredito.contributo),'');
    addLine('Imponibile eccedenza massimale','','');
    addLine('Aderente Credito DM 45/2007','','');

    addLine('/ENPDEP','','');
    addLine('Codice',IntToStr2(V1.Gestioni.ENPDEP.CodGestione),'');
    addLine('Imponibile',CurrToStrPt(V1.Gestioni.ENPDEP.Imponibile),'');
    addLine('Contributo',CurrToStrPt(V1.Gestioni.ENPDEP.contributo),'');

    addLine('/ENAM','','');
    addLine('Codice',IntToStr2(V1.Gestioni.ENAM.CodGestione),'');
    addLine('Imponibile',CurrToStrPt(V1.Gestioni.ENAM.Imponibile),'');
    addLine('Contributo',CurrToStrPt(V1.Gestioni.ENAM.contributo),'');

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

