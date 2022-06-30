unit UClsUniEmensTab;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

Type

  { TCodGestione }

  TCodGestione=Class
    Function Descr(cod:Integer):String;
  end;

  { TTipoPartTime }

  TTipoPartTime=class
    Function Descr(cod:String):String;
  end;

  { TRegimeFineServizio }

  TRegimeFineServizio=Class
    Function Descr(cod:Integer):String;
  end;

  { TCodCestione }



 { TTipoImpiego }

 TTipoImpiego=class
   Function Descr(cod:Integer):String;
 end;

 { TTipoServizio }

 TTipoServizio=class
   Function Descr(cod:Integer):String;
 end;
 { TCausaleVarizione }
  TCausaleVarizione=class
 Public
   Function Descr(cod:Integer):String;
 end;

Function _TipoOperazione(s:String):String;
Function _TipoPiano(n:Integer):String;
Function _Aliquota(n:Integer):String;
Function _CodiceCessazione(n:Integer):String;
Function _CodMotivoUtilizzo(n:Integer):String;
Function _InquadramentoLavPA(Q:String):String;

var
  _CausaleVariazione:TCausaleVarizione;
  TipoImpiego:TTipoImpiego;
  TipoServizio:TTipoServizio;
  RegimeFineServizio:TRegimeFineServizio;
  TipoPartTime:TTipoPartTime;
  _CodGestione:TCodGestione;

implementation

{ TTipoPartTime }

function TTipoPartTime.Descr(cod: String): String;
begin
  case cod of
    'P':Descr:='ORIZZONTALE';
    'V':Descr:='VERTICALE';
    'M':Descr:='MISTO';
  end;
end;

{ TRegimeFineServizio }

function TRegimeFineServizio.Descr(cod: Integer): String;
begin
  case cod of
    1:Descr:='TFR';
    2:Descr:='OPTANTE';
    3:Descr:='TFS';
  end;
end;


{ TTipoImpiego }

function TTipoImpiego.Descr(cod: Integer): String;
begin
  case cod of
    1: Descr:='Contratto a tempo indeterminato (tempo pieno)';
    2: Descr:='Giornaliero';
    3: Descr:='C.F.L.-D.L.299/94 conv. in L.451/94 art.16 c.2 lett.a)-CENTRO,NORD-Aliquota datore di di lavoro: riduzione aliquota ordinaria del 25% (limite max 24 mesi)';
    4: Descr:='C.F.L.-D.L.299/94 conv.in L.451/94 art.16 c.2 lett.a) - MEZZOGIORNO - Aliquota datore di lavoro: riduzione aliquota ordinaria del 50% (limite max 24 mesi)';
    5: Descr:='C.F.L.-D.L.299/94 conv.in L.451/94 art.16 c.2 lett.b) CENTRO-NORD.Trasformazione C.F.L. in rapp. di lavoro a tempo indet. per periodo pari a durata del C.F.L. trasf.(limite max 12 mesi)';
    6: Descr:='C.F.L.-D.L.299/94 conv.in L.451/94 art.16 c.2 lett.b) MEZZOGIORNO - Trasformaz.C.F.L.in rapporto a tempo indet. per la durata del C.F.L.trasformato(lim.max 12 mesi)';
    7: Descr:='C.F.L.-L.196/97-ART.15 REGIONI:BASILICATA,CAMPANIA,PUGLIA,CALABRIA,SARDEGNA E SICILIATrasformaz. di C.F.L.art.16 c.2 a)L.451/94 in rapporti di lavoro a tempo indeterminato';
    8: Descr:='Part-time (contratto a tempo indeterminato)';
    9: Descr:='Orario ridotto';
    10: Descr:='Tempo definito (personale sanitario e universitario)';
    11: Descr:='Lavoratori assunti ai sensi L.407 del 1990, art.8, comma 9, da IMPRESE, ENTI PUBBLICI ECONOMICI E CONSORZI EX Legge 267/2000 - CENTRO-NORD';
    12: Descr:='Lavoratori assunti ai sensi L.407 del 1990, art. 8, comma 9, da IMPRESE, ENTI PUBBLICI ECONOMICI E CONSORZI ex legge 267/2000 - MEZZOGIORNO';
    13: Descr:='Supplenti della Scuola';
    14: Descr:='Applicazione D.Lgs.165 del 1997 - art. 4 per personale militare in sistema retributivo';
    17: Descr:='Contratto a tempo determinato (tempo pieno)';
    18: Descr:='Part-time (contratto a tempo determinato)';
    35: Descr:='CONTRATTI DI INSERIMENTO. Art.54 D.Lgs.276/2003, comma 1 lettere b) c) d) f) - Aliquota datore di lavoro: riduzione aliquota ordinaria del 25% per durata contratto (min. 9 mesi max 36 mesi).';
    36: Descr:='CONTRATTI DI INSERIMENTO. Art.54 D.Lgs. 276/2003, comma 1 lettera e) - Lavoratrici residenti in Lazio e Molise. Aliquota datore di lavoro: riduzione aliquota ordinaria del 25% durata contratto min. 12 mesi.';
    37: Descr:='CONTRATTI DI INSERIMENTO. Art.54 D.Lgs.276/2003, comma 1 lettera e) -Lavoratrici residenti in Campania, Puglia, Basilicata, Calabria, Sicilia, Sardegna. Aliquota datore di lavoro: riduzione aliquota ordinaria del 50% , durata contratto min. 12 mesi.';
    38: Descr:='Personale militare di ferma breve o prolungata';
    39: Descr:='Lavoratore in esodo ex art.4 legge n.92/2012';
    40: Descr:='Ausiliaria Ufficiali';
    41: Descr:='Ausiliaria Sottufficiali';
    42: Descr:='Lavoratore in esodo ex art. 3 legge n. 92/2012 (Circ. n. 90/2015)';

  end;
