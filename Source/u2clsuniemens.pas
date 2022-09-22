unit U2ClsUniemens;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,Contnrs,SysUtils,XMLRead,DOM,UFrmLog,UXMLUtil;

type
  TPosContributiva =class
  End;

  TListaCollaboratori =class
  End;

  { TDatiSedeLavoro }
  TDatiSedeLavoro = class
    CodiceComune :String;
    CAP          :String;
    procedure ParseXML(iNode:TDOMNode);
  end;

 { TPartTimePA }
  TPartTimePA=Class
    TipoPartTime :Char;  //P V M
    PercPartTime :integer;
    procedure ParseXML(iNode:TDOMNode);
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
    Procedure ParseXML(iNode:TDOMNode);
  end;

  TRecuperoSgravi = record
    Anno           :Integer;
    Mese           :Integer;
    Codice         :String;
    AltroImponibile:Currency;
    Importo        :Currency;
  end;

  { TGestPensionistica }
  TGestPensionistica = class
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
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TGestPrevidenziale }
  TGestPrevidenziale=class
    CodGestione           :integer;
    ImponibileTFR         :Currency;
    ContributoTFR         :Currency;
    ImponibileTFREccMass  :Currency;
    ImponibileTFS         :Currency;
    ContributoTFS         :Currency;
    ImponibileTFSEccMass  :Currency;
    ContributoSospesoPrev :Currency;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TGestCredito }
  TGestCredito=class
    CodGestione            :integer;
    AderenteCredito45_2007 :integer;
    Imponibile             :Currency;
    Contributo             :Currency;
    ImponibileEccMass      :Currency;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TENPDEP }
   TENPDEP=Class
    CodGestione :integer;
    Imponibile  :Currency;
    Contributo  :Currency;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TENAM }
  TENAM=Class
    CodGestione :integer;
    Imponibile  :Currency;
    Contributo  :Currency;
    Procedure ParseXML(iNode:TDOMNode);
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
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TAltroEnteVersanteF1 }
   TAltroEnteVersanteF1=Class
    CodiceFiscale :string;
    Progressivo   :String;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  TAltroEnteVersante=Class
    TipoContributo   :Integer;
    CFAzienda        :string; //11 car
    PRGAZIENDA       :string; //5 car num
    Imponibile       :Currency;
    Contributo       :Currency;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TEnteVersante }
  TEnteVersante=Class  //V1
    TipoContributo     :Integer;
    CFAzienda          :string; //11 car
    PRGAZIENDA         :string; //5 car num
    Imponibile         :Currency;
    Contributo         :Currency;
    AnnoMeseErogazione :String;
    Aliquota           :Integer;
    Procedure ParseXML(iNode:TDOMNode);
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
    Procedure ParseXML(iNode:TDOMNode);
   end;

  { TQuadriE0 }
  TQuadriE0 = class
  private
    Lst_E0 : TObjectList;
    function GetItems(i: integer): TE0_PeriodoNelMese;
    procedure SetItems(i: integer; AValue: TE0_PeriodoNelMese);
  public
    property items[i:integer]:TE0_PeriodoNelMese read GetItems write SetItems;default;
    Procedure Add(E0:TE0_PeriodoNelMese);
    function Count:Integer;
    Constructor Create;
    Destructor Destroy;
    Procedure ParseXML(iNode:TDOMNode);
  end;

