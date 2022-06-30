unit UClsUniEmens;
//Uniemens Individuale
//Release 3.3
//del 12/02/2016

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Contnrs,Grids;

Type

  { TPartTimePA }

  TPartTimePA=Class
    TipoPartTime :Char;  //P V M
    PercPartTime :integer;
  end;

  { TAnnoMese }

  TAnnoMese=Class
  private
    AnnoMeseStr:String;
    function GetStr: String;
    procedure SetStr(AValue: String);
  Public
    Anno:Integer;
    Mese:Integer;
    Property AsStr:String Read GetStr Write SetStr;
  end;

  { TInquadramentoLavPA }

  TInquadramentoLavPA = class
    TipoImpiego        :integer;
    TipoServizio       :integer;
    PercRetribuzione   :Integer;
    Contratto          :String;
    Qualifica          :String;
    PartTimePa         :TPartTimePA;
    RegimeFineServizio :Integer;
    Constructor Create;
    Destructor Destroy;
  end;

  TRecuperoSgravi= record
    Anno           :Integer;
    Mese           :Integer;
    Codice         :String;
    AltroImponibile:Currency;
    Importo        :Currency;
  end;

  TGestPensionistica=class
    CodGestione       :integer;
    Imponibile        :Currency;
    Contributo        :Currency;
    ImponibileEccMass :Currency;
    Contrib1PerCento  :Currency;
    //IndennitaVolo
    //MaggiorazBasePensL165_97
    GiorniUtiliFiniPensionistici:integer;
    RetribVirtualeFiniPens  :Currency;
    //ContributoSospesoCalam
    //Maggiorazione
    StipendioTabellare  :Currency;
    RetribIndivAnzianita:Currency;
    QuotaDatoreL166_91  :Currency;
    ContributoL166_91   :Currency;
    RecuperoSgravi      :array of TRecuperoSgravi;
  end;

  TGestPrevidenziale=class
    CodGestione           :integer;
    ImponibileTFR         :Currency;
    ContributoTFR         :Currency;
    ImponibileTFREccMass  :Currency;
    ImponibileTFS         :Currency;
    ContributoTFS         :Currency;
    ImponibileTFSEccMass  :Currency;
    ContributoSospesoPrev :Currency;
  end;

  TGestCredito=class
    CodGestione            :integer;
    AderenteCredito45_2007 :integer;
    Imponibile             :Currency;
    Contributo             :Currency;
    ImponibileEccMass      :Currency;
  end;

  TENPDEP=Class
    CodGestione :integer;
    Imponibile  :Currency;
    Contributo  :Currency;
  end;

  TENAM=Class
    CodGestione :integer;
    Imponibile  :Currency;
    Contributo  :Currency;
   end;

  { TGestioni }
  TGestioni = class
    GestPensionistica :TGestPensionistica;
    GestPrevidenziale :TGestPrevidenziale;
    GestCredito       :TGestCredito;
    ENPDEP            :TENPDEP;
    ENAM              :TENAM;
    Constructor Create;
    Destructor Destroy;
  end;

  TAltroEnteVersanteF1=Class
    CodiceFiscale :string;
    Progressivo   :String;
  end;

  TAltroEnteVersante=Class
    TipoContributo   :Integer;
    CFAzienda        :string; //11 car
    PRGAZIENDA       :string; //5 car num
    Imponibile       :Currency;
    Contributo       :Currency;
  end;

  TEnteVersante=Class  //V1
    TipoContributo     :Integer;
    CFAzienda          :string; //11 car
    PRGAZIENDA         :string; //5 car num
    Imponibile         :Currency;
    Contributo         :Currency;
    AnnoMeseErogazione :String;
    Aliquota           :Integer;
  end;

  { TE0_PeriodoNelMese }
  TE0_PeriodoNelMese = Class
    GiornoInizio              :TDate;
    GiornoFine                :TDate;
    InquadramentoLavPA        :TInquadramentoLavPA;
    Gestioni                  :TGestioni;
    CodiceCessazione          :Integer;
    NumeroMensilita           :Integer;
    RetribTeoricaTabellareTFR :Currency;
    RetribValutabileTFR       :Currency;
    DataFineBeneficioCalamita :TDate;
    ConguaglioImponibile      :Currency;
    AltroEnteVersante         :TAltroEnteVersante;
    function Periodo          :String;
    Constructor Create;
    Destructor Destroy;
    Procedure FillSG(SG,SG_Sgravio:TStringGrid);
  end;

  TDatiSedeLavoro = class
    CodiceComune :String;
    CAP          :String;
  end;

  { TQuadriE0 }
  TQuadriE0 = class
  private
    lItems : TObjectList;
    function GetItems(i: integer): TE0_PeriodoNelMese;
    procedure SetItems(i: integer; AValue: TE0_PeriodoNelMese);
  public
    property items[i:integer]:TE0_PeriodoNelMese read GetItems write SetItems;default;
    Procedure Add(E0:TE0_PeriodoNelMese);
    function Count:Integer;
    Constructor Create;
    Destructor Destroy;
  end;

  { TE1_FondoPensioneCompl }
  TE1_FondoPensioneCompl = class
    GiornoInizio       :TDate;
    GiornoFine         :TDate;
    Function Periodo:String;
  end;

  { TQuadriE1 }
  TQuadriE1 = class
  private
    lItems : TObjectList;
    function GetItems(i: integer): TE1_FondoPensioneCompl;
    procedure SetItems(i: integer; AValue: TE1_FondoPensioneCompl);
  public
    property items[i:integer]:TE1_FondoPensioneCompl read GetItems write SetItems;default;
    Procedure Add(E1:TE1_FondoPensioneCompl);
    function Count:Integer;
    Constructor Create;
    Destructor Destroy;
  end;

  { TF1_Ammortamento }
  TF1_Ammortamento = Class
    AnnoMeseVersNonDich  :TAnnoMese; //Formato AAAA-MM
    AnnoMeseRif          :TAnnoMese; //Formato AAAA-MM
    CodGestione          :Integer;
    TipoPiano            :Integer;
    DataInizio           :TDate;
    DataScadenza         :TDate;
    PrgRata              :Integer;
    TotaleRate           :Integer;
    DataRipristino       :TDate;
    AnteSubentro         :Char;
    Importo              :currency;
    TipoOperazione       :String;
    AltroEnteVersante    :TAltroEnteVersanteF1;

    Function Periodo :String;
    Constructor Create;
    Destructor Destroy;
    Procedure FillSG(SG:TStringGrid);
  end;

  { TQuadriF1 }

  TQuadriF1 = Class
  private
    lItems : TObjectList;
    function GetItems(i: integer): TF1_Ammortamento;
    procedure SetItems(i: integer; AValue: TF1_Ammortamento);
  public
    property items[i:integer]:TF1_Ammortamento read GetItems write SetItems;default;
    Procedure Add(F1:TF1_Ammortamento);
    function Count:Integer;
    Constructor Create;
    Destructor Destroy;
  end;

  { TV1_PeriodoPrecedente }
  TDescrMotivoUtilizzo = Class
    DataAtto             :TDate;
    IdentAtto            :Integer;
    NumeroRegistro       :Integer;
    CodOrgano            :Integer;
    SedeGeograficaOrgano :Integer;
  end;

  TV1_PeriodoPrecedente = Class
    CausaleVariazione    :Integer;
    CodiceMotivoUtilizzo :Integer;

    Aliquota           :Integer;
    GiornoInizio       :TDate;
    GiornoFine         :TDate;
    InquadramentoLavPA :TInquadramentoLavPA;
    Gestioni           :TGestioni;
    CodiceCessazione   :Integer;
    NumeroMensilita    :Integer;
    RetribTeoricaTabellareTFR :Currency;
    RetribValutabileTFR       :Currency;
    DataFineBeneficioCalamita :TDate;
    DescrMotivoUtilizzo       :TDescrMotivoUtilizzo;
    EnteVersante              :TEnteVersante;
    Function Periodo:String;
    Constructor Create;
    Destructor Destroy;
    Procedure FillSG(SG:TStringGrid);
  end;

  { TQuadriV1 }

  TQuadriV1 = class
  private
    lItems : TObjectList;
    function GetItems(i: integer): TV1_PeriodoPrecedente;
    procedure SetItems(i: integer; AValue: TV1_PeriodoPrecedente);
  public
    property items[i:integer]:TV1_PeriodoPrecedente read GetItems write SetItems;default;
    Procedure Add(V1:TV1_PeriodoPrecedente);
    function Count:Integer;
    Constructor Create;
    Destructor Destroy;
  end;

  { TD0_DenunciaIndividuale ---------------------------------------------------}
  TD0_DenunciaIndividuale = Class
    private
    public
     CFLavoratore :String; //16C
     Cognome      :String; //1-40C
     Nome         :String; //1-30C
     //DatiPrevCompl+
     DatiSedeLavoro :TDatiSedeLavoro;
     QuadriE0 :TQuadriE0;
     QuadriE1 :TQuadriE1;
     QuadriF1 :TQuadriF1;
     QuadriV1 :TQuadriV1;

     Function Nominativo:String;
     Constructor Create;
     Destructor Destroy;
  end;

  { TPosPa }
  TPosPa = Class
    private
      Lst_DenInd : TObjectList;
      function GetItems(i: integer): TD0_DenunciaIndividuale;
      procedure SetItems(i: integer; AValue: TD0_DenunciaIndividuale);
    public
      property items[i:integer]:TD0_DenunciaIndividuale read GetItems write SetItems; default;
      Constructor Create;
      Destructor Destroy;
      Procedure Insert(CF,Cognome,Nome: String);
      Procedure Add(D0:TD0_DenunciaIndividuale);
      function Count:Integer;
  end;

