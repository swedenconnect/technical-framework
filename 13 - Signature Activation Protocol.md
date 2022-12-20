<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Signature Activation Protocol for Federated Signing

### Version 1.2 - 2022-12-20 - *Draft version*

Registration number: **2019-317**

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (DIGG)</a>, 2015-2022. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirement key words](#requirement-key-words)

    1.2. [XML namespace references](#xml-namespace-references)

    1.3. [Structure](#structure)

2. [**Signature Activation Protocol**](#signature-activation-protocol)

    2.1. [Scope](#scope)

    2.2. [Data Exchange](#data-exchange)

3. [**Data elements**](#data-elements)

    3.1. [SADRequest](#sadrequest)

    3.1.1. [Syntax](#syntax)

    3.1.2. [Example](#example)

    3.2. [Signature Activation Data](#signature-activation-data)

    3.2.1. [SAD JSON Web Token](#sad-json-web-token)

    3.2.1.1. [Registered JWT Claims](#registered-jwt-claims)

    3.2.1.2. [SAD Extension Claim](#sad-extension-claim)

    3.2.2. [Example](#example)

    3.2.3 [Verification of a SAD](#verification-of-a-sad)

4. [**Schemas**](#schemas)

5. [**Normative References**](#normative-references)

6. [**Changes between versions**](#changes-between-versions)

<a name="introduction"></a>
## 1. Introduction

This document specifies a **Signature Activation Protocol** (SAP) and its data elements for implementation of **Sole Control Assurance Level 2** (SCAL2) according the European standards prEN 419241 - Trustworthy Systems Supporting Server Signing - Part 1 and 2 (prEN 419 241-1 [[RSIG-PP-1](#rsig-pp-1)] and prEN 419 241-2 [[RSIG-PP-2](#rsig-pp-2)]).

The Signature Activation Protocol (SAP) defined in this document is used to exchange data between a signature service and a delegated authenticating authority such as a SAML Identity Provider. The function of the SAP is to authenticate the intent of a signer to sign a particular document, or collection of documents, through exchange of the following data elements.

- Signature Activation Data (SAD) - Signed data, asserting the signer's agreement to sign specific data.
- SADRequest - Request for a SAD.

The SAP specified in this document is specifically designed to be used with a signing service operating in accordance with the federated signing specification \[[DSS-Ext](#dss-ext)\].

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

The prefix **sap:** stands for the Signature Activation Protocol XML Schema namespace `http://id.elegnamnden.se/csig/1.1/sap/ns` (https://docs.swedenconnect.se/schemas/csig/1.1/EidCsigSAP-1.1.xsd).

The prefix **saml2:** stands for the OASIS SAML 2 Assertion Schema namespace `urn:oasis:names:tc:SAML:2.0:assertion`.

The prefix **saml2p:** stands for the OASIS SAML 2 Protocol Schema namespace `urn:oasis:names:tc:SAML:2.0:protocol`.

<a name="structure"></a>
### 1.3. Structure

This specification uses the following typographical conventions in text:
`<Eid2Element>`, `<ns:ForeignElement>`, `Attribute`, **Datatype**,
`OtherCode`.

<a name="signature-activation-protocol"></a>
## 2. Signature Activation Protocol

<a name="scope"></a>
### 2.1. Scope
The scope of the Signature Activation Protocol (SAP) is to support request for and delivery of the Signature Activation Data (SAD) to the Signature Activation Module (SAM). The SAM is a tamper resistant module inside the Remote Signing Service which validates the SAD in order to ensure that:

- the signer is properly authenticated,
- the signer agrees to sign the data to be signed, and,
- the correct signing key for this signer and this instance of signing is properly identified.

The federated signing model does not use pre-assigned signing keys. Instead, a new signing key is generated for each sign request and then permanently deleted. This particular use-case is recognised by prEN 419 241-1 [[RSIG-PP-1](#rsig-pp-1)] and prEN 419 241-2 [[RSIG-PP-2](#rsig-pp-2)], which under these conditions allows the signature key reference to be implicit and derived from the signer's identity. For the present implementation of the SAP the following data is included in the SAD:

- the signer's identity,
- information about how the signer was authenticated and by whom, and,
- reference to the signature request, binding this instance of authentication to the specific instance of signing, the data being signed and the agreement to sign.

This implements the scenario where the Identity Provider is the sole entity which can verify the signer's private credentials via the SIC (Signer’s Interaction Component). This instance of authentication is used by the Identity Provider to generate the SAD in accordance with section 5.10 of [[RSIG-PP-1](#rsig-pp-1)].

<a name="data-exchange"></a>
### 2.2. Data exchange
This document specifies exchange of two data elements:

- `SADRequest`
- `SAD`

The `SADRequest` SHALL have the format defined in section [3.1](#sadrequest). When a Remote Signing Service request a SAD from the Identity Provider, it MUST include the `SADRequest` element as an request extension by including it as a child element to a `<saml2p:Extensions>` element in the `<saml2p:AuthnRequest>`.

When an Identity Provider returns a SAD, as defined in section [3.2](#signature-activation-data), in a SAML Assertion, it MUST be included as a single string value of a `sad` attribute identified by the attribute name `urn:oid:1.2.752.201.3.12` as defined in the attribute specification [[EidAttributes](#eidattributes)].

<a name="data-elements"></a>
## 3. Data elements

The SAD requested in the SAP binds the documents to be signed to the intent by the signer to sign. This is accomplished by the interaction of a number of independent information attributes and elements as follows:

- **Sign request ID**. Identifies the sign request for signing specific documents. This sign request is sent to the signing service from the service provider requesting the signature. The sign request bound by this identifier contains all detailed data about what is being signed.
- **LoA**. The level of assurance declaration asserting the level of security used to authenticate the user.
- **Number of documents to sign**. Ensures that the user is aware whether more than one document is being signed. This allows adaptations of the signing UI displayed by the Identity Provider.
- **Identity of the signer**. Allows verification that the signature is bound to the appropriate signer.
- **SAD Request ID**. Unique identifier for the `SADRequest` element. This identifier is later included in the SAD in order to accomplish a binding between the request and the issued SAD.

The SAD request and the SAD specified in this section specifies the data that needs to be exchanged in addition to other protocol elements specified by SAML as well as the federated signing specification \[[DSS-Ext](#dss-ext)\].

<a name="sadrequest"></a>
### 3.1. SADRequest

<a name="syntax"></a>
#### 3.1.1. Syntax

The SAD Request is provided in a `<sap:SADRequest>` element. The element has the following elements and attributes:

`<RequesterID>` \[Required]

> Specifies the SAML entityID of the requesting entity. The value for this element should be the same identifier as given in the `<saml2:Issuer>` element of the `<saml2p:AuthnRequest>` that encapsulates the `<sap:SADRequest>` extension.

`<SignRequestID>` \[Required\]

> Specifies the value of the `RequestID` attribute of the associated `SignRequest`.

`<DocCount>` \[Required\]

> The number of requested signatures in the associated sign request.

`<RequestedVersion>` \[Optional Default="1.0"\]

> The requested version of the SAD.

`<RequestParams>` \[Optional\]

> Optional parameters provided as name-value pairs. This specification does not define any parameters. The use of parameters may be defined in profiles of this specification or may be negotiated by other means between a remote signing service and an Identity Provider.

`ID` \[Required\]

> Attribute holding an unique identifier for the `SADRequest`.

The following schema fragment defines the `<sap:SADRequest>` element:

    <xs:element name="SADRequest" type="sap:SADRequestType" />

    <xs:complexType name="SADRequestType">
      <xs:sequence>
        <xs:element name="RequesterID" type="xs:string" />
        <xs:element name="SignRequestID" type="xs:string" />
        <xs:element name="DocCount" type="xs:int" />
        <xs:element name="RequestedVersion" type="xs:string" minOccurs="0" default="1.0" />
        <xs:element name="RequestParams" minOccurs="0">
          <xs:complexType>
            <xs:sequence>
              <xs:element name="Parameter" type="sap:ParameterType" minOccurs="0" maxOccurs="unbounded" />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
      <xs:attribute name="ID" type="xs:ID" use="required" />
    </xs:complexType>

    <xs:complexType name="ParameterType">
      <xs:simpleContent>
        <xs:extension base="xs:string">
          <xs:attribute name="name" type="xs:string" use="required" />
        </xs:extension>
      </xs:simpleContent>
    </xs:complexType>


<a name="example"></a>
#### 3.1.2. Example

    <sap:SADRequest ID="_a74a068d0548a919e503e5f9ef901851" xmlns:sap="http://id.elegnamnden.se/csig/1.1/sap/ns">
      <sap:RequesterID>http://www.example.com/sigservice</sap:RequesterID>
      <sap:SignRequestID>f6e7d061a23293b0053dc7b038a04dad</sap:SignRequestID>
      <sap:DocCount>1</sap:DocCount>
      <sap:RequestedVersion>1.0</sap:RequestedVersion>
      <sap:RequestParams>
        <sap:Parameter name="ParamName">paramValue</sap:Parameter>
      </sap:RequestParams>
    </sap:SADRequest>

*Example of a SADRequest.*

<a name="signature-activation-data"></a>
### 3.2. Signature Activation Data

<a name="sad-json-web-token"></a>
#### 3.2.1. SAD JSON Web Token
This section specifies a JSON Web Token (JWT) in accordance with [[RFC7519](#rfc7519)] as the SAD container, binding the data as defined in section [2.1](#scope).

The SAD JWT MUST have the form of a signed JWS (JSON Web Signature).

<a name="registered-jwt-claims"></a>
##### 3.2.1.1. Registered JWT Claims
The data signed by the SAD JWT is carried in the JWS payload in the form of JWT claims using registered claim names (as specified in [[RFC7519](#rfc7519)]) in addition to one private claim name (`seElnSadext`) specified in section [3.2.1.2](#sad-extension-claim). The following table defines the use of registered claims.

name | Content
---|---
**sub** | Subject - holds the attribute value of the signer's unique identifier.
**aud** | Audience - holds the entityID of the Signature Service which is the legitimate recipient of this SAD. This value corresponds to the `<sap:RequesterID>` element of the SAD request.
**iss** | Issuer - holds the entityID of the IdP that generated this SAD.
**exp** | Expiry - specifies the time when this SAD is no longer valid (epoch time/seconds since 1970-01-01).
**iat** | Issued At - specifies the time when this SAD was issued (epoch time/seconds since 1970-01-01).
**jti** | Unique identifier of this SAD.

<a name="sad-extension-claim"></a>
##### 3.2.1.2. SAD Extension Claim
A private claim name is defined in this specification which extends the registered claims with additional SAD data:

> `seElnSadext`

The claim identified by this name has the value of a JSON object holding name-value pairs in accordance with the following table:

| Name | Type | Content |
| --- | --- | --- |
| **ver** | String | The version of this claim, default 1.0 (Optional). |
| **irt** | String | In Response To - holds the identifier of the SAD request (`ID` attribute) that was used to request this SAD. |
| **attr** | String | Attribute - holds the URI identifier of the attribute specifying the users unique identifier value. |
| **loa** | String | LevelOfAssurance - holds the URI identifier of the level of assurance (LoA) used to authenticate the signer. |
| **reqid** | String | RequestID - holds the ID of the sign request associated with this SAD. Inclusion of this ID assert that the authenticated subject agrees to sign the docuements identified by this sign reqeust.|
| **docs** | Integer | Specifies the number of documents to be signed in the associated sign request. |

<a name="example"></a>
#### 3.2.2. Example

The following example illustrates a claim binding the following claim values:

**Registered Claims**

Name | Value
---|---
**sub** | `197802031877`
**aud** | `https://sandbox.swedenconnect.se/eid2cssp`
**iss** | `http://dev.test.swedenconnect.se/idp`
**exp** | `1666128029` (Oct 18, 2022, 23:20:29 CET)
**iat** | `1666127729` (Oct 18, 2022, 23:15:29 CET)
**jti** | `NbnmpGA1gwtL3AgtKPfe77Ia`

**seElnSadext Claim**

Name | Value
---|---
**ver** | `1.0`
**irt** | `752c30b3-30c1-49f0-ab04-a28909dc3b67`
**attr** | `urn:oid:1.2.752.29.4.13`
**loa** | `http://id.elegnamnden.se/loa/1.0/loa3`
**reqid** | `70fabf30-d474-4d21-8463-2c6811005ce0`
**docs** | `4`

**JWS Header**

The Header of the JWS specifies that it is a JWT by the "typ" parameter and the signature algoritm through the "alg" parameter. In this example the header is `{"typ":"JWT","alg":"RS256"}`. The Base64 URL-encoded header is:

> eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9

**JWS Payload**

The JWS payload holding the JWT claims is represented by the following JSON object:

```
{
    "sub": "197802031877",
    "aud": "https://sandbox.swedenconnect.se/eid2cssp",
    "iss": "http://dev.test.swedenconnect.se/idp",
    "exp": 1666128029,
    "iat": 1666127729,
    "jti": "NbnmpGA1gwtL3AgtKPfe77Ia",
    "seElnSadext": {
        "ver": "1.0",
        "irt": "752c30b3-30c1-49f0-ab04-a28909dc3b67",
        "attr": "urn:oid:1.2.752.29.4.13",
        "loa": "http://id.elegnamnden.se/loa/1.0/loa3",
        "reqid": "70fabf30-d474-4d21-8463-2c6811005ce0",
        "docs": 4
    }
}

```

This payload is represented by the following Base64 URL-encoded string:

> eyJzdWIiOiIxOTc4MDIwMzE4NzciLCJhdWQiOiJodHRwczovL3NhbmRib3guc3dlZGVuY29ubmVjdC5zZS9laWQyY3NzcCIsImlzcyI6Imh0dHA6Ly9kZXYudGVzdC5zd2VkZW5jb25uZWN0LnNlL2lkcCIsImV4cCI6MTY2NjEyODAyOSwiaWF0IjoxNjY2MTI3NzI5LCJqdGkiOiJOYm5tcEdBMWd3dEwzQWd0S1BmZTc3SWEiLCJzZUVsblNhZGV4dCI6eyJ2ZXIiOiIxLjAiLCJpcnQiOiI3NTJjMzBiMy0zMGMxLTQ5ZjAtYWIwNC1hMjg5MDlkYzNiNjciLCJhdHRyIjoidXJuOm9pZDoxLjIuNzUyLjI5LjQuMTMiLCJsb2EiOiJodHRwOi8vaWQuZWxlZ25hbW5kZW4uc2UvbG9hLzEuMC9sb2EzIiwicmVxaWQiOiI3MGZhYmYzMC1kNDc0LTRkMjEtODQ2My0yYzY4MTEwMDVjZTAiLCJkb2NzIjo0fX0

**JWT**

The complete SAD JWT including signature:

> eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxOTc4MDIwMzE4NzciLCJhdWQiOiJodHRwczovL3NhbmRib3guc3dlZGVuY29ubmVjdC5zZS9laWQyY3NzcCIsImlzcyI6Imh0dHA6Ly9kZXYudGVzdC5zd2VkZW5jb25uZWN0LnNlL2lkcCIsImV4cCI6MTY2NjEyODAyOSwiaWF0IjoxNjY2MTI3NzI5LCJqdGkiOiJOYm5tcEdBMWd3dEwzQWd0S1BmZTc3SWEiLCJzZUVsblNhZGV4dCI6eyJ2ZXIiOiIxLjAiLCJpcnQiOiI3NTJjMzBiMy0zMGMxLTQ5ZjAtYWIwNC1hMjg5MDlkYzNiNjciLCJhdHRyIjoidXJuOm9pZDoxLjIuNzUyLjI5LjQuMTMiLCJsb2EiOiJodHRwOi8vaWQuZWxlZ25hbW5kZW4uc2UvbG9hLzEuMC9sb2EzIiwicmVxaWQiOiI3MGZhYmYzMC1kNDc0LTRkMjEtODQ2My0yYzY4MTEwMDVjZTAiLCJkb2NzIjo0fX0.Qn-K-5V5-979GMITVSXgqWOrSVQfYFUMLv0P8PLUMSZzF6s6Zk05SOztH3XGN-4AjmjQeBHcqylpzoqG26eIXW7kuJZB9zodhAyTcvOogQj62XUFsoun5wfWpou8v8-Cpw1G4cwFZdMKt-oRbN43ViZ8u7EIZHBjzYMxfJNgMv2YGmzMQDPQLmtIW-f_O0nE_NPcFsaweYGJXcEWxi7fE3wzNnOR2rPBgQ3L0oehF2mP9dhenlptKrugH6Ru6eLZH66yFaAtR5RRA2m1wh2fXnwXJWO0-8jrvIZiZ9GLDt9W0r1Hs5Le--KPeuPcStli0nIi5YVLoAiGUaHc-Eb_DILwdqYpHS6mxJL3lb8j8u5JsIdEj9FEpqD8MlCbVM4HaWDL_wIiU16QVUOrxPUjoo3wyxLYhW6x3WnQ2an8fhIgahck7m9gS6_rVHKG1OAL_jn4h5jZzP-gX9yZeNcfTmhSiEdwrObydZ4dKx7JGEbmKn4EK1-8Pc65SOj9Zg5jTsRsl6uo9dMoJ-35Tb-x5IKsGs9Y1_94NCuqJH_a7HgC8nORfHBDOTPjzG008FLEFHSRmql6hYSYEd9F3kvR5816KixZpLT_BEED1m4RNdufa8nYEgEroi6X_AvmjpZKiwXCgnJyW6_80IIV89EMViiQ-BjTSSt8AK5KxxpTLkA

<a name="verification-of-a-sad"></a>
#### 3.2.3. Verification of a SAD

The recipient of a requested SAD MUST verify it as part of the SAML response processing by asserting the following:

*  That the signature of the SAD JWT verifies correctly using the signature certificate of the issuing Identity Provider (found in the Identity Provider metadata).
*  That the version of the SAD (`seElnSadext.ver`) matches the `<sap:RequestedVersion>` element of the `<sap:SADRequest>`.
*  That the audience (`aud`) matches the entityID of the recipient, i.e., matches the `<sap:RequesterID>` element from the `<sap:SADRequest>`.
*  That the issuer (`iss`) value matches the issuer entityID of the assertion containing the SAD (*).
*  That the SAD is valid by checking the expiry (`exp`) and issued-at (`iat`) values (allowing for a reasonable clock skew).
*  That the in-response-to (`seElnSadExt.irt`) value matches that `ID` of the corresponding `<sap:SADRequest>`.
*  That the subject (`sub`) value is also represented in the SAML assertion as an attribute having the name given by the `seElnSadExt.attr` field.
*  That the level of assurance (`seElnSadEx.loa`) value matches the value given in the `<saml2:AuthnContextClassRef>` element of the assertion.
*  That the request ID (`seElnSadEx.reqid`) value matches the ID for the sign request (which is passed in the `<sap:SignRequestID>` element of the `<sap:SADRequest>`).
*  That the number of documents specified in the SAD (`seElnSadEx.docs`) matches the `<sap:DocCount>` element of the `<sap:SADRequest>`.

If any of the above verification steps fail, the Signature Service MUST reject the assertion.

> \[\*\]: In the case where a Signature Service communicates with a Proxy Identity Provider that forwards requests to an *authenticating* Identity Provider that issues a SAD, the `iss`-value of the SAD will differ from the issuer of the assertion that is received by the Signature Service. In these cases the Signature Service should compare the `iss`-value with the value found in the `<saml2:AuthenticatingAuthority>` element of the assertion, or with relevant local policy and out-of-band configuration data.

<a name="schemas"></a>
## 4. Schemas
The following XML schema defines the `http://id.elegnamnden.se/csig/1.1/sap/ns` name space:

    <?xml version="1.0" encoding="UTF-8"?>
    <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
        targetNamespace="http://id.elegnamnden.se/csig/1.1/sap/ns"
        xmlns:sap="http://id.elegnamnden.se/csig/1.1/sap/ns">

      <xs:annotation>
        <xs:documentation>
          Schema location URL: https://docs.swedenconnect.se/schemas/csig/1.1/EidCsigSAP-1.1.xsd
        </xs:documentation>
      </xs:annotation>

      <xs:element name="SADRequest" type="sap:SADRequestType" />

      <xs:complexType name="SADRequestType">
        <xs:sequence>
          <xs:element name="RequesterID" type="xs:string" />
          <xs:element name="SignRequestID" type="xs:string" />
          <xs:element name="DocCount" type="xs:int" />
          <xs:element name="RequestedVersion" type="xs:string" minOccurs="0" default="1.0" />
          <xs:element minOccurs="0" name="RequestParams">
            <xs:complexType>
              <xs:sequence>
                <xs:element name="Parameter" type="sap:ParameterType" minOccurs="0" maxOccurs="unbounded" />
              </xs:sequence>
            </xs:complexType>
          </xs:element>
        </xs:sequence>
        <xs:attribute name="ID" type="xs:ID" use="required" />
      </xs:complexType>

      <xs:complexType name="ParameterType">
        <xs:simpleContent>
          <xs:extension base="xs:string">
            <xs:attribute name="name" type="xs:string" use="required" />
          </xs:extension>
        </xs:simpleContent>
      </xs:complexType>
    </xs:schema>

<a name="normative-references"></a>
## 5. Normative References

<a name="rfc2119"></a>
**[RFC2119]**
> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="rfc7519"></a>
**[RFC7519]**
> [Jones, M., Bradley, J., and N. Sakimura, "JSON Web Token (JWT)", RFC 7519, DOI 10.17487/RFC7519, May 2015](http://www.rfc-editor.org/info/rfc7519).

<a name="eidattributes"></a>
**[EidAttributes]**
> [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html).

<a name="dss-ext"></a>
**[DSS-Ext]**
> [DSS Extension for Federated Central Signing Services](https://docs.swedenconnect.se/technical-framework/latest/09_-_DSS_Extension_for_Federated_Signing_Services.html).

<a name="rsig-pp-1"></a>
**[RSIG-PP-1]**
> European Standard prEN 419241-1 - Trustworthy Systems Supporting Server Signing - Part 1:
General System Security Requirements

<a name="rsig-pp-2"></a>
**[RSIG-PP-2]*s
> European Standard prEN 419241-2 - Trustworthy Systems Supporting Server Signing - Part 2:
Protection profile for QSCD for Server Signing


<a name="changes-between-versions"></a>
## 6. Changes between versions

**Changes between version 1.1 and 1.2:**

- The protocol logic was clarified by removing references to sign message (which was never present in the actual protocol) and replacing this with a clarification of the semantics of including the the Sign Request ID in SAD to assert the acceptance to sign the documents referenced in that Sign Request.

- Updated examples where the use of "signmessage" LoA URI:s was removed.

- Updated broken links.

**Changes between version 1.0 and 1.1:**

- The `RequestedVersion` element of the `SADRequestType` is now marked as optional in the schema definition.