//E1 ---------------------------------------------------------------------------

  { TDatiPosContribIscritto }

  TDatiPosContribIscritto = Class
    ContribVersNonDich        :String; //Attributo
    CodFondo                  :STring;
    Comparto                  :String;
    DataSottoscrizioneDomanda :TDate;
    AnnoMeseDecorrenzaContrib :String;
    DataInizioPeriodo         :TDate;
    DataFinePeriodo           :TDate;
    AliquotaLav               :String;
    AliquotaDL                :String;
    PercTFR                   :String;
    Cessazione                :String;
    RetribSoggettaAContrib    :String;
    ConguaglioFiscale         :String;
    ContribLav                :String;
    ContribDL                 :String;
    ContribAgg                :String;
    QuotaReintegrazione       :String;
    QuotaIscrizioneLav        :String;
    QuotaIscrizioneDL         :String;
    VersTFRAPrevCompl         :String;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TContribOmessiOIndebiti }

  TContribOmessiOIndebiti = Class
    DataInizioPeriodo      :Tdate;
    DataFinePeriodo        :TDate;
    ContribLav             :String;
    ImportoSanzione        :String;
    ImportoRifusioneDanno  :String;
    ContribDL              :String;
    ContribIndebitoDL      :String;
    ContribIndebitoLav     :String;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TE1_FondoPensioneCompl }

  TE1_FondoPensioneCompl = class
    DatiPosContribIscritto :TDatiPosContribIscritto;
    ContribOmessiOIndebiti :TContribOmessiOIndebiti;
    AltroEnteVersante      :TAltroEnteVersante;

    GiornoInizio       :TDate;
    GiornoFine         :TDate;
    Constructor Create;
    Destructor Destroy;
    Function Periodo:String;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TQuadriE1 }
  TQuadriE1 = class
  private
    Lst_E1 : TObjectList;
    function GetItems(i: integer): TE1_FondoPensioneCompl;
    procedure SetItems(i: integer; AValue: TE1_FondoPensioneCompl);
  public
    property items[i:integer]:TE1_FondoPensioneCompl read GetItems write SetItems;default;
    Procedure Add(E1:TE1_FondoPensioneCompl);
    function Count:Integer;
    Constructor Create;
    Destructor Destroy;
    Procedure ParseXML(iNode:TDOMNode);
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
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TQuadriF1 }
  TQuadriF1 = Class
  private
    Lst_F1 : TObjectList;
    function GetItems(i: integer): TF1_Ammortamento;
    procedure SetItems(i: integer; AValue: TF1_Ammortamento);
  public
    property items[i:integer]:TF1_Ammortamento read GetItems write SetItems;default;
    Procedure Add(F1:TF1_Ammortamento);
    function Count:Integer;
    Constructor Create;
    Destructor Destroy;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TDescrMotivoUtilizzo }
  TDescrMotivoUtilizzo = Class
    DataAtto             :TDate;
    IdentAtto            :Integer;
    NumeroRegistro       :Integer;
    CodOrgano            :Integer;
    SedeGeograficaOrgano :Integer;
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TV1_PeriodoPrecedente }
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
    Procedure ParseXML(iNode:TDOMNode);
  end;

  { TQuadriV1 }
  TQuadriV1 = class
  private
    Lst_V1 : TObjectList;
    function GetItems(i: integer): TV1_PeriodoPrecedente;
    procedure SetItems(i: integer; AValue: TV1_PeriodoPrecedente);
  public
    property items[i:integer]:TV1_PeriodoPrecedente read GetItems write SetItems;default;
    Procedure Add(V1:TV1_PeriodoPrecedente);
    function Count:Integer;
    Constructor Create;
    Destructor Destroy;
    Procedure ParseXML(iNode:TDOMNode);
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
     Procedure ParseXML(iNode: TDOMNode);
  end;

  { TPosPa }
  TPosPa = Class
    private
      //EnteAppartenenza :TEnteAppartenenza;
      //SedeServizio     :TSedeServizio;
      Lst_D0 : TObjectList;
      function GetItems(i: integer): TD0_DenunciaIndividuale;
      procedure SetItems(i: integer; AValue: TD0_DenunciaIndividuale);
    public
      property items[i:integer]:TD0_DenunciaIndividuale read GetItems write SetItems; default;
      Constructor Create;
      Destructor Destroy;
      Procedure Insert(CF,Cognome,Nome: String);
      Procedure Add(D0:TD0_DenunciaIndividuale);
      function Count:Integer;
      Procedure ParseXML(iNode: TDOMNode);
  end;

  { TListaPosPA }
  TListaPosPA=class
    PRGAZIENDA                 :String;
    CFRappresentanteFirmatario :string;
    ISTAT                      :string;
    FormaGiuridica             :String;
    EnteVersanteMEF            :String;
    PosPA                      :TPosPA;
    AltriImportiDovuti_Z2      :string;
    AltriImportiAConguaglio    :string;
    Constructor Create;
    Destructor Destroy;
    Procedure ParseXML(iNode: TDOMNode);
  end;

 { TDatiMittente }
  TDatiMittente=Class
   Tipo:Integer;
   CFPersonaMittente:String;
   RagSocMittente:String;
   CFMittente:String;
   CFSoftwarehouse:String;
   SedeINPS:String;
   Procedure ParseXML(iNode: TDOMNode);
 end;

 { TAzienda }
 TAzienda=Class
   AnnoMeseDenuncia     :string[7];
   CFAzienda            :String;
   RagSocAzienda        :String;
   PosContributiva      :TPosContributiva;
   ListaCollaboratori   :TListaCollaboratori;
   ListaPosPa           :TListaPosPA;
   //PosSportSpet         :TSportSpet;
   //PosAgri              :TPosAgri;
   Constructor Create;
   Destructor Destroy;
   Procedure ParseXML(iNode: TDOMNode);
 end;

 { TDenunceMensili }
 TDenunceMensili=Class
   DatiMittente :TDatiMittente;
   Azienda      :TAzienda;
   Constructor Create;
   Destructor Destroy;
   Procedure ParseXML(iNode: TDOMNode);
 end;

  { TUniemens }
 TUniemens = Class
    nFileXml     :string;  //Nome File Xml
    XMLDoc: TXMLDocument;
    //Uniemens Data
    DenunceMensili :TDenunceMensili;
    //Uniemens Data End
    Constructor Create;
    Destructor Destroy;
    Procedure LoadXML(nFile:string);
    Procedure Save(nFile:String);
    private
     procedure ParseXML;
  end;

implementation
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

uses StrUtils,UUtilFunz,UClsUniEmensTab;

{ TContribOmessiOIndebiti }

procedure TContribOmessiOIndebiti.ParseXML(iNode: TDOMNode);
begin
   // Da completare
end;

{ TDatiPosContribIscritto }

procedure TDatiPosContribIscritto.ParseXML(iNode: TDOMNode);
var
  aN:TDOMNode;
  t:integer;