implementation

uses StrUtils,UUtilFunz,UClsUniEmensTab;

{ TAnnoMese }

function TAnnoMese.GetStr: String;
begin
  GetStr:=AnnoMeseStr;
end;

procedure TAnnoMese.SetStr(AValue: String);
var
  sAnno,sMese:String;
  p:Integer;
begin
  AnnoMeseStr:=AValue;
  p:=pos('-',AnnoMeseStr);
  sAnno:=MidStr(AnnoMeseStr,1,p-1);
  SMese:=MidStr(AnnoMeseStr,p+1,2);
  Anno:=StrToInt(sAnno);
  Mese:=StrToInt(sMese);
end;

{ TInquadramentoLavPA }

constructor TInquadramentoLavPA.Create;
begin
  PartTimePa:=TPartTimePA.create;
end;

destructor TInquadramentoLavPA.Destroy;
begin
  PartTimePa.free;
end;

{ TGestioni }

constructor TGestioni.Create;
begin
  GestPensionistica :=TGestPensionistica.Create;
  GestPrevidenziale :=TGestPrevidenziale.Create;
  GestCredito       :=TGestCredito.Create;
  ENPDEP            :=TENPDEP.Create;
  ENAM              :=TENAM.Create;
end;

destructor TGestioni.Destroy;
begin
  GestPensionistica.free;
  GestPrevidenziale.free;
  GestCredito.free;
  ENPDEP.free;
  ENAM.free;
