<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Registration Rules for the Sweden Connect SAML Federation

### 2026-10-19

Specification for parties that connect to Digg's identity federation Sweden Connect using SAML.

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (Digg)</a>, 2021-2026.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

   1.1. [Agreements](#agreements)
   
   1.1.1. [Authorization System for Electronic Identification (Auktorisationssystem för elektronisk identifiering)](#auktorisationssystem-for-elektronisk-identifiering)
   
   1.1.2. [International Authentication - eIDAS](#international-authentication-eidas)
   
   1.1.3. [eID for Employees (eID för medarbetare)](#eid-for-medarbetare)
   
   1.1.4. [Bilateral Agreements on Authentication](#bilateral-agreements-on-authentication)
   
   1.2. [Levels of Assurance and Identifiers for Authentication](#levels-of-assurance)
   
   1.2.1. [Swedish Levels of Assurance](#swedish-levels-of-assurance)
   
   1.2.2. [Levels of Assurance According to eIDAS](#levels-of-assurance-according-to-eidas)
   
   1.2.3. [Identifiers for Levels of Assurance](#identifiers-for-levels-of-assurance)
   
   1.3. [Identity Providers within Sweden Connect](#identity-providers-within-sweden-connect)
   
   1.3.1. [Review of Compliance with the Technical Framework](#review-of-compliance-with-the-technical-framework)
   
   1.3.2. [Publishing Instances to the Sweden Connect Environments](#publishing-instances-to-the-sweden-connect-environments)
   
   1.3.3. [Specific Requirements for Party-specific Identity Providers](#party-specific-identity-providers)
   
   1.3.4. [Compliance with the Technical Framework over Time](#compliance-with-the-technical-framework-over-time)
   
2. [**Authentication and Delivery of Assertions**](#authentication-and-delivery-of-assertions)

   2.1. [User Interface](#user-interface)

   2.1.1. [Error Handling and Reporting](#error-handling-and-reporting)
   
   2.1.2. [Information about Identity Attributes](#information-about-identity-attributes)
   
   2.2. [Requirements for Single Sign-On](#requirements-for-single-sign-on)
   
   2.3. [Requirements for Attribute Release](#requirements-for-attribute-release)
   
   2.3.1. [Delivery of Assertions to the Swedish eIDAS Node](#delivery-of-assertions-to-the-swedish-eidas-node)

   2.3.2. [Other Attributes](#other-attributes)
   
   2.4. [Specific Requirements for Level of Assurance 4](#specific-requirements-for-loa-4)
   
3. [**Metadata**](#metadata)

   3.1. [Registration of Organization Information](#registration-of-organization-information)
   
   3.2. [Registration of Display Name and Logotype](#registration-of-display-name-and-logotype)
   
   3.3. [Registration of Levels of Assurance](#registration-of-levels-of-assurance)
   
   3.4. [Registration of Service Entity Category Values](#registration-of-service-entity-category-values)
   
   3.4.1. [loa3-pnr](#loa3-pnr)
   
   3.4.2. [loa4-pnr](#loa4-pnr)
   
   3.4.3. [loa3-orgid](#loa3-orgid)
   
   3.4.4. [loa4-orgid](#loa4-orgid)
   
   3.4.5. [loa3-name](#loa3-name)
   
   3.4.6. [loa4-name](#loa4-name)
   
   3.4.7. [eidas-naturalperson](#eidas-naturalperson)
   
   3.4.8. [eidas-pnr-delivery](#eidas-pnr-delivery)
   
   3.5. [Registration of Relying Party Type - Service Type Category](#registration-of-relying-party-type)
   
   3.5.1. [Signature Service Indicator](#sigservice)
   
   3.5.2. [Public or Private Sector Indicator](#public-or-private-sector-indicator)
   
   3.6. [Registration of Signed Agreements](#registration-of-signed-agreements)
   
   3.6.1. [Sweden Connect Agreement](#sweden-connect-agreement)
   
   3.6.2. [Bilateral Agreements](#other-contracts)
   
   3.6.3. [eID for Employees (eID för medarbetare)](#eid-for-medarbetare2)

   3.6.4. [Authorization System for Electronic Identification (Auktorisationssystem för elektronisk identifiering)](#eid-authorization-system)
   
   3.7. [Metadata Rules for Organizational Identities](#metadata-rules-for-organizational-identities)
   
   3.8. [Metadata Rules for Coordination Numbers](#metadata-rules-for-coordination-numbers)
   
   3.9. [Metadata Rules for Level of Assurance 4 (LoA 4)](#metadata-rules-for-loa-4)
   
4. [**Document History**](#document-history)

<a name="introduction"></a>
## 1. Introduction

This document is a normative specification for parties that connect to Digg's identity federation Sweden Connect.

Based on the different agreements for providers and participants within the federation, this document defines specific requirements derived from the design of the agreements and the technical requirements of the [Sweden Connect Technical Framework](https://docs.swedenconnect.se/technical-framework/).

> Note: This document covers connection using SAML only. The corresponding documents for connection using OpenID Connect are published at https://docs.swedenconnect.se/technical-framework/#federation-openid-connect.

<a name="agreements"></a>
### 1.1. Agreements

Participants in the Sweden Connect federation have signed one or more connection agreements. These agreements define the type of authentication that is delivered or requested, as well as matters such as fees and liability. This specification covers only the technical aspects of the different agreements, that is, how authentication is performed and which requirements apply to a party regarding registration and similar matters.

<a name="auktorisationssystem-for-elektronisk-identifiering"></a>
#### 1.1.1. Authorization System for Electronic Identification (Auktorisationssystem för elektronisk identifiering)

The [Authorization System for Electronic Identification](https://www.digg.se/digitala-tjanster/e-legitimering/bli-godkand-utfardare-av-svensk-e-legitimation/leverera-elektronisk-identifiering-inom-auktorisationssystemet) is an agreement that gives Relying Parties access to approved and reviewed eIDs and the associated Identity Providers.

The eIDs are issued to persons with a personal identity number or a coordination number and meet Level of Assurance 2, 3 or 4 according to the [Trust Framework for Swedish e-Identification](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation) (Tillitsramverket för Svensk e-legitimation).

The connected providers offer functions for authentication, identification, electronic signature and delivery of assertions. A provider may also offer identity mapping (id-växling).

Only public sector Relying Parties can sign this agreement. The agreements take effect, and the services can be used, from January 2026.

Providers that deliver according to the Authorization System for Electronic Identification have signed the [Connection Agreement for the Authorization System for Electronic Identification - Provider](https://www.digg.se/digitala-tjanster/e-legitimering/bli-godkand-utfardare-av-svensk-e-legitimation/leverera-elektronisk-identifiering-inom-auktorisationssystemet/auktorisationssystem-for-elektronisk-identifiering---administrativa-foreskrifter/anslutningsavtal-for-auktorisationssystem-for-elektronisk-identifiering---leverantor) (Anslutningsavtal för Auktorisationssystem för elektronisk identifiering – leverantör).

<a name="international-authentication-eidas"></a>
#### 1.1.2. International Authentication - eIDAS

For a Swedish Relying Party to get access to eIDAS authentication, the [Connection Agreement for Sweden Connect - Public Sector Party](https://www.digg.se/digitala-tjanster/e-legitimering/erbjud-inloggning-med-utlandska-e-legitimationer/anslut-till-den-svenska-eidas-noden/teckna-avtal-gallande-eidas-noden) (Anslutningsavtal till Sweden Connect – offentlig aktör) is signed.

This agreement gives a Relying Party the right to use the Swedish eIDAS node for authentication of persons who hold a foreign eID.

> Both public and private sector parties can sign this agreement. Note, however, that eIDAS authentication for "private sector" currently has poor or no support among the connected countries.

<a name="eid-for-medarbetare"></a>
#### 1.1.3. eID for Employees (eID för medarbetare)

The [Relying Party Agreement - Prepaid Electronic Identification](https://www.digg.se/digitala-tjanster/e-legitimering/erbjud-inloggning-med-e-tjanstelegitimationer) (Förlitandeavtal - Förbetald e-legitimering) gives a Relying Party the right to use the Identity Providers within Sweden Connect that issue assertions based on authentication with an eID provided by an employer (e-tjänstelegitimation). These Identity Providers must also have passed an assurance review at level 2, 3 or 4 and deliver according to the [Connection Agreement for Issuers of Employee eIDs - Prepaid Electronic Identification](https://www.digg.se/digitala-tjanster/e-legitimering/bli-godkand-utfardare-av-svensk-e-legitimation/leverera-e-tjanstelegitimationer) (Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald e-legitimering).

> Both public and private sector Relying Parties can sign the Relying Party Agreement - Prepaid Electronic Identification.

<a name="bilateral-agreements-on-authentication"></a>
#### 1.1.4. Bilateral Agreements on Authentication

A Relying Party that has signed the [Connection Agreement for Sweden Connect - Public Sector Party](https://www.digg.se/digitala-tjanster/e-legitimering/erbjud-inloggning-med-utlandska-e-legitimationer/anslut-till-den-svenska-eidas-noden/teckna-avtal-gallande-eidas-noden) (Anslutningsavtal till Sweden Connect – offentlig aktör) may also sign bilateral agreements with providers of Identity Providers that are not offered through the existing Digg agreements. One example is a third-party Identity Provider for BankID (which is not available as an official Identity Provider in Sweden Connect).

In these cases, the party has the right to request that the federation operator (Digg) publishes the metadata of these "party-specific" Identity Providers in the Sweden Connect federation (under the party's responsibility). See Section [1.3.3](#party-specific-identity-providers) below.

> Note: Providers that deliver, for example, BankID services within Sweden Connect may have agreements with several different Relying Parties. The provider may then have **one** instance of an Identity Provider in Sweden Connect that is shared between the different Relying Parties. The requirement of the federation operator (Digg) is that all Relying Parties that use this instance notify Digg about this.

<a name="levels-of-assurance"></a>
### 1.2. Levels of Assurance and Identifiers for Authentication

This section describes the [levels of assurance](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering) that are used within the Sweden Connect federation and the identifiers that are used to represent different types of authentication.

<a name="swedish-levels-of-assurance"></a>
#### 1.2.1. Swedish Levels of Assurance

The [Trust Framework for Swedish e-Identification](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation) (Tillitsramverket för Svensk e-legitimation) defines three levels of assurance, 2, 3 and 4, of which Level of Assurance 3 and 4 are currently used within Sweden Connect.

For an Identity Provider to be allowed to authenticate users and issue assertions according to any of these levels, the eID issuer **and** the Identity Provider must have been reviewed and approved by Digg.

See [Becoming an Approved Issuer of Swedish eIDs](https://www.digg.se/digitala-tjanster/e-legitimering/bli-godkand-utfardare-av-svensk-e-legitimation) (Bli godkänd utfärdare av svensk e-legitimation) and [Becoming an Approved Provider of an Assertion Service](https://www.digg.se/digitala-tjanster/e-legitimering/bli-godkand-leverantor-av-intygsfunktion) (Bli godkänd leverantör av intygsfunktion) for more information about applying for a review.

<a name="levels-of-assurance-according-to-eidas"></a>
#### 1.2.2. Levels of Assurance According to eIDAS

The EU eIDAS Regulation, [No 910/2014](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32014R0910), defines three levels of assurance: "low", "substantial" and "high". These roughly correspond to the Swedish levels 2, 3 and 4, but there are differences that make a direct mapping between the levels impossible.

Swedish Relying Parties that authenticate individuals using eIDAS authentication, via the Swedish eIDAS node, must therefore be able to handle the assurance identifiers for eIDAS (see below).

<a name="identifiers-for-levels-of-assurance"></a>
#### 1.2.3. Identifiers for Levels of Assurance

Within Sweden Connect, an authentication operation is represented by "Authentication Context URIs". These are described in Section 3.1.1 of [Sweden Connect – Registry for Identifiers](https://docs.swedenconnect.se/technical-framework/latest/03_-_Registry_for_Identifiers.html#authentication-context-uris).

This section lists these identifiers and the rules that apply to their use.

- `http://id.elegnamnden.se/loa/1.0/loa3` - Level of Assurance 3 - Only Identity Providers approved according to level 3 (or 4) of the [Trust Framework for Swedish e-Identification](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation) (Tillitsramverket för Svensk e-legitimation) may issue assertions containing this identifier.

- `http://id.elegnamnden.se/loa/1.0/loa4` - Level of Assurance 4 - Only Identity Providers approved according to level 4 of the [Trust Framework for Swedish e-Identification](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation) may issue assertions containing this identifier. It is also recommended that the SAML profile "Holder-of-key" is used.

- `http://id.elegnamnden.se/loa/1.0/eidas-nf-low` - eIDAS "low" issued by an eID notified to the EU according to the eIDAS Regulation - Issued by the Swedish eIDAS node when the authentication was performed according to the eIDAS level `http://eidas.europa.eu/LoA/low`.

- `http://id.elegnamnden.se/loa/1.0/eidas-low` - eIDAS "low" issued by a notified or a non-notified<sup>*</sup> eID - Issued by the Swedish eIDAS node when the authentication was performed according to the eIDAS level `http://eidas.europa.eu/NotNotified/LoA/low`.

- `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub` - eIDAS "substantial" issued by an eID notified to the EU according to the eIDAS Regulation - Issued by the Swedish eIDAS node when the authentication was performed according to the eIDAS level `http://eidas.europa.eu/LoA/substantial`.

- `http://id.elegnamnden.se/loa/1.0/eidas-sub` - eIDAS "substantial" issued by a notified or a non-notified<sup>*</sup> eID - Issued by the Swedish eIDAS node when the authentication was performed according to the eIDAS level `http://eidas.europa.eu/NotNotified/LoA/substantial`.

- `http://id.elegnamnden.se/loa/1.0/eidas-nf-high` - eIDAS "high" issued by an eID notified to the EU according to the eIDAS Regulation - Issued by the Swedish eIDAS node when the authentication was performed according to the eIDAS level `http://eidas.europa.eu/LoA/high`.

- `http://id.elegnamnden.se/loa/1.0/eidas-high` - eIDAS "high" issued by a notified or a non-notified<sup>*</sup> eID - Issued by the Swedish eIDAS node when the authentication was performed according to the eIDAS level `http://eidas.europa.eu/NotNotified/LoA/high`.

\[\*\]: Currently, the Swedish eIDAS node is only connected to notified eIDs according to the EU eIDAS Regulation.

The [Trust Framework for Swedish e-Identification](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation) requires that an individual who receives an eID holds a Swedish personal identity number (or a verified coordination number). When eIDs are acquired by employers according to [Electronic Identification for Employees](https://www.digg.se/digitala-tjanster/e-legitimering/skaffa-losningar-for-inloggning-med-e-legitimationer/erbjud-inloggning-med-e-tjanstelegitimationer) (E-legitimering för medarbetare), and assertions are issued by an Identity Provider that delivers according to the [Connection Agreement for Issuers of Employee eIDs - Prepaid Electronic Identification](https://www.digg.se/digitala-tjanster/e-legitimering/bli-godkand-utfardare-av-svensk-e-legitimation/leverera-e-tjanstelegitimationer) (Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald e-legitimering), individuals who do not hold a Swedish personal identity number or coordination number may be issued an eID. When such eIDs are used for authentication within Sweden Connect, the ordinary identifiers for level 2, 3 or 4 must not be used. An Identity Provider that is approved for level 2, 3 or 4, and that issues assertions for these types of eIDs, shall instead use the following identifiers:

- `http://id.swedenconnect.se/loa/1.0/loa2-nonresident` - Authentication according to Level of Assurance 2 where the presented eID has been issued to an individual who does not hold a Swedish personal identity number (or coordination number).

- `http://id.swedenconnect.se/loa/1.0/loa3-nonresident` - Authentication according to Level of Assurance 3 where the presented eID has been issued to an individual who does not hold a Swedish personal identity number (or coordination number).

- `http://id.swedenconnect.se/loa/1.0/loa4-nonresident` - Authentication according to Level of Assurance 4 where the presented eID has been issued to an individual who does not hold a Swedish personal identity number (or coordination number).

In all cases above, the issuance of the eID must follow the Trust Framework for Swedish e-Identification, with the exception of the requirement for a personal identity number or coordination number, and with the additional requirements for "non-resident".

Sections [1.1.4](#bilateral-agreements-on-authentication) and [1.3.3](#party-specific-identity-providers) describe how Identity Providers that have not passed an assurance review can be used within the Sweden Connect federation. Since these Identity Providers are not approved according to the [Trust Framework for Swedish e-Identification](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation), they must not include any of the identifiers above in assertions. A third-party Identity Provider is free to define its own identifiers, but to support interoperability a number of identifiers are defined in Section 3.1.1.2 of [Sweden Connect – Registry for Identifiers](https://docs.swedenconnect.se/technical-framework/latest/03_-_Registry_for_Identifiers.html#authentication-context-uris-for-uncertified-providers).

These are:

- `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` - Shall be used by an Identity Provider that has not been reviewed and approved according to level 3 of the Trust Framework for Swedish e-Identification, but that delivers services claimed to correspond to level 3 (by self-declaration). This also applies to Identity Providers that have not been reviewed and that deliver authentication for an issuer approved according to level 3 (for example BankID).

- `http://id.swedenconnect.se/loa/1.0/uncertified-eidas-low` - Shall be used by a Proxy-IdP that offers eIDAS authentication and receives `http://id.elegnamnden.se/loa/1.0/eidas-low` or `http://id.elegnamnden.se/loa/1.0/eidas-nf-low` from the official Swedish eIDAS node.

- `http://id.swedenconnect.se/loa/1.0/uncertified-eidas-sub` - Shall be used by a Proxy-IdP that offers eIDAS authentication and receives `http://id.elegnamnden.se/loa/1.0/eidas-sub` or `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub` from the official Swedish eIDAS node.

- `http://id.swedenconnect.se/loa/1.0/uncertified-eidas-high` - Shall be used by a Proxy-IdP that offers eIDAS authentication and receives `http://id.elegnamnden.se/loa/1.0/eidas-high` or `http://id.elegnamnden.se/loa/1.0/eidas-nf-high` from the official Swedish eIDAS node.

Note that it is not possible to request a review of a proxy service so that it can deliver the official identifiers for eIDAS. Only the official Swedish eIDAS node can do this.

<a name="identity-providers-within-sweden-connect"></a>
### 1.3. Identity Providers within Sweden Connect

The following sections describe requirements and rules for authentication and metadata registration for Identity Providers and Relying Parties within the Sweden Connect federation. This section describes the specific rules that apply for an Identity Provider to be allowed to connect to Sweden Connect.

<a name="review-of-compliance-with-the-technical-framework"></a>
#### 1.3.1. Review of Compliance with the Technical Framework

All Identity Providers, whether or not they have passed an assurance review, must be reviewed and approved with regard to compliance with the [Sweden Connect Technical Framework](https://docs.swedenconnect.se/technical-framework/) before they can connect.

Such a review is requested through a dialogue with Digg.

The following steps shall be performed:

- Before the review, the provider shall perform its own tests and verify support for the requirements of the [Sweden Connect Technical Framework](https://docs.swedenconnect.se/technical-framework/).

- The provider shall supply an IdP instance that, as far as possible, is configured and set up as a "real" production service (except that test users instead of real individuals shall be used for testing authentication). This instance shall be published to the Sweden Connect Sandbox federation (https://sandbox.swedenconnect.se), and it shall consume all SAML metadata for all Relying Parties in that federation.

- During testing, the provider shall provide resources to handle any questions that arise.

When the review has been completed and the results are approved, the provider may proceed to publish its IdP instance in Sweden Connect QA (see below).

<a name="publishing-instances-to-the-sweden-connect-environments"></a>
#### 1.3.2. Publishing Instances to the Sweden Connect Environments

Sweden Connect has three environments:

- Sweden Connect Sandbox - A test environment for initial testing. All parties, regardless of agreement, have the right to connect to this environment. See https://sandbox.swedenconnect.se.

- Sweden Connect QA - The official test environment of Sweden Connect. Only parties that have an agreement with Digg have the right to publish metadata to this environment. This environment shall mirror the production environment, with the important exception that only test users may occur (that is, no real personal identity numbers or similar are allowed).

- Sweden Connect Production - The production environment.

An Identity Provider that connects to the Sweden Connect federation commits to publishing an instance in the Sweden Connect QA federation. This instance shall offer the same functionality as the corresponding instance in the production federation, with the exception that only test identities may be used.

> It is therefore not allowed to test "the next version of the IdP" in Sweden Connect QA. The functionality must correspond to the production federation. Testing of upcoming versions can instead be performed in Sweden Connect Sandbox.

Only after the service has been successfully published in Sweden Connect QA is the provider allowed to connect to Sweden Connect Production.

<a name="party-specific-identity-providers"></a>
#### 1.3.3. Specific Requirements for Party-specific Identity Providers

A "party-specific" Identity Provider is a service that is not a provider under any of the agreements offered by Digg, but an Identity Provider that is added to Sweden Connect under the responsibility (and agreement) of a Relying Party.

These Identity Providers must also comply with the [Sweden Connect Technical Framework](https://docs.swedenconnect.se/technical-framework/) and the other rules that apply to Identity Providers within the federation.

Third-party Identity Providers that deliver BankID authentication should comply with the requirements in [Implementation Profile for BankID Identity Providers within the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/12_-_BankID_Profile_for_the_Swedish_eID_Framework.html).

<a name="compliance-with-the-technical-framework-over-time"></a>
#### 1.3.4. Compliance with the Technical Framework over Time

New versions of the specifications in the [Sweden Connect Technical Framework](https://docs.swedenconnect.se/technical-framework/) are published periodically by Digg. An Identity Provider within Sweden Connect must support the latest published version no later than 180 days after the version was published.

> Digg may request a new review of an Identity Provider after a new version of a specification in the Technical Framework has been published (if the specification is relevant to the Identity Provider's connection agreement).


<a name="authentication-and-delivery-of-assertions"></a>
## 2. Authentication and Delivery of Assertions

[Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html) defines how an authentication request shall be built and how assertions shall be delivered. This section complements and clarifies that specification.

<a name="user-interface"></a>
### 2.1. User Interface

The user interface of the Identity Provider must be designed so that it is clear which Relying Party has requested authentication. The display name and logotype of the Relying Party shall be obtained from the Relying Party's metadata entry, see Section [3.2](#registration-of-display-name-and-logotype) below.

<a name="error-handling-and-reporting"></a>
#### 2.1.1. Error Handling and Reporting

Any errors that occur during an authentication process shall be clearly described to the user, and the user shall always be able to confirm that they have read the error message. When the user confirms, that is, clicks the "OK" or "I understand" button, a SAML response message indicating failed authentication shall be posted back to the Relying Party. See Section 6.4 of [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#error-responses).

<a name="information-about-identity-attributes"></a>
#### 2.1.2. Information about Identity Attributes

An Identity Provider should inform the user in its user interface about which identity attributes are delivered for a given authentication. When authentication is performed according to the agreement [Authorization System for Electronic Identification](#auktorisationssystem-for-elektronisk-identifiering) (Auktorisationssystem för elektronisk identifiering), or a corresponding bilateral agreement, this is not a strict requirement, since the user in these cases is expected to understand that the personal identity number is delivered.

If the Identity Provider delivers according to [eID for Employees](#eid-for-medarbetare) (eID för medarbetare), that is, the eID used has been acquired through the employer, the Identity Provider shall always inform the user about which identity information is delivered in an assertion before it is sent back to the Relying Party. The Identity Provider shall also offer the user a way to cancel the authentication after this information has been displayed.

The reason for this requirement is that, depending on the Relying Party's requirements for attribute release, the assertion may contain only an organizational identity, both an organizational identity and personal identity number information, or only personal identity number information. Since some users may be unwilling to use their personal identity number in their work, the Identity Provider shall inform them about which attributes are requested and included in the assertion.

The Identity Provider is allowed to "remember" the user's approval of attribute release and not display this information again if the user has previously approved the attribute release. However, this must be implemented per Relying Party, that is, per e-service the user logs in to.

<a name="requirements-for-single-sign-on"></a>
### 2.2. Requirements for Single Sign-On

An Identity Provider in Sweden Connect may choose to support Single Sign-On, that is, issuing assertions based on a previously performed authentication. This is allowed if an authentication request is received within 60 minutes from when the original authentication was performed. An Identity Provider may choose a shorter session time, but the limit of 60 minutes must not be exceeded.

Each time a user performs a full authentication at the Identity Provider, the time of the "original authentication" is moved.

Section 5.4.5 of [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#single-sign-on-processing) describes requirements for reused authentication. This section extends those requirements with the following:

If a requirement to display which identity attributes are delivered (see [2.1.2](#information-about-identity-attributes) above) applies to a given authentication request, it also applies if the assertion is issued based on a previously performed authentication, that is, the user must be informed about the delivered identity attributes even if no actual authentication is performed.

<a name="requirements-for-attribute-release"></a>
### 2.3. Requirements for Attribute Release

The specification [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html) declares a number of attribute sets. The attributes referenced in these sets are also linked to the level of assurance according to which an Identity Provider has been reviewed and approved. In addition to these attributes, a number of other attributes are defined in [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html). How these may be used within the Sweden Connect federation is described in Section [2.3.2](#other-attributes) below.

The requirements for attribute release based on Digg's delivery agreements are as follows:

[Authorization System for Electronic Identification](#auktorisationssystem-for-elektronisk-identifiering) (Auktorisationssystem för elektronisk identifiering)

> An Identity Provider that delivers authentication for Relying Parties that have joined the [Authorization System for Electronic Identification](#auktorisationssystem-for-elektronisk-identifiering) shall support the following attribute sets:

> - [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number) - Personal identity number or coordination number, given name and surname, and the user's "display name".

> - [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number) - The user's given name and surname, and "display name".

[eID for Employees](#eid-for-medarbetare) (eID för medarbetare)

> An Identity Provider that delivers authentication for Relying Parties that have signed the [Relying Party Agreement - Prepaid Electronic Identification](https://www.digg.se/download/18.129a4fef1939e2e1c1f162ca/1650447908281/forlitandeavtal-forbetald-e-legitimering.docx) (Förlitandeavtal - Förbetald e-legitimering) shall support the following attribute sets:

> - [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons) - Organizational identity, organization name and the user's "display name".

> - [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number) - Personal identity number or coordination number, given name and surname, and the user's "display name".

> - [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number) - The user's given name and surname, and "display name".

The Swedish eIDAS connector

> The Swedish eIDAS connector (eIDAS node) delivers according to the following attribute set:

> - [eIDAS Natural Person Attribute Set](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#eidas-natural-person-attribute-set)


<a name="delivery-of-assertions-to-the-swedish-eidas-node"></a>
#### 2.3.1. Delivery of Assertions to the Swedish eIDAS Node

Identity Providers that have a supplementary agreement with Digg to deliver assertions to the Swedish eIDAS Proxy Service node (that is, the eIDAS node that authenticates holders of Swedish eIDs for login to foreign e-services) shall deliver according to the attribute set [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number), with the addition that the date of birth is also required.

The Identity Provider may also choose to inform the user that identity information will be sent to the country and the e-service that requests authentication, and obtain the user's consent to this. Whether or not an Identity Provider implements this "consent" dialogue shall be agreed with Digg.

An Identity Provider that delivers assertions to the Swedish eIDAS node may choose to accept authentication requests from other countries that have been requested by a private sector party, or to refuse such requests. If the Identity Provider chooses to support authentication for private sector parties from other countries, it is the responsibility of the Identity Provider to decide which private sector parties are accepted and how compensation for performed authentications is handled. The Identity Provider's choice to accept requests from private sector parties is agreed directly with Digg, since it is not specified through the Identity Provider's metadata.

<a name="other-attributes"></a>
#### 2.3.2. Other Attributes

Section 3 of [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#attribute-definitions) defines more attributes than those included in the attribute sets referenced earlier in this section. An Identity Provider in Sweden Connect has the right to deliver attributes other than those included in the attribute sets referenced above, under the following conditions:

- There is a bilateral agreement between the Identity Provider and the Relying Party regarding delivery of additional attributes.

- A Relying Party includes one or more `RequestedAttribute` elements in its metadata, requesting delivery of attributes in addition to the attribute sets (which are governed by declared entity categories, see below). See the example below.

```
<md:AttributeConsumingService index="0" isDefault="true">
  ...
  <md:RequestedAttribute Name="urn:oid:0.9.2342.19200300.100.1.3" isRequired="false" />
  <md:RequestedAttribute Name="urn:oid:2.5.4.20" isRequired="false" />
</md:AttributeConsumingService>
```

*Example of how a Relying Party requests delivery of the attributes `mail` and `telephoneNumber`. Note that `isRequired` is set to `false`, which means that the Relying Party also accepts assertions that do not include the requested attributes.*


<a name="specific-requirements-for-loa-4"></a>
### 2.4. Specific Requirements for Level of Assurance 4

An Identity Provider that is approved for authentication and assertion delivery at Level of Assurance 4 according to the Trust Framework for Swedish e-Identification (Tillitsramverket för Svensk e-legitimation) may choose to support the SAML profile [SAML V2.0 Holder-of-key Web Browser SSO Profile](https://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-holder-of-key-browser-sso.pdf). The use of "Holder-of-key" according to the Sweden Connect Technical Framework is specified in [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).

An Identity Provider that is approved for authentication and assertion delivery according to Level of Assurance 4 and that supports the "Holder-of-key" profile shall also accept authentication requests according to the ordinary Web SSO profile (that is, a request according to [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html) that does not use "Holder-of-key").

A Relying Party may choose to require authentication according to the "Holder-of-key" profile for Identity Providers that have announced support for it.

To maintain the increased security of "Holder-of-key", it is important that both the Identity Provider (at request) and the Relying Party (at assertion delivery) require that a TLS client certificate is presented. See Section [3.9](#metadata-rules-for-loa-4) below.


<a name="metadata"></a>
## 3. Metadata

This section describes rules for registration of SAML metadata and how the different elements shall be interpreted.

Relevant specifications:

- Section 2 of [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#metadata-and-trust-management)

- [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html)

- [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html)

<a name="registration-of-organization-information"></a>
### 3.1. Registration of Organization Information

All parties, that is, both Identity Providers and Relying Parties, shall include organization information in each registered metadata entry.

Such an element looks as follows:

```
<md:Organization>
  <md:Extensions>
    <mdorgext:OrganizationNumber xmlns:mdorgext="http://id.swedenconnect.se/authn/1.0/md-org-ext/ns">
      2021006883
    </mdorgext:OrganizationNumber>
  </md:Extensions>
  <md:OrganizationName xml:lang="sv">Myndigheten för digital förvaltning</md:OrganizationName>
  <md:OrganizationName xml:lang="en">Agency for digital government</md:OrganizationName>
  <md:OrganizationDisplayName xml:lang="sv">Myndigheten för digital förvaltning - Digg</md:OrganizationDisplayName>
  <md:OrganizationDisplayName xml:lang="en">Agency for digital government - Digg</md:OrganizationDisplayName>
  <md:OrganizationURL xml:lang="sv">https://www.digg.se/</md:OrganizationURL>
  <md:OrganizationURL xml:lang="en">https://www.digg.se/en</md:OrganizationURL>
</md:Organization>
```

*Example of how the organization Digg has registered organization information in metadata.*

**Note:** The extension representing the organization number is created by the Sweden Connect connection processes (if it is not set when the metadata is submitted). This element contains the organization number of the given organization, formatted as 10 digits without a hyphen.

For more information about the XML format of this element, see [OrganizationNumber-1.0.xsd](https://docs.swedenconnect.se/schemas/authn/1.0/OrganizationNumber-1.0.xsd).

In the aggregated metadata for the federation, the `OrganizationNumber` element is included for all parties.

**Rules and routines for metadata registration**:

- The name given in Swedish in the `OrganizationName` element shall match the name given when the organization signed the agreement with Digg regarding participation in the federation (except as stated in the item below).

    - In cases where a public sector party that has signed any kind of Sweden Connect agreement has requested that a third-party Identity Provider is registered in metadata under the party's agreement, `OrganizationName` does not need to state the registered name of the public sector party. The reason for this is that in many cases several public sector parties use the same third-party Identity Provider. However, the party shall notify Digg of the link between the party and the Identity Provider.

- If the `OrganizationNumber` element is given in the registered metadata, it is checked that this number matches the organization that has signed the agreement with Digg. If the element is missing in the submitted metadata, an element containing the organization number of the connecting party is created.<br /><br />The same exception as for the organization name regarding third-party Identity Providers also applies to the organization number.

<a name="registration-of-display-name-and-logotype"></a>
### 3.2. Registration of Display Name and Logotype

All parties, that is, both Identity Providers and Relying Parties, shall include the display name and logotype of the service in each registered metadata entry. The display name shall be given in Swedish and should also be given in English.

Note that the logotype should have a format and design that allows it to be used on most web pages. For example, it is not suitable to assume that the logotype will be displayed using a specific color scheme.

The logotype of a Relying Party will be displayed in the user interface of an Identity Provider, and the logotype of an Identity Provider may be displayed on "choose how to log in" pages of Relying Parties.

Example:

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

*Example of how Digg's service "Testa ditt eID" registers display information.*

**Rules and routines for metadata registration**:

- At registration, it is checked that the element is present in the metadata and that a logotype and display information in Swedish are included.

- The address of the logotype must be reachable.

- In addition, a visual inspection is made to ensure that the given information appears to match the party's organization.

<a name="registration-of-levels-of-assurance"></a>
### 3.3. Registration of Levels of Assurance

Identity Providers shall declare all supported levels of assurance, and variants thereof (see [1.2](#levels-of-assurance) above), in metadata. This is done using the "assurance certification" attribute.

Example:

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

*Metadata example for an Identity Provider that is approved to deliver assertions according to Level of Assurance 3 and 4.*

**Rules and routines for metadata registration**:

- Only Identity Providers that have been reviewed and approved according to Level of Assurance 3 or 4 may declare `http://id.elegnamnden.se/loa/1.0/loa3`.

- Only Identity Providers that have been reviewed and approved according to Level of Assurance 4 may declare `http://id.elegnamnden.se/loa/1.0/loa4`.

- Only Identity Providers that deliver according to the [Connection Agreement for Issuers of Employee eIDs - Prepaid Electronic Identification](https://www.digg.se/digitala-tjanster/e-legitimering/bli-godkand-utfardare-av-svensk-e-legitimation/leverera-e-tjanstelegitimationer) (Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald e-legitimering) and that have been reviewed and approved according to Level of Assurance 3 may declare `http://id.swedenconnect.se/loa/1.0/loa3-nonresident`.

- Only Identity Providers that deliver according to the [Connection Agreement for Issuers of Employee eIDs - Prepaid Electronic Identification](https://www.digg.se/digitala-tjanster/e-legitimering/bli-godkand-utfardare-av-svensk-e-legitimation/leverera-e-tjanstelegitimationer) and that have been reviewed and approved according to Level of Assurance 4 may declare `http://id.swedenconnect.se/loa/1.0/loa4-nonresident`.

- Only Identity Providers that deliver according to the [Connection Agreement for Issuers of Employee eIDs - Prepaid Electronic Identification](https://www.digg.se/digitala-tjanster/e-legitimering/bli-godkand-utfardare-av-svensk-e-legitimation/leverera-e-tjanstelegitimationer) and that have been reviewed and approved according to Level of Assurance 2 may declare `http://id.swedenconnect.se/loa/1.0/loa2-nonresident`.

- Only the Swedish eIDAS node may declare any of the following identifiers:
  - `http://id.elegnamnden.se/loa/1.0/eidas-low`, `http://id.elegnamnden.se/loa/1.0/eidas-nf-low`,
  - `http://id.elegnamnden.se/loa/1.0/eidas-sub`, `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub`,
  - `http://id.elegnamnden.se/loa/1.0/eidas-high`, `http://id.elegnamnden.se/loa/1.0/eidas-nf-high`.

- Third-party Identity Providers that declare `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` shall explain to the federation operator (Digg) how the authentication is performed. For example, "delivers a SAML IdP for BankID".

- The previously used identifier `http://id.elegnamnden.se/loa/1.0/loa3-sigmessage` must no longer be used.

<a name="registration-of-service-entity-category-values"></a>
### 3.4. Registration of Service Entity Category Values

An entity category is an attribute value that is declared in metadata to describe a certain property of a party within the federation. A "Service Entity Category" is used by both Relying Parties (SP) and Identity Providers (IdP) to declare which combinations of levels of assurance and attributes are supported or required.

See Section 2 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#definitions-for-service-entity-categories) for details.

The "Service Entity Category" type was originally introduced to make it possible to derive which Identity Providers within the federation could deliver assertions to a given Relying Party. The idea was to dynamically build a discovery page listing all Identity Providers offering authentication that the Relying Party can use. There is currently no central Discovery Service, and the main use of this type of entity category is for an Identity Provider to derive which attributes a given Relying Party requests at authentication.

A Relying Party may declare one or more "Service Entity Category" values in its metadata. Based on the declared values, an Identity Provider tries to derive which attributes shall be included in an issued assertion. This simple rule may, however, cause problems. SAML offers no standardized way for a Relying Party to dynamically (that is, per request) tell an Identity Provider which attributes are requested. The only available tool is the data declared in the Relying Party's metadata.

Suppose that a Relying Party wants the personal identity number and the organizational identity in assertions. It may then, for example, declare both `loa3-pnr` and `loa3-orgid` (see below) in its metadata. But what happens if it is in some cases interested in receiving the personal identity number, and in other cases the organizational identity, but not both attributes in the same assertion?

The solution in this case is that the organization creates two Relying Parties (SAML SPs) and declares `loa3-pnr` in the metadata for one SP and `loa3-orgid` in the metadata for the other. Depending on which type of assertion is wanted in each case, the correct SP is used.

> This is far from a perfect solution, but unfortunately a necessity. With the introduction of OpenID Connect this problem will disappear, since that technology is more dynamic and each individual request can contain information about the requested attributes.

Below follow descriptions and rules for both Identity Providers and Relying Parties for relevant "Service Entity Category" values defined in Section 2 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#definitions-for-service-entity-categories):

<a name="loa3-pnr"></a>
#### 3.4.1. loa3-pnr

**Definition**: Section 2.1.2 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-pnr).

A declaration of the entity category `http://id.elegnamnden.se/ec/1.0/loa3-pnr` means the following:

**For an Identity Provider**:

> The Identity Provider declares that it can authenticate users according to Level of Assurance 3<sup>\*</sup> and deliver assertions with attributes from the attribute set [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number).

**For a Relying Party**:

> The Relying Party declares that it will request authentication according to Level of Assurance 3<sup>\*</sup> and that it requests delivery of attributes according to the attribute set [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number).

\[*\]: Previously, the entity category `http://id.swedenconnect.se/ec/sc/uncertified-loa3-pnr` was used for delivery of the personal identity number after a "loa3-uncertified" authentication (see Section [1.2](#levels-of-assurance) above). In the latest version of the Technical Framework this category is deprecated, and the official "loa3-pnr" category also covers these cases.

**Rules and routines for metadata registration**:

- Only Identity Providers that declare `http://id.elegnamnden.se/loa/1.0/loa3` or `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` in the `assurance-certification` attribute (see Section [3.3](#registration-of-levels-of-assurance) above) may declare the entity category `loa3-pnr`.

- An Identity Provider that declares `loa3-pnr` shall also declare the category `loa3-name` (that is, attribute release with name only and no personal identity number or coordination number). See Section 2.4.2 of [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-name).
    
<a name="loa4-pnr"></a>
#### 3.4.2. loa4-pnr

**Definition**: Section 2.1.3 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-pnr).

A declaration of the entity category `http://id.elegnamnden.se/ec/1.0/loa4-pnr` means the following:

**For an Identity Provider**:

> The Identity Provider declares that it can authenticate users according to Level of Assurance 4 and deliver assertions with attributes from the attribute set [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number).

**For a Relying Party**:

> The Relying Party declares that it will request authentication according to Level of Assurance 4 and that it requests delivery of attributes according to the attribute set [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number).

**Rules and routines for metadata registration**:

- Only Identity Providers that declare `http://id.elegnamnden.se/loa/1.0/loa4` in the `assurance-certification` attribute (see Section [3.3](#registration-of-levels-of-assurance) above) may declare the entity category `loa4-pnr`.

- An Identity Provider that declares `loa4-pnr` shall also declare the category `loa4-name` (that is, attribute release with name only and no personal identity number or coordination number). See Section 2.4.3 of [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-name).

<a name="loa3-orgid"></a>
#### 3.4.3. loa3-orgid

**Definition**: Section 2.3.2 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-orgid).

A declaration of the entity category `http://id.swedenconnect.se/ec/1.0/loa3-orgid` means the following:

**For an Identity Provider**:

> The Identity Provider declares that it can authenticate users according to Level of Assurance 3<sup>\*</sup> and deliver assertions with attributes from the attribute set [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons).

**For a Relying Party**:

> The Relying Party declares that it will request authentication according to Level of Assurance 3<sup>\*</sup> and that it requests delivery of attributes according to the attribute set [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons).

\[*\]: This entity category applies to authentication according to `http://id.elegnamnden.se/loa/1.0/loa3`, `http://id.swedenconnect.se/loa/1.0/loa3-nonresident` or `http://id.swedenconnect.se/loa/1.0/uncertified-loa3`.

**Rules and routines for metadata registration**:

- Only Identity Providers that declare `http://id.elegnamnden.se/loa/1.0/loa3`, `http://id.swedenconnect.se/loa/1.0/loa3-nonresident` or `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` in the `assurance-certification` attribute (see Section [3.3](#registration-of-levels-of-assurance) above) may declare the entity category `loa3-orgid`.

- An Identity Provider that declares `loa3-orgid` shall also declare the category `loa3-name` (that is, release of given name and surname). See Section 2.4.2 of [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-name).

<a name="loa4-orgid"></a>
#### 3.4.4. loa4-orgid

**Definition**: Section 2.3.3 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-orgid).

A declaration of the entity category `http://id.swedenconnect.se/ec/1.0/loa4-orgid` means the following:

**For an Identity Provider**:

> The Identity Provider declares that it can authenticate users according to Level of Assurance 4 and deliver assertions with attributes from the attribute set [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons).

**For a Relying Party**:

> The Relying Party declares that it will request authentication according to Level of Assurance 4 and that it requests delivery of attributes according to the attribute set [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons).

**Rules and routines for metadata registration**:

- Only Identity Providers that declare `http://id.elegnamnden.se/loa/1.0/loa4` in the `assurance-certification` attribute (see Section [3.3](#registration-of-levels-of-assurance) above) may declare the entity category `loa4-orgid`.

- An Identity Provider that declares `loa4-orgid` shall also declare the category `loa4-name` (that is, release of given name and surname). See Section 2.4.3 of [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-name).

<a name="loa3-name"></a>
#### 3.4.5. loa3-name

**Definition**: Section 2.4.2 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa3-name).

The entity category `http://id.swedenconnect.se/ec/1.0/loa3-name` is mainly intended to complement `http://id.swedenconnect.se/ec/1.0/loa3-orgid` (see Section [3.4.3](#loa3-orgid) above) with the possibility to also receive the given name and surname of the authenticated user. In these cases, a Relying Party declares both `loa3-orgid` and `loa3-name`.

A declaration of the entity category means the following:

**For an Identity Provider**:

> The Identity Provider declares that it can authenticate users according to Level of Assurance 3<sup>\*</sup> and deliver assertions with attributes from the attribute set [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number).

**For a Relying Party**:

> The Relying Party declares that it will request authentication according to Level of Assurance 3<sup>\*</sup> and that it requests delivery of attributes according to the attribute set [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number).

\[*\]: This entity category applies to authentication according to `http://id.elegnamnden.se/loa/1.0/loa3`, `http://id.swedenconnect.se/loa/1.0/loa3-nonresident` or `http://id.swedenconnect.se/loa/1.0/uncertified-loa3`.

**Rules and routines for metadata registration**:

- Only Identity Providers that declare `http://id.elegnamnden.se/loa/1.0/loa3`, `http://id.swedenconnect.se/loa/1.0/loa3-nonresident` or `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` in the `assurance-certification` attribute (see Section [3.3](#registration-of-levels-of-assurance) above) may declare the entity category `loa3-name`.

- An Identity Provider that declares `loa3-pnr` (see [3.4.1](#loa3-pnr) above) or `loa3-orgid` (see [3.4.3](#loa3-orgid) above) must also declare `loa3-name`.

<a name="loa4-name"></a>
#### 3.4.6. loa4-name

**Definition**: Section 2.4.3 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#loa4-name).

The entity category `http://id.swedenconnect.se/ec/1.0/loa4-name` is mainly intended to complement `http://id.swedenconnect.se/ec/1.0/loa4-orgid` (see Section [3.4.4](#loa4-orgid) above) with the possibility to also receive the given name and surname of the authenticated user. In these cases, a Relying Party declares both `loa4-orgid` and `loa4-name`.

A declaration of the entity category means the following:

**For an Identity Provider**:

> The Identity Provider declares that it can authenticate users according to Level of Assurance 4<sup>\*</sup> and deliver assertions with attributes from the attribute set [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number).

**For a Relying Party**:

> The Relying Party declares that it will request authentication according to Level of Assurance 4<sup>\*</sup> and that it requests delivery of attributes according to the attribute set [Natural Personal Identity without Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-without-civic-registration-number).

\[*\]: This entity category applies to authentication according to `http://id.elegnamnden.se/loa/1.0/loa4` and `http://id.swedenconnect.se/loa/1.0/loa4-nonresident`.

**Rules and routines for metadata registration**:

- Only Identity Providers that declare `http://id.elegnamnden.se/loa/1.0/loa4` or `http://id.swedenconnect.se/loa/1.0/loa4-nonresident` in the `assurance-certification` attribute (see Section [3.3](#registration-of-levels-of-assurance) above) may declare the entity category `loa4-name`.

- An Identity Provider that declares `loa4-pnr` (see [3.4.2](#loa4-pnr) above) or `loa4-orgid` (see [3.4.4](#loa4-orgid) above) must also declare `loa4-name`.

<a name="eidas-naturalperson"></a>
#### 3.4.7. eidas-naturalperson

**Definition**: Section 2.1.1 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#eidas-naturalperson).

A declaration of the entity category `http://id.elegnamnden.se/ec/1.0/eidas-naturalperson` means the following:

**For an Identity Provider**:

> The Identity Provider declares that it is an eIDAS node acting as "Identity Provider" towards the Sweden Connect federation and as "Service Provider" towards the eIDAS federation<sup>*</sup>. Users are authenticated according to any of the defined levels of assurance for eIDAS (see Section 3.1.1 of [Sweden Connect – Registry for Identifiers](https://docs.swedenconnect.se/technical-framework/latest/03_-_Registry_for_Identifiers.html#authentication-context-uris)), and the attributes included in issued assertions follow the attribute set [eIDAS Natural Person Attribute Set](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#eidas-natural-person-attribute-set).

**For a Relying Party**:

> The Relying Party declares that it will request eIDAS authentication and that it requests delivery of attributes according to the attribute set [eIDAS Natural Person Attribute Set](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#eidas-natural-person-attribute-set).

\[*\]: In principle, only the official Swedish eIDAS node shall declare this category among Identity Providers, but there are cases where providers offer a Proxy-IdP that includes eIDAS authentication as one authentication option. The Proxy-IdP then acts as a Relying Party towards the official eIDAS node and as an IdP towards its Relying Parties. These Proxy-IdPs are also allowed to declare this category.

<a name="eidas-pnr-delivery"></a>
#### 3.4.8. eidas-pnr-delivery

**Definition**: Section 2.1.4 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#eidas-pnr-delivery).

A special category that is only used by the Identity Providers that deliver assertions to the Swedish eIDAS node (connector), and by the official eIDAS proxy service that acts as a Relying Party towards Sweden Connect. See Section [2.3.1](#delivery-of-assertions-to-the-swedish-eidas-node).

**Rules and routines for metadata registration**:

- Only the Identity Providers that have an agreement with Digg to deliver assertions to the Swedish eIDAS Proxy Service node shall declare the category.

<a name="registration-of-relying-party-type"></a>
### 3.5. Registration of Relying Party Type - Service Type Category

An entity category is an attribute value that is declared in metadata to describe a certain property of a party within the federation. A "Service Type Category" is declared by Relying Parties to indicate that the party is of a certain "type".

Below follow descriptions and rules for Relying Parties for relevant "Service Type Category" values defined in Section 4 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#definitions-for-service-type-entity-categories):

<a name="sigservice"></a>
#### 3.5.1. Signature Service Indicator

**Definition**: Section 4.1 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#sigservice).

A declaration of the entity category `http://id.elegnamnden.se/st/1.0/sigservice` means that the Relying Party indicates that it is a signature service.

**Rules and routines for metadata registration**:

- The registering organization shall explicitly notify the federation operator (Digg) that the service is a signature service.

<a name="public-or-private-sector-indicator"></a>
#### 3.5.2. Public or Private Sector Indicator

**Definition**: Sections 4.2 and 4.3 of the specification [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#definitions-for-service-type-entity-categories).

Public sector Relying Parties within Sweden Connect must declare the category `http://id.elegnamnden.se/st/1.0/public-sector-sp`, and Relying Parties from the private sector must declare `http://id.elegnamnden.se/st/1.0/private-sector-sp`.

**Rules and routines for metadata registration**:

- At metadata registration, it is checked that either `public-sector-sp` or `private-sector-sp` is declared, and that this declaration matches the agreement signed by the party.

<a name="registration-of-signed-agreements"></a>
### 3.6. Registration of Signed Agreements

Participation in the Sweden Connect federation is governed by agreements, for both Relying Parties and Identity Providers. For an Identity Provider to accept an authentication request from a Relying Party, it must be able to determine whether the Relying Party has the right to use the service. This is achieved by Relying Parties declaring "Service Contract Category" values that indicate which agreements apply to the party. See Section 5 of [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#service-contract-categories).

Below follow the identifiers that map to the agreements listed in Section [1.1](#agreements).

<a name="sweden-connect-agreement"></a>
#### 3.6.1. Sweden Connect Agreement

**Identifier**: `http://id.swedenconnect.se/contract/sc/sweden-connect`

Indicates that the organization of the Relying Party has signed one of Digg's connection agreements.

Note: For an Identity Provider that only consumes metadata from the Sweden Connect federation, this category means practically nothing, since it only marks "participant in the Sweden Connect federation". For Identity Providers that consume metadata from several different federations, it may however be significant.

**Rules and routines for metadata registration**:

- At metadata registration, it is checked that the organization has signed a connection agreement.

<a name="other-contracts"></a>
#### 3.6.2. Bilateral Agreements

For Relying Parties that sign agreements directly with providers, for example a provider of a SAML IdP for BankID, the provider shall define an identifier according to the format described in Section 5 of [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#service-contract-categories). This identifier shall then be declared by both the Relying Party and the Identity Provider.

**Rules and routines for metadata registration**:

- No check is performed. These agreements are outside the responsibility of the federation operator (Digg).

<a name="eid-for-medarbetare2"></a>
#### 3.6.3. eID for Employees (eID för medarbetare)

**Identifier**: `http://id.swedenconnect.se/contract/sc/prepaid-auth-2021`

Shall be declared by Relying Parties that have signed the [Relying Party Agreement - Prepaid Electronic Identification](#eid-for-medarbetare) (Förlitandeavtal - Förbetald e-legitimering), and by Identity Providers that deliver according to the [Connection Agreement for Issuers of Employee eIDs - Prepaid Electronic Identification](#eid-for-medarbetare) (Anslutningsavtal för utfärdare av e-tjänstelegitimationer - Förbetald e-legitimering).

**Rules and routines for metadata registration**:

- At metadata registration, a check is made against the agreements signed by the organization.

<a name="eid-authorization-system"></a>
#### 3.6.4. Authorization System for Electronic Identification (Auktorisationssystem för elektronisk identifiering)

**Identifier**: `http://id.swedenconnect.se/contract/sc/eid-authorization-system`

Shall be declared by Relying Parties that have joined the [Authorization System for Electronic Identification](#auktorisationssystem-for-elektronisk-identifiering), and by Identity Providers that deliver according to this agreement.

**Rules and routines for metadata registration**:

- At metadata registration, a check is made against the agreements signed by the organization.

<a name="metadata-rules-for-organizational-identities"></a>
### 3.7. Metadata Rules for Organizational Identities

Identity Providers that deliver according to the agreements for [eID for Employees](#eid-for-medarbetare) (eID för medarbetare) and support delivery of assertions according to the attribute set [Organizational Identity for Natural Persons](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#organizational-identity-for-natural-persons) must notify the federation operator (Digg) of which organizations are handled by the Identity Provider.

This information will be published in the SAML metadata of the Identity Provider as described in Section 2.1.3.1 of [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).

> Note: This information shall be kept up to date continuously, which means that the Identity Provider is responsible for notifying the federation operator (Digg) of connecting organizations in good time and requesting a metadata update.

Below is an example of the `Scope` elements included in the metadata of an Identity Provider that is approved to deliver to the organizations Digg (202100-6883), Försäkringskassan (202100‑5521) and Pensionsmyndigheten (202100-6255).

```
<md:IDPSSODescriptor ...>
  <md:Extensions>
    <shibmd:Scope xmlns:shibmd="urn:mace:shibboleth:metadata:1.0>2021006883</shibmd:Scope>
    <shibmd:Scope xmlns:shibmd="urn:mace:shibboleth:metadata:1.0>2021005521</shibmd:Scope>
    <shibmd:Scope xmlns:shibmd="urn:mace:shibboleth:metadata:1.0>2021006255</shibmd:Scope>
    ...
```

*Note that the organization number shall be represented without a hyphen in the metadata file.*

A Relying Party that consumes organizational identities (the `orgAffliation` attribute) is expected to verify the content of the attribute against the metadata entry of the issuing Identity Provider according to Section 6.2.1 of [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#attribute-release-and-consuming-rules).

**Rules and routines for metadata registration**:

- The federation operator (Digg) checks that the notified list of connected organizations matches the content of the metadata (that is, verifies that the `Scope` elements are correct).

<a name="metadata-rules-for-coordination-numbers"></a>
### 3.8. Metadata Rules for Coordination Numbers

An Identity Provider that delivers according to the attribute set [Natural Personal Identity with Civic Registration Number](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html#natural-personal-identity-with-civic-registration-number) delivers the individual's personal identity number **or** coordination number in the `personalIdentityNumber` attribute.

Previously, Digg did not approve the use of coordination numbers in assertions, which means that some Relying Parties that only expect a personal identity number in the `personalIdentityNumber` attribute may have problems processing the assertion.

Therefore, an "opt-in" from the Relying Party is required before the Identity Provider may deliver a coordination number to that Relying Party. This is described in Section 6.2 of [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html#accepts-coordination-number).

Example of metadata for a SAML SP that accepts delivery of coordination numbers:

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

By declaring the entity category `http://id.swedenconnect.se/general-ec/1.0/accepts-coordination-number`, the SAML SP informs Identity Providers that the Relying Party allows delivery of coordination numbers in the `personalIdentityNumber` attribute.

An Identity Provider must **not** deliver an assertion containing a coordination number to a Relying Party that has not declared the above. In these cases, the Identity Provider shall instead inform the user that a personal identity number is required to authenticate, and not issue an assertion.

<a name="metadata-rules-for-loa-4"></a>
### 3.9. Metadata Rules for Level of Assurance 4 (LoA 4)

For authentication and delivery of assertions according to Level of Assurance 4, the Sweden Connect federation recommends that the SAML profile [SAML V2.0 Holder-of-key Web Browser SSO Profile](https://docs.oasis-open.org/security/saml/Post2.0/sstc-saml-holder-of-key-browser-sso.pdf) is used. The use of "Holder-of-key" according to the Sweden Connect Technical Framework is specified in [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).

> Note that Identity Providers that do not deliver according to Level of Assurance 4 may also choose to offer support for "Holder-of-key".

The following metadata rules apply to Holder-of-key:

An Identity Provider that offers "Holder-of-key" support shall declare dedicated `SingleSignOnService` elements for "Holder-of-key" in its metadata entry according to Section 2.1.3.2 of [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#idp-holder-of-key-support). The addresses given in these elements must be configured for mutual TLS, that is, TLS where a client certificate is required.

A Relying Party that wants to use "Holder-of-key" at authentication shall declare an `AssertionConsumerService` element for "Holder-of-key" according to Section 2.1.2.1 of [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html#sp-holder-of-key-support). The address given in this element must be configured for mutual TLS, that is, TLS where a client certificate is required.

  
<a name="document-history"></a>
## 4. Document History

- 2026-10-19: First English version, translated from "Tekniska anslutningsregler för Sweden Connects SAML-federation" of the same date.
