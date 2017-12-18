<img src="img/eln-logo.png"></img>

# Signature Activation Protocol for Federated Signing

### Version 1.0 - 2017-12-18 - *draft version*

*ELN-0613-v1.0*

---

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirement key words](#requirement-key-words)

    1.2. [XML name space references](#xml-name-space-references)

    1.3. [Structure](#structure)

2. [**Signature Activation Protocol**](#signature-activation-protocol)

    2.1. [Scope](#scope)

    2.2. [Data exchange](#data-exchange)

3. [**Data elements**](#data-elements)

    3.1. [SADRequest](#sadrequest)

    3.1.1 [Syntax](#syntax)

    3.1.2 [Example](#example)

    3.2. [Signature Activation Data](#signature-activation-data)

    3.2.1. [SAD JSON Web Token](#sad-json-web-token)

    3.2.1.1. [Registered JWT claims](#registered-jwt-claims)

    3.2.1.2. [SAD Extension claim](#sad-extension-claim)

    3.2.1.3. [Serialization](#serialization)

    3.2.2. [Example](#example)

4. [**Schemas**](#schemas)

5. [**Normative References**](#normative-references)

<a name="introduction"></a>
## 1. Introduction

This document specifies a **Signature Activation Protocol** (SAP) and its data elements for implementation of **Sole Control Assurance Level 2** (SCAL2) according the European standards prEN 419241 - Trustworthy Systems Supporting Server Signing - Part 1 and 2 (prEN 419 241-1 [[RSIG-PP-1](#rsig-pp-1)] and prEN 419 241-2 [[RSIG-PP-2](#rsig-pp-2)]).

The Signature Activation Protocol (SAP) defined in this document is used to exchange data between a signature service and a delegated authenticating authority such as a SAML Identity Provider. The function of the SAP is to authenticate the intent of a signer to sign a particular document, or collection of documents, through exchange of the following data elements.

- Signature Activation Data (SAD) - Signed data, asserting the signer's agreement to sign specific data.
- SADRequest - Request for a SAD.

The SAP specified in this document is specifically designed to be used with a signing service operating in accordance with the federated signing specification \[[ELN-0609](#eln-0609)\].

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

The prefix **sap:** stands for the Signature Activation Protocol XML Schema namespace `http://id.elegnamnden.se/csig/1.1/sap/ns` (https://elegnamnden.github.io/schemas/csig/1.1/EidCsigSAP-1.1.xsd). 

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
- information about how the signer was authenticated and by whom,
- reference to the evidence of the signer's identity (e.g. SAML Assertion), and, 
- reference to the data to be signed.

This implements the scenario where the Identity Provider is the sole entity which can verify the signer's private credentials via the SIC (Signer’s Interaction Component). This instance of authentication is used by the Identity Provider to generate the SAD in accordance with section 5.10 of [[RSIG-PP-1](#rsig-pp-1)].

<a name="data-exchange"></a>
### 2.2. Data exchange
This document specifies exchange of two data elements:

- SADRequest
- SAD

The `SADRequest` SHALL have the format defined in section [3.1](#sadrequest). When a Remote Signing Service request a SAD from the Identity Provider, it MUST include the `SADRequest` element as an request extension by including it as a child element to a `<saml2p:Extensions>` element in the `<saml2p:AuthnRequest>`.

When an Identity Provider returns a SAD, as defined in section [3.2](#signature-activation-data), in a SAML Assertion, it MUST be included as a single string value of a `sad` attribute identified by the attribute name `urn:oid:1.2.752.201.3.12` as defined in the attribute specification [[ELN-0604](#eln-0604)].   


<a name="data-elements"></a>
## 3. Data elements

The SAD requested in the SAP binds the documents to be signed to the intent by the signer to sign. This is accomplished by the interaction of a number of independent information elements as follows:

- **Sign request ID**. Identifies the sign request message for signing specific documents. This sign request is sent to the signing service from the service provider requesting the signature. The sign request bound by this identifier contains all detailed data about what is being signed.
- **Sign message**. A description of what is being signed that is passed from the service provider requesting signing to the Identity Provider, via the signing service. The sign message is included in the sign request as well as in the SAML authentication request sent to the Identity Provider.
- **LoA**. The level of assurance declaration asserting the level of security used to authenticate the user and asserting that the user read and accepted the sign message and approved to sign the document/s.
- **Number of documents to sign**. Ensures that the user is aware whether more than one document is being signed. This allows adaptations of the signing UI displayed by the Identity Provider.
- **Identity of the signer**. Allows verification that the signature is bound to the appropriate signer.

The SAD request and the SAD specified in this section specifies the data that needs to be exchanged in addition to other protocol elements specified by SAML as well as the federated signing specification \[[ELN-0609](#eln-0609)\].

<a name="sadrequest"></a>
### 3.1. SADRequest

<a name="syntax"></a>
#### 3.1.1 Syntax

The SAD Request is provided in a `<sap:SADRequest>` element. The element has the following elements and attributes:

`<SignRequestID>` [Required]

> Specifies the value of the `RequestID` attribute of the associated `SignRequest`.

`<DocCount>` [Required]

> The number of requested signatures in the associated sign request.

`<RequestedVersion>` [Optional Default="1.0"]

> The requested version of the SAD.

`<RequestParams>` [Optional]

> Optional parameters provided as name-value pairs. This specification does not define any parameters. The use of parameters may be defined in profiles of this specification or may be negotiated by other means between a remote signing service and an Identity Provider.

The following schema fragment defines the `<sap:SADRequest>` element:

    <xs:element name="SADRequest" type="sap:SADRequestType" />
    
    <xs:complexType name="SADRequestType">
      <xs:sequence>
        <xs:element name="SignRequestID" type="xs:string" />
        <xs:element name="DocCount" type="xs:int" />
        <xs:element name="RequestedVersion" type="xs:string" default="1.0" />
        <xs:element minOccurs="0" name="RequestParams">
          <xs:complexType>
            <xs:sequence>
              <xs:element maxOccurs="unbounded" minOccurs="0" name="Parameter" type="sap:ParamType" />
            </xs:sequence>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
    </xs:complexType>
    
    <xs:complexType name="ParamType">
      <xs:simpleContent>
        <xs:extension base="xs:string">
          <xs:attribute name="Name" type="xs:string" use="required" />
        </xs:extension>
      </xs:simpleContent>
    </xs:complexType>


<a name="example"></a>
#### 3.1.2 Example

    <sap:SADRequest xmlns:sap="http://id.elegnamnden.se/csig/1.1/sap/ns">
      <sap:SignRequestID>f6e7d061a23293b0053dc7b038a04dad</sap:SignRequestID>
      <sap:DocCount>1</sap:DocCount>
      <sap:RequestedVersion>1.0</sap:RequestedVersion>
      <sap:RequestParams>
        <sap:Parameter Name="ParamName">paramValue</sap:Parameter>
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
##### 3.2.1.1. Registered JWT claims
The data signed by the SAD JWT is carried in the JWS payload in the form of JWT claims using registered claim names (as specified in [[RFC7519](#rfc7519)]) in addition to one private claim name (`seElnSadext`) specified in section [3.2.1.2](#sad-extension-claim). The following table defines the use of registered claims.

name | Content
---|---
**sub** | Subject - holding the attribute of the signer's unique identifier attribute.
**aud** | Audience - holding the entityID of the Signature Service which is the legitimate recipient of this SAD.
**iss** | Issuer - holding the entityID of the IdP that generated this SAD.
**exp** | Expiry - specifying the time when this SAD is no longer valid (epoch time/seconds since 1970-01-01).
**iat** | Issued At - specifying the time when this SAD was issued (epoch time/seconds since 1970-01-01).
**jti** | Unique identifier of this SAD.

<a name="sad-extension-claim"></a>
##### 3.2.1.2. SAD Extension claim
A private claim name is defined in this specification which extends the registered claims with additional SAD data:

> `seElnSadext`

The claim identified by this name has the value of a JSON object holding name-value pairs in accordance with the following table:

Name | Type | Content
--- |--- | ---
**ver** | String | The version of this claim, default 1.0 (Optional).
**irt** | String | In Response To - holding the identifier of the SAML `AuthnRequest` message associated with this SAD.
**attr** | String | Attribute - holding the URI identifier of the attribute specifying the users unique identifier value.
**loa** | String | LevelOfAssurance - holding the URI identifier of the level of assurance (LoA) used to authenticate the signer.
**reqid** | String | RequestID - holding the ID of the Sign Request associated with this SAD.
**docs** | Integer | Specifies the number of documents to be signed in the associated sign request.

<a name="example"></a>
#### 3.2.2. Example

The following example illustrates a claim binding the following claim values:

**Registered Claims**

Name | Value
---|---
**sub** | `188803099368`
**aud** | `https://eid2csig.konki.se/sign`
**iss** | `https://idp.svelegtest.se/idp`
**exp** | `1513611170` (2017-12-18 16:32:50 CET)
**iat** | `1513611110` (2017-12-18 16:31:50 CET)
**jti** | `fb934b226b9a71b1`

**seElnSadext Claim**

Name | Value
---|---
**ver** | `1.0`
**irt** | `_a3a232edc94ce04ca54b41958c1b12c2`
**attr** | `urn:oid:1.2.752.29.4.13`
**loa** | `http://id.elegnamnden.se/loa/1.0/loa3`
**reqid** | `f6e7d061a23293b0053dc7b038a04dad`
**docs** | `1`

**JWS Header**

The Header of the JWS specifies that it is a JWT by the "typ" parameter and the signature algoritm through the "alg" parameter. In this example the header is `{"typ":"JWT","alg":"RS256"}`. The Base64 URL-encoded header is:

> eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9

**JWS Payload**

The JWS payload holding the JWT claims is represented by the following JSON object:

    {
        "sub": "188803099368",
        "aud": "https://eid2csig.konki.se/sign",
        "iss": "https://idp.svelegtest.se/idp",
        "exp": 1513611170,
        "seElnSadext": {
            "ver": "1.0",
            "irt": "_a3a232edc94ce04ca54b41958c1b12c2",
            "attr": "urn:oid:1.2.752.29.4.13",
            "loa": "http://id.elegnamnden.se/loa/1.0/loa3",
            "reqid": "f6e7d061a23293b0053dc7b038a04dad",
            "docs": 1
        },
        "iat": 1513611110,
        "jti": "d4073fc74b1b9199"
    }

This payload is represented by the following Base64 URL-encoded string:

> eyJzdWIiOiIxODg4MDMwOTkzNjgiLCJhdWQiOiJodHRwczpcL1wvZWlkMmNzaWcua29ua2kuc2VcL3NpZ24iLCJpc3MiOiJodHRwczpcL1wvaWRwLnN2ZWxlZ3Rlc3Quc2VcL2lkcCIsImV4cCI6MTUxMzM1MTA2MCwic2VFbG5TYWRleHQiOnsidmVyIjoiMS4wIiwiaXJ0IjoiX2EzYTIzMmVkYzk0Y2UwNGNhNTRiNDE5NThjMWIxMmMyIiwiYXR0ciI6InVybjpvaWQ6MS4yLjc1Mi4yOS40LjEzIiwibG9hIjoiaHR0cDpcL1wvaWQuZWxlZ25hbW5kZW4uc2VcL2xvYVwvMS4wXC9sb2EzIiwicmVxaWQiOiJmNmU3ZDA2MWEyMzI5M2IwMDUzZGM3YjAzOGEwNGRhZCIsImRvY3MiOjF9LCJpYXQiOjE1MTMzNTEwMDAsImp0aSI6ImQ0MDczZmM3NGIxYjkxOTkifQ

**JWT**

The complete SAD JWT including signature:

> eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxODg4MDMwOTkzNjgiLCJhdWQiOiJodHRwczpcL1wvZWlkMmNzaWcua29ua2kuc2VcL3NpZ24iLCJpc3MiOiJodHRwczpcL1wvaWRwLnN2ZWxlZ3Rlc3Quc2VcL2lkcCIsImV4cCI6MTUxMzM1MTA2MCwic2VFbG5TYWRleHQiOnsidmVyIjoiMS4wIiwiaXJ0IjoiX2EzYTIzMmVkYzk0Y2UwNGNhNTRiNDE5NThjMWIxMmMyIiwiYXR0ciI6InVybjpvaWQ6MS4yLjc1Mi4yOS40LjEzIiwibG9hIjoiaHR0cDpcL1wvaWQuZWxlZ25hbW5kZW4uc2VcL2xvYVwvMS4wXC9sb2EzIiwicmVxaWQiOiJmNmU3ZDA2MWEyMzI5M2IwMDUzZGM3YjAzOGEwNGRhZCIsImRvY3MiOjF9LCJpYXQiOjE1MTMzNTEwMDAsImp0aSI6ImQ0MDczZmM3NGIxYjkxOTkifQ.dYQatHCxUKMSfY42FxC1g025DkmFwHk9dk9LTDdHi98yKpwM6-waoICO5YhwJq0MO2MiKmYMqOJTi31BeB_RUv4Zi6GgUfYq0CRs1nTjFgTcYtyAaoUxR9WEiylE32rBI1U2iqO2X4iUb3TzI6hb2ZtLuah72NH_ymO_taOyN_I


<a name="schemas"></a>
## 4. Schemas
The following XML schema defines the `http://id.elegnamnden.se/csig/1.1/sap/ns` name space:

    <?xml version="1.0" encoding="UTF-8"?>
    <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
        targetNamespace="http://id.elegnamnden.se/csig/1.1/sap/ns"
        xmlns:sap="http://id.elegnamnden.se/csig/1.1/sap/ns">
        
      <xs:annotation>
        <xs:documentation>
          Schema location URL: https://elegnamnden.github.io/schemas/csig/1.1/EidCsigSAP-1.1.xsd
        </xs:documentation>
      </xs:annotation>

      <xs:element name="SADRequest" type="sap:SADRequestType" />
        
      <xs:complexType name="SADRequestType">
        <xs:sequence>
          <xs:element name="SignRequestID" type="xs:string" />
          <xs:element name="DocCount" type="xs:int" />
          <xs:element name="RequestedVersion" type="xs:string" default="1.0" />
          <xs:element minOccurs="0" name="RequestParams">
            <xs:complexType>
              <xs:sequence>
                <xs:element maxOccurs="unbounded" minOccurs="0" name="Parameter" type="sap:ParamType" />
              </xs:sequence>
            </xs:complexType>
          </xs:element>
        </xs:sequence>
      </xs:complexType>
        
      <xs:complexType name="ParamType">
        <xs:simpleContent>
          <xs:extension base="xs:string">
            <xs:attribute name="Name" type="xs:string" use="required" />
          </xs:extension>
        </xs:simpleContent>
      </xs:complexType>
    </xs:schema>

<a name="normative-references"></a>
## 5. Normative References

<a name="rfc2119"></a>**[RFC2119]**

> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="rfc7519"></a>**[RFC7519]**

> [Jones, M., Bradley, J., and N. Sakimura, "JSON Web Token
              (JWT)", RFC 7519, DOI 10.17487/RFC7519, May 2015,
              ](http://www.rfc-editor.org/info/rfc7519).

<a name="eln-0604"></a>**[ELN-0604]**

> [Attribute Specification for the Swedish eID Framework](http://elegnamnden.github.io/technical-framework/updates/ELN-0604_-_Attribute_Specification_for_the_Swedish_eID_Framework.html).

<a name="eln-0609"></a>**[ELN-0609]**

> [DSS Extension for Federated Central Signing Services](http://elegnamnden.github.io/technical-framework/updates/ELN-0609_-_DSS_Extension_for_Federated_Signing_Services.html).

<a name="rsig-pp-1"></a>**[RSIG-PP-1]**

> European Standard prEN 419241-1 - Trustworthy Systems Supporting Server Signing - Part 1:
General System Security Requirements

<a name="rsig-pp-2"></a>**[RSIG-PP-2]**

> European Standard prEN 419241-2 - Trustworthy Systems Supporting Server Signing - Part 2:
Protection profile for QSCD for Server Signing