end;

{ TV1_PeriodoPrecedente }

function TV1_PeriodoPrecedente.Periodo: String;
begin
  Periodo := DateToStr(GiornoInizio)+'...'+DateToStr(GiornoFine);
end;

constructor TV1_PeriodoPrecedente.Create;
begin
  InquadramentoLavPa:=TInquadramentoLavPa.Create;
  Gestioni:=TGestioni.Create;
  EnteVersante:=TEnteVersante.Create;
end;

destructor TV1_PeriodoPrecedente.Destroy;
begin
  InquadramentoLavPa.Free;
  Gestioni.Free;
  EnteVersante.Free;
end;

procedure TV1_PeriodoPrecedente.FillSG(SG: TStringGrid);
var
  r:Integer;
  Procedure AddLine(Campo,Valore,Descr:STring);
  begin
    SG.cells[0,R]:=IntToStr(R);
    SG.cells[1,R]:=Campo;
    SG.cells[2,R]:=Valore;
    SG.cells[3,R]:=Descr;
    inc(R)
   end;
begin
  r:=0;
  SG.ColWidths[0]:=20;
  SG.ColWidths[1]:=200;
  SG.ColWidths[2]:=100;
  SG.ColWidths[3]:=300;
  SG.RowCount:=60;

  addLine('Causale Variazione',IntToStr(CausaleVariazione),_CausaleVariazione.Descr(CausaleVariazione));
  addLine('Codice motivo Utilizzo',IntToStr(CodiceMotivoUtilizzo),'');
  addLine('Giorno Inizio',DateToStr(GiornoInizio),'');
  addLine('Giorno Fine',DateToStr(GiornoFine),'');
  addLine('Retribuzione Teorica Tabellare TFR',CurrToStrpt(RetribTeoricaTabellareTFR),'');
  addLine('Data fine benefici calamità','','');
  addLine('/INQUADRAMENTO','','');
  addLine('Tipo Impiego',inttostr2(InquadramentoLavPA.TipoImpiego),TipoImpiego.Descr(InquadramentoLavPA.TipoImpiego));
  addLine('Tipo Servizio',inttostr(InquadramentoLavPA.TipoServizio),TipoServizio.Descr(InquadramentoLavPA.TipoServizio));
  addLine('% Retribuzione',inttostr(InquadramentoLavPA.PercRetribuzione),'');
  addLine('Contratto',InquadramentoLavPA.Contratto,'');
  addLine('Qualifica',InquadramentoLavPA.Qualifica,_InquadramentoLavPA(InquadramentoLavPA.Qualifica));
  addLine('Part-Time : Tipo',InquadramentoLavPA.PartTimePa.TipoPartTime,'');
  addLine('Part-Time : Percentuale',IntToStr(InquadramentoLavPA.PartTimePa.PercPartTime),'');
  addLine('Orario Sett. Ridotto','','');
  addLine('Orario Sett. Comp.','','');
  addLine('Regime Fine',IntToStr(InquadramentoLavPA.RegimeFineServizio),RegimeFineServizio.Descr(InquadramentoLavPA.RegimeFineServizio));
  addLine('Perc. asp. (L.300/70)','','');
  addLine('/Servizio presso altra amministrazione','','');
  addLine('Tipo Servizio','','');
  addLine('C.F. altra amministrazione','','');
  addLine('Progressivo','','');

  addLine('/GESTIONE PENSIONISTICA','','');
  addLine('Codice Gestione',IntToStr(Gestioni.GestPensionistica.CodGestione),_CodGestione.Descr(Gestioni.GestPensionistica.CodGestione));
  addLine('Imponibile',CurrToStrPt(Gestioni.GestPensionistica.Imponibile),'');
  addLine('Contributo',CurrToStrPt(Gestioni.GestPensionistica.contributo),'');
  addLine('Contributo 1%',CurrToStrPt(Gestioni.GestPensionistica.Contrib1PerCento),'');
  addLine('Imponibile eccedenza massimale',CurrToStrPt(Gestioni.GestPensionistica.ImponibileEccMass),'');
  addLine('Giorni utili','','');
  addLine('Maggiorazione pens. D.lgs 165/2007','','');
  addLine('Retribuzione Virtuale','','');
  addLine('Eventi Calamitosi','','');
  addLine('Stipendio tabellare','','');
  addLine('Importo RIA','','');

  addLine('/GESTIONE PREVIDENZIALE','','');
  addLine('Codice Gestione',IntToStr2(Gestioni.GestPrevidenziale.CodGestione),_CodGestione.Descr(Gestioni.GestPrevidenziale.CodGestione));
  addLine('Imponibile TFR',CurrToStrPt(Gestioni.GestPrevidenziale.ImponibileTFR),'');
  addLine('Contributo TFR',CurrToStrPt(Gestioni.GestPrevidenziale.contributoTFR),'');
  addLine('Imponibile TFR Eccedena Massimale','','');
  addLine('Imponibile TFS',CurrToStrPt(Gestioni.GestPrevidenziale.ImponibileTFS),'');
  addLine('Contributo TFS',CurrToStrPt(Gestioni.GestPrevidenziale.contributoTFS),'');
  addLine('Imponibile TFS Eccedenza Massimale','','');
  addLine('Contributo Sospeso','','');

  addLine('/GESTIONE CREDITO','','');
  addLine('Codice Gestione',IntToStr2(Gestioni.GestCredito.CodGestione),_CodGestione.Descr(Gestioni.GestCredito.CodGestione));
  addLine('Imponibile',CurrToStrPt(Gestioni.GestCredito.Imponibile),'');
  addLine('Contributo',CurrToStrPt(Gestioni.GestCredito.contributo),'');
  addLine('Imponibile eccedenza massimale','','');
  addLine('Aderente Credito DM 45/2007','','');

  addLine('/ENPDEP','','');
  addLine('Codice',IntToStr2(Gestioni.ENPDEP.CodGestione),'');
  addLine('Imponibile',CurrToStrPt(Gestioni.ENPDEP.Imponibile),'');
  addLine('Contributo',CurrToStrPt(Gestioni.ENPDEP.contributo),'');

  addLine('/ENAM','','');
  addLine('Codice',IntToStr2(Gestioni.ENAM.CodGestione),'');
  addLine('Imponibile',CurrToStrPt(Gestioni.ENAM.Imponibile),'');
  addLine('Contributo',CurrToStrPt(Gestioni.ENAM.contributo),'');

