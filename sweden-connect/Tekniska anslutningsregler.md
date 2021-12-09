<p>
<img align="left" src="../img/sweden-connect.png"></img>
<img align="right" src="../img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="../img/transparent.png"></img>
</p>

# Tekniska anslutningsregler för Sweden Connect-federationen

### 2021-12-10

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">Myndigheten för digital förvaltning (DIGG)</a>, 2021.
</p>

## Innehållsförteckning

1. [**Introduktion**](#introduktion)

   1.1. [Avtal](#avtal)
   
   1.1.1. [Valfrihetssystem 2017](#valfrihetssystem-2017)
   
   1.1.2. [Internationell legitimering - eIDAS](#internationell-legitimering-eidas)
   
   1.1.3. [eID för medarbetare](#eid-for-medarbetare)
   
   1.1.4. [Bilaterala avtal om legitimering](#bilaterala-avtal-om-legitimering)
   
   1.2. [Tillitsnivåer](#tillitsnivaer)
   
2. [**Legitimering och leverans av identitetsintyg**](#legitimering-och-leverans-av-identitetsintyg)
   
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

Deltagare inom Sweden Connect-federationen har tecknat ett, eller flera, anslutningsavtal. Dessa avtal 
definierar vilken typ av legitimering som levereras/efterfrågas, samt frågor såsom avgifter och ansvarsfrågor.
Denna specifikation berör endast de tekniska aspekterna av de olika avtalen, d.v.s., hur legitimering går till
och vilka krav som ställs på en viss aktör rörande registrering etc.

<a name="valfrihetssystem-2017"></a>
#### 1.1.1. Valfrihetssystem 2017

[Valfrihetssystem 2017](https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/nationell-e-legitimering) är ett avtal som ger förlitande parter tillgång till godkända, och granskade, legitimeringstjänst(er) som levererar
identitetsintyg utställda enligt tillitsnivå 3 (eller 4), och innehållande personnummerinformation. 

> Endast offentliga aktörer kan teckna detta avtal.

<a name="internationell-legitimering-eidas"></a>
#### 1.1.2. Internationell legitimering - eIDAS

För att en förlitande part ska få tillgång till eIDAS-legitimering tecknas avtalet [Avtal med förlitande part beträffande funktioner för elektronisk identifiering - Sweden Connect](https://www.digg.se/digital-identitet/e-legitimering/offentlig-aktor/internationell-e-legitimering). I text nedan betecknar vi detta avtal "Sweden Connect - eIDAS".

Detta avtal ger en förlitande part rätt att nyttja den svenska eIDAS-noden för legitimering av personer som innehar
ett utländskt eID.

> Både offentliga och privata aktörer kan teckna detta avtal. Notera dock att eIDAS-legitimering för "private sector"
i dagsläget inte stöds av några länder.

Avtalet, som tidigare benämndes "Sweden Connect Trafikavtal", ger också den förlitande parten rätt att XXX.

<a name="eid-for-medarbetare"></a>
#### 1.1.3. eID för medarbetare

Avtalet [Förbetald elektronisk identifiering](https://www.digg.se/4a762d/globalassets/dokument/digital-identitet/eid-for-medarbetare/forlitandeavtal-eid-for-medarbetare_2021-09-17.pdf) ger en förlitande part rätt att nyttja de legitimeringstjänster inom Sweden Connect som levererar identitetsintyg baserat på legitimering utförd med e-tjänstlegitimation. För dessa legitimeringstjänster krävs även en godkänd tillitsgranskning enligt nivå 3 eller 4. 

<a name="bilaterala-avtal-om-legitimering"></a>
#### 1.1.4. Bilaterala avtal om legitimering

Utöver de avtal ovan som tillhandahålls av DIGG, kan en aktör teckna direktavtal med legitimeringstjänster som finns
i Sweden Connect. Dessa avtal ligger utanför DIGG:s ansvar, men XXX


<a name="tillitsnivaer"></a>
### 1.2. Tillitsnivåer

DIGG 

> Skriv om nivåer och avarter

non-resident

### 1.3. Legitimeringstjänster inom Sweden Connect

#### 1.3.1. Tillitsgranskade legitimeringstjänster

#### 1.3.2. Aktörsspecifika legitimeringstjänster 

> Måste granskas med avseende på uppfyllnad av tekniskt ramverk

> Gå igenom de regler som gäller för tredjeparts-IdP:er.

> Ta upp krav på proxy.

> BankID. Måste följa specen


<a name="legitimering-och-leverans-av-identitetsintyg"></a>
## 2. Legitimering och leverans av identitetsintyg

### 2.1. Allmänt

[Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html) definierar hur en legitimeringsbegäran ("authentication request") ska byggas upp och hur leverans av identitetsintyg ska ske. Detta avsnitt går igenom detaljer rörande:

- Regler för hur legitimeringstjänster legitimerar användare, samt leverans av intyg.

- Råd och anvisningar kring hur en legitimeringsbegäran byggs upp.

<a name="leverans-av-intyg-till-den-svenska-eidas-noden"></a>
### 2.X. Leverans av intyg till den svenska eIDAS-noden

### 2.2. Personnummer

### 2.3. Organisationsidentitet

### 2.4. eIDAS

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

En sådant element ser ut enligt:

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

Exempel på hur organisationen DIGG har registrerat organisationsinformation i metadata.

**Regler och rutiner vid registrering av metadata**:

- Det namn som anges på svenska under elementet `OrganizationName` skall stämma överens med namnet
som angavs när organisationen tecknade avtal med DIGG angående deltagande i federationen (undantaget
nedanstående punkt).

- I de fall en offentlig aktör som har tecknat något form av Sweden Connect-avtal har begärt att 
en tredjeparts-legitimeringstjänst registreras i metadata under aktörens avtal behöver `OrganizationName`
inte ange den offentliga aktörens registrerade namn (se XXX ovan). Orsaken till detta är att det
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

- Ytterligare utförs en okulärbesiktning för att säkerställa att angiven information ser ut
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

- Endast legitimeringstjänster som levererar enligt avtalet [Förbetald elektronisk identifiering](https://www.digg.se/4a762d/globalassets/dokument/digital-identitet/eid-for-medarbetare/forlitandeavtal-eid-for-medarbetare_2021-09-17.pdf)
och som är granskade och godkända enligt tillitsnivå 3 eller 4 får deklarera `http://id.swedenconnect.se/loa/1.0/loa3-nonresident`.

- Endast legitimeringstjänster som levererar enligt avtalet [Förbetald elektronisk identifiering](https://www.digg.se/4a762d/globalassets/dokument/digital-identitet/eid-for-medarbetare/forlitandeavtal-eid-for-medarbetare_2021-09-17.pdf)
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

Lösningen i detta fall behöver tyvärr vara så att den givna organisationen skapar två förlitande parter (SAML SP)
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

- En förlitande part som deklarerar `loa4-pnr` måste också deklarera ett `AssertionConsumerService`-element
gällande SAML Holder-of-key profilen (se XXX nedan). Se kapitel 2.1.2.1 av [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#service-providers). 

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

- En förlitande part som deklarerar `loa4-orgid` måste också deklarera ett `AssertionConsumerService`-element
gällande SAML Holder-of-key profilen (se XXXX nedan). Se kapitel 2.1.2.1 av [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#service-providers). 

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

- En förlitande part som deklarerar `loa4-name` måste också deklarera ett `AssertionConsumerService`-element
gällande SAML Holder-of-key profilen (se XXXX nedan). Se kapitel 2.1.2.1 av [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#service-providers).


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
Connect. Se [Leverans av intyg till den svenska eIDAS-noden](#leverans-av-intyg-till-den-svenska-eidas-noden).

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

- Vid registrering av metadata görs en kontroll att antingen `public-sector-sp` eller `private-sector-sp`, samt att 
deklarationen stämmer överens med aktörens tecknade avtal.

<a name="registrering-av-tecknade-avtal"></a>
### 3.6. Registrering av tecknade avtal

Deltagande i Sweden Connect-federationen styrs av avtal, både gällande förlitande parter och legitimeringstjänster.
För att en legitimeringstjänst ska acceptera en legitimeringsbegäran från en förlitande part måste den kunna ta reda
på om den förlitande parten har rätt att nyttja tjänsten. Detta åstadkoms genom att förlitande parter deklarerar 
"Service Contract Category"-värden som indikerar vilka avtal som gäller för aktören. Se kapitel 5 av 
[Entity Categories for the Swedish eID Framework](#https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#service-contract-categories).

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
levererar enligt [Anslutningsavtal för leverantör avseende Valfrihetssystem 2017 e-legitimering](https://www.digg.se/49d5f2/globalassets/dokument/digital-identitet/e-legitimering/valfrihetssystem-2017-e-legitimering/anslutningsavtal-leverantor-valfrihetssystem-2017.docx).

**Regler och rutiner vid registrering av metadata**:

- Vid registrering av metadata görs en kontroll mot tecknade avtal för den givna organisationen.

<a name="eid-for-medarbetare2"></a>
#### 3.6.4. eID för medarbetare

**Identifierare**: `http://id.swedenconnect.se/contract/sc/prepaid-auth-2021`

Skall deklareras av förlitande parter som tecknat avtalet [Förbetald elektronisk identifiering](https://www.digg.se/4a762d/globalassets/dokument/digital-identitet/eid-for-medarbetare/forlitandeavtal-eid-for-medarbetare_2021-09-17.pdf)
och av legitimeringstjänster som levererar enligt [Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald elektronisk identifiering](#https://www.digg.se/4a7622/globalassets/dokument/digital-identitet/eid-for-medarbetare/2021-09-17-anslutningsavtal-leverantor.pdf).

**Regler och rutiner vid registrering av metadata**:

- Vid registrering av metadata görs en kontroll mot tecknade avtal för den givna organisationen.

<a name="metadataregler-gallande-organisationsidentiteter"></a>
### 3.7. Metadataregler gällande organisationsidentiteter

Legitimeringstjänster som levererar enligt [Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald elektronisk identifiering](https://www.digg.se/4a7622/globalassets/dokument/digital-identitet/eid-for-medarbetare/2021-09-17-anslutningsavtal-leverantor.pdf) och stödjer leverans av intyg enligt attributsuppsättningen [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons) måste anmäla
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

Följande metadataregler gäller rörande tillitsnivå 4:

- En legitimeringstjänst som deklarerat ... 



<a name="versioner-av-detta-dokument"></a>
## 4. Versioner av detta dokument

- 2021-12-10: Första utkast


