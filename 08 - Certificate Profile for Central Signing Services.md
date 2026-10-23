<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Certificate Profile for Certificates Issued by Central Signing Services

### Version 1.3 – 2026-10-21

Registration number: **2019-313** (*previously: ELN-0608*)

---

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirement key words](#requirement-key-words)

    1.2. [XML namespace references](#xml-namespace-references)

    1.3. [Structure](#structure)

2. [**Certificate Profile**](#certificate-profile)

    2.1. [Standards](#standards)

    2.2. [Qualified and PKC Certificates](#qualified-and-pkc-certificates)

    2.3. [Certificate Content](#certificate-content)

    2.3.1. [Subject Attributes and Name Forms](#subject-attributes-and-name-forms)

    2.3.1.1. [Person Identifier Attributes](#person-identifier-attributes)

    2.3.1.2. [Other Attribute Requirements](#other-attribute-requirements)

    2.3.2. [Authentication Context and Attribute Mapping](#authentication-context-and-attribute-mapping)

    2.3.2.1. [SAML Authentication Context Information](#saml-authentication-context-information)

    2.3.2.2. [OpenID Connect Authentication Context Information](#openid-connect-authentication-context-information)

    2.3.3. [Certificate Policy](#certificate-policy)

    2.4. [Revocation and Expiration](#revocation-and-expiration)

3. [**Normative References**](#normative-references)

4. [**Changes between versions**](#changes-between-versions)

---

<a name="introduction"></a>
## 1. Introduction

This document specifies a certificate profile for certificates issued by a signature service based on the OASIS DSS protocol \[[DSS](#dss)\], enhanced by the DSS Extension for Federated Central Signing Services \[[DSS-Ext](#dss-ext)\].

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

<a name="xml-namespace-references"></a>
### 1.2. XML namespace references

The prefix **saci:** stands for the SAML Authentication Context Information XML Schema 
namespace, `http://id.elegnamnden.se/auth-cont/1.0/saci`.

> Schema location URL: https://docs.swedenconnect.se/schemas/cert-schemas/1.0/CertAuthContextExtension-SAML-1.0.xsd

The prefix **sacex:** stands for the Extended Authentication Information XML Schema
namespace, `http://id.swedenconnect.se/auth-cont/1.0/ext-auth-info`.

> Schema location URL: https://docs.swedenconnect.se/schemas/cert-schemas/1.0/CertAuthContextExtension-ExtAuthInfo-1.0.xsd

The OpenID Connect Authentication Context Information (section [2.3.2.2](#openid-connect-authentication-context-information)) is expressed in JSON and does not use an XML namespace.

<a name="structure"></a>
### 1.3. Structure

This specification uses the following typographical conventions in text:
`<Eid2Element>`, `<ns:ForeignElement>`, `Attribute`, **Datatype**,
`OtherCode`.

<a name="certificate-profile"></a>
## 2. Certificate Profile

<a name="standards"></a>
### 2.1. Standards

The following standards provide normative requirements for this certificate profile:

Standard | Function | Reference
--- | --- | ---
RFC 5280 | Main certificate standard | \[[RFC5280](#rfc5280)\]
RFC 3739 | Qualified Certificates profile and the QCStatements extension | \[[RFC3739](#rfc3739)\]
RFC 7773 | Authentication context extension | \[[RFC7773](#rfc7773)\]
draft-santesson-oidc-<br/>cert-auth-context | Authentication context extension, context type for OpenID Connect | \[[OIDC.Authn.Context](#oidc-authn-context)\]
RFC 9608 | No Revocation Available extension | \[[RFC9608](#rfc9608)\]
EN 319 411-1 | Policy requirements for PKC certificates | \[[EU-POL-NCP](#eu-pol-ncp)\]
EN 319 411-2 | Policy requirements for Qualified certificates | \[[EU-POL-QC](#eu-pol-qc)\]
EN 319 412-1 | Definitions of semantics identifiers and formatting rules for identity data | \[[EU-CERT-GEN](#eu-cert-gen)\]
EN 319 412-2 | Certificate profile for certificates issued to natural persons | \[[EU-CERT-NP](#eu-cert-np)\]
EN 319 412-5 | Declaration of qualified certificate properties | \[[EU-CERT-QC](#eu-cert-qc)\]


<a name="qualified-and-pkc-certificates"></a>
### 2.2. Qualified and PKC Certificates

This profile supports both Qualified Certificates, profiled in \[[RFC3739](#rfc3739)\] and \[[EU-CERT-QC](#eu-cert-qc)\], and certificates that are not Qualified Certificates, here named PKC certificates (Public Key Certificates).

All profile requirements apply to both Qualified Certificates and to PKC certificates unless it is explicitly stated that a particular requirement applies only to PKC or Qualified Certificates.

<a name="certificate-content"></a>
### 2.3. Certificate Content

All certificates SHALL be fully compliant with \[[RFC5280](#rfc5280)\] and \[[EU-CERT-NP](#eu-cert-np)\]. All Qualified Certificates SHALL also include the QCStatements extension defined in \[[RFC3739](#rfc3739)\], carrying the mandatory QC statements defined in \[[EU-CERT-QC](#eu-cert-qc)\].

<a name="subject-attributes-and-name-forms"></a>
#### 2.3.1. Subject Attributes and Name Forms

<a name="person-identifier-attributes"></a>
##### 2.3.1.1. Person Identifier Attributes

<a name="data-source"></a>
###### 2.3.1.1.1. Data Source

All certificates SHALL contain a unique person identifier, carried in the `serialNumber` attribute (OID 2.5.4.5) in the subject field. The person identifier SHALL be obtained from the Identity Provider in the form of a SAML attribute, or from the OpenID Provider in the form of an OpenID Connect claim, depending on the protocol used to authenticate the signer. The SAML attribute or OpenID Connect claim SHOULD be one of those listed below.

| Identifier | SAML attribute | OpenID Connect claim | Specification |
| :--- | :--- | :--- | :--- |
| Swedish Personal Identity Number (personnummer) \[[SKV704](#skv704)\] | urn:oid:1.2.752.29.4.13 | `https://id.oidc.se/`<br/>`claim/personalIdentityNumber` | \[[AttrSpec](#attrspec)\], \[[OIDC.Sweden.Claims](#oidc-sweden-claims)\] |
| Swedish Coordination Number (samordningsnummer) \[[SKV707](#skv707)\] | urn:oid:1.2.752.29.4.13 | `https://id.oidc.se/`<br/>`claim/coordinationNumber` | \[[AttrSpec](#attrspec)\], \[[OIDC.Sweden.Claims](#oidc-sweden-claims)\] |
| Provisional ID | urn:oid:1.2.752.201.3.4 | `https://id.swedenconnect.se/`<br/>`claim/prid` | \[[AttrSpec](#attrspec)\], \[[OIDC.Claims](#oidc-claims)\] |
| eIDAS Person Identifier | urn:oid:1.2.752.201.3.7 | `http://eidas.europa.eu/attributes/`<br/>`naturalperson/PersonIdentifier` | \[[AttrSpec](#attrspec)\], \[[OIDC.Claims](#oidc-claims)\]

In SAML, personal identity numbers and coordination numbers are carried in the same attribute and are distinguished by their format, see \[[SKV704](#skv704)\] and \[[SKV707](#skv707)\]. In OpenID Connect they are carried in separate claims. 

<a name="data-format"></a>
###### 2.3.1.1.2. Data Format

The identifier obtained from the SAML attribute or the OpenID Connect claim SHALL be stored in the `serialNumber` attribute using one of the following formats:

- exactly the same format as it was obtained from the SAML attribute or claim, or
- the conventions specified in \[[EU-CERT-GEN](#eu-cert-gen)\], as defined below.

When a person identifier is stored in the `serialNumber` attribute in accordance with \[[EU-CERT-GEN](#eu-cert-gen)\], the certificate SHALL include a semantics identifier as specified in section 5.1 of \[[EU-CERT-GEN](#eu-cert-gen)\].

**Swedish Personal Identity Number (personnummer) and Coordination Number (samordningsnummer)**

When the identifier is a Swedish personal identity number (personnummer) \[[SKV704](#skv704)\], the semantics identifier SHALL be a natural person semantics identifier using the identity type reference "PNO".

> Example: PNOSE-194911172296

When the identifier is a Swedish coordination number (samordningsnummer) \[[SKV707](#skv707)\], the semantics identifier SHALL be a natural person semantics identifier using a local national identity type reference "CN:SE".

> Example: CN:SE-194911772293

**Provisional ID**

When the identifier is a provisional ID the semantics identifier SHALL be a natural person semantics identifier using a local national identity type reference "PI:SE".

> Example: PI:SE-NO:16043700158

This identifier illustrates that the identifier is a Provisional ID (PI) as defined in Sweden (SE) followed by a hyphen (-) and the actual provisional ID for a person from Norway (NO:16043700158).

When the identity type reference is "PI:SE" or "CN:SE", the `nameRegistrationAuthorities` element of `SemanticsInformation` SHALL be present and SHALL contain a `GeneralName` of type `uniformResourceIdentifier` with one of the following values:

> `http://id.elegnamnden.se/eln/name-registration-authority` (Deprecated)

> `https://id.swedenconnect.se/cert/name-registration-authority`

The deprecated identifier under elegnamnden.se SHALL not be used in new certificates.

**eIDAS Person Identifier**

An eIDAS person identifier MAY be stored in the `serialNumber` attribute in exactly the same format as received in the SAML attribute or claim listed above, accompanied by a semantics identifier according to \[[EU-CERT-GEN](#eu-cert-gen)\] identified by the OID `0.4.0.194121.1.3`.

**Note:** A new version of the \[[EU-CERT-GEN](#eu-cert-gen)\] is processed for approval at the time of publication of this document. The new version will specify a semantics identifier for storing eIDAS person identifier attributes using the semantics identifier OID `0.4.0.194121.1.3`. This semantics identifier (`id-etsi-qcs-semanticsId-eIDASNatural`) is not yet present in the latest published version of the standard.

<a name="other-attribute-requirements"></a>
##### 2.3.1.2. Other Attribute Requirements

An e-mail address, when present, SHALL be stored in a Subject Alternative Name extension as an rfc822Name.

<a name="authentication-context-and-attribute-mapping"></a>
#### 2.3.2. Authentication Context and Attribute Mapping

Certificates MUST include an Authentication Context extension according to \[[RFC7773](#rfc7773)\]. The extension SHALL NOT be marked critical.

The extension SHALL include exactly one `AuthenticationContext` entry. The context type of the entry depends on the protocol that was used to authenticate the signer as part of the signature creation process:

| Authentication protocol | Context type | contextType identifier | Requirements |
| :--- | :--- | :--- | :--- |
| SAML – the signer was authenticated by means of a SAML assertion from an Identity Provider | SAML Authentication Context Information (SACI) | `http://id.elegnamnden.se/`<br>`auth-cont/1.0/saci` | Section [2.3.2.1](#saml-authentication-context-information) |
| OpenID Connect – the signer was authenticated by means of an ID Token from an OpenID Provider | OpenID Connect Authentication Context Information (OACI) | `urn:ietf:params:`<br/>`x509-auth-context:oidc` | Section [2.3.2.2](#openid-connect-authentication-context-information) |

Both context types record the authentication event and map the identity data obtained from the authentication to the subject attributes and name forms of the certificate.

<a name="saml-authentication-context-information"></a>
##### 2.3.2.1. SAML Authentication Context Information

An `AuthenticationContext` entry of the SACI context type SHALL contain a `<saci:SAMLAuthContext>` element as specified in section 3 of \[[RFC7773](#rfc7773)\].

The `<saci:SAMLAuthContext>` element SHALL contain both an `<saci:AuthContextInfo>` element as well as an `<saci:IdAttributes>` element.

The `<saci:IdAttributes>` element SHALL contain one `<saci:AttributeMapping>` element for each subject attribute or other name form that was obtained from a SAML attribute in the SAML assertion used to authenticate the signer as part of the signature creation process. Each `<saci:AttributeMapping>` element SHALL identify the SAML attribute by its `Name` attribute, and MAY include the `<saml:AttributeValue>` element(s) that were obtained from the SAML assertion.

<a name="extended-authentication-information"></a>
###### 2.3.2.1.1. Extended Authentication Information

In addition to the attributes of `<saci:AuthContextInfo>`, additional authentication information can be provided through the extensibility of the `<saci:AuthContextInfo>` element, which allows a sequence of any elements to be included.

One such element is defined in this section, the `<sacex:ExtAuthInfo>` element.

This element MAY be included to provide the name of a parameter and its associated value.

This element MAY be used to carry the value of any single valued attribute from the associated SAML assertion as long as the SAML attribute value is not composed of a complex type. When used to carry a SAML attribute value, the value of the `<sacex:ExtAuthInfo>` element SHALL be identical to the content of the SAML attribute value element and the `Name` attribute SHALL hold the same value as the `Name` attribute of the corresponding SAML attribute.

The `<sacex:ExtAuthInfo>` element is defined by the following XML Schema:

```
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
    targetNamespace="http://id.swedenconnect.se/auth-cont/1.0/ext-auth-info"
    xmlns:sacex="http://id.swedenconnect.se/auth-cont/1.0/ext-auth-info">
    
  <xs:element name="ExtAuthInfo" type="sacex:ExtAuthInfoType" />

  <xs:complexType name="ExtAuthInfoType">
    <xs:simpleContent>
      <xs:extension base="xs:string">
        <xs:attribute name="Name" type="xs:string" use="required" />
        <xs:anyAttribute namespace="##any" processContents="lax" />
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>
</xs:schema>
```

**Example:**

The following example illustrates inclusion of the content of a transaction identifier SAML attribute as extended authentication information.

```
<saci:SAMLAuthContext
    xmlns:saci="http://id.elegnamnden.se/auth-cont/1.0/saci"
    xmlns:sacex="http://id.swedenconnect.se/auth-cont/1.0/ext-auth-info">
  <saci:AuthContextInfo IdentityProvider="http://eid.example.com/idp"
      AuthenticationInstant="2020-01-10T17:02:46.000Z"
      AuthnContextClassRef="http://id.elegnamnden.se/loa/1.0/loa3"
      AssertionRef="_936e075dc2725b016de57b9a0624c766">
    <sacex:ExtAuthInfo Name="urn:oid:1.2.752.201.3.2">dc6ac7656H89bfb51</sacex:ExtAuthInfo>
  </saci:AuthContextInfo>
  <saci:IdAttributes>...</saci:IdAttributes>
</saci:SAMLAuthContext>
```

<a name="openid-connect-authentication-context-information"></a>
##### 2.3.2.2. OpenID Connect Authentication Context Information

An `AuthenticationContext` entry of the OACI context type SHALL contain a JSON object as specified in \[[OIDC.Authn.Context](#oidc-authn-context)\]. The terms ID Token, UserInfo Response, Claim, Subject Identifier, OpenID Provider and Relying Party are used as defined in \[[OpenID.Core](#openid-core)\].

The OACI object SHALL contain the members `iss`, `auth_time`, `acr`, `client_id` and `claim_mappings`.

The OACI object MUST contain information that uniquely identifies the authentication event. The combination of the required members `iss`, `auth_time` and `client_id` is normally sufficient for this purpose; where it is not, the object SHALL contain additional information that makes the identification unique, such as the `jti` member, the `sub` member, or a custom member defined for this purpose. The `jti` member SHALL be present when the ID Token contained a `jti` claim. The `sub` member MAY be present, but SHOULD NOT be present when the OpenID Provider issues public (non-pairwise) Subject Identifiers, see the privacy considerations of \[[OIDC.Authn.Context](#oidc-authn-context)\].

The `amr` member MUST NOT be present. Assurance is evaluated solely by means of the Authentication Context Class Reference carried in the `acr` member; authentication method references are not part of what the Signature Service verifies against the sign request, and their presence in the certificate could give a false impression of what was verified.

The `client_id` member SHALL hold the client identifier under which the Signature Service acted as Relying Party towards the OpenID Provider.

The `claim_mappings` member SHALL contain one claim mapping object for each subject attribute or other name form that was obtained from a claim in the ID Token or the UserInfo Response used to authenticate the signer as part of the signature creation process. The `source` member of a claim mapping object SHALL be present when the claim was obtained from the UserInfo Response. The OACI object does not carry claim values; the value is present in the certificate attribute that the mapping refers to.

The OACI object MAY be extended with additional members to provide further authentication information. Each member is a name/value pair. Additional member names SHOULD be collision resistant, for example by using a URI as the name. Relying parties ignore members they do not recognize.

**Example:**

The following example illustrates an OACI object for a signer authenticated at assurance level 3, where the `serialNumber`, `givenName`, `surname` and `commonName` attributes of the certificate subject were obtained from claims in the ID Token. Note that the `/` characters of a claim name that is a URI are escaped as `~1` in the JSON Pointer of the `claim` member, as specified in RFC 6901.

```json
{
  "iss": "https://op.example.com",
  "auth_time": 1792415045,
  "acr": "http://id.elegnamnden.se/loa/1.0/loa3",
  "jti": "0f3e2c6a-7b1d-4e4c-9a2e-5d1c2b3a4f60",
  "client_id": "https://sign.example.com",
  "claim_mappings": [
    { "type": "rdn", "ref": "2.5.4.5",
      "claim": "/https:~1~1id.oidc.se~1claim~1personalIdentityNumber" },
    { "type": "rdn", "ref": "2.5.4.42", "claim": "/given_name" },
    { "type": "rdn", "ref": "2.5.4.4", "claim": "/family_name" },
    { "type": "rdn", "ref": "2.5.4.3", "claim": "/name" }
  ]
}
```

<a name="certificate-policy"></a>
#### 2.3.3. Certificate Policy

Certificates SHALL reference at least one certificate policy. PKC certificates SHALL reference at least one certificate policy identified in \[[EU-POL-NCP](#eu-pol-ncp)\]. Qualified Certificates SHALL reference at least one certificate policy identified in \[[EU-POL-QC](#eu-pol-qc)\].


<a name="revocation-and-expiration"></a>
### 2.4. Revocation and Expiration

Certificates issued in accordance with this profile are issued for a single instance of signing. The signing key is generated for that instance and is destroyed once the signature has been created. This has consequences for revocation and expiration that certificate issuers should consider.

**Revocation**

Revocation serves no purpose for such certificates. The validity of a signature is determined by the status of the certificate at the time of signing, and signing takes place at the time of issuance of the certificate. Any revocation would necessarily take effect after that time and would therefore not affect the validity of the signature. As the private key is destroyed after signing, there is no key that could be compromised and misused to create further signatures. An issuer MAY therefore issue certificates without providing any revocation mechanism.

A certificate for which no revocation information is provided SHALL include the `id-ce-noRevAvail` extension defined in \[[RFC9608](#rfc9608)\], so that relying parties do not attempt to obtain revocation information for the certificate. The extension SHALL NOT be marked critical.

**Expiration**

The `notAfter` field of the certificate validity period indicates the time after which the issuer no longer maintains status information about the certificate. For a certificate that includes the `id-ce-noRevAvail` extension, no status information is maintained at any time, and the `notAfter` field therefore has no function. An issuer of such certificates MAY set the `notAfter` field to the GeneralizedTime value `99991231235959Z`, which, in accordance with section 4.1.2.5 of \[[RFC5280](#rfc5280)\], indicates that the certificate has no well-defined expiration date.

A certificate with no well-defined expiration date does not change how the validity of a signature is determined: the signature is validated with respect to the time of signing, established by the time of issuance of the certificate and any proof of existence, such as a time-stamp, applied to the signature. Nor does it extend the validity period of the issuing CA certificate; the conditions under which a CA certificate is trusted after its own validity period has ended are governed by the applicable certificate policy and validation policy, not by this profile.

<a name="normative-references"></a>
## 3. Normative References

<a name="dss"></a>
**[DSS]**
> [OASIS Standard - Digital Signature Service Core Protocols, Elements, and Bindings Version 1.0, April 11, 2007](https://docs.oasis-open.org/dss/v1.0/oasis-dss-core-spec-v1.0-os.html).

<a name="dss-ext"></a>
**[DSS-Ext]**
> [DSS Extension for Federated Central Signing Services](https://docs.swedenconnect.se/technical-framework/latest/09_-_DSS_Extension_for_Federated_Signing_Services.html).

<a name="attrspec"></a>
**[AttrSpec]**
> [Attribute Specification for the Swedish eID Framework.](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html)

<a name="rfc2119"></a>
**[RFC2119]**
> [Bradner, S., "Key words for use in RFCs to Indicate Requirement Levels", BCP 14, RFC 2119, March 1997](https://www.rfc-editor.org/rfc/rfc2119).

<a name="rfc3739"></a>
**[RFC3739]**
> [Santesson, S., Nystrom, M., and T. Polk, "Internet X.509 Public Key Infrastructure: Qualified Certificates Profile", RFC 3739, March 2004](https://www.rfc-editor.org/rfc/rfc3739).

<a name="rfc5280"></a>
**[RFC5280]**
> [Cooper, D., Santesson, S., Farrell, S., Boeyen, S., Housley, R., and
> W. Polk, "Internet X.509 Public Key Infrastructure Certificate and
> Certificate Revocation List (CRL) Profile", RFC 5280, May 2008](https://www.rfc-editor.org/rfc/rfc5280).

<a name="rfc9608"></a>
**[RFC9608]**
> [Housley, R., Hoyland, J. and T. Okubo, "No Revocation Available for X.509 Public Key Certificates", RFC 9608, June 2024](https://www.rfc-editor.org/rfc/rfc9608).

<a name="rfc7773"></a>
**[RFC7773]**
> [Santesson, S., "Authentication Context Certificate Extension", RFC 7773, March 2016](https://www.rfc-editor.org/rfc/rfc7773).

<a name="oidc-authn-context"></a>
**[OIDC.Authn.Context]**
> [Santesson, S. and M. Lindström, "Certificate Authentication Context Type for OpenID Connect", Internet-Draft draft-santesson-oidc-cert-auth-context](https://datatracker.ietf.org/doc/draft-santesson-oidc-cert-auth-context/).

<a name="openid-core"></a>
**[OpenID.Core]**
> [Sakimura, N., Bradley, J., Jones, M., de Medeiros, B. and C. Mortimore, "OpenID Connect Core 1.0", August 2015](https://openid.net/specs/openid-connect-core-1_0.html).

<a name="oidc-sweden-claims"></a>
**[OIDC.Sweden.Claims]**
> [Claims and Scopes Specification for the Swedish OpenID Connect Profile - Version 1.0](https://www.oidc.se/specifications/swedish-oidc-claims-specification-1_0.html).

<a name="oidc-claims"></a>
**[OIDC.Claims]**
> [OpenID Connect Claims and Scopes Specification for Sweden Connect](https://docs.swedenconnect.se/technical-framework/latest/OpenID_Connect_Claims_and_Scopes_Specification.html).

<a name="eu-pol-ncp"></a>
**[EU-POL-NCP]**
> ETSI EN 319 411-1, Electronic Signatures and Infrastructures (ESI); Policy and security requirements for Trust Service Providers issuing certificates; Part 1: General requirements.

<a name="eu-pol-qc"></a>
**[EU-POL-QC]**
> ETSI EN 319 411-2, Electronic Signatures and Infrastructures (ESI); Policy and security requirements for Trust Service Providers issuing certificates; Part 2: Requirements for trust service providers issuing EU qualified certificates.

<a name="eu-cert-gen"></a>
**[EU-CERT-GEN]**
> ETSI EN 319 412-1, Electronic Signatures and Infrastructures (ESI); Certificate Profiles; Part 1: Overview and common data structures.

<a name="eu-cert-np"></a>
**[EU-CERT-NP]**
> ETSI EN 319 412-2, Electronic Signatures and Infrastructures (ESI); Certificate Profiles; Part 2: Certificate profile for certificates issued to natural persons.

<a name="eu-cert-qc"></a>
**[EU-CERT-QC]**
> ETSI EN 319 412-5, Electronic Signatures and Infrastructures (ESI); Certificate Profiles; Part 5: QCStatements.

<a name="skv704"></a>
**[SKV704]**
> [Skatteverket, SKV 704 utgåva 8, Personnummer, September 2007](https://docs.swedenconnect.se/technical-framework/mirror/skv/skv704-8.pdf).

<a name="skv707"></a>
**[SKV707]**
> [Skatteverket, SKV 707, Utgåva 2, Samordningsnummer](https://docs.swedenconnect.se/technical-framework/mirror/skv/skv707-2.pdf).


<a name="changes-between-versions"></a>
## 4. Changes between versions

**Changes between version 1.2 and version 1.3:**

- Editorial revision: corrected section numbering, broken reference links and the namespace prefix in the example of section 2.3.2.1; added citations of \[[RFC3739](#rfc3739)\], \[[SKV704](#skv704)\] and \[[SKV707](#skv707)\], which were listed but not cited; updated RFC reference links; language improvements throughout.

- Section 2.3.1.1.2, "Data Format": a Swedish coordination number (samordningsnummer) stored with a semantics identifier now uses the local national identity type reference "CN:SE" instead of "PNO", so that personal identity numbers and coordination numbers can be distinguished without analysing the identifier format. "PNO" is retained for personal identity numbers (personnummer).

- Section 2.3.1.1.2, "Data Format": the name registration authority identifier for the local identity type references "PI:SE" and "CN:SE" is now `https://id.swedenconnect.se/cert/name-registration-authority`. The previous identifier `http://id.elegnamnden.se/eln/name-registration-authority` is deprecated but remains valid.

- Support for signers authenticated using OpenID Connect was added. Section 2.3.2 was restructured: the Authentication Context extension now carries either SAML Authentication Context Information (SACI) or OpenID Connect Authentication Context Information (OACI), depending on the protocol used to authenticate the signer, and the extension SHALL NOT be marked critical. The SACI requirements were moved to section 2.3.2.1 (with "Extended Authentication Information" becoming section 2.3.2.1.1) and the OACI requirements were added as section 2.3.2.2.

- Section 2.3.1.1, "Person Identifier Attributes", was extended to cover person identifiers obtained from OpenID Connect claims, with the Swedish coordination number listed as a separate identifier.

- Section 2.3.2.1, "SAML Authentication Context Information": the requirement that each `<saci:AttributeMapping>` element include the `<saml:AttributeValue>` element(s) obtained from the SAML assertion was relaxed from SHALL to MAY, in line with section 3.1.2 of \[[RFC7773](#rfc7773)\], which allows a mapping to identify the SAML attribute by name only without duplicating its value.

- Section 2.3.1.1.1, "Data Source": the requirement that the person identifier of a Qualified Certificate be obtained from one of the listed attributes was relaxed from SHALL to SHOULD, aligning it with PKC certificates. Under eIDAS 2 the personal identifier is no longer a standardized part of the minimum data set and may be any identifier attribute defined by the applicable PID rulebook, so the profile no longer restricts the source of the identifier to the listed attributes and claims.

- Section 2.4, "Revocation and Expiration", was added. It explains why revocation serves no purpose for certificates issued for a single instance of signing, and allows issuers to omit revocation support, indicated by the `id-ce-noRevAvail` extension of \[[RFC9608](#rfc9608)\], and to issue such certificates without a well-defined expiration date.

**Changes between version 1.1 and version 1.2:**

- Update of logotype, fixes of typos and reference list.

- Section 2.3.2.1, "Extended Authentication Information", was added.

**Changes between version 1.0 and version 1.1:**

- Removed the requirement to store "personnummer" or "samordningsnummer".
- Updated standards references to remove old deprecated standards and replace them with the currently published documents.
- Specified optional support for using semantics identifiers in accordance with ETSI EN 319 412-1 to specify that the serialNumber attribute contains a Swedish "personnummer" or "samordningsnummer", Provisional ID or eIDAS person identifier.
- Added requirement to specify ETSI policy identifiers.
- Fix of invalid links for SKV704 and SKV707.