end;

{ TF1_Ammortamento }

function TF1_Ammortamento.Periodo: String;
begin
  Periodo := AnnoMeseRif.AsStr;
end;

constructor TF1_Ammortamento.Create;
begin
  AnnoMeseVersNonDich :=TAnnoMese.Create;
  AnnoMeseRif         :=TAnnoMese.Create;
  AltroEnteVersante   :=TAltroEnteVersanteF1.Create;
end;

destructor TF1_Ammortamento.Destroy;
begin
  AnnoMeseVersNonDich.free;
  AnnoMeseRif.free;
  AltroEnteVersante.Free;
end;

procedure TF1_Ammortamento.FillSG(SG: TStringGrid);
var
  r:Integer;
  Procedure AddLine(Campo,Valore,Descr:STring);
  begin
    SG.cells[0,R]:=IntToStr(R);
    SG.cells[1,R]:=Campo;
    SG.cells[2,R]:=Valore;
    SG.cells[3,R]:=Descr;
    inc(R)
   end;
begin
  r:=0;
  SG.ColWidths[0]:=20;
  SG.ColWidths[1]:=200;
  SG.ColWidths[2]:=100;
  SG.ColWidths[3]:=300;
  SG.RowCount:=20;

  AddLine('Gestione Cassa',IntToStr(CodGestione),_CodGestione.Descr(CodGestione));
  AddLine('/Importo Versato non Dichiarato','','');
  AddLine('Mese',IntToStr(AnnoMeseVersNonDich.Mese),'');
  AddLine('Anno',IntToStr(AnnoMeseVersNonDich.Anno),'');
  AddLine('/Periodo di riferimento','','');
  AddLine('Mese',IntToStr(AnnoMeseRif.Mese),'');
  AddLine('Anno',IntToStr(AnnoMeseRif.Anno),'');
  AddLine('Tipologia del piano di ammortamento',IntToStr(TipoPiano),_TipoPiano(TipoPiano));
  AddLine('Data Inizio',DateToStr(DataInizio),'');
  AddLine('Data Scadenza',DateToStr(DataScadenza),'');
  AddLine('Progressivo Rata',IntToStr(PrgRata),'');
  AddLine('Totale Rate',IntToStr(TotaleRate),'');
  AddLine('Data ripristino',DateToStr(DataRipristino),'');
  AddLine('Ante Subentro',AnteSubentro,'');
  AddLine('Quota',CurrToStrPt(Importo),'');
  AddLine('Tipo Operazione',TipoOperazione,_TipoOperazione(TipoOperazione));
  AddLine('/Altro Ente Versante','','');
  AddLine('Codice Fiscale',AltroEnteVersante.CodiceFiscale,'');
  AddLine('Progressivo',AltroEnteVersante.Progressivo,'');
 end;