begin
  aN:=iNode;
  while aN<>Nil do
    begin
      if aN.NodeName='CodFondo' then CodFondo:=An.TextContent;
      if aN.NodeName='Comparto' then Comparto:=An.TextContent;
      if aN.NodeName='DataSottoscrizioneDomanda' then DataSottoscrizioneDomanda:=XMLDateToDate(String(An.TextContent));
      if aN.NodeName='AnnoMeseDecorrenzaContrib' then AnnoMeseDecorrenzaContrib:=An.TextContent;
      if aN.NodeName='DataInizioPeriodo' then DataInizioPeriodo:=XMLDateToDate(String(An.TextContent));
      if aN.NodeName='DataFinePeriodo' then DataFinePeriodo:=XMLDateToDate(String(An.TextContent));
      if aN.NodeName='AliquotaLav' then AliquotaLav:=An.TextContent;
      if aN.NodeName='AliquotaDL' then AliquotaDL:=An.TextContent;
      if aN.NodeName='PercTFR' then PercTFR:=An.TextContent;
      if aN.NodeName='Cessazione' then Cessazione:=An.TextContent;
      if aN.NodeName='RetribSoggettaAContrib' then RetribSoggettaAContrib:=An.TextContent;
      if aN.NodeName='ConguaglioFiscale' then ConguaglioFiscale:=An.TextContent;
      if aN.NodeName='ContribLav' then ContribLav:=An.TextContent;
      if aN.NodeName='ContribDL' then ContribDL:=An.TextContent;
      if aN.NodeName='ContribAgg' then ContribAgg:=An.TextContent;
      if aN.NodeName='QuotaReintegrazione' then QuotaReintegrazione:=An.TextContent;
      if aN.NodeName='QuotaIscrizioneLav' then QuotaIscrizioneLav:=An.TextContent;
      if aN.NodeName='QuotaIscrizioneDL' then QuotaIscrizioneDL:=An.TextContent;
      if aN.NodeName='VersTFRAPrevCompl' then VersTFRAPrevCompl:=An.TextContent;
      aN:=aN.NextSibling;
    end;
end;

{ TPartTimePA }

procedure TPartTimePA.ParseXML(iNode: TDOMNode);
var
  aN:TDOMNode;
  t:integer;
begin
  aN:=iNode;
  while aN<>Nil do
    begin
      if aN.NodeName='TipoPartTime' then TipoPartTime:=An.TextContent[1];
      if aN.NodeName='PercPartTime' then PercPartTime:=StrToInt(An.TextContent);
      aN:=aN.NextSibling;
    end
end;

{ TEnteVersante }

procedure TEnteVersante.ParseXML(iNode: TDOMNode);
begin

end;

{ TAltroEnteVersante }

procedure TAltroEnteVersante.ParseXML(iNode: TDOMNode);
begin

end;

{ TAltroEnteVersanteF1 }

procedure TAltroEnteVersanteF1.ParseXML(iNode: TDOMNode);
begin

end;

{ TENAM }

procedure TENAM.ParseXML(iNode: TDOMNode);
var
aN:TDOMNode;
t:integer;
begin
  aN:=iNode;
  while aN<>Nil do
    begin
    if aN.NodeName='CodGestione'
        then CodGestione:=StrToInt(An.TextContent);
    if aN.NodeName='Imponibile'
        then Imponibile:=StrToCurr(An.TextContent);
    if aN.NodeName='Contributo'
        then Contributo:=StrToCurr(An.TextContent);
    aN:=aN.NextSibling;
  end
end;

{ TENPDEP }

procedure TENPDEP.ParseXML(iNode: TDOMNode);
var
  aN:TDOMNode;
  t:integer;
  Tmps:String;
begin
  aN:=iNode;
  while aN<>Nil do
    begin
      Tmps:=aN.NodeName;
      if Tmps='CodGestione' then CodGestione:=StrToInt(An.TextContent);
      if Tmps='Imponibile' then Imponibile:=StrToCurr(An.TextContent);
      if Tmps='Contributo' then Contributo:=StrToCurr(An.TextContent);
      aN:=aN.NextSibling;
    end
end;

{ TGestCredito }

procedure TGestCredito.ParseXML(iNode: TDOMNode);
var
aN:TDOMNode;
t:integer;
begin
  aN:=iNode;
  while aN<>Nil do
  begin
    if aN.NodeName='CodGestione'
        then CodGestione:=StrToInt(An.TextContent);
    if aN.NodeName='AderenteCredito45_2007'
        then AderenteCredito45_2007:=StrToInt(An.TextContent);
    if aN.NodeName='Imponibile'
        then Imponibile:=StrToCurr(An.TextContent);
    if aN.NodeName='Contributo'
        then Contributo:=StrToCurr(An.TextContent);
    if aN.NodeName='ImponibileEccMass'
        then ImponibileEccMass:=StrToCurr(An.TextContent);
    aN:=aN.NextSibling;
  end
end;

{ TGestPrevidenziale }

procedure TGestPrevidenziale.ParseXML(iNode: TDOMNode);
var
aN:TDOMNode;
t:integer;
begin
  aN:=iNode;
  while aN<>Nil do
  begin
    if aN.NodeName='CodGestione'
        then CodGestione:=StrToInt(An.TextContent);
    if aN.NodeName='ImponibileTFR'
        then ImponibileTFR:=StrToCurr(An.TextContent);
    if aN.NodeName='ContributoTFR'
        then ContributoTFR:=StrToCurr(An.TextContent);
    if aN.NodeName='ImponibileTFS'
        then ImponibileTFS:=StrToCurr(An.TextContent);
    if aN.NodeName='ContributoTFS'
        then ContributoTFS:=StrToCurr(An.TextContent);
    aN:=aN.NextSibling;
  end

end;

{ TGestPensionistica }