end;

{ TTipoServizio }
function TTipoServizio.Descr(cod: Integer): String;
begin
  case cod of
    4: Descr:='Servizio ordinario';
    9: Descr:='Congedo Parentale con retribuzione ridotta per maternità e per assistenza al bambino';
    11: Descr:='Periodo in ausiliaria personale militare (D.lgs. 165 del 1997)';
    15: Descr:='Aspettativa personale fuori ruolo impiego presso enti ed organismi internazionali di cui all’art. 1 della legge n. 1114 del 27/07/1962';
    27: Descr:='Aspettativa servizio militare (art 40 DPR.130/69,DPR 1092/73)';
    29: Descr:='Assenza dal lavoro per educazione e assistenza ai figli fino al 6° anno di età (art.1 comma 40 lett. a L.335/95)';
    32: Descr:='Servizio ed aspettativa non retribuita per motivi sindacali fruita in misura parziale';
    33: Descr:='Congedo di maternità e paternità ex artt. 16,17, 20 e 28 D.Lgs. n.151/2001 dei dipendenti delle aziende di cui all''art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    34: Descr:='Prolungamento del congedo parentale fino a tre anni del bambino con handicap, disciplinato dall’art.33, comma 1, D.Lgs. n. 151/2001 modificato dall’art. 8 del D.Lgs. 80/2015, dei dipendenti delle aziende di cui all''art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    35: Descr:='Astensione dal lavoro per malattia ,degli operai delle aziende di cui all''art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    42: Descr:='Congedo parentale senza retribuzione per assistenza al bambino';
    43: Descr:='Aspettativa senza assegni per nomina a direttore generale utile ai fini trattamento quiescenza e previdenza';
    44: Descr:='Riposi giornalieri per lavoratore portatore di handicap grave, art 33, comma 6, legge n. 104/1992 dei dipendenti delle aziende di cui all''art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    45: Descr:='Permessi mensili per handicap grave legge 104/92 dei dipendenti delle aziende di cui all''art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    46: Descr:='Mandato amministrativo ex art.81 d.lgs. 267/2000 con obbligo a carico amministrazione di appartenenza';
    47: Descr:='Esonero art.72 D.L. 112/2008';
    48: Descr:='Assenza dal lavoro per assistenza figli dal 6° anno di età, coniuge, genitori conviventi per condizioni previste ex. art.3 L.104/92 (art. 1 comma 40 lett. b L. 335/95)';
    49: Descr:='Congedo straordinario per assistenza ai soggetti con handicap grave ex. art.42 comma 5 decreto legislativo 151/2001 sostituito dalla lettera b del comma 1 dell’art. 4 del decreto legislativo del 18 luglio 2011 n. 119';
    50: Descr:='Aspettativa senza assegni docenti universitari ai sensi degli art. 12 e 13 del DPR 382/1980';
    51: Descr:='Sospensione cautelare dal servizio del personale militare ai sensi dell''art. 3 della legge 538/1961 e 24 della legge469/1958 e successive modifiche';
    52: Descr:='Aspettativa per incarico di responsabilità di governo Art. 6 DPR 1032/73';
    53: Descr:='Congedo straordinario per assistenza ai soggetti con handicap grave ex. art.42 comma 5 decreto legislativo 151/2001 sostituito dalla lettera b del comma 1 dell’art. 4 del decreto legislativo del 18 luglio 2011 n. 119 dei dipendenti delle aziende di cui all''art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    54: Descr:='Riposi giornalieri fino al primo anno di vita del bambino o fino sl terzo anno per figli con handicap grave utilizzati da dipendenti delle aziende di cui all''art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    55: Descr:='Incarico di Direttore Generale, Amministrativo o Sanitario delle Aziende Sanitarie Locali ed Ospedaliere';
    56: Descr:='Aspettativa per Dottorato di Ricerca - art. 2 della legge 476 del 13 agosto 1984';
    57: Descr:='Cooperazione con paesi in via di sviluppo - art. 32 della legge 49 del 26 febbraio 1987; art. 3 della legge 288 del 29 agosto 1991';
    58: Descr:='Assenza dal servizio per richiamo alle armi';
    59: Descr:='Servizio per richiamo alle armi';
    60: Descr:='Lavoratore in esodo ex art.4 legge n.92/2012';
    63: Descr:='Congedo per malattia bambino di età inferiore ai tre anni con retribuzione assente - ex art.47, comma 1, d. lgs. n.151/2001';
    64: Descr:='Congedo malattia bambino di età superiore ai tre anni ed inferiore agli otto senza retribuzione (max 5 giorni all’anno per ciascun genitore) - ex art.47, comma 2 d. lgs. n.151/2001';
    65: Descr:='Congedo parentale disciplinato dall’art. 35, comma 1, d.lgs. n. 151/2001 (sei mesi entro il sesto anno di vita del bambino) dei dipendenti delle aziende di cui all’art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    66: Descr:='Congedo per malattia figlio con età inferiore ai tre anni disciplinati dall’art. 49, comma 1, d.lgs. n. 151/2001 dei dipendenti delle aziende di cui all’art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    67: Descr:='Congedo per malattia del bambino di età compresa trai tre e gli otto anni (max 5 giorni all’anno per ciascun genitore) ex art. 47 c. 2 del d.lgs. 151/2001 dei dipendenti delle aziende di cui all’art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    68: Descr:='Congedo parentale disciplinato dall’art.35, comma 2, d.lgs. n.151/2001 (oltre i sei mesi entro i sei anni di vita del bambino ovvero fruiti fra il sesto e il dodicesimo anno), dei dipendenti delle aziende di cui all’art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    69: Descr:='Congedo obbligatorio del padre di cui all’art.4, comma 24 lettera a) della legge 28 giugno 2012 n.92 dei dipendenti delle aziende di cui all’art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    70: Descr:='Congedo facoltativo del padre di cui all’art.4, comma 24 lettera a) della legge 28 giugno 2012 n.92 dei dipendenti delle aziende di cui all’art.20 c.2 del decreto legge 25 giugno 2008 n.112';
    71: Descr:='Lavoratore in esodo ex art. 3 legge n. 92/2012 – fondo solidarietà personale del credito (Circ. n. 90/2015)';
    72: Descr:='Congedo parentale ad ore con retribuzione ridotta (Circ. n. 40/2016).';
    73: Descr:='Congedo parentale ad ore senza retribuzione (Circ. n. 40/2016).';
    74: Descr:='Retribuzione figurativa tredicesima (Circ. n. 40/2016).';
    75: Descr:='Congedo parentale ad ore disciplinato dall’art.35, comma 1, d.lgs. n. 151/2001 dei dipendenti delle aziende di cui all’art. 20 c. 2 del decreto legge 25 giugno 2008 n. 112 (Circ. n. 40/2016).';
    76: Descr:='Congedo parentale ad ore disciplinato dall’art.35, comma 2, d.lgs. n. 151/2001 dei dipendenti delle aziende di cui all’art. 20 c. 2 del decreto legge 25 giugno 2008 n. 112 (Circ. n. 40/2016).';
    77: Descr:='Congedo art 24 d.lgs. 80/2015 su base giornaliera (Circ. n. 65/2016).';
    78: Descr:='Congedo art 24 d.lgs. 80/2015 su base oraria (Circ. n. 65/2016).';
    79: Descr:='Congedo art 24 d.lgs. 80/2015 su base giornaliera datori di lavoro privati (Circ. n. 65/2016).';
    80: Descr:='Congedo art 24 d.lgs. 80/2015 su base oraria datori di lavoro privati (Circ. n. 65/2016).';
    81: Descr:='Lavoratore in esodo ex art.4 legge n.92/2012- Domanda presentata a decorrere dal 1° maggio 2015 (Messaggio n. 5804/2015).';
  end;