{ TE1_FondoPensioneCompl }

function TE1_FondoPensioneCompl.Periodo: String;
begin
  Periodo := DateToStr(GiornoInizio)+'...'+DateToStr(GiornoFine);
end;

{ TQuadriV1 }

function TQuadriV1.GetItems(i: integer): TV1_PeriodoPrecedente;
begin
  GetItems:=TV1_PeriodoPrecedente(lItems[i]);
end;

procedure TQuadriV1.SetItems(i: integer; AValue: TV1_PeriodoPrecedente);
begin
  lItems[i]:=AValue;
end;

procedure TQuadriV1.Add(V1: TV1_PeriodoPrecedente);
begin
  lItems.Add(V1);
end;

function TQuadriV1.Count: Integer;
begin
  Count := lItems.Count;
end;

constructor TQuadriV1.Create;
begin
  lItems:=TObjectList.Create;
end;

destructor TQuadriV1.Destroy;
begin
  lItems.free;
end;

{ TQuadriF1 }

function TQuadriF1.GetItems(i: integer): TF1_Ammortamento;
begin
  GetItems:=TF1_Ammortamento(lItems[i]);
end;

procedure TQuadriF1.SetItems(i: integer; AValue: TF1_Ammortamento);
begin

end;

procedure TQuadriF1.Add(F1: TF1_Ammortamento);
begin
  lItems.Add(F1);