procedure TGestPensionistica.ParseXML(iNode: TDOMNode);
var
aN:TDOMNode;
t:integer;

 Procedure Parse_RecuperoSgravi(Node:TDOMNode;P:TGestPensionistica);
                 {
                  <RecuperoSgravi>
                   <AnnoRif>2022</AnnoRif>
                   <MeseRif>4</MeseRif>
                   <CodiceRecupero>30</CodiceRecupero>
                   <Importo>13,54</Importo>
                 </RecuperoSgravi>
                 }
    var
    aN:TDOMNode;
    t,al:integer;
  Begin
    al:=Length(P.RecuperoSgravi);
    setLength(P.RecuperoSgravi,al+1);
    for t:=0 to Node.ChildNodes.Count-1 do
      begin
         aN:=Node.ChildNodes[T];
        if aN.NodeName='AnnoRif'
            then P.recuperoSgravi[al].Anno:=StrToInt(An.childNodes[0].TextContent);
        if aN.NodeName='MeseRif'
            then P.recuperoSgravi[al].Mese :=StrToInt(An.childNodes[0].TextContent);
        if aN.NodeName='CodiceRecupero'
            then P.recuperoSgravi[al].Codice :=An.childNodes[0].TextContent;
        if aN.NodeName='AltroImponibile'      { #todo : Verificare }
            then P.recuperoSgravi[al].AltroImponibile :=StrToCurr(An.childNodes[0].TextContent);
        if aN.NodeName='Importo'
            then P.recuperoSgravi[al].Importo :=StrToCurr(An.childNodes[0].TextContent);
      end;
  end;

begin
  aN:=iNode;
  while aN<>nil do
  begin
    if aN.NodeName='CodGestione'      then CodGestione:=StrToInt(An.TextContent);
    if aN.NodeName='Imponibile'       then Imponibile:=StrToCurr(An.TextContent);
    if aN.NodeName='Contributo'       then Contributo:=StrToCurr(An.TextContent);
    if aN.NodeName='ImponibileEccMass'then ImponibileEccMass:=StrToCurr(An.TextContent);
    if aN.NodeName='Contrib1PerCento' then Contrib1PerCento:=StrToCurr(An.TextContent);
    if aN.NodeName='StipendioTabellare' then StipendioTabellare:=StrToCurr(An.TextContent);
    if aN.NodeName='RetribIndivAnzianita'  then RetribIndivAnzianita:=StrToCurr(An.TextContent);
    if aN.NodeName='RecuperoSgravi'   then Parse_RecuperoSgravi(aN,Self);
    aN:=aN.NextSibling;
  end
end;

{ TDescrMotivoUtilizzo }

procedure TDescrMotivoUtilizzo.ParseXML(iNode: TDOMNode);
begin

end;

{ TDatiSedeLavoro }

procedure TDatiSedeLavoro.ParseXML(iNode: TDOMNode);
var
   t:integer;
   aN:TDOMNode;
begin
  aN:=iNode;
    while aN<>nil do
    begin
      if aN.NodeName='CodiceComune' then CodiceComune := An.TextContent;
      if aN.NodeName='CAP'          then CAP :=An.TextContent;
     aN:=An.NextSibling;
   end;
end;

{ TD0_DenunciaIndividuale }

function TD0_DenunciaIndividuale.Nominativo: String;
begin
  Nominativo:=Cognome + ' '+Nome;
end;

constructor TD0_DenunciaIndividuale.Create;
begin
  FrmLog.log('TD0_DenunciaIndividuale.Create');
  DatiSedeLavoro:=TDatiSedeLavoro.Create;
  QuadriE0 :=TQuadriE0.Create;
  QuadriE1 :=TQuadriE1.Create;
  QuadriF1 :=TQuadriF1.Create;
  QuadriV1 :=TQuadriV1.Create;
end;

destructor TD0_DenunciaIndividuale.Destroy;
begin
  FrmLog.log('TD0_DenunciaIndividuale.Destroy');
  DatiSedeLavoro.free;
  QuadriE0.free;
  QuadriE1.free;
  QuadriF1.free;
  QuadriV1.free;
end;

procedure TD0_DenunciaIndividuale.ParseXML(iNode: TDOMNode);
var
    t:integer;
    aN:TDOMNode;
    tmps:string;
  begin
    an:=iNode;
    while an<>nil do
      begin
       tmps:=aN.NodeName;
        if tmps='CFLavoratore'          then CFLavoratore := An.childNodes[0].TextContent;
        if tmps='Cognome'               then Cognome :=An.childNodes[0].TextContent;
        if tmps='Nome'                  then Nome := An.childNodes[0].TextContent;
        if tmps='DatiSedeLavoro'        then DatiSedeLavoro.ParseXML(aN.FirstChild);
        if tmps='E0_PeriodoNelMese'     then QuadriE0.ParseXML(aN);
        if tmps='E1_FondoPensioneCompl' then QuadriE1.ParseXML(aN);
        if tmps='F1_Ammortamento'       then QuadriF1.ParseXML(aN);
        if tmps='V1_PeriodoPrecedente'  then QuadriV1.ParseXML(aN);
      aN:=aN.NextSibling;
      end;
  end;

{ TQuadriV1 }

function TQuadriV1.GetItems(i: integer): TV1_PeriodoPrecedente;
begin
  GetItems:=TV1_PeriodoPrecedente(Lst_V1[i]);
end;

procedure TQuadriV1.SetItems(i: integer; AValue: TV1_PeriodoPrecedente);
begin
  Lst_V1[i]:=AValue;
end;

procedure TQuadriV1.Add(V1: TV1_PeriodoPrecedente);
begin
  Lst_V1.Add(V1);
end;

function TQuadriV1.Count: Integer;
begin
  Count := Lst_V1.Count;
end;

constructor TQuadriV1.Create;
begin
  FrmLog.log('TQuadriV1.Create');
  Lst_V1:=TObjectList.Create;
end;

destructor TQuadriV1.Destroy;
begin
  Lst_V1.free;
end;

procedure TQuadriV1.ParseXML(iNode: TDOMNode);
var
    V1:TV1_PeriodoPrecedente;
    tmps:String;
    aN:TDOMNode;
begin
    aN:=iNode;
    while aN<>Nil do
    begin
      tmps:=aN.NodeName;
      if Tmps='V1_PeriodoPrecedente' then
      begin
         V1:=TV1_PeriodoPrecedente.Create;
         V1.ParseXML(aN.firstChild);
         add(V1);
      end;
    an:=An.NextSibling;
  end;
end;

{ TQuadriE0 }

function TQuadriE0.GetItems(i: integer): TE0_PeriodoNelMese;
begin
  GetItems:=TE0_PeriodoNelMese(Lst_E0[i]);
end;

procedure TQuadriE0.SetItems(i: integer; AValue: TE0_PeriodoNelMese);
begin
  Lst_E0[i]:=AValue;
end;

procedure TQuadriE0.Add(E0: TE0_PeriodoNelMese);
begin
  Lst_E0.Add(E0);
end;

function TQuadriE0.Count: Integer;
begin
  Count :=Lst_E0.Count;
end;

constructor TQuadriE0.Create;
begin
  FrmLog.Log('TQuadriE0.Create');
  Lst_E0:=TObjectList.create;
end;

destructor TQuadriE0.Destroy;
begin
  FrmLog.Log('TQuadriE0.Destroy');
  Lst_E0.free;
end;

procedure TQuadriE0.ParseXML(iNode: TDOMNode);
var
    E0:TE0_PeriodoNelMese;
    t:integer;
    tmps:String;
    aN:TDOMNode;
begin
    aN:=iNode;
    while aN<>Nil do
    begin
      tmps:=aN.NodeName;
      if Tmps='E0_PeriodoNelMese' then
      begin
         E0:=TE0_PeriodoNelMese.Create;
         E0.ParseXML(aN.firstChild);
         Add(E0)
      end;
    an:=An.NextSibling;
  end;
end;

{ TE0_PeriodoNelMese }

function TE0_PeriodoNelMese.Periodo: String;
begin
  Periodo := DateToStr(GiornoInizio)+'...'+DateToStr(GiornoFine);
end;

constructor TE0_PeriodoNelMese.Create;
begin
  FrmLog.Log('TE0_PeriodoNelMese.Create');
  InquadramentoLavPa:=TInquadramentoLavPa.Create;
  Gestioni:=TGestioni.Create;
  AltroEnteVersante:=TAltroEnteVersante.Create;
end;

destructor TE0_PeriodoNelMese.Destroy;
begin
  FrmLog.Log('TE0_PeriodoNelMese.Destroy');
  InquadramentoLavPa.Free;
  Gestioni.free;
  AltroEnteVersante.Free;
end;

procedure TE0_PeriodoNelMese.ParseXML(iNode: TDOMNode);
var
    t:integer;
    aN:TDOMNode;
  begin
     an:=iNode;
     while aN<>nil do
       begin
         if aN.NodeName='GiornoInizio'
            then GiornoInizio := XMLDateToDate(String(An.TextContent));
         if aN.NodeName='GiornoFine'
           then GiornoFine :=XMLDateToDate(String(An.TextContent));
         if aN.NodeName='InquadramentoLavPA'
           then InquadramentoLavPA.parseXML(An.firstchild);
         if aN.NodeName='Gestioni'
           then Gestioni.parseXML(an.FirstChild);
         if aN.NodeName='CodiceCessazione'
           then CodiceCessazione:=StrToInt(An.TextContent);
         if aN.NodeName='NumeroMensilita'
           then NumeroMensilita:=StrToInt(An.TextContent);
         if aN.NodeName='RetribTeoricaTabellareTFR'
           then RetribTeoricaTabellareTFR:=StrToCurr(An.TextContent);
         if aN.NodeName='RetribValutabileTFR'
           then RetribTeoricaTabellareTFR:=StrToCurr(An.TextContent);
         if aN.NodeName='DataFineBeneficioCalamita'
           then DataFineBeneficioCalamita:=XMLDateToDate(String(An.TextContent));
         if aN.NodeName='ConguaglioImponibile'
           then ConguaglioImponibile :=StrToCurr(An.TextContent);
         if aN.NodeName='AltroEnteVersante'
           then AltroEnteVersante.parseXML(AN.firstchild);
         aN:=an.NextSibling;
       end;
  end;

{ TE1_FondoPensioneCompl }

constructor TE1_FondoPensioneCompl.Create;
begin
    DatiPosContribIscritto :=TDatiPosContribIscritto.Create;
    ContribOmessiOIndebiti :=TContribOmessiOIndebiti.Create;
    AltroEnteVersante      :=TAltroEnteVersante.Create;
end;

destructor TE1_FondoPensioneCompl.Destroy;
begin
  DatiPosContribIscritto.Free;
  ContribOmessiOIndebiti.Free;
  AltroEnteVersante.Free;
end;

function TE1_FondoPensioneCompl.Periodo: String;
begin
  Periodo := DateToStr(GiornoInizio)+'...'+DateToStr(GiornoFine);
end;

procedure TE1_FondoPensioneCompl.ParseXML(iNode: TDOMNode);
var
  aN:TDOMNode;
begin
  aN:=iNode;
  while aN<>Nil do
  begin
      if aN.NodeName='GiornoInizio'       then GiornoInizio := XMLDateToDate(String(An.TextContent));
      if aN.NodeName='GiornoFine'         then GiornoFine :=XMLDateToDate(String(An.TextContent));

      if aN.NodeName='DatiPosContribIscritto' then DatiPosContribIscritto.parseXML(aN.FirstChild);
      if aN.NodeName='ContribOmessiOIndebiti' then ContribOmessiOIndebiti.parseXML(aN.FirstChild);
      if aN.NodeName='AltroEnteVersante>' then AltroEnteVersante.parseXML(aN.FirstChild);
     aN:=aN.NextSibling;
    end;
end;

{ TQuadriE1 }

function TQuadriE1.GetItems(i: integer): TE1_FondoPensioneCompl;
begin
  GetItems:= TE1_FondoPensioneCompl(Lst_E1[i]);
end;

procedure TQuadriE1.SetItems(i: integer; AValue: TE1_FondoPensioneCompl);
begin
  Lst_E1[i]:=aValue;
end;

procedure TQuadriE1.Add(E1: TE1_FondoPensioneCompl);
begin
  Lst_E1.Add(E1);
end;

function TQuadriE1.Count: Integer;
begin
  Count:=Lst_E1.Count;
end;

constructor TQuadriE1.Create;
begin
  Lst_E1:=TObjectList.Create;
end;

destructor TQuadriE1.Destroy;
begin
  Lst_E1.free;
end;

procedure TQuadriE1.ParseXML(iNode: TDOMNode);
var
    E1:TE1_FondoPensioneCompl;
    t:integer;
    tmps:String;
    aN:TDOMNode;
begin
    aN:=iNode;
    while aN<>Nil do
    begin
      tmps:=aN.NodeName;
      if Tmps='E1_FondoPensioneCompl' then
      begin
         E1:=TE1_FondoPensioneCompl.Create;
         E1.ParseXML(aN.firstChild);
         Add(E1)
      end;
    an:=An.NextSibling;
  end;
end;

{ TQuadriF1 }

function TQuadriF1.GetItems(i: integer): TF1_Ammortamento;
begin
  GetItems:=TF1_Ammortamento(Lst_F1[i]);
end;

procedure TQuadriF1.SetItems(i: integer; AValue: TF1_Ammortamento);
begin

end;

procedure TQuadriF1.Add(F1: TF1_Ammortamento);
begin
  Lst_F1.Add(F1);
end;

function TQuadriF1.Count: Integer;
begin
  Count := Lst_F1.Count;
end;

constructor TQuadriF1.Create;
begin
  FrmLog.log('TQuadriF1.Create');
  Lst_F1:=TObjectList.create;
end;

destructor TQuadriF1.Destroy;
begin
  Lst_F1.free;
end;

procedure TQuadriF1.ParseXML(iNode: TDOMNode);
begin

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

procedure TF1_Ammortamento.ParseXML(iNode: TDOMNode);
var
  aN:TDOMNode;
  F1:TF1_Ammortamento;
  t:Integer;
begin
  aN:=iNode;
  While aN<>Nil do
  Begin
      if aN.NodeName='AnnoMeseVersNonDich'
         then AnnoMeseVersNonDich.AsStr:= String(An.TextContent);
      if aN.NodeName='AnnoMeseRif'
        then AnnoMeseRif.AsStr:=String(An.TextContent);
      if aN.NodeName='CodGestione'
        then CodGestione:=StrToInt(An.TextContent);
      if aN.NodeName='TipoPiano'
        then TipoPiano:=StrToInt(An.TextContent);
      if aN.NodeName='DataInizio'
        then DataInizio:=XMLDateToDate(String(An.TextContent));
      if aN.NodeName='DataScadenza'
        then DataScadenza:=XMLDateToDate(String(An.TextContent));
      if aN.NodeName='PrgRata'
        then PrgRata:=StrToInt(An.TextContent);
      if aN.NodeName='TotaleRate'
        then TotaleRate:=StrToInt(An.TextContent);
      if aN.NodeName='DataRipristino'
        then DataRipristino:=XMLDateToDate(String(An.TextContent));
      if aN.NodeName='AnteSubentro'
        then AnteSubentro:=String(An.TextContent)[1];
      if aN.NodeName='Importo'
        then Importo:=StrToCurr(An.TextContent);
      if aN.NodeName='TipoOperazione'
        then TipoOperazione:=String(An.TextContent)[1];
//      if aN.NodeName='AltroEnteVersante'
//        then AltroEnteVersante:=An.childNodes[0].TextContent);
      aN:=aN.NextSibling;
    end;
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

procedure TV1_PeriodoPrecedente.ParseXML(iNode: TDOMNode);
var
  aN:TDOMNode;
  V1:TV1_PeriodoPrecedente;
  t:Integer;
  s:string;
  tmps:String;
begin
  s:=inode.ParentNode.Attributes. GetNamedItem('CausaleVariazione').nodevalue;
  CausaleVariazione:=StrToInt(s);

  s:='';
  if inode.ParentNode.Attributes.GetNamedItem('CodMotivoUtilizzo')<>nil
    then begin
      S:=inode.ParentNode.Attributes.GetNamedItem('CodMotivoUtilizzo').nodevalue;
      CodiceMotivoUtilizzo:=StrToInt(s);
    end;

  aN:=iNode;
  while aN<>nil do
    begin
      tmps:=aN.NodeName;
      //Elementi
      if tmps='Aliquota'      then Aliquota := StrToInt(An.TextContent);
      if tmps='GiornoInizio'  then GiornoInizio := XMLDateToDate(String(An.TextContent));
      if tmps='GiornoFine'    then GiornoFine := XMLDateToDate(String(An.TextContent));
      if tmps='InquadramentoLavPA' then InquadramentoLavPA.ParseXML(aN.FirstChild);
      if tmps='Gestioni'      then Gestioni.ParseXML(aN.FirstChild);

      aN:=aN.NextSibling;
    end;
end;



{ TGestioni }

constructor TGestioni.Create;
begin
  FrmLog.Log('TGestioni.Create');
  GestPensionistica :=TGestPensionistica.Create;
  GestPrevidenziale :=TGestPrevidenziale.Create;
  GestCredito       :=TGestCredito.Create;
  ENPDEP            :=TENPDEP.Create;
  ENAM              :=TENAM.Create;
end;

destructor TGestioni.Destroy;
begin
  FrmLog.Log('TGestioni.Destroy');
  GestPensionistica.free;
  GestPrevidenziale.free;
  GestCredito.free;
  ENPDEP.free;
  ENAM.free;
end;

procedure TGestioni.ParseXML(iNode: TDOMNode);
var
  aN:TDOMNode;
  t:integer;
  tmps:String;
begin
  aN:=iNode;
  while aN<>nil do
    begin
      tmps:=aN.NodeName;
      if tmps='GestPensionistica' then GestPensionistica.ParseXML(aN.FirstChild);
      if tmps='GestPrevidenziale' then GestPrevidenziale.ParseXML(aN.FirstChild);
      if tmps='GestCredito'       then GestCredito.ParseXML(aN.FirstChild);
      if tmps='ENPDEP'            then ENPDEP.ParseXML(aN.FirstChild);
      if tmps='ENAM'              then ENAM.ParseXML(aN.FirstChild);

      aN:=aN.NextSibling;
    end
end;

{ TInquadramentoLavPA }

constructor TInquadramentoLavPA.Create;
begin
  PartTimePa:=TPartTimePA.create;
end;

destructor TInquadramentoLavPA.Destroy;
begin
  PartTimePa.Free;
end;

procedure TInquadramentoLavPA.ParseXML(iNode: TDOMNode);
var
  aN:TDOMNode;
  t:integer;
begin
  aN:=iNode;

  while aN<>nil do
    begin
      if aN.NodeName='TipoImpiego'
          then TipoImpiego:=StrToInt(An.TextContent);
      if aN.NodeName='TipoServizio'
          then TipoServizio:=StrToInt(An.TextContent);
      if aN.NodeName='PercRetribuzione'
                  then PercRetribuzione:=StrToInt(An.TextContent);
      if aN.NodeName='Contratto'
          then Contratto:=An.TextContent;
      if aN.NodeName='Qualifica'
          then Qualifica:=An.TextContent;
//      if aN.NodeName='PartTimePA'
//          then PartTimePA.ParseXML(An.firstChild);
      if aN.NodeName='RegimeFineServizio'
          then regimeFineServizio:=StrToInt(An.TextContent);
      aN:=aN.NextSibling;
    end
end;

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

{ TPosPa }

function TPosPa.GetItems(i: integer): TD0_DenunciaIndividuale;
begin
  GetItems:=TD0_DenunciaIndividuale(Lst_D0.Items[i]);
end;

procedure TPosPa.SetItems(i: integer; AValue: TD0_DenunciaIndividuale);
begin

end;

constructor TPosPa.Create;
begin
  FrmLog.Log('TPosPa.Create');
  Lst_D0:= TObjectList.create;
end;

destructor TPosPa.Destroy;
begin
  FrmLog.Log('TPosPa.Destroy');
  Lst_D0.free;
end;

procedure TPosPa.Insert(CF,Cognome,Nome: String);
var
  D0:TD0_DenunciaIndividuale;
begin
  D0:=TD0_DenunciaIndividuale.Create;
  D0.CFLavoratore :=CF;
  D0.Cognome      :=Cognome;
  D0.Nome         :=Nome;
  Lst_D0.Add(D0);
end;

procedure TPosPa.Add(D0: TD0_DenunciaIndividuale);
begin
  Lst_D0.Add(D0);
end;

function TPosPa.Count: Integer;
begin
  Count:=Lst_D0.Count;
end;

procedure TPosPa.ParseXML(iNode: TDOMNode);
var
  D0:TD0_DenunciaIndividuale;
  t:integer;
  aN:TDOMNode;
  tmps:String;
begin

  aN:=iNode;
  while AN<>nil do
    begin
      tmps:=aN.Nodename;
      //if tmps='EnteAppartenenza' then EnteAppartenenza.ParseXML(aN.firstChild);
      //if tmps='SedeServizio' then  SedeServizio.ParseXML(aN.firstChild);

      if tmps='D0_DenunciaIndividuale' then
        begin
          D0:=TD0_DenunciaIndividuale.Create;
          D0.ParseXML(aN.firstchild);
          add(D0)
        end;
      aN:=aN.NextSibling;
    end;
end;



{ TUniemens }

constructor TUniemens.Create;
begin
  FrmLog.Log('TUniEmens.Create');
  DenunceMensili := TDenunceMensili.Create;
end;

destructor TUniemens.Destroy;
begin
  FrmLog.Log('TUniEmens.Destroy');
  DenunceMensili.Free;
end;

procedure TUniemens.LoadXML(nFile: string);
//var
//  PassNode: TDOMNode;
begin
  FrmLog.Log('UniEmens.LoadXML - '+ nFile);
  nFileXml:=nFile;
  try
    ReadXMLFile(XMLDoc, nFile);
    ParseXML;
  finally
    // finally, free the document
    XMLDoc.Free;
  end;
end;

procedure TUniemens.Save(nFile: String);
begin
 { #todo : da fare }
end;

procedure TUniemens.ParseXML;
var
  iNode: TDOMNode;
  tmps : String;
begin
  //Carica i dati dal file XML
  tmps:=XMLDoc.NodeName;
  iNode:=XMLDoc.DocumentElement;
  tmps:=iNode.NodeName;  //<DenunceMensili>
  if tmps='DenunceMensili'
    then DenunceMensili.ParseXML(iNode.FirstChild);
end;

{ TDenunceMensili }

constructor TDenunceMensili.Create;
begin
  FrmLog.Log('TDenunceMensili.Create');
  DatiMittente :=TDatiMittente.Create;
  Azienda      :=TAzienda.Create; //Pero ora solo una..
end;

destructor TDenunceMensili.Destroy;
begin
  FrmLog.Log('TDenunceMensili.Destroy');
  DatiMittente.free;
  Azienda.free;
end;

procedure TDenunceMensili.ParseXML(iNode: TDOMNode);
var
  aNode:TDOMNode;
  tmps:String;
begin
    aNode:=iNode;
    While aNode<> nil do
      begin
      tmps:=aNode.NodeName;

      if tmps='DatiMittente' then
      begin
        DatiMittente.ParseXML(aNode.FirstChild);
      end;
      if tmps='Azienda' then
      begin
        Azienda.ParseXML(aNode.FirstChild);
      end;
      aNode:=aNode.NextSibling;
    end;
end;

{ TDatiMittente }

procedure TDatiMittente.ParseXML(iNode: TDOMNode);
var
  aNode:TDOMNode;
  tmps:String;
begin
    aNode:=iNode;
    While aNode<> nil do
      begin
        tmps:=aNode.NodeName;

        if tmps='CFPersonaMittente' then CFPersonaMittente:=aNode.TextContent;
        if tmps='RagSocMittente' then RagSocMittente:=aNode.TextContent;
        if tmps='CFMittente' then CFMittente:=aNode.TextContent;
        if tmps='CFSoftwarehouse' then CFSoftwarehouse:=aNode.TextContent;
        if tmps='SedeINPS' then SedeINPS:=aNode.TextContent;

        aNode:=aNode.NextSibling;
      end;
end;

{ TAzienda }

constructor TAzienda.Create;
begin
  FrmLog.log('TAzienda.Create');
  PosContributiva      :=TPosContributiva.Create;
  ListaCollaboratori   :=TListaCollaboratori.Create;
  ListaPosPa           :=TListaPosPA.Create;
end;

destructor TAzienda.Destroy;
begin
  FrmLog.log('TAzienda.Destroy');
  PosContributiva.Free;
  ListaCollaboratori.Free;
  ListaPosPa.Free;
end;

procedure TAzienda.ParseXML(iNode: TDOMNode);
var
  aNode:TDOMNode;
  tmps:String;
begin
    aNode:=iNode;
    While aNode<> nil do
      begin
        tmps:=aNode.NodeName;

        if tmps='AnnoMeseDenuncia' then AnnoMeseDenuncia:=aNode.TextContent;
        if tmps='CFAzienda' then CFAzienda:=aNode.TextContent;
        if tmps='RagSocAzienda' then RagSocAzienda:=aNode.TextContent;

        //if tmps='PosContributiva' then PosContributiva.ParseXML(aNode.FirstChild);
        //if tmps='ListaCollaboratori' then ListaCollaboratori.ParseXML(aNode.FirstChild);
        if tmps='ListaPosPA' then ListaPosPA.ParseXML(aNode.FirstChild);

        //if tmps='PosSportSpet' then PosSportSpet.ParseXML(aNode.FirstChild);
        //if tmps='PosAgri' then PosAgri.ParseXML(aNode.FirstChild);

        aNode:=aNode.NextSibling;
      end;
end;

{ TListaPosPA }

constructor TListaPosPA.Create;
begin
  FrmLog.log('TListaPosPA.Create');
  PosPa:=TPosPa.create;
end;

destructor TListaPosPA.Destroy;
begin
  FrmLog.log('TListaPosPA.Destroy');
  PosPa.Free;
end;

procedure TListaPosPA.ParseXML(iNode: TDOMNode);
var
  aNode:TDOMNode;
  tmps:String;
begin
    aNode:=iNode;
    While aNode<> nil do
      begin
        tmps:=aNode.NodeName;

        if tmps='PRGAZIENDA' then PRGAZIENDA:=aNode.TextContent;
        if tmps='CFRappresentanteFirmatario' then CFRappresentanteFirmatario:=aNode.TextContent;
        if tmps='ISTAT' then ISTAT:=aNode.TextContent;
        if tmps='FormaGiuridica' then FormaGiuridica:=aNode.TextContent;
        if tmps='EnteVersanteMEF' then EnteVersanteMEF:=aNode.TextContent;
        if tmps='PosPA'
          then PosPA.ParseXML(aNode.FirstChild);
        //if tmps='AltriImportiDovutiZ2' then AltriImportiDovutiZ2:=aNode.TextContent;
        //if tmps='AltriImportiAConguaglio' then AltriImportiAConguaglio:=aNode.TextContent;

        aNode:=aNode.NextSibling;
      end;

end;




end.