end;
{ TCausaleVarizione }

function TCausaleVarizione.Descr(cod: Integer): String;
begin
  case cod of
    1: Descr:='Integrazione di dati già comunicati';
    2: Descr:='Dati di retribuzioni e contributi non denunciati relativi a periodi pregressi';
    5: Descr:='Sostituzione periodi pregressi trasmessi in precedenza';
    6: Descr:='Annullamento periodi pregressi trasmessi in precedenza';
    7: Descr:='Conguaglio previdenziale';
  end;
end;

{ TCodCestione }

function TCodGestione.Descr(cod: Integer): String;
begin
  case cod of
    1: Descr:='Cassa Trattamenti pensionistici dei dipendenti statali';
    2: Descr:='Cassa Pensioni Dipendenti Enti Locali';
    3: Descr:='Cassa Pensioni Insegnanti';
    4: Descr:='Cassa Pensioni Ufficiali Giudiziari';
    5: Descr:='Cassa Pensioni Sanitari';
    6: Descr:='I.N.A.D.E.L.';
    7: Descr:='E.N.P.A.S.';
    8: Descr:='E.N.P.D.E.P. (Assicurazione Sociale Vita)';
    9: Descr:='Gestione Unitaria delle Prestazioni Creditizie e Sociali';
    11: Descr:='E.N.A.M.';
    else Descr:='';
   end;
