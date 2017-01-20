<img src="img/eln-logo.png"></img>

# Certificate profile for certificates issued by Central Signing services

### Version 1.0 - 2013-10-30

*ELN-0608-v1.0*

---

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirement key words](#requirement-key-words)

    1.2. [XML name space references](#xml-name-space-references)

    1.3. [Structure](#structure)

2. [**Certificate Profile**](#certificate-profile)

    2.1. [Standards](#standards)

    2.2. [Qualified and PKC Certificates](#qualified-and-pkc-certificates)

    2.3. [Certificate content](#certificate-content)

    2.3.1. [Subject attributes and name forms](#subject-attributes-and-name-forms)

    2.3.2. [Authentication Context and Attribute mapping](#authentication-context-and-attribute-mapping)

3. [**Normative References**](#normative-references)

<a name="introduction"></a>
## 1. Introduction

This document specifies a certificate profile for certificates issued by
a signature service within the infrastructure for “Svensk
E-legitimation”.

<a name="requirement-key-words"></a>
### 1.1. Requirement key words

The key words **MUST**, **MUST** **NOT**, **REQUIRED**, **SHALL**,
**SHALL** **NOT**, **SHOULD**, **SHOULD** **NOT**, **RECOMMENDED**,
**MAY**, and **OPTIONAL** are to be interpreted as described in
\[[RFC2119](#rfc2119)\].

These keywords are capitalized when used to unambiguously specify
requirements over protocol features and behavior that affect the
interoperability and security of implementations. When these words are
not capitalized, they are meant in their natural-language sense.

<a name="xml-name-space-references"></a>
### 1.2. XML name space references

The prefix **saci:** stands for the SAML Authentication Context
Information XML Schema namespace
(`http://id.elegnamnden.se/auth-cont/1.0/saci`).

<a name="structure"></a>
### 1.3. Structure

This specification uses the following typographical conventions in text:
`<Eid2Element>`, `<ns:ForeignElement>`, `Attribute`, **Datatype**,
`OtherCode`.

<a name="certificate-profile"></a>
## 2. Certificate Profile

<a name="standards"></a>
### 2.1. Standards

The following standards provides normative requirements for this
certificate profile:

Standard | Function | Referens
--- | --- | ---
RFC 5280 | Main certificate standard | \[[RFC5280](#rfc5280)\]
RFC 3739 | Main certificate profile for Qualified Certificates | \[[RFC3739](#rfc3739)\]
EN 319 412-5 | EU profile of RFC 3739 providing defined data structures for issuing Qualified Certificate in accordance with the EU electronic signature directive \[EUSig\]. | \[[EU-QC](#eu-qc)\]
TS 102 280 | EU interoperability profile for certificates issued to Natural Persons. | \[[EU-INTEROP](#eu-interop)\]

<a name="qualified-and-pkc-certificates"></a>
### 2.2. Qualified and PKC Certificates

This profile supports both Qualified Certificates as well as
certificates that are not Qualified Certificates, here named PKC
certificates (Public Key Certificates).

The same profile requirements apply for both Qualified Certificates and
for PKC certificates unless a requirement is explicitly related to only
Qualified Certificates.

<a name="certificate-content"></a>
### 2.3. Certificate content

All certificates SHALL be fully compliant with  \[[RFC5280](#rfc5280)\], \[[RFC3739](#rfc3739)\]
and \[[EU-INTEROP](#eu-interop)\]. All Qualified Certificates SHALL also be fully
compliant with \[[EU-QC](#eu-qc)\].

Qualified Certificates SHALL implement the “Statement regarding location
of Policy Disclosure Statements” (PDS) as specified in section 5.2.4 of
\[[EU-QC](#eu-qc)\].

<a name="subject-attributes-and-name-forms"></a>
#### 2.3.1. Subject attributes and name forms

Subject name attributes and other name forms in the certificate SHALL
comply with \[[RFC3739](#rfc3739)\].

The following specific certificate subject name conventions SHALL be
met:

Subject data | Requirement
--- | ---
Swedish “personnummer” | Swedish “personnummer” obtained from a SAML assertion using the attribute with OID 1.2.752.29.4.13, SHALL be stored in a serialNumber attribute (OID 2.5.4.5) in the subject field. The data SHALL be composed according to \[[SKV704](#skv704)\]
Swedish “samordningsnummer” | Swedish “samordningsnummer” obtained from a SAML assertion using the attribute with OID 1.2.752.29.4.13, SHALL be stored in a serialNumber attribute (OID 2.5.4.5) in the subject field. The data SHALL be composed according to \[[SKV707](#skv707)\].
E-mail address | E-mail address, when present, SHALL be stored in a Subject Alternative Name extension as an rfc822Name.

<a name="authentication-context-and-attribute-mapping"></a>
#### 2.3.2. Authentication Context and Attribute mapping

Certificates MUST include an `AuthContextExtension` according to
\[[AuthCont](#authcont)\]. This extension SHALL include one SAML Authentication
Context Information element identified by the XML schema name space
identifier:

> `http://id.elegnamnden.se/auth-cont/1.0/saci`

The `<saci:SAMLAuthContext>` element SHALL contain both an
`<saci:AuthContextInfo>` element as well as an
`<saci:IdAttributes>` element.

The `<saci:IdAttributes>` element SHALL contain one
`<saci:AttributeMapping>` element for each subject attribute or
other name form that was obtained from a SAML attribute in the SAML
assertion used to authenticate the signer as part of the signature
creation process. Each `<saci:AttributeMapping>` element SHALL
provide the `<saml:AttributeValue>` that were obtained from the SAML
assertion.

<a name="normative-references"></a>
## 3. Normative References

<a name="rfc2119"></a>**[RFC2119]**

> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997.](http://www.ietf.org/rfc/rfc2119.txt)

<a name="rfc3739"></a>**[RFC3739]**

> Santesson, S., Nystrom, M., and T. Polk, "Internet X.509 Public Key
> Infrastructure: Qualified Certificates Profile", RFC\\03739, March
> 2004.

<a name="rfc5280"></a>**[RFC5280]**

> Cooper, D., Santesson, S., Farrell, S., Boeyen, S., Housley, R., and
> W. Polk, "Internet X.509 Public Key Infrastructure Certificate and
> Certificate Revocation List (CRL) Profile", RFC\\05280, May 2008.

<a name="eu-qc"></a>**[EU-QC]**

> “Electronic Signatures and Infrastructures (ESI); Profiles for Trust
> Service Providers issuing certificates; Part 5: Extension for
> Qualified Certificate profile”, ETSI TS 319 412-5 V1.1.1, Jan 2013.

<a name="eu-interop"></a>**[EU-INTEROP]**

> “X.509 V.3 Certificate Profile for Certificates Issued to Natural
> Persons”, ETSI TS 102 280 V1.1.1, March 2004.

<a name="authcont"></a>**[AuthCont]**

> Authentication Context Certificate Extension
> (<http://tools.ietf.org/html/draft-santesson-auth-context-extension>)

<a name="skv704"></a>**[SKV704]**

> [Skatteverket, SKV 704 utgåva 8, Personnummer, September
> 2007.](http://www.skatteverket.se/download/18.1e6d5f87115319ffba380001857/70408.pdf)

<a name="skv707"></a>**[SKV707]**

> [Skatteverket, SKV 707 utgåva 2, Samordningsnummer, October
> 2006.](http://www.skatteverket.se/download/18.3dfca4f410f4fc63c86800016382/70702.pdf)