end;

function TQuadriF1.Count: Integer;
begin
  Count := lItems.Count;
end;

constructor TQuadriF1.Create;
begin
  lItems:=TObjectList.create;
end;

destructor TQuadriF1.Destroy;
begin
  lItems.free;
end;

{ TQuadriE1 }

function TQuadriE1.GetItems(i: integer): TE1_FondoPensioneCompl;
begin
  GetItems:= TE1_FondoPensioneCompl(lItems[i]);
end;

procedure TQuadriE1.SetItems(i: integer; AValue: TE1_FondoPensioneCompl);
begin
  lItems[i]:=aValue;
end;

procedure TQuadriE1.Add(E1: TE1_FondoPensioneCompl);
begin
  lItems.Add(E1);
end;

function TQuadriE1.Count: Integer;
begin
  Count:=lItems.Count;
end;

constructor TQuadriE1.Create;
begin
  lItems:=TObjectList.Create;
end;

destructor TQuadriE1.Destroy;
begin
  lItems.free;
end;

{ TQuadriE0 }

function TQuadriE0.GetItems(i: integer): TE0_PeriodoNelMese;
begin
  GetItems:=TE0_PeriodoNelMese(lItems[i]);
end;

procedure TQuadriE0.SetItems(i: integer; AValue: TE0_PeriodoNelMese);
begin
  lItems[i]:=AValue;
end;

procedure TQuadriE0.Add(E0: TE0_PeriodoNelMese);
begin
  lItems.Add(E0);
end;

function TQuadriE0.Count: Integer;
begin
  Count :=lItems.Count;
end;

constructor TQuadriE0.Create;
begin
  lItems:=TObjectList.create;
end;

destructor TQuadriE0.Destroy;
begin
  lItems.free;
end;

{ TE0_PeriodoNelMese }

function TE0_PeriodoNelMese.Periodo: String;
begin
  Periodo := DateToStr(GiornoInizio)+'...'+DateToStr(GiornoFine);
end;

constructor TE0_PeriodoNelMese.Create;
begin
  InquadramentoLavPa:=TInquadramentoLavPa.Create;
  Gestioni:=TGestioni.Create;
  AltroEnteVersante:=TAltroEnteVersante.Create;
end;

destructor TE0_PeriodoNelMese.Destroy;
begin
  InquadramentoLavPa.Free;
  Gestioni.free;
  AltroEnteVersante.Free;
end;

procedure TE0_PeriodoNelMese.FillSG(SG,SG_Sgravio:TStringGrid);
var
  t,n,r:Integer;
  Procedure AddLine(Campo,Valore,Descr:STring);
  begin
    SG.cells[0,R]:=IntToStr(R);
    SG.cells[1,R]:=Campo;
    SG.cells[2,R]:=Valore;
    SG.cells[3,R]:=Descr;
    inc(R)
   end;
