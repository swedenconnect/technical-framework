<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Tekniska anslutningsregler för Sweden Connect-federationen

### 2022-12-20

Specifikation gällande aktörer som ansluter till
DIGG:s identitetsfederation Sweden Connect.

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">Myndigheten för digital förvaltning (DIGG)</a>, 2021-2022.
</p>

## Innehållsförteckning

1. [**Introduktion**](#introduktion)

   1.1. [Avtal](#avtal)
   
   1.1.1. [Valfrihetssystem 2017](#valfrihetssystem-2017)
   
   1.1.2. [Internationell legitimering - eIDAS](#internationell-legitimering-eidas)
   
   1.1.3. [eID för medarbetare](#eid-for-medarbetare)
   
   1.1.4. [Bilaterala avtal om legitimering](#bilaterala-avtal-om-legitimering)
   
   1.2. [Tillitsnivåer och identifierare för legitimering](#tillitsnivaer)
   
   1.2.1. [Svenska tillitsnivåer](#svenska-tillitsnivaer)
   
   1.2.2. [Tillitsnivåer enligt eIDAS](#tillitsnivaer-enligt-eidas)
   
   1.2.3. [Identifierare för tillitsnivåer](#identifierare-for-tillitsnivaer)
   
   1.3. [Legitimeringstjänster inom Sweden Connect](#legitimeringstjanster-inom-sweden-connect)
   
   1.3.1. [Granskning avseende uppfyllnad av Tekniskt ramverk](#granskning-avseende-uppfyllnad-av-tekniskt-ramverk)
   
   1.3.2. [Publicering av instanser till Sweden Connect-miljöer](#publicering-av-instanser-till-sweden-connect-miljeer)
   
   1.3.3. [Specifika krav för aktörsspecifika legitimeringstjänster](#aktorsspecifika-legitimeringstjanster)
   
   1.3.4. [Uppfyllnad av Tekniskt ramverk över tid](#uppfyllnad-av-tekniskt-ramverk-over-tid)
   
2. [**Legitimering och leverans av identitetsintyg**](#legitimering-och-leverans-av-identitetsintyg)

   2.1. [Användargränssnitt](#anvandargranssnitt)

   2.1.1. [Felhantering och rapportering](#felhantering-och-rapportering)
   
   2.1.2. [Information om identitetsattribut](#information-om-identitetsattribut)
   
   2.2. [Krav rörande Single-sign-on](#krav-rorande-single-sign-on)
   
   2.3. [Krav på attributleverans](#krav-pa-attributleverans)
   
   2.3.1. [Leverans av intyg till den svenska eIDAS-noden](#leverans-av-intyg-till-den-svenska-eidas-noden)

   2.3.2. [Övriga attribut](#ovriga-attribut)
   
   2.4. [Specifika krav rörande Tillitsnivå 4](#specifika-krav-rorande-tillitsniva-4)
   
3. [**Metadata**](#metadata)

   3.1. [Registrering av organisationsinformation](#registrering-av-organisationsinformation)
   
   3.2. [Registrering av visningsnamn och logotyp](#registrering-av-visningsnamn-och-logotyp)
   
   3.3. [Registrering av tillitsnivåer](#registrering-av-tillitsnivaer)
   
   3.4. [Registrering av Service Entity Category-värden](#registrering-av-service-entity-category-varden)
   
   3.4.1. [loa3-pnr](#loa3-pnr)
   
   3.4.2. [loa4-pnr](#loa4-pnr)
   
   3.4.3. [loa3-orgid](#loa3-orgid)
   
   3.4.4. [loa4-orgid](#loa4-orgid)
   
   3.4.5. [loa3-name](#loa3-name)
   
   3.4.6. [loa4-name](#loa4-name)
   
   3.4.7. [eidas-naturalperson](#eidas-naturalperson)
   
   3.4.8. [eidas-pnr-delivery](#eidas-pnr-delivery)
   
   3.5. [Registrering av typ av förlitande part - Service Type Category](#registrering-av-typ-av-forlitande-part)
   
   3.5.1. [Indikator för underskriftstjänst](#indikator-for-underskriftstjanst)
   
   3.5.2. [Indikator för offentlig eller privat sektor](#indikator-for-offentlig-eller-privat-sektor)
   
   3.6. [Registrering av tecknade avtal](#registrering-av-tecknade-avtal)
   
   3.6.1. [Sweden Connect-avtal](#sweden-connect-avtal)
   
   3.6.2. [Bilaterala avtal](#other-contracts)
   
   3.6.3. [Valfrihetssystem 2017](#eid-choice-2017)
   
   3.6.4. [eID för medarbetare](#eid-for-medarbetare2)
   
   3.7. [Metadataregler gällande organisationsidentiteter](#metadataregler-gallande-organisationsidentiteter)
   
   3.8. [Metadataregler gällande samordningsnummer](#metadataregler-gallande-samordningsnummer)
   
   3.9. [Metadataregler gällande tillitsnivå 4 (LoA 4)](#metadataregler-gallande-tillitsniva-4)
   
4. [**Versioner av detta dokument**](#versioner-av-detta-dokument)

    
<a name="introduktion"></a>
## 1. Introduktion

Detta dokument är en normativt styrande specifikation gällande aktörer som ansluter till
DIGG:s identitetsfederation Sweden Connect.

Givet de olika avtalen för leverantörer och deltagare inom federationen definieras specifika 
krav baserat på avtalens utformning och de tekniska kraven i [Sweden Connect - Tekniskt ramverk](https://docs.swedenconnect.se/technical-framework/). 

<a name="avtal"></a>
### 1.1. Avtal

Deltagare inom Sweden Connect-federationen har tecknat ett, eller flera, anslutningsavtal. 
Dessa avtal definierar vilken typ av legitimering som levereras/efterfrågas, samt områden 
såsom avgifter och ansvarsfrågor. Denna specifikation berör endast de tekniska aspekterna av
de olika avtalen, d.v.s., hur legitimering går till och vilka krav som ställs på en viss aktör
rörande registrering etc.

<a name="valfrihetssystem-2017"></a>
#### 1.1.1. Valfrihetssystem 2017

[Valfrihetssystem 2017](https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/nationell-e-legitimering) är ett avtal som ger förlitande parter tillgång till godkända, och granskade, legitimeringstjänst(er) som levererar identitetsintyg utställda enligt tillitsnivå 3 (eller 4), och innehållande person- eller samordningsnummer. 

> Endast offentliga förlitande parter kan teckna detta avtal.

Legitimeringstjänster som levererar enligt Valfrihetssystem 2017 har tecknat 
[Anslutningsavtal för leverantör avseende
Valfrihetssystem 2017 e-legitimering](https://www.digg.se/download/18.3b27105f17fb89447e844b9/1650367183306/anslutningsavtal-leverantor-valfrihetssystem-2017.docx).


<a name="internationell-legitimering-eidas"></a>
#### 1.1.2. Internationell legitimering - eIDAS

För att en svensk förlitande part ska få tillgång till eIDAS-legitimering tecknas avtalet
[Avtal med förlitande part beträffande funktioner för elektronisk identifiering - Sweden Connect](https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/internationell-e-legitimering).

Detta avtal ger en förlitande part rätt att nyttja den svenska eIDAS-noden för legitimering av personer som innehar ett utländskt eID.

> Både offentliga och privata aktörer kan teckna detta avtal. Notera dock att eIDAS-legitimering för "private sector" i dagsläget har dåligt, eller inget, stöd bland de anslutna länderna.

<a name="eid-for-medarbetare"></a>
#### 1.1.3. eID för medarbetare

[Förlitandeavtal - Förbetald e-legitimering](https://www.digg.se/download/18.3b27105f17fb89447e84747/1650447908281/forlitandeavtal-forbetald-e-legitimering.docx) ger en förlitande part rätt att nyttja de legitimeringstjänster inom Sweden Connect som levererar identitetsintyg baserat på legitimering utförd med e-tjänstelegitimation. För dessa legitimeringstjänster krävs även en godkänd tillitsgranskning enligt nivå 2, 3 eller 4
och att de levererar enligt [Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald e-legitimering](https://www.digg.se/download/18.5b30ce7218475cd9ed3289b/1670934932324/Anslutningsavtal-leverantor-forbetald-e-legitimering.docx).

> Endast offentliga förlitande parter kan teckna [Förlitandeavtal - Förbetald e-legitimering](https://www.digg.se/download/18.3b27105f17fb89447e84747/1650447908281/forlitandeavtal-forbetald-e-legitimering.docx).

Se vidare:

- E-legitimering för medarbetare - https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/tjanstelegitimation

- Leverantör av e-tjänstelegitimationer - https://www.digg.se/digitala-tjanster/e-legitimering/e-legitimering-for-dig-som-leverantor/leverera-e-tjanstelegitimationer

<a name="bilaterala-avtal-om-legitimering"></a>
#### 1.1.4. Bilaterala avtal om legitimering

En förlitande part som har tecknat [Avtal med förlitande part beträffande funktioner för elektronisk identifiering - Sweden Connect](https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/internationell-e-legitimering) kan också
teckna bilaterala avtal med leverantörer angående legitimeringstjänster som inte
erbjuds via de befintliga DIGG-avtalen. Detta kan till exempel vara en 
tredjeparts-legitimeringstjänst för BankID (som inte finns som officiell legitimeringstjänst 
i Sweden Connect).

Aktören har i dessa fall rätt att begära av federationsoperatören (DIGG) att dessa 
"aktörsspecifika" legitimeringstjänster publicerar sin metadata i Sweden Connect-federationen
(under aktörens ansvar). Se kapitel [1.3.3](#aktorsspecifika-legitimeringstjanster) nedan.

> Notera: Leverantörer som levererar t.ex. BankID-tjänster inom Sweden Connect kan ha
avtal med flera olika förlitande parter. Leverantören kan då ha **en** instans av en
legitimeringstjänst i Sweden Connect som delas mellan de olika förlitande parterna.
Federationsoperatörens (DIGG) krav är att samtliga förlitande parter som nyttjar
denna instans meddelar DIGG om detta.

<a name="tillitsnivaer"></a>
### 1.2. Tillitsnivåer och identifierare för legitimering

Detta kapitel går igenom de [tillitsnivåer](https://www.digg.se/digital-identitet/e-legitimering/tillitsnivaer) som används inom Sweden Connect-federationen
samt de olika identifierare som används för att representera olika typer av legitimering.

<a name="svenska-tillitsnivaer"></a>
#### 1.2.1. Svenska tillitsnivåer

DIGG:s tillitsramverk, [Tillitsramverk för kvalitetsmärket Svensk e-legitimation](https://www.digg.se/digital-identitet/e-legitimering/tillitsnivaer/tillitsramverket), definierar tre tillitsnivåer; 2, 3 or 4, 
varav tillitsnivå 3 och 4 för närvarande används inom Sweden Connect.

För att en legitimeringstjänst skall ha tillåtelse att legitimera och utfärda intyg
enligt någon av dessa nivåer måste eID-utfärdaren **och** legitimeringstjänsten ha
granskats och godkänts av DIGG. 

Se https://www.digg.se/digitala-tjanster/e-legitimering/e-legitimering-for-dig-som-leverantor för mer information angående ansökan om granskning.

<a name="tillitsnivaer-enligt-eidas"></a>
#### 1.2.2. Tillitsnivåer enligt eIDAS

EU-förordningen eIDAS, [nr 910/2014](https://eur-lex.europa.eu/legal-content/SV/TXT/?uri=CELEX%3A32014R0910),
definierar tre olika tillitsnivåer: "low", "substantial" och "high". Dessa motsvarar i princip
de svenska nivåerna 2, 3 och 4, men det finns vissa skillnader vilket gör att en översättning mellan nivåerna inte låter sig göras.

Svenska förlitande parter som legitimerar individer genom eIDAS-legitimering, via den svenska eIDAS-noden, måste därför kunna hantera tillitsidentifierare för eIDAS (se nedan).

<a name="identifierare-for-tillitsnivaer"></a>
#### 1.2.3. Identifierare för tillitsnivåer

Inom Sweden Connect representeras en legitimeringoperation genom s.k. 
"Authentication Context URI:er". Dessa beskrivs i kapitel 3.1.1 av 
[Swedish eID Framework - Registry for identifiers](https://docs.swedenconnect.se/technical-framework/latest/03_-_Registry_for_Identifiers.html#authentication-context-uris).

Detta kapitel går igenom dessa och redogör för vilka regler som gäller för dess
användning.

- `http://id.elegnamnden.se/loa/1.0/loa3` - tillitsnivå 3 - Endast legitimeringstjänster
som är godkända enligt [tillitsramverkets](https://www.digg.se/digital-identitet/e-legitimering/tillitsnivaer/tillitsramverket) nivå 3 (eller 4) får utfärda identitetsintyg innehållande
denna identifierare.

- `http://id.elegnamnden.se/loa/1.0/loa4` - tillitsnivå 4 - Endast legitimeringstjänster
som är godkända enligt [tillitsramverkets](https://www.digg.se/digital-identitet/e-legitimering/tillitsnivaer/tillitsramverket) nivå 4 får utfärda identitetsintyg innehållande
denna identifierare. [Sweden Connect - Tekniskt ramverk](https://docs.swedenconnect.se/technical-framework/) ställer också ytterligare krav rörande tillitsnivå där SAML-profilen "Holder-of-key"
krävs.

- `http://id.elegnamnden.se/loa/1.0/eidas-nf-low` - eIDAS "low" utfärdat av eID som anmälts till EU enligt eIDAS-förordningen -
Utfärdas av den svenska eIDAS-noden då legitimeringen utförts enligt eIDAS-nivån `http://eidas.europa.eu/LoA/low`.

- `http://id.elegnamnden.se/loa/1.0/eidas-low` - eIDAS "low" utfärdat av anmält eller ett icke anmält<sup>*</sup> eID - Utfärdas av den svenska eIDAS-noden då legitimeringen utförts enligt eIDAS-nivån `http://eidas.europa.eu/NotNotified/LoA/low`.

- `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub` - eIDAS "substantial" utfärdat av eID som anmälts till EU enligt eIDAS-förordningen - Utfärdas av den svenska eIDAS-noden då legitimeringen utförts enligt eIDAS-nivån `http://eidas.europa.eu/LoA/substantial`.

- `http://id.elegnamnden.se/loa/1.0/eidas-sub` - eIDAS "substantial" utfärdat av anmält eller ett icke anmält<sup>*</sup> eID - Utfärdas av den svenska eIDAS-noden då legitimeringen utförts enligt eIDAS-nivån `http://eidas.europa.eu/NotNotified/LoA/substantial`.

- `http://id.elegnamnden.se/loa/1.0/eidas-nf-high` - eIDAS "high" utfärdat av av eID som anmälts till EU enligt eIDAS-förordningen - Utfärdas av den svenska eIDAS-noden då legitimeringen utförts enligt eIDAS-nivån `http://eidas.europa.eu/LoA/high`.

- `http://id.elegnamnden.se/loa/1.0/eidas-high` - eIDAS "high" utfärdat av anmält eller ett icke anmält<sup>*</sup> eID - Utfärdas av den svenska eIDAS-noden då legitimeringen utförts enligt eIDAS-nivån `http://eidas.europa.eu/NotNotified/LoA/high`.

\[\*\]: För närvarande har den svenska eIDAS-noden ingen koppling mot annat än anmälda
eID (eng. notified) enligt EU:s eIDAS-förordning.

Det svenska [tillitsramverket](https://www.digg.se/digital-identitet/e-legitimering/tillitsnivaer/tillitsramverket) kräver att en individ som erhåller ett eID innehar
ett svenskt personnummer (eller styrkt samordningsnummer). Då tjänstelegitimationer 
anskaffas av arbetsgivare enligt [E-legitimering för medarbetare](https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/tjanstelegitimation), och intygsleverans
sker av legitimeringstjänst som leverarer enligt [Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald e-legitimering](https://www.digg.se/download/18.5b30ce7218475cd9ed3289b/1670934932324/Anslutningsavtal-leverantor-forbetald-e-legitimering.docx) kan det förekomma att individer som inte innehar ett svenskt personnummer
eller samordningsnummer tilldelas ett eID. Då dessa eID:n används för legitimering inom
Sweden Connect får inte de ordinarie tillitsnivåerna för nivå 3 eller 4 användas. En
legitimeringstjänst som är godkänd för nivå 3 eller 4, och som utfärdar intyg för dessa
typer av eID:n skall då använda följande identifierare:

- `http://id.swedenconnect.se/loa/1.0/loa3-nonresident` - Legitimering enligt tillitsnivå 3 där det presenterade eID:t är utfärdat till en individ som inte innehar ett svenskt personnummer (eller samordningsnummer).

- `http://id.swedenconnect.se/loa/1.0/loa4-nonresident` - Legitimering enligt tillitsnivå 4 där det presenterade eID:t är utfärdat till en individ som inte innehar ett svenskt personnummer (eller samordningsnummer).

I båda ovanstående fall krävs att utfärdandet av e-legitimationen följer tillitsramverket med
undantag av kravet på personnummer/samordningsnummer och med tilläggskraven för "non-resident".

Kapitel [1.1.4](#bilaterala-avtal-om-legitimering) och [1.3.3](#aktorsspecifika-legitimeringstjanster) redogör för hur icke-tillitsgranskade legitimeringstjänster kan
användas inom Sweden Connect-federationen. Eftersom dessa legitimeringstjänster inte
är godkända enligt det svenska [tillitsramverket](https://www.digg.se/digital-identitet/e-legitimering/tillitsnivaer/tillitsramverket) får de inte inkludera någon av de ovanstående
identifierarna i identitetsintyg. Det står en tredjeparts-legitimeringstjänst fritt att
definiera egna identifierare, men för att upprätthålla möjligheter för god interoperabilitet
definieras ett antal identifierare i kapitel 3.1.1.2 av [Swedish eID Framework - Registry for identifiers](https://docs.swedenconnect.se/technical-framework/latest/03_-_Registry_for_Identifiers.html#authentication-context-uris-for-uncertified-providers).
Dessa är:

- `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` - Skall användas av en legitimeringstjänst som inte granskats, och godkänts, enligt tillitsramverkets nivå 3 men
som leverarar tjänster som påstås motsvara nivå 3 (via självdeklaration). Detta
gäller även för icke-granskade legitimeringstjänster som levererar legitimering för
en utfärdare som är godkänd enligt nivå 3 (t.ex. BankID).

- `http://id.swedenconnect.se/loa/1.0/uncertified-eidas-low` - Skall användas av en
s.k. Proxy-IdP som erbjuder eIDAS-legitimering och mottar `http://id.elegnamnden.se/loa/1.0/eidas-low` eller `http://id.elegnamnden.se/loa/1.0/eidas-nf-low` från den officiella
svenska eIDAS-noden.

- `http://id.swedenconnect.se/loa/1.0/uncertified-eidas-sub` - Skall användas av en
s.k. Proxy-IdP som erbjuder eIDAS-legitimering och mottar `http://id.elegnamnden.se/loa/1.0/eidas-sub` eller `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub` från den officiella
svenska eIDAS-noden.

- `http://id.swedenconnect.se/loa/1.0/uncertified-eidas-high` - Skall användas av en
s.k. Proxy-IdP som erbjuder eIDAS-legitimering och mottar `http://id.elegnamnden.se/loa/1.0/eidas-high` eller `http://id.elegnamnden.se/loa/1.0/eidas-nf-high` från den officiella
svenska eIDAS-noden.

Notera att de inte finns möjlighet att begära granskning av en proxy-tjänst så att
den kan leverera de officiella identifierarna för eIDAS. Detta kan endast den officiella
svenska eIDAS-noden göra.

<a name="legitimeringstjanster-inom-sweden-connect"></a>
### 1.3. Legitimeringstjänster inom Sweden Connect

Kommande kapitel redogör för krav och regler gällande legitimering och metadataregistrering för 
legitimeringstjänster och förlitande parter inom Sweden Connect-federationen. Detta kapitel går 
igenom specifika regler som gäller för att en legitimeringstjänst skall få ansluta till
Sweden Connect.

<a name="granskning-avseende-uppfyllnad-av-tekniskt-ramverk"></a>
#### 1.3.1. Granskning avseende uppfyllnad av Tekniskt ramverk

Gemensamt för alla legitimeringstjänster, oavsett om de har genomgått en tillitsgranskning
eller inte, är att de måste granskas och godkännas med avseende på uppfyllnad av [Sweden Connect - Tekniskt ramverk](https://docs.swedenconnect.se/technical-framework/) innan anslutning kan ske.

Begäran om en sådan granskning görs genom en dialog med DIGG.

Följande steg ska genomföras:

- Leverantören skall innan granskningen genomföra egna tester och verifiera stöd för de krav som ställs
i [Sweden Connect - Tekniskt ramverk](https://docs.swedenconnect.se/technical-framework/).

- Leverantören skall tillhandahålla en IdP-instans som i största möjliga mån är konfigurerad och
uppsatt som en "riktig" produktionstjänst (med undantag att testanvändare istället för riktiga
individer ska användas för test av legitimering). Denna instans skall publiceras till Sweden Connect
Sandbox-federationen (https://sandbox.swedenconnect.se), och den skall konsumera all SAML-metadata
för alla förlitande parter däri.

- Under testningen ska leverantören bistå med resurser kring uppkomna frågeställningar.

När granskningen har slutförts och resultaten är godkända kan leverantören gå vidare för publicering
av sin IdP-instans i Sweden Connect QA (se nedan).

<a name="publicering-av-instanser-till-sweden-connect-miljeer"></a>
#### 1.3.2. Publicering av instanser till Sweden Connect-miljöer

Sweden Connect har tre olika miljöer:

- Sweden Connect Sandbox - En testmiljö för initial testning. Alla aktörer, oavsett avtal, har rätt
att ansluta till denna miljö. Se vidare https://sandbox.swedenconnect.se.

- Sweden Connect QA - Sweden Connect:s officiella testmiljö. Endast aktörer som har avtal med DIGG
har rätt att publicera metadata till denna miljö. Denna miljö ska vara en spegling av produktionsmiljön
med det viktiga undantaget att endast testanvändare får förekomma (d.v.s., inga riktiga personnummer eller
liknande tillåts). 

- Sweden Connect produktion - Produktionsmiljön.

En legitimeringstjänst som ansluter sig till Sweden Connect-federationen förbinder sig till att
publicera en instans i Sweden Connect QA-federationen. Denna instans ska erbjuda samma funktionalitet som
motsvarande instans i produktionsfederationen, med undantaget att endast testidentiteter får användas.

> Det är alltså inte tillåtet att testa "nästa version av IdP:n" i Sweden Connect QA. Funktionaliteten
måste motsvara produktionsfederationen. Testing av kommande versioner kan däremot med fördel utföras
i Sweden Connect Sandbox.

Först när en lyckosam publicering av tjänsten utförts i Sweden Connect QA tillåts leverantören 
ansluta till Sweden Connect produktion.

<a name="aktorsspecifika-legitimeringstjanster"></a>
#### 1.3.3. Specifika krav för aktörsspecifika legitimeringstjänster 

Med en "aktörsspecifik" legitimeringstjänst avses en tjänst som inte ingår som leverantör enligt
något av de avtal som DIGG tillhandahåller, utan är en legitimeringstjänst som läggs in i Sweden
Connect under en förlitande parts ansvar (och avtal).

Även dessa legitimeringstjänster måste uppfylla [Sweden Connect - Tekniskt ramverk](https://docs.swedenconnect.se/technical-framework/) och övriga regler som gäller för legitimeringstjänster inom federationen.

Tredjeparts-legitimeringstjänster som levererar BankID-legitimering måste uppfylla de krav som
anges i [Implementation Profile for BankID Identity Providers within the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/12_-_BankID_Profile_for_the_Swedish_eID_Framework.html).

<a name="uppfyllnad-av-tekniskt-ramverk-over-tid"></a>
#### 1.3.4. Uppfyllnad av Tekniskt ramverk över tid

Nya versioner av de specifikationer som ingår i [Sweden Connect - Tekniskt ramverk](https://docs.swedenconnect.se/technical-framework/)
publiceras periodiskt av DIGG. En legitimeringstjänst inom Sweden Connect måste stödja
senast publicerade version senast 180 dagar efter versionen publicerats.

> DIGG kan komma att begära omgranskning av en legitimeringstjänst efter att en ny version av en specifikation i 
det Tekniska ramverket publicerats (om specifikationen är relevant för legitimeringstjänstens anslutningsavtal).


<a name="legitimering-och-leverans-av-identitetsintyg"></a>
## 2. Legitimering och leverans av identitetsintyg

[Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html) definierar hur en legitimeringsbegäran ("authentication request") ska byggas upp och hur leverans av identitetsintyg ska ske. Detta avsnitt kompletterar och förtydligar
denna specifikation.

<a name="anvandargranssnitt"></a>
### 2.1. Användargränssnitt

Legitimeringstjänstens användargränssnitt måste utformas på ett sådant sätt att det tydligt framgår 
vilken förlitande part som har begärt legitimering. Visningsnamn och logotyp för den förlitande parten
skall hämtas från den förlitande partens metadatapost, se kapitel [3.2](#registrering-av-visningsnamn-och-logotyp)
nedan.

<a name="felhantering-och-rapportering"></a>
#### 2.1.1. Felhantering och rapportering

Eventuella fel som uppkommer under en legitimeringsprocess ska beskrivas tydligt för användaren,
och användaren ska alltid ha en möjlighet att bekräfta att denne har tagit del av felmeddelandet.
Då användaren bekräftar, d.v.s., klickar på “OK”, eller “Jag förstår”-knappen, skall ett SAML-responsmeddelande
som indikerar felaktig autentisering postas tillbaka till den förlitande parten. 
Se vidare kapitel 6.4 av [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#error-responses).

<a name="information-om-identitetsattribut"></a>
#### 2.1.2. Information om identitetsattribut

En legitimeringstjänst bör i dess användargränssnitt upplysa användaren om vilka identitetsattribut
som levereras för en given legitimering. Då legitimering sker enligt avtalet [Valfrihetssystem 2017](https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/nationell-e-legitimering), eller motsvarande
bilateralt avral, är detta inte ett strikt krav eftersom användaren i dessa fall förväntas förstå att 
personnummer levereras. 

Om legitimeringstjänsten levererar enligt [Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald e-legitimering](https://www.digg.se/download/18.5b30ce7218475cd9ed3289b/1670934932324/Anslutningsavtal-leverantor-forbetald-e-legitimering.docx), d.v.s., e-legitimationenen som används är anskaffad via 
arbetsgivare, skall däremot legitimeringstjänsten alltid informera användaren om vilka identitetsinformation
som levereras i ett intyg innan detta skickas tillbaka till den förlitande parten. Legitimeringstjänsten
skall också erbjuda användaren ett sätt att avbryta legitimeringen efter denna information har visats.


Anledningen för detta krav är att beroende på den förlitande partens krav kring attributleverans kan intyget
innehålla endast organisationsidentitet, både organisationsidentitet och personnummerinformation, eller 
enbart personnummerinformation. Eftersom vissa användare kan vara ovilliga att använda sitt personnummer i
sin tjänsteutövning skall legitimeringstjänsten därför informera om vilka attribut som efterfrågas och 
inkluderas i intyget.

Legitimeringstjänsten är tillåten att “komma ihåg” eventuella svar kring tillåten attributleverans och inte
visa upp denna information om användaren tidigare har godkänt attributleverans. Dock måste detta implementeras
per förlitande part, d.v.s., per e-tjänst som användaren loggar in till.

<a name="krav-rorande-single-sign-on"></a>
### 2.2. Krav rörande Single-sign-on

En legitimeringstjänst i Sweden Connect kan välja att stödja Single-sign-on, d.v.s., utställande av intyg 
baserat på en tidigare utförd legitimering. Detta får ske om en legitimeringsbegäran inkommer inom 60
minuter sedan den ursprungliga legitimeringen utfördes. En legitimeringstjänst kan välja att ha en kortare
sessionstid, men gränsen på 60 minuter får inte överskridas.

Varje gång en användare utför en fullständig legitimering hos legitimeringstjänsten flyttas tiden för
den s.k. "ursprungslegitimeringen".

Kapitel 5.4.5 av [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#single-sign-on-processing) 
redogör för krav rörande återanvänd legitimering. Detta kapitel utökar dessa krav med följande:

Om krav på visning av vilka identitetsattribut som levereras (se [2.1.2](#information-om-identitetsattribut) ovan)
gäller för en viss legitimeringsbegäran, så gäller detta även om intyget som ställs ut baseras på en tidigare 
utförd legitimering, d.v.s., användaren måste informeras angående levererade identitetsattribut även om ingen egentlig 
legitimering utförs.

<a name="krav-pa-attributleverans"></a>
### 2.3. Krav på attributleverans

Specifikationen [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html) deklarerar ett 
antal "attribute sets", eller attributuppsättningar. Attributen som refereras i dessa uppsättningar har
en koppling också till den tillitsnivå som en legitimeringstjänst är granskad och godkänd enligt. Utöver
dessa attribut definieras också ett antal övriga attribut i [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html). Hur dessa kan användas inom Sweden Connect-federationen
redogörs för i kapitel [2.3.2](#ovriga-attribut) nedan.

Kraven på attributleverans baserat på DIGG:s leveransavtal är enligt följande:

[Anslutningsavtal för leverantör avseende
Valfrihetssystem 2017 e-legitimering](https://www.digg.se/download/18.3b27105f17fb89447e844b9/1650367183306/anslutningsavtal-leverantor-valfrihetssystem-2017.docx)

> En legitimeringstjänst som levererar legitimering för förlitande parter som tecknat [Valfrihetssystem 2017](https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/nationell-e-legitimering) skall stödja följande attributuppsättningar:

> - [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number) - Personnummer/samordningsnummer samt för- och efternamn samt användarens "visningsnamn". 

> - [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number) - Användarens för- och efternamn samt "visningsnamn".

[Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald e-legitimering](https://www.digg.se/download/18.5b30ce7218475cd9ed3289b/1670934932324/Anslutningsavtal-leverantor-forbetald-e-legitimering.docx)

> En legitimeringstjänst som levererar legitimering för förlitande parter som tecknat 
[Förlitandeavtal - Förbetald e-legitimering](https://www.digg.se/download/18.3b27105f17fb89447e84747/1650447908281/forlitandeavtal-forbetald-e-legitimering.docx) skall stödja följande 
attributuppsättningar:

> - [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons) - Organisationsidentitet, organisationsnamn och användarens "visningsnamn".

> - [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number) - Personnummer/samordningsnummer samt för- och efternamn samt användarens "visningsnamn". 

> - [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number) - Användarens för- och efternamn samt "visningsnamn".

Den svenska eIDAS-connectorn

> Den svenska eIDAS-connectorn (eIDAS-noden) levererar enligt följande attributuppsättning:

> - [eIDAS Natural Person Attribute Set](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#eidas-natural-person-attribute-set)


<a name="leverans-av-intyg-till-den-svenska-eidas-noden"></a>
#### 2.3.1. Leverans av intyg till den svenska eIDAS-noden

De legitimeringstjänster som har ett tillägsavtal med DIGG om att kunna leverera identitetsintyg
till den svenska eIDAS Proxy Service-noden (d.v.s., den eIDAS-nod som legitimerar innehavare av
svenska e-legitimationer för inloggning i utländska e-tjänster) skall leverera enligt 
attributuppsättningen [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number) med det tillägg att också födelsedatum krävs.

Legitimeringstjänsten kan välja att även upplysa användaren om att identitetsuppgifter kommer att skickas till det land och den e-tjänst som begär legitimering samt inhämta användarens medgivande till att så sker. Huruvida en
legitimeringstjänst implementerar ovanstående "consent"-dialog eller inte ska regleras med DIGG.

En legitimeringstjänst som levererar intyg till den svenska eIDAS-noden kan välja mellan att acceptera
begäran om legitimering från andra länder som begärts av privat aktör, eller välja att vägra sådana anrop. 
Om legitimeringstjänsten väljer att stödja legitimering från privata aktörer från andra länder så åligger
det legitimeringstjänsten att avgöra vilka privata aktörer som accepteras och hur ersättning för utförd legitimering
ska hanteras. Legitimeringstjänstens val att acceptera begäran från privat aktör regleras direkt med DIGG då det inte specificeras genom legitimeringstjänstens metadata.

<a name="ovriga-attribut"></a>
#### 2.3.2. Övriga attribut

Kapitel 3 i [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#attribute-definitions) definierar
fler attribut än vad som pekas ut i de attributuppsättningar som refereras tidigare i detta kapitel.
En legitimeringstjänst i Sweden Connect har rätt att leverera andra attribut än de som ingår i de attributuppsättningar
som refereras ovan under följande förutsättningar:

- Det finns en bilateral överenskommelse mellan legitimeringstjänst och förlitande part rörande leverans av ytterligare attribut.

- En förlitande part inkluderar en, eller flera, `RequestedAttribute`-element i sin metadata där leverans
av attribut utöver attributuppsättningar (som styrs av deklarerade entitetskategorier, se nedan) begärs, se
exempel nedan.

```
<md:AttributeConsumingService index="0" isDefault="true">
  ...
  <md:RequestedAttribute Name="urn:oid:0.9.2342.19200300.100.1.3" isRequired="false" />
  <md:RequestedAttribute Name="urn:oid:2.5.4.20" isRequired="false" />
</md:AttributeConsumingService>
```

*Exempel på hur en förlitande part begär leverans av attributen `mail` and `telephoneNumber`. Notera att
`isRequired` är satt till `false` vilket innebär att den förlitande parten även accepterar intyg vilka
inte inkluderar de önskade attributen.*


<a name="specifika-krav-rorande-tillitsniva-4"></a>
### 2.4. Specifika krav rörande Tillitsnivå 4

För Legitimeringsbegäran och leverans av identitetsintyg enligt enligt tillitsnivå 4 är kravet
att SAML-profilen [SAML V2.0 Holder-of-key Web Browser SSO Profile](https://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-holder-of-key-browser-sso.pdf) används. Användandet av "Holder-of-key" enligt Sweden Connect Tekniskt Ramverk specificeras i [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).

För att den höjda säkerheten med användandet av "Holder-of-key" ska bibehållas är det viktigt att både
legitimeringstjänsten (vid begäran) och den förlitande parten (vid intygsleverans) kräver att ett 
TLS-klientcertifikat presenteras. Se kapitel [3.9](#metadataregler-gallande-tillitsniva-4) nedan.


<a name="metadata"></a>
## 3. Metadata

Detta kapitel redogör för regler gällande registrering av SAML metadata samt hur de olika elementen ska
tolkas.

Relevanta specifikationer:

- Kapitel 2 i [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#metadata-and-trust-management)

- [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html)

- [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html).

<a name="registrering-av-organisationsinformation"></a>
### 3.1. Registrering av organisationsinformation

Alla aktörer, d.v.s., både legitimeringstjänster och förlitande parter, skall inkludera organisationsinformation
i varje metadatapost som registreras.

En sådant element ser ut enligt följande:

```
<md:Organization>
  <md:OrganizationName xml:lang="sv">Myndigheten för digital förvaltning</md:OrganizationName>
  <md:OrganizationName xml:lang="en">Agency for digital government</md:OrganizationName>
  <md:OrganizationDisplayName xml:lang="sv">Myndigheten för digital förvaltning - DIGG</md:OrganizationDisplayName>
  <md:OrganizationDisplayName xml:lang="en">Agency for digital government - DIGG</md:OrganizationDisplayName>
  <md:OrganizationURL xml:lang="sv">https://www.digg.se/</md:OrganizationURL>
  <md:OrganizationURL xml:lang="en">https://www.digg.se/en</md:OrganizationURL>  
</md:Organization>
```

*Exempel på hur organisationen DIGG har registrerat organisationsinformation i metadata.*

**Regler och rutiner vid registrering av metadata**:

- Det namn som anges på svenska under elementet `OrganizationName` skall stämma överens med namnet
som angavs när organisationen tecknade avtal med DIGG angående deltagande i federationen (undantaget
nedanstående punkt).

- I de fall en offentlig aktör som har tecknat något form av Sweden Connect-avtal har begärt att 
en tredjeparts-legitimeringstjänst registreras i metadata under aktörens avtal behöver `OrganizationName`
inte ange den offentliga aktörens registrerade namn. Orsaken till detta är att det
i många fall är flera offentliga aktörer som använder samma tredjeparts-legitimeringstjänst. Dock
skall aktören meddela kopplingen mellan aktören och legitimeringstjänsten.

<a name="registrering-av-visningsnamn-och-logotyp"></a>
### 3.2. Registrering av visningsnamn och logotyp

Alla aktörer, d.v.s., både legitimeringstjänster och förlitande parter, skall inkludera tjänstens
visningsnamn och logotyp i varje metadatapost som registreras. Detta visningsnamn skall anges
på svenska och bör också anges på engelska.

Notera att den logotyp som anges bör vara på ett sådant format och utformning att den kan användas
på de flesta webbsidor. Till exempel är det inte lämpligt att förutsätta att logotypen ska visas
upp enligt ett specifikt färgschema.

En förlitande parts logotyp kommer att visas upp i användargränssnittet hos en legitimeringstjänst
och logotypen för en legitimeringstjänst kan komma att visas upp på "välj sätt att logga in"-sidor
hos förlitande parter.

Exempel:

```
<mdui:UIInfo xmlns:mdui="urn:oasis:names:tc:SAML:metadata:ui">
  <mdui:DisplayName xml:lang="sv">Testa ditt eID</mdui:DisplayName>
  <mdui:DisplayName xml:lang="en">Test your eID</mdui:DisplayName>
  <mdui:Description xml:lang="sv">Applikation för att testa ditt eID</mdui:Description>
  <mdui:Description xml:lang="en">Application for testing your eID</mdui:Description>
  <mdui:Logo xmlns:mdui="urn:oasis:names:tc:SAML:metadata:ui" height="80" width="228">
    https://test.swedenconnect.se/images/sc-logo.svg
  </mdui:Logo>
</mdui:UIInfo>
```

*Exempel på hur DIGG:s tjänst "Testa ditt eID" registrerar visningsinformation.*

**Regler och rutiner vid registrering av metadata**:

- Vid registrering utförs en kontroll att elementet finns med i metadata samt att logotyp och 
visningsinformation på svenska finns med.

- Adress till logotypen som anges måste vara nåbar. 

- Vidare utförs en okulärbesiktning för att säkerställa att angiven information ser ut
att stämma överens med aktörens organisation. 

<a name="registrering-av-tillitsnivaer"></a>
### 3.3. Registrering av tillitsnivåer

För legitimeringstjänster så skall alla tillitsnivåer, och varianter därav (se [1.2](#tillitsnivaer) ovan), 
som stöds deklareras i metadata. Detta görs via "assurance certification"-attributet.

Exempel:

```
<md:Extensions>
  <mdattr:EntityAttributes>
    <saml:Attribute Name="urn:oasis:names:tc:SAML:attribute:assurance-certification"
                    NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri">
      <saml:AttributeValue>http://id.elegnamnden.se/loa/1.0/loa3</saml:AttributeValue>
      <saml:AttributeValue>http://id.elegnamnden.se/loa/1.0/loa4</saml:AttributeValue>
    </saml:Attribute>
    ...
```

*Metadataexempel för en legitimeringstjänst som är godkänd att leverera intyg enligt
tillitsnivå 3 och 4.*

**Regler och rutiner vid registrering av metadata**:

- Endast legitimeringstjänster som är granskade och godkända enligt tillitsnivå 3 eller 4 får deklarera 
`http://id.elegnamnden.se/loa/1.0/loa3`.

- Endast legitimeringstjänster som är granskade och godkända enligt tillitsnivå 4 får deklarera 
`http://id.elegnamnden.se/loa/1.0/loa4`.

- Endast legitimeringstjänster som levererar enligt [Anslutningsavtal för utfärdare av 
e-tjänstelegitimationer - Förbetald e-legitimering](https://www.digg.se/4b00bd/globalassets/dokument/digital-identitet/eid-for-medarbetare/anslutningsavtal-leverantor-forbetald-e-legitimering.docx) 
och som är granskade och godkända enligt tillitsnivå 3 eller 4 får deklarera `http://id.swedenconnect.se/loa/1.0/loa3-nonresident`.

- Endast legitimeringstjänster som levererar enligt [Anslutningsavtal för utfärdare av 
e-tjänstelegitimationer - Förbetald e-legitimering](https://www.digg.se/4b00bd/globalassets/dokument/digital-identitet/eid-for-medarbetare/anslutningsavtal-leverantor-forbetald-e-legitimering.docx)
och som är granskade och godkända enligt tillitsnivå 4 får deklarera `http://id.swedenconnect.se/loa/1.0/loa4-nonresident`. 

- Endast den svenska eIDAS-noden får deklarera någon av följande identifierare:
  - `http://id.elegnamnden.se/loa/1.0/eidas-low`, `http://id.elegnamnden.se/loa/1.0/eidas-nf-low`,
  - `http://id.elegnamnden.se/loa/1.0/eidas-sub`, `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub`,
  - `http://id.elegnamnden.se/loa/1.0/eidas-high`, `http://id.elegnamnden.se/loa/1.0/eidas-nf-high`.

- Tredjeparts-legitimeringstjänster som deklarerar `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` skall
regogöra för federationsoperatören (DIGG) kring hur legitimeringen går till. Till exempel, "levererar SAML-IdP
för BankID".

- Den tidigare använda identifieraren `http://id.elegnamnden.se/loa/1.0/loa3-sigmessage` får ej längre användas.

<a name="registrering-av-service-entity-category-varden"></a>
### 3.4. Registrering av Service Entity Category-värden

En entitetskategori (Entity Category) är ett attributvärde som deklareras i metadata i syfte att beskriva en viss
egenskap hos en aktör inom federationen. En s.k. "Service Entity Category" används av både förlitande parter (SP)
och legitimeringstjänster (IdP) för att deklarera vilka kombinationer av tillitsnivåer och attribut som stöds
alterativt krävs.

Se kapitel 2 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#definitions-for-service-entity-categories) för detaljer.

Ursprungligen infördes "Service Entity Category"-typen för att kunna härleda vilka legitimeringstjänster
inom federationen som kunde leverera intyg till en viss förlitande part. Tanken var att dynamiskt kunna bygga 
upp en anvisningssida där alla legitimeringstjänster som erbjuder legitimering som kan nyttjas av den förlitande 
parten visades. Det finns i dagsläget ingen central anvisningstjänst (Discovery Service), och användningsområdet
för denna typ av entitetskategorier är primärt att en legitimeringstjänst ska kunna härleda vilka attribut en viss
förlitande part efterfrågar i samband med legitimering.

En förlitande part kan deklarera en eller flera "Service Entity Category"-värden i dess metadata. Baserat på
deklarerade värden försöker en legitimeringstjänst härleda vilka attribut som ska ingå i ett utfärdat identitetsintyg.
Denna enkla regel kan dock ställa till med problem. SAML erbjuder inget standardiserat sätt för en förlitande part att
dynamiskt (d.v.s., per begäran) tala om för en legitimeringstjänst vilka attribut som efterfrågas, utan de verktyg 
som finns att tillgå är den data som deklarerats i den förlitande partens metadata. 

Ponera att en förlitande part önskar personnummer och organisationsidentiet i intyg. Den kan då t.ex. deklarera 
både `loa3-pnr` och `loa3-orgid` (se nedan) i sin metadata. Men vad händer om den i vissa fall är intresserad av 
att erhålla personnummer, och i andra fall organisationsidentitet, men inte både attributen i samma intyg?

Lösningen i detta fall behöver vara så att den givna organisationen skapar två förlitande parter (SAML SP)
och deklarerar `loa3-pnr` i metadata för den ena SP:n och `loa3-orgid` i metadata för den andra. Baserat på
vilken typ av identitetsintyg som önskas i olika fall används korrekt SP.

> Detta är långt ifrån en perfekt lösning, men tyvärr en nödvändighet. I och med införandet av OpenID Connect
så kommer detta problem att försvinna eftersom denna teknik har ett större mått av dynamik, och varje enskild
begäran kan innehålla information om önskade attribut.

Nedan följer beskrivningar och regler gällande både legitimeringstjänster och förlitande parter för 
relevanta "Service Entity Category"-värden definierade i kapitel 2 av specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#definitions-for-service-entity-categories):

<a name="loa3-pnr"></a>
#### 3.4.1. loa3-pnr

**Definition**: Kapitel 2.1.2 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-pnr).

En deklaration av entitetskategorin `http://id.elegnamnden.se/ec/1.0/loa3-pnr` innebär följande:

**För en legitimeringstjänst**:

> Legitimeringstjänsten deklarerar att den kan legitimera användare enligt tillitsnivå 3<sup>\*</sup> och
leverera intyg med attribut från attributuppsättningen [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number).

**För en förlitande part**:

> Den förlitande parten deklarerar att den kommer att begära legitimering enligt tillitsnivå 3<sup>\*</sup> och
att den begär leverans av attribut enligt uppsättningen [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number).

\[*\]: Tidigare användes entitetskategorin `http://id.swedenconnect.se/ec/sc/uncertified-loa3-pnr` för leverans
av personnummer efter en "loa3-uncertified" legitimering (se kapitel [1.2](#tillitsnivaer) ovan). I den senaste
versionen av tekniskt ramverk är denna kategori "deprecated", och den officiella "loa3-pnr" kategorin täcker in 
även dessa fall.

**Regler och rutiner vid registrering av metadata**:

- Endast legitimeringstjänster som i `assurance-certification`-attributet 
(se kapitel [3.3](#registrering-av-tillitsnivaer) ovan) deklarerar  `http://id.elegnamnden.se/loa/1.0/loa3`
eller `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` får deklarera entitetskategorin `loa3-pnr`.

- En legitimeringstjänst som deklarerar `loa3-pnr` skall även deklarera kategorin `loa3-name` (d.v.s., 
attributleverans med endast namn och inget personnummer/samordningsnummer). Se kapitel 2.4.2 i [
Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-name).
    
<a name="loa4-pnr"></a>
#### 3.4.2. loa4-pnr

**Definition**: Kapitel 2.1.3 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-pnr).

En deklaration av entitetskategorin `http://id.elegnamnden.se/ec/1.0/loa4-pnr` innebär följande:

**För en legitimeringstjänst**:

> Legitimeringstjänsten deklarerar att den kan legitimera användare enligt tillitsnivå 4 och
leverera intyg med attribut från attributuppsättningen [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number).

**För en förlitande part**:

> Den förlitande parten deklarerar att den kommer att begära legitimering enligt tillitsnivå 4 och
att den begär leverans av attribut enligt uppsättningen [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number).

**Regler och rutiner vid registrering av metadata**:

- Endast legitimeringstjänster som i `assurance-certification`-attributet 
(se kapitel [3.3](#registrering-av-tillitsnivaer) ovan) deklarerar `http://id.elegnamnden.se/loa/1.0/loa4` får 
deklarera entitetskategorin `loa4-pnr`.

- En legitimeringstjänst som deklarerar `loa4-pnr` skall även deklarera kategorin `loa4-name` (d.v.s., 
attributleverans med endast namn och inget personnummer/samordningsnummer). Se kapitel 2.4.3 i [
Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-name).

- Se också regler och rutiner i kapitel [3.9](#metadataregler-gallande-tillitsniva-4) nedan.

<a name="loa3-orgid"></a>
#### 3.4.3. loa3-orgid

**Definition**: Kapitel 2.3.2 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-orgid).

En deklaration av entitetskategorin `http://id.swedenconnect.se/ec/1.0/loa3-orgid` innebär följande:

**För en legitimeringstjänst**:

> Legitimeringstjänsten deklarerar att den kan legitimera användare enligt tillitsnivå 3<sup>\*</sup> och
leverera intyg med attribut från attributuppsättningen [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons).

**För en förlitande part**:

> Den förlitande parten deklarerar att den kommer att begära legitimering enligt tillitsnivå 3<sup>\*</sup> och
att den begär leverans av attribut enligt uppsättningen [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons).

\[*\]: Denna entitetskategori gäller för legitimering enligt `http://id.elegnamnden.se/loa/1.0/loa3`,
`http://id.swedenconnect.se/loa/1.0/loa3-nonresident` eller `http://id.swedenconnect.se/loa/1.0/uncertified-loa3`.

**Regler och rutiner vid registrering av metadata**:

- Endast legitimeringstjänster som i `assurance-certification`-attributet 
(se kapitel [3.3](#registrering-av-tillitsnivaer) ovan) deklarerar `http://id.elegnamnden.se/loa/1.0/loa3`, 
`http://id.swedenconnect.se/loa/1.0/loa3-nonresident` eller `http://id.swedenconnect.se/loa/1.0/uncertified-loa3`
får deklarera entitetskategorin `loa3-orgid`.

- En legitimeringstjänst som deklarerar `loa3-orgid` skall även deklarera kategorin `loa3-name` (d.v.s., 
attributleverans av för- och efternamn). Se kapitel 2.4.2 i [
Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-name). 

<a name="loa4-orgid"></a>
#### 3.4.4. loa4-orgid

**Definition**: Kapitel 2.3.3 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-orgid).

En deklaration av entitetskategorin `http://id.swedenconnect.se/ec/1.0/loa4-orgid` innebär följande:

**För en legitimeringstjänst**:

> Legitimeringstjänsten deklarerar att den kan legitimera användare enligt tillitsnivå 4<sup>\*</sup> och
leverera intyg med attribut från attributuppsättningen [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons).

**För en förlitande part**:

> Den förlitande parten deklarerar att den kommer att begära legitimering enligt tillitsnivå 4<sup>\*</sup> och
att den begär leverans av attribut enligt uppsättningen [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons).

\[*\]: Denna entitetskategori gäller för legitimering enligt `http://id.elegnamnden.se/loa/1.0/loa4`
eller `http://id.swedenconnect.se/loa/1.0/loa4-nonresident`.


**Regler och rutiner vid registrering av metadata**:

- Endast legitimeringstjänster som i `assurance-certification`-attributet (se kapitel 
[3.3](#registrering-av-tillitsnivaer) ovan) deklarerar `http://id.elegnamnden.se/loa/1.0/loa4` eller 
`http://id.swedenconnect.se/loa/1.0/loa4-nonresident` får deklarera entitetskategorin `loa4-orgid`.

- En legitimeringstjänst som deklarerar `loa4-orgid` skall även deklarera kategorin `loa4-name` (d.v.s., 
attributleverans av för- och efternamn). Se kapitel 2.4.3 i [
Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-name).

- Se också regler och rutiner i kapitel [3.9](#metadataregler-gallande-tillitsniva-4) nedan.

<a name="loa3-name"></a>
#### 3.4.5. loa3-name

**Definition**: Kapitel 2.4.2 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-name).

Entitetskategorin `http://id.swedenconnect.se/ec/1.0/loa3-name` är primärt avsedd för att komplettera
`http://id.swedenconnect.se/ec/1.0/loa3-orgid` (se kapitel [3.4.3](#loa3-orgid) ovan) med möjligheten
att också erhålla för- och efternamn på legitimerad användare. I dessa fall deklarerar en förlitande 
part både `loa3-orgid` och `loa3-name`.

En deklaration av entitetskategorin innebär följande:

**För en legitimeringstjänst**:

> Legitimeringstjänsten deklarerar att den kan legitimera användare enligt tillitsnivå 3<sup>\*</sup> och
leverera intyg med attribut från attributuppsättningen [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number).

**För en förlitande part**:

> Den förlitande parten deklarerar att den kommer att begära legitimering enligt tillitsnivå 3<sup>\*</sup> och
att den begär leverans av attribut enligt uppsättningen [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number).

\[*\]: Denna entitetskategori gäller för legitimering enligt `http://id.elegnamnden.se/loa/1.0/loa3`,
`http://id.swedenconnect.se/loa/1.0/loa3-nonresident` eller `http://id.swedenconnect.se/loa/1.0/uncertified-loa3`.

**Regler och rutiner vid registrering av metadata**:

- Endast legitimeringstjänster som i `assurance-certification`-attributet 
(se kapitel [3.3](#registrering-av-tillitsnivaer) ovan) deklarerar `http://id.elegnamnden.se/loa/1.0/loa3`, 
`http://id.swedenconnect.se/loa/1.0/loa3-nonresident` eller `http://id.swedenconnect.se/loa/1.0/uncertified-loa3`
får deklarera entitetskategorin `loa3-name`.

- En legitimeringstjänst som deklarerar `loa3-pnr` (se [3.4.1](#loa3-pnr) ovan) eller 
`loa3-orgid` (se [3.4.3](#loa3-orgid) ovan) måste också deklarera `loa3-name`.

<a name="loa4-name"></a>
#### 3.4.6. loa4-name

**Definition**: Kapitel 2.4.3 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-name).

Entitetskategorin `http://id.swedenconnect.se/ec/1.0/loa4-name` är primärt avsedd för att komplettera
`http://id.swedenconnect.se/ec/1.0/loa4-orgid` (se kapitel [3.4.4](#loa4-orgid) ovan) med möjligheten
att också erhålla för- och efternamn på legitimerad användare. I dessa fall deklarerar en förlitande 
part både `loa4-orgid` och `loa4-name`.

En deklaration av entitetskategorin innebär följande:

**För en legitimeringstjänst**:

> Legitimeringstjänsten deklarerar att den kan legitimera användare enligt tillitsnivå 4<sup>\*</sup> och
leverera intyg med attribut från attributuppsättningen [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number).

**För en förlitande part**:

> Den förlitande parten deklarerar att den kommer att begära legitimering enligt tillitsnivå 4<sup>\*</sup> och
att den begär leverans av attribut enligt uppsättningen [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number).

\[*\]: Denna entitetskategori gäller för legitimering enligt `http://id.elegnamnden.se/loa/1.0/loa4` och
`http://id.swedenconnect.se/loa/1.0/loa4-nonresident`.

**Regler och rutiner vid registrering av metadata**:

- Endast legitimeringstjänster som i `assurance-certification`-attributet 
(se kapitel [3.3](#registrering-av-tillitsnivaer) ovan) deklarerar `http://id.elegnamnden.se/loa/1.0/loa4`
eller  `http://id.swedenconnect.se/loa/1.0/loa3-nonresident` får deklarera entitetskategorin `loa4-name`.

- En legitimeringstjänst som deklarerar `loa4-pnr` (se [3.4.2](#loa4-pnr) ovan) eller 
`loa4-orgid` (se [3.4.4](#loa4-orgid) ovan) måste också deklarera `loa4-name`.

- Se också regler och rutiner i kapitel [3.9](#metadataregler-gallande-tillitsniva-4) nedan.

<a name="eidas-naturalperson"></a>
#### 3.4.7. eidas-naturalperson

**Definition**: Kapitel 2.1.1 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#eidas-naturalperson).

En deklaration av entitetskategorin `http://id.elegnamnden.se/ec/1.0/eidas-naturalperson` innebär följande:

**För en legitimeringstjänst**:

> Legitimeringstjänsten deklarerar att den är en eIDAS-nod som agerar "Identity Provider" mot 
Sweden Connect-federationen och "Service Provider" mot eIDAS-federationen<sup>*</sup>. Legitimering av användare
sker enligt någon av de definierade tillitsnivåerna för eIDAS (se kapitel 3.1.1 i [Swedish eID Framework - Registry for identifiers](https://docs.swedenconnect.se/technical-framework/latest/03_-_Registry_for_Identifiers.html#authentication-context-uris)) och attribut som ingår i utställda identitetsintyg är enligt uppsättningen [eIDAS Natural Person Attribute Set](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#eidas-natural-person-attribute-set).

**För en förlitande part**:

> Den förlitande parten deklarerar att den kommer att begära eIDAS-legitimering och att den begär
leverans av attribut enligt uppsättningen [eIDAS Natural Person Attribute Set](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#eidas-natural-person-attribute-set).

\[*\]: För legitimeringstjänster så ska i princip ska endast den officiella svenska eIDAS-noden deklarera 
denna kategori, men det finns fall där leverantörer erbjuder en s.k. Proxy-IdP som inkluderar eIDAS-legitimering
som ett legitimeringsalternativ. Proxy-IdP:n agerar då förlitande part mot den officiella eIDAS-noden och 
IdP mot dess förlitande parter. Dessa Proxy-IdP:er tillåts också deklarera denna kategori.

<a name="eidas-pnr-delivery"></a>
#### 3.4.8. eidas-pnr-delivery

**Definition**: Kapitel 2.1.4 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#eidas-pnr-delivery).

En specialkategori som endast används av de legitimeringstjänster som leverarar intyg till den svenska 
eIDAS-noden (connector), samt den officiella eIDAS proxy-service som agerar förlitande part mot Sweden
Connect. Se kapitel [2.3.1](#leverans-av-intyg-till-den-svenska-eidas-noden).

**Regler och rutiner vid registrering av metadata**:

- Endast de legitimeringstjänster som avtalat med DIGG om att leverera intyg till den svenska eIDAS Proxy Service-noden
skall deklarera kategorin.

<a name="registrering-av-typ-av-forlitande-part"></a>
### 3.5. Registrering av typ av förlitande part - Service Type Category

En entitetskategori (Entity Category) är ett attributvärde som deklareras i metadata i syfte att beskriva en viss egenskap hos en aktör inom federationen. En s.k. "Service Type Category" deklareras av förlitande parter för att indikera att aktören är av en viss "typ".

Nedan följer beskrivningar och regler gällande förlitande parter för relevanta "Service Type Category"-värden definierade i kapitel 4 av specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#definitions-for-service-type-entity-categories):

<a name="sigservice"></a>
#### 3.5.1. Indikator för underskriftstjänst

**Definition**: Kapitel 4.1 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#sigservice).

En deklaration av entitetskategorin `http://id.elegnamnden.se/st/1.0/sigservice` innebär att den
förlitande parten indikerar att den är en underskriftstjänst. 

**Regler och rutiner vid registrering av metadata**:

- Anmälande organisation skall uttryckligen notifiera federationsoperatören (DIGG) om att aktuell tjänst är en underskriftstjänst.

<a name="indikator-for-offentlig-eller-privat-sektor"></a>
#### 3.5.2. Indikator för offentlig eller privat sektor

**Definition**: Kapitel 4.2 och 4.3 i specifikationen [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#definitions-for-service-type-entity-categories).

Offentliga förlitande parter inom Sweden Connect måste deklarera kategorin `http://id.elegnamnden.se/st/1.0/public-sector-sp` och förlitande parter från den privata sektorn måste deklarera `http://id.elegnamnden.se/st/1.0/private-sector-sp`.

**Regler och rutiner vid registrering av metadata**:

- Vid registrering av metadata görs en kontroll att antingen `public-sector-sp` eller `private-sector-sp` är deklarerat, samt att att denna deklaration stämmer överens med aktörens tecknade avtal.

<a name="registrering-av-tecknade-avtal"></a>
### 3.6. Registrering av tecknade avtal

Deltagande i Sweden Connect-federationen styrs av avtal, både gällande förlitande parter och legitimeringstjänster.
För att en legitimeringstjänst ska acceptera en legitimeringsbegäran från en förlitande part måste den kunna ta reda
på om den förlitande parten har rätt att nyttja tjänsten. Detta åstadkoms genom att förlitande parter deklarerar 
"Service Contract Category"-värden som indikerar vilka avtal som gäller för aktören. Se kapitel 5 av 
[Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#service-contract-categories).

Nedan följer identifierare som mappas mot de avtal som listades i kapitel [1.1](#avtal).

<a name="sweden-connect-avtal"></a>
#### 3.6.1. Sweden Connect-avtal

**Identifierare**: `http://id.swedenconnect.se/contract/sc/sweden-connect`

Indikerar att den förlitande partens organisation har tecknat något av DIGG:s anslutningsavtal.

Notera: För en legitimeringstjänst som endast konsumerar metadata från Sweden Connect-federationen betyder
denna kategori i princip ingenting eftersom den endast markerar "deltagare i Sweden Connect-federationen".
För legitimeringstjänster som konsumerar metadata från flera olika federationer kan den dock ha betydelse.

**Regler och rutiner vid registrering av metadata**:

- Vid registrering av metadata görs en kontroll att den givna organisationen tecknat ett anslutningsavtal.

<a name="other-contracts"></a>
#### 3.6.2. Bilaterala avtal

För de förlitande parter som tecknar avtal direkt med leveratörer, t.ex. en leverantör som levererar
en SAML-IdP för BankID, så skall leverantören definiera en identifierare enligt det format som beskrivs
i kapitel 5 av [Entity Categories for the Swedish eID Framework](#https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#service-contract-categories). Denna
identifierare skall sedan deklareras av både förlitande part och legitimeringstjänst.

**Regler och rutiner vid registrering av metadata**:

- Ingen kontroll utförs. Dessa avtal ligger utanför federationsoperatörens (DIGG) ansvar.

<a name="eid-choice-2017"></a>
#### 3.6.3. Valfrihetssystem 2017
 
**Identifierare**: `http://id.swedenconnect.se/contract/sc/eid-choice-2017`

Skall deklareras av förlitande parter som tecknat avtalet [Valfrihetssystem 2017](https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/nationell-e-legitimering) och av legitimeringstjänster som
levererar enligt [Anslutningsavtal för leverantör avseende Valfrihetssystem 2017 e-legitimering](https://www.digg.se/download/18.3b27105f17fb89447e844b9/1650367183306/anslutningsavtal-leverantor-valfrihetssystem-2017.docx).

**Regler och rutiner vid registrering av metadata**:

- Vid registrering av metadata görs en kontroll mot tecknade avtal för den givna organisationen.

<a name="eid-for-medarbetare2"></a>
#### 3.6.4. eID för medarbetare

**Identifierare**: `http://id.swedenconnect.se/contract/sc/prepaid-auth-2021`

Skall deklareras av förlitande parter som tecknat avtalet [Förlitandeavtal - Förbetald e-legitimering](https://www.digg.se/4b00bf/globalassets/dokument/digital-identitet/eid-for-medarbetare/forlitandeavtal-forbetald-e-legitimering.docs)
och av legitimeringstjänster som levererar enligt [Anslutningsavtal för utfärdare av 
e-tjänstelegitimationer - Förbetald e-legitimering](https://www.digg.se/4b00bd/globalassets/dokument/digital-identitet/eid-for-medarbetare/anslutningsavtal-leverantor-forbetald-e-legitimering.docx).

**Regler och rutiner vid registrering av metadata**:

- Vid registrering av metadata görs en kontroll mot tecknade avtal för den givna organisationen.

<a name="metadataregler-gallande-organisationsidentiteter"></a>
### 3.7. Metadataregler gällande organisationsidentiteter

Legitimeringstjänster som levererar enligt [Anslutningsavtal för utfärdare av 
e-tjänstelegitimationer - Förbetald e-legitimering](https://www.digg.se/4b00bd/globalassets/dokument/digital-identitet/eid-for-medarbetare/anslutningsavtal-leverantor-forbetald-e-legitimering.docx) och stödjer leverans av intyg enligt attributsuppsättningen [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons) måste anmäla
till federationsoperatören (DIGG) vilka organisationer som hanteras av den givna legitimeringstjänsten.

Denna information kommer att publiceras i legitimeringstjänstens SAML-metadata enligt beskrivningen i kapitel 2.1.3.1
av [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).

> Notera: Denna information skall kontinuerligt hållas uppdaterad, vilket innebär att legitimeringstjänsten
är ansvarig för att i god tid anmäla anslutande organisationer till federationsoperatören (DIGG) och begära
metadatauppdatering.

Nedan visas ett exempel på de `Scope`-element som inkluderas i metadata för en legitimeringstjänst som är 
godkänd att leverera till organisationerna DIGG (202100-6883), Försäkringskassan (202100‑5521) och 
Pensionsmyndigheten (202100-6255). 

```
<md:IDPSSODescriptor ...>
  <md:Extensions>
    <shibmd:Scope xmlns:shibmd="urn:mace:shibboleth:metadata:1.0>2021006883</shibmd:Scope>
    <shibmd:Scope xmlns:shibmd="urn:mace:shibboleth:metadata:1.0>2021005521</shibmd:Scope>
    <shibmd:Scope xmlns:shibmd="urn:mace:shibboleth:metadata:1.0>2021006255</shibmd:Scope>
    ...
```

*Notera att organisationsnumret ska representeras utan bindestreck i metadata-filen.*

En förlitande part som konsumerar organisationsidentiteter (attributet `orgAffliation`) förväntas verifiera
attributets innehåll mot utfärdande legitimeringstjänsts metadatapost enligt kapitel 6.2.1 av [
Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#attribute-release-and-consuming-rules).

**Regler och rutiner vid registrering av metadata**:

- Federationsoperatören (DIGG) kontrollerar att den anmälda listan av anslutna organisationer
överensstämmer med innehållet i metadata (d.v.s., verifierar att `Scope` elementen är korrekta).

<a name="metadataregler-gallande-samordningsnummer"></a>
### 3.8. Metadataregler gällande samordningsnummer

En legitimeringstjänst som levererar enligt attributuppsättningen [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number)
levererar individens personnummer **eller** styrkta samordningsnummer i attributet `personalIdentityNumber`. 

Tidigare var styrkta samordningsnummer i identitetsintyg inte godkända att användas av DIGG, vilket gör att vissa
förlitande parter som enbart förväntar sig ett personnummer i `personalIdentityNumber`-attributet kan få problem
vid hanteringen av intyget.

Därför krävs en s.k. "opt-in" från den förlitande parten för att legitimeringstjänsten ska få leverera ett 
samordningsnummer till en given förlitande part. Detta beskrivs i kapitel 6.2 i [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#accepts-coordination-number). 

Exempel på en metadata för SAML SP som accepterar att samordningsnummer levereras:

```
...
<md:Extensions>
  <mdattr:EntityAttributes xmlns:mdattr="urn:oasis:names:tc:SAML:metadata:attribute">
    <saml2:Attribute Name="http://macedir.org/entity-category"
                     NameFormat="urn:oasis:names:tc:SAML:2.0:attrname-format:uri">
      <saml2:AttributeValue>
        http://id.elegnamnden.se/ec/1.0/loa3-pnr
      </saml2:AttributeValue>
      ...
      <saml2:AttributeValue>
! ->    http://id.swedenconnect.se/general-ec/1.0/accepts-coordination-number
      </saml2:AttributeValue>
      ...            
    </saml2:Attribute>        
  </mdattr:EntityAttributes>
</md:Extensions>
...
```

Genom att SAML SP:n deklarerar entitetskategorin `http://id.swedenconnect.se/general-ec/1.0/accepts-coordination-number`
så informerar den legitimeringstjänster om att leverans av samordningsnummer i `personalIdentityNumber`-attributet
medges av den förlitande parten.

En legitimeringstjänst får **inte** leverera ett intyg innehållande ett samordningsnummer till
en förlitande part som inte deklarerat ovanstående. I dessa fall ska istället legitimeringstjänsten informera
användaren om att ett personnummer krävs för att autentisera sig och inte ställa ut ett identitetsintyg.

<a name="metadataregler-gallande-tillitsniva-4"></a>
### 3.9. Metadataregler gällande tillitsnivå 4 (LoA 4)

För legitimering och leverans av identitetsintyg enligt tillitsnivå 4 kräver Sweden Connect-federationen att
SAML-profilen [SAML V2.0 Holder-of-key Web Browser SSO Profile](https://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-holder-of-key-browser-sso.pdf) används. Användandet av "Holder-of-key" enligt Sweden Connect Tekniskt Ramverk specificeras i [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).

Följande metadataregler gäller rörande tillitsnivå 4 och Holder-of-key:

En legitimeringstjänst som deklarerar att den levererar legitimering och intyg enligt
tillitsnivå 4<sup>*</sup> skall deklarera dedikerade `SingleSignOnService`-element för 
"Holder-of-key" i sin metadatapost enligt kapitel 2.1.3.2 av 
[Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#idp-holder-of-key-support). De adresser som pekas ut i dessa element måste vara konfigurerade för mutual-TLS, 
d.v.s., TLS där ett klientcertifikat krävs.

En förlitande part som deklarerar en entitetskategori som indikerar att aktören kräver
legitimering enligt tillitsnivå 4<sup>\*\*</sup> måste också deklarera ett `AssertionConsumerService`-element för "Holder-of-key" enligt kapitel 2.1.2.1 av [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#sp-holder-of-key-support). Adressen som pekas ut i detta element måste vara konfigurerat för mutual-TLS, d.v.s., TLS där ett klientcertifikat krävs.

\[*\]: `http://id.elegnamnden.se/loa/1.0/loa4` och/eller `http://id.swedenconnect.se/loa/1.0/loa4-nonresident`.

\[\*\*\]: `http://id.elegnamnden.se/ec/1.0/loa4-pnr`, `http://id.swedenconnect.se/ec/1.0/loa4-orgid` eller `http://id.swedenconnect.se/ec/1.0/loa4-name`.

**Regler och rutiner vid registrering av metadata**:

- För en legitimeringstjänst som deklarerar stöd för tillitsnivå 4 verifieras att följande finns deklarerat i metadata:

  - Ett `SingleSignOnService`-element som har attributet `Binding` satt till 
  `urn:oasis:names:tc:SAML:2.0:profiles:holder-of-key:SSO:browser` samt attributet
  `hoksso:ProtocolBinding` satt till `urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect`.
  
  - Ett `SingleSignOnService`-element som har attributet `Binding` satt till 
  `urn:oasis:names:tc:SAML:2.0:profiles:holder-of-key:SSO:browser` samt attributet
  `hoksso:ProtocolBinding` satt till `urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST`.
  
- För en förlitande part som deklarerar en LoA4-entitetskategori verifieras att ett 
  `AssertionConsumerService`-element med `Binding`-attributet satt till 
  `urn:oasis:names:tc:SAML:2.0:profiles:holder-of-key:SSO:browser` och 
  `hoksso:ProtocolBinding`-attributet satt till `urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST`.

<a name="versioner-av-detta-dokument"></a>
## 4. Versioner av detta dokument

- 2022-12-20:
	- Korrigering efter att DIGG:s webbteam ändrat länkar till diverse avtal.

- 2022-04-01: 
	- Korrigering av felaktig länk.

- 2022-01-10: 

   - Förtydlingar kring leverans av intyg till den svenska eIDAS-noden (kapitel 2.3.1).
   - Uppdatering av länkar för "eID för medarbetare"-avtal.

- 2021-12-14: Första versionen