end;

Function _TipoPiano(n:Integer):String;
var
  Descr:String;
begin
  case n of
    11:Descr:='Riscatto ai fini pensionistici';
    12:Descr:='Ricongiunzione L.29/79';
    13:Descr:='Riscatto ai fini TFS';
    28:Descr:='Riscatto ai fini TFR';
    41:Descr:='Ricongiunzione L.45/90';
  end;
  _TipoPiano:=Descr;
end;

Function _TipoOperazione(s:String):String;
var
  Descr:String;
begin
  case s of
    'V':Descr:='Versamento';
    'R':Descr:='Rimborso';
    'S':Descr:='Storno';
  end;
  _TipoOperazione:=Descr;
end;

Function _Aliquota(n:Integer):String;
var
  Descr:String;
begin
  case n of
    1:Descr:='Emolumenti assoggettati ad aliquota contributiva di competenza';
    2:Descr:='Emolumenti assoggettati ad aliquota contributiva di cassa';
  end;
  _Aliquota:=Descr;
end;

Function _CodiceCessazione(n:Integer):String;
var
  Descr:String;
begin
  case n of
    1:Descr:='Decesso';
    2:Descr:='Dimissioni volontarie/recesso del dipendente';
    3:Descr:='Limiti di età';
    4:Descr:='Limiti di servizio';
    5:Descr:='Dispensa dal servizio per inabilità permanente alle mansioni';
    6:Descr:='Dispensa dal servizio per invalidità (art. 2, comma 12, L. 335/95)';
    9:Descr:='Destituzione';
    12:Descr:='Dimissioni volontarie (valido fino a 01/2013)';
    13:Descr:='Passaggio ad altra amministrazione (MOBILITA'')';
    14:Descr:='Licenziamento';
    17:Descr:='Dispensa dal servizio inabilità assoluta e permanente a qualsiasi proficuo lavoro';
    18:Descr:='Fine incarico';
    25:Descr:='Trasformazione del rapporto di lavoro in tempo parziale (D.M. 331/97)';
    29:Descr:='Risoluzione consensuale per i dirigenti';
    30:Descr:='Perdita della cittadinanza nel rispetto della normativa comunitaria';
    31:Descr:='Prosecuzione del rapporto di lavoro oltre i limiti di età per il collocamento a riposo (L.186/2004)';
    32:Descr:='Sospensione di periodo lavorativo utile';
    34:Descr:='Collocamento a riposo oltre i limiti di età';
    35:Descr:='Trattamento di mobilità';
    36:Descr:='Aspettativa per mandato amministrativo d. lgs 267/2000 con onere amministrazione locale';
    37:Descr:='Aspettativa per mandato amministrativo d. lgs 267/2000 con onere carico iscritto (articolo 2, comma 24, della legge 24 dicembre 2007, n. 244)';
    38:Descr:='Aspettativa per incarico di Direttore Generale, Amministrativo o Sanitario di Aziende Sanitarie Locali o Aziende Ospedaliere';
    39:Descr:='Aspettativa per mandato politico elettivo (art.31, L.300 del 1970)';
    40:Descr:='Aspettativa non retribuita per motivi sindacali (art.31, L.300 del 1970)';
    41:Descr:='Aspettativa per cooperazione paesi in via di sviluppo';
    42:Descr:='Sospensione cautelare';
    43:Descr:='C.I.G ordinaria';
    44:Descr:='C.I.G straordinaria';
    45:Descr:='C.I.G speciale';
    46:Descr:='Aspettativa per incarico di Direttore Generale di Amministrazioni Pubbliche';
    47:Descr:='Cessazione per esodo legge n.92/2012';
    48:Descr:='Cambio TipoImpiego';
  end;
  _CodiceCessazione:=Descr;