begin
  r:=0;
  SG.ColWidths[0]:=20;
  SG.ColWidths[1]:=200;
  SG.ColWidths[2]:=100;
  SG.ColWidths[3]:=300;

  addLine('Giorno Inizio',DateToStr(GiornoInizio),'');
  addLine('Giorno Fine',DateToStr(GiornoFine),'');
  addLine('Codice Cessazione',inttostr(CodiceCessazione),'');
  addLine('Numero Mensilità',inttostr(NumeroMensilita),'');
  addLine('Retribuzione Teorica Tabellare TFR',CurrToStrpt(RetribTeoricaTabellareTFR),'');
  addLine('Retribuzione Valutabile TFR',CurrToStrpt(RetribValutabileTFR),'');
  addLine('Data fine beneficio calamità','','');
  addLine('Conguaglio Imponibile','','');
  addLine('AltriEnteVersante','','');

  addLine('/INQUADRAMENTO','','');
  addLine('Tipo Impiego',inttostr2(InquadramentoLavPA.TipoImpiego),TipoImpiego.descr(InquadramentoLavPA.TipoImpiego));
  addLine('Tipo Servizio',inttostr(InquadramentoLavPA.TipoServizio),TipoServizio.descr(InquadramentoLavPA.TipoServizio));
  addLine('% Retribuzione',inttostr(InquadramentoLavPA.PercRetribuzione),'');
  addLine('Contratto',InquadramentoLavPA.Contratto,'');
  addLine('Qualifica',InquadramentoLavPA.Qualifica,_InquadramentoLavPA(InquadramentoLavPA.Qualifica));
  addLine('Part-Time : Tipo',InquadramentoLavPA.PartTimePa.TipoPartTime,TipoPartTime.Descr(InquadramentoLavPA.PartTimePa.TipoPartTime));
  addLine('Part-Time : Percentuale',IntToStr(InquadramentoLavPA.PartTimePa.PercPartTime),'');
  addLine('Orario Sett. Ridotto','','');
  addLine('Orario Sett. Comp.','','');
  addLine('Regime Fine',IntToStr(InquadramentoLavPA.RegimeFineServizio),RegimeFineServizio.Descr(InquadramentoLavPA.RegimeFineServizio));
  addLine('Perc. asp. (L.300/70)','','');
  addLine('/Servizio presso altra amministrazione','','');
  addLine('Tipo Servizio','','');
  addLine('C.F. altra amministrazione','','');
  addLine('Progressivo','','');

  addLine('/GESTIONE PENSIONISTICA','','');
  addLine('Codice Gestione',IntToStr(Gestioni.GestPensionistica.CodGestione),_CodGestione.Descr(Gestioni.GestPensionistica.CodGestione));
  addLine('Imponibile',CurrToStrPt(Gestioni.GestPensionistica.Imponibile),'');
  addLine('Contributo',CurrToStrPt(Gestioni.GestPensionistica.contributo),'');
  addLine('Contributo 1%',CurrToStrPt(Gestioni.GestPensionistica.Contrib1PerCento),'');
  addLine('Imponibile eccedenza massimale',CurrToStrPt(Gestioni.GestPensionistica.ImponibileEccMass),'');
  addLine('Giorni utili','','');
  addLine('Maggiorazione pens. D.lgs 165/2007','','');
  addLine('Retribuzione Virtuale','','');
  addLine('Eventi Calamitosi','','');
  addLine('Stipendio tabellare','','');
  addLine('Importo RIA','','');

  addLine('/GESTIONE PREVIDENZIALE','','');
  addLine('Codice Gestione',IntToStr2(Gestioni.GestPrevidenziale.CodGestione),_CodGestione.Descr(Gestioni.GestPrevidenziale.CodGestione));
  addLine('Imponibile TFR',CurrToStrPt(Gestioni.GestPrevidenziale.ImponibileTFR),'');
  addLine('Contributo TFR',CurrToStrPt(Gestioni.GestPrevidenziale.contributoTFR),'');
  addLine('Imponibile TFR Eccedena Massimale','','');
  addLine('Contributo TFS',CurrToStrPt(Gestioni.GestPrevidenziale.ImponibileTFS),'');
  addLine('Imponibile TFS',CurrToStrPt(Gestioni.GestPrevidenziale.contributoTFS),'');
  addLine('Imponibile TFS Eccedenza Massimale','','');
  addLine('Contributo Sospeso','','');

  addLine('/GESTIONE CREDITO','','');
  addLine('Codice Gestione',IntToStr2(Gestioni.GestCredito.CodGestione),_CodGestione.Descr(Gestioni.GestCredito.CodGestione));
  addLine('Imponibile',CurrToStrPt(Gestioni.GestCredito.Imponibile),'');
  addLine('Contributo',CurrToStrPt(Gestioni.GestCredito.contributo),'');
  addLine('Imponibile eccedenza massimale','','');
  addLine('Aderente Credito DM 45/2007','','');

  addLine('/ENPDEP','','');
  addLine('Codice',IntToStr2(Gestioni.ENPDEP.CodGestione),_CodGestione.Descr(Gestioni.ENPDEP.CodGestione));
  addLine('Imponibile',CurrToStrPt(Gestioni.ENPDEP.Imponibile),'');
  addLine('Contributo',CurrToStrPt(Gestioni.ENPDEP.contributo),'');

  addLine('/ENAM','','');
  addLine('Codice',IntToStr2(Gestioni.ENAM.CodGestione),_CodGestione.Descr(Gestioni.ENAM.CodGestione));
  addLine('Imponibile',CurrToStrPt(Gestioni.ENAM.Imponibile),'');
  addLine('Contributo',CurrToStrPt(Gestioni.ENAM.contributo),'');

  SG_Sgravio.Clean;
  SG_Sgravio.Cells[0,0]:='Anno';
  SG_Sgravio.Cells[1,0]:='Mese';
  SG_Sgravio.Cells[2,0]:='Codice';
  SG_Sgravio.Cells[3,0]:='Altro Imp';
  SG_Sgravio.Cells[4,0]:='Importo';
  n:=Length(Gestioni.GestPensionistica.RecuperoSgravi);
  for t:=0 to n-1 do begin
    SG_Sgravio.Cells[0,t+1]:=IntToStr2(Gestioni.GestPensionistica.RecuperoSgravi[t].Anno);
    SG_Sgravio.Cells[1,t+1]:=IntToStr2(Gestioni.GestPensionistica.RecuperoSgravi[t].Mese);
    SG_Sgravio.Cells[2,t+1]:=Gestioni.GestPensionistica.RecuperoSgravi[t].Codice;
    SG_Sgravio.Cells[3,t+1]:=CurrToStrPt(Gestioni.GestPensionistica.RecuperoSgravi[t].AltroImponibile);
    SG_Sgravio.Cells[4,t+1]:=CurrToStrPt(Gestioni.GestPensionistica.RecuperoSgravi[t].importo);
  end;