end;

Function _CodMotivoUtilizzo(n:Integer):String;
var
  Descr:String;
begin
  case n of
    1: Descr:='Conguaglio contributivo in occasione dei conguagli annuali (retribuzioni corrisposte direttamente)';
    2: Descr:='Conguaglio contributivo in occasione dei conguagli annuali (retribuzioni corrisposte anche da terzi)';
    3: Descr:='Regolarizzazione da sentenza';
    4: Descr:='Regolarizzazione da transazione';
    5: Descr:='Regolarizzazione da circolare o messaggio';
    6: Descr:='Riduzioni dell’imponibile gestioni INADEL o ENPAS per recuperi effettuati in periodi con tipo servizio non utile ai fini delle suddette gestioni';
    7: Descr:='Recupero competenze dipendente cessato';
    8: Descr:='Eventi con accredito figurativo';
    9: Descr:='Contribuzione Correlata lavoratori in esodo (Circ. n. 90/2015)';
    10: Descr:='Regolarizzazione TFS Dipendenti Tempo Determinato delle Province di Bolzano e Trento. Utilizzabile a seguito di emanazione di apposito messaggio.';
    11: Descr:='Assenza Retribuita (Circ. n. 65/2016)';
  end;
  _CodMotivoUtilizzo:=Descr;
end;

Function _InquadramentoLavPA(Q:String):String;
var
  r:String;
begin
  if Q='000061' then r:='CONTRATTISTI';
  if Q='000096' then r:='COLLABORATORE A TEMPO DETERMINATO';
  if Q='025000' then r:='POSIZIONE ECONOMICA A2';
  if Q='027000' then r:='POSIZIONE ECONOMICA A3';
  if Q='028000' then r:='POSIZIONE ECONOMICA A4';
  if Q='032000' then r:='POSIZIONE ECONOMICA B2';
  if Q='034000' then r:='POSIZIONE ECONOMICA B3';
  if Q='036494' then r:='POSIZ.ECON. B4 PROFILI ACCESSO B3';
  if Q='036495' then r:='POSIZ.ECON. B4 PROFILI ACCESSO B1';
  if Q='037492' then r:='POSIZ.ECON. B5 PROFILI ACCESSO B3';
  if Q='037493' then r:='POSIZ.ECON. B5 PROFILI ACCESSO B1';
  if Q='038490' then r:='POSIZ.ECON. B6 PROFILI ACCESSO B3';
  if Q='038491' then r:='POSIZ.ECON. B6 PROFILI ACCESSO B1';
  if Q='042000' then r:='POSIZIONE ECONOMICA C2';
  if Q='043000' then r:='POSIZIONE ECONOMICA C3';
  if Q='045000' then r:='POSIZIONE ECONOMICA C4';
  if Q='046000' then r:='POSIZIONE ECONOMICA C5';
  if Q='049000' then r:='POSIZIONE ECONOMICA D2';
  if Q='050000' then r:='POSIZIONE ECONOMICA D3';
  if Q='051488' then r:='POSIZ.ECON. D4 PROFILI ACCESSO D3';
  if Q='051489' then r:='POSIZ.ECON. D4 PROFILI ACCESSO D1';
  if Q='052486' then r:='POSIZ.ECON. D5 PROFILI ACCESSO D3';
  _InquadramentoLavPA:=r;
end;

 initialization
   TipoImpiego:=TTipoImpiego.Create;
   _CausaleVariazione:=TCausaleVarizione.Create;
   RegimeFineServizio:=TRegimeFineServizio.Create;
   TipoPartTime:=TTipoPartTime.Create;
   _CodGestione:=TCodGestione.Create;
 finalization
   TipoImpiego.free;
   _CausaleVariazione.Free;
   RegimeFineServizio.Free;
   TipoPartTime.Free;
   _CodGestione.Free;
end.