end;

{ TD0_DenunciaIndividuale }

function TD0_DenunciaIndividuale.Nominativo: String;
begin
  Nominativo:=Cognome + ' '+Nome;
end;

constructor TD0_DenunciaIndividuale.Create;
begin
  DatiSedeLavoro:=TDatiSedeLavoro.Create;
  QuadriE0 :=TQuadriE0.Create;
  QuadriE1 :=TQuadriE1.Create;
  QuadriF1 :=TQuadriF1.Create;
  QuadriV1 :=TQuadriV1.Create;
end;

destructor TD0_DenunciaIndividuale.Destroy;
begin
  DatiSedeLavoro.free;
  QuadriE0.free;
  QuadriE1.free;
  QuadriF1.free;
  QuadriV1.free;
end;

{ TPosPa }

function TPosPa.GetItems(i: integer): TD0_DenunciaIndividuale;
begin
  GetItems:=TD0_DenunciaIndividuale(Lst_DenInd.Items[i]);
end;

procedure TPosPa.SetItems(i: integer; AValue: TD0_DenunciaIndividuale);
begin

end;

constructor TPosPa.Create;
begin
  Lst_DenInd:= TObjectList.create;
end;

destructor TPosPa.Destroy;
begin
  Lst_DenInd.free;
end;

procedure TPosPa.Insert(CF,Cognome,Nome: String);
var
  D0:TD0_DenunciaIndividuale;
begin
  D0:=TD0_DenunciaIndividuale.Create;
  D0.CFLavoratore :=CF;
  D0.Cognome      :=Cognome;
  D0.Nome         :=Nome;
  Lst_DenInd.Add(D0);
end;

procedure TPosPa.Add(D0: TD0_DenunciaIndividuale);
begin
  Lst_DenInd.Add(D0);
end;

function TPosPa.Count: Integer;
begin
  Count:=Lst_DenInd.Count;
end;

end.

