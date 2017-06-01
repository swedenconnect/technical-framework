<img src="img/eln-logo.png"></img>

# Signature Activation Data specification

### Version 0.1 - 2017-05-30

*ELN-0613-v0.1*

---

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirement key words](#requirement-key-words)

    1.2. [XML name space references](#xml-name-space-references)

    1.3. [Structure](#structure)

2. [**Signature Activation Data**](#signature-activation-data)

    2.1. [Scope](#scope)

    2.2. [Data binding](#data-binding)

    2.3. [SAD JWT](#sad-jwt)

    2.3.1. [Registered JWT claims](#registered-jwt-claims)

    2.3.2. [SAD Extension claim](#sad-extension-claim)

    2.4. [Example](#example)

3. [**Normative References**](#normative-references)


<a name="introduction"></a>
## 1. Introduction

This document specifies the Signature Activation Data (SAD) data element. The function of the SAD is to authenticate the intent of a signer to sign a particular document or collection of documents in accordance with the CEN standards prEN 419 241-1 [[RSIG-PP-1](#rsig-pp-1)] and prEN 419 241-2 [[RSIG-PP-2](#rsig-pp-2)].

The SAD specified in this document is designed to be used with a signing service operating in accordance with the federated signing specification \[[ELN-0609](#eln-0609)\].

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

**ToDo - If needed**

The prefix **saci:** stands for the SAML Authentication Context
Information XML Schema namespace
(`http://id.elegnamnden.se/auth-cont/1.0/saci`).

<a name="structure"></a>
### 1.3. Structure

This specification uses the following typographical conventions in text:
`<Eid2Element>`, `<ns:ForeignElement>`, `Attribute`, **Datatype**,
`OtherCode`.

<a name="signature-activation-data"></a>
## 2. Signature Activation Data

<a name="scope"></a>
### 2.1. Scope
The SAD is a collection of data which can be verified by the SAM (Signature Activation Module) in order to ensure sole control of the signers private signing key in accordance with the CEN standards prEN 419 241-1 [[RSIG-PP-1](#rsig-pp-1)] and prEN 419 241-2 [[RSIG-PP-2](#rsig-pp-2)].

This document specifies a SAD which is produced by an Identity Provider (IdP) implementing delegated authentication in accordance with prEN 419 241-1 [[RSIG-PP-1](#rsig-pp-1)].

This implements the scenario where the IdP is the sole entity which can verify the signer's SIC (Signer’s Interaction Component) and where the SIC is used to authenticate the signer to the IdP and where that instance of authentication is used by the IdP to generate the SAD in accordance with section 5.10 of [[RSIG-PP-1](#rsig-pp-1)].


<a name="data-binding"></a>
### 2.2. Data binding

In accordance with [[RSIG-PP-2](#rsig-pp-2)] the objective of the SAD is to provide cryptographically verifiable data which binds together:

- the authenticated identity of the signer,
- the level of security with which the signer was authenticated,
- indication of the intent of of the signer to sign the requested document(s),
- reference to the data to be signed
- reference to the signing key

The signing key reference can be implicit, e.g. derived from the identity of the signer.

This specification implements the requirements of  [[RSIG-PP-2](#rsig-pp-2)] with regard to SAD by a signed token, signed by the authenticating Identity Provider, containing the following information:

- The signer unique identifier attribute value
- The signer unique identifier attribute name
- The Authn request ID associated with this SAD
- The LoA Identifier for the authentication instant
- The time of authentication
- The IdP entityID
- RequestID of the sign request holding signature reference data.
- Number of documents to sign

<a name="sad-jwt"></a>
### 2.3. SAD JWT
This section specifies a JSON Web Token (JWT) in accordance with [[RFC7519](#rfc7519)] as the SAD container, binding the data as defined in section 2.2.

The SAD JWT MUST have the form of a signed JWS (JSON Web Signature).

<a name="registered-jwt-claims"></a>
#### 2.3.1. Registered JWT claims
The data signed by the SAD JWT is carried in the JWS payload in the form of JWT claims using registered claim names (as specified in [[RFC7519](#rfc7519)]) in addition to one public claim name (`urn:se:elegnamnden:jwt:sad`) specified in section 2.3.2. The following table defines the use of registered claims.

name | Content
---|---
**sub** | Subject, holding the attribute of the signer's unique identifier attribute
**aud** | Audience, holding the entityID of the Signature Service which is the legitimate recipient of this SAD
**iss** | Issuer, holding the entityID of the IdP that generated this SAD
**exp** | Expiry, specifying the time when this SAD is no longer valid
**iat** | Issued At, specifying the time when this SAD was issued
**jti** | a unique identifier of this SAD

<a name="sad-extension-claim"></a>
#### 2.3.2. SAD Extension claim
One public claim name is defined in this specification having the claim name:

> `urn:se:elegnamnden:jwt:sadext`

The claim identified by this name has the value of a JSON object holding name value pairs in accordance with the following table:

Name | Type | Content
--- |--- | ---
**ver** | String | The version of this claim, default 1.0 (Optional)
**irt** | String | In Response To, holding the identifier of the Authn Reuqest associated with this SAD.
**attr** | String | Attribute, holding the URI identifier of the attribute specifying the users unique identifier value.
**loa** | String | LevelOfAssurance, holding the URI identifier of the LoA used to  authenticate the signer.
**reqid** | String | RequestID, holding the ID of the Sign Request associated with this SAD.
**docs** | Integer | Documents, specifying the number of documents to be signed in the associated sign request.

The value of this claim can be serialized to and from the following Java Class:

    public class SadData {
        String ver,irt,attr,loa,reqid;
        int docs;
    }

<a name="example"></a>
### 2.4. Example

The following example illustrates a claim binding the following claim values:

**Registered Claims**

Name | Value
---|---
**sub** | 188803099368
**aud** | https://eid2csig.konki.se/sign
**iss** | https://idp.svelegtest.se/idp
**exp** | Thu Jun 01 14:52:54 CEST 2017
**iat** | Thu Jun 01 14:51:54 CEST 2017
**jti** | d84a9a298c28a032

**`urn:se:elegnamnden:jwt:sadext` Claim**

Name | Value
---|---
**ver** | 1.0
**irt** | \_a3a232edc94ce04ca54b41958c1b12c2
**attr** | urn:oid:1.2.752.29.4.13
**loa** | http://id.elegnamnden.se/loa/1.0/loa3
**reqid** | f6e7d061a23293b0053dc7b038a04dad
**docs** | 1

**JWS Header**

The Header of the JWS specifies the the signature algoritm, In this example the header is `{"alg":"RS256"}`. The Base64url encoded header is:

> eyJhbGciOiJSUzI1NiJ9

**JWS Payload**

The JWS payload holding the JWT claims is represented by the following JSON object:

    {
      "sub":"188803099368",
      "aud":"https:\/\/eid2csig.konki.se\/sign",
      "iss":"https:\/\/idp.svelegtest.se\/idp",
      "urn:se:elegnamnden:jwt:sadext":{
            "ver":"1.0",
            "irt":"_a3a232edc94ce04ca54b41958c1b12c2",
            "attr":"urn:oid:1.2.752.29.4.13",
            "loa":"http:\/\/id.elegnamnden.se\/loa\/1.0\/loa3",
            "reqid":"f6e7d061a23293b0053dc7b038a04dad",
            "docs":1},
      "exp":1496321574,
      "iat":1496321514,
      "jti":"78b32d24a7d208ff"
    }

This payload is represented by the following Base64url encoded string:

> eyJzdWIiOiIxODg4MDMwOTkzNjgiLCJhdWQiOiJodHRwczpcL1wvZWlkMmNzaWcua29ua2kuc2VcL3NpZ24iLCJpc3MiOiJodHRwczpcL1wvaWRwLnN2ZWxlZ3Rlc3Quc2VcL2lkcCIsInVybjpzZTplbGVnbmFtbmRlbjpqd3Q6c2FkZXh0Ijp7InZlciI6IjEuMCIsImlydCI6Il9hM2EyMzJlZGM5NGNlMDRjYTU0YjQxOTU4YzFiMTJjMiIsImF0dHIiOiJ1cm46b2lkOjEuMi43NTIuMjkuNC4xMyIsImxvYSI6Imh0dHA6XC9cL2lkLmVsZWduYW1uZGVuLnNlXC9sb2FcLzEuMFwvbG9hMyIsInJlcWlkIjoiZjZlN2QwNjFhMjMyOTNiMDA1M2RjN2IwMzhhMDRkYWQiLCJkb2NzIjoxfSwiZXhwIjoxNDk2MzIxNTc0LCJpYXQiOjE0OTYzMjE1MTQsImp0aSI6Ijc4YjMyZDI0YTdkMjA4ZmYifQ

**JWT**

The complete SAD JWT including signature:

> eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiIxODg4MDMwOTkzNjgiLCJhdWQiOiJodHRwczpcL1wvZWlkMmNzaWcua29ua2kuc2VcL3NpZ24iLCJpc3MiOiJodHRwczpcL1wvaWRwLnN2ZWxlZ3Rlc3Quc2VcL2lkcCIsInVybjpzZTplbGVnbmFtbmRlbjpqd3Q6c2FkZXh0Ijp7InZlciI6IjEuMCIsImlydCI6Il9hM2EyMzJlZGM5NGNlMDRjYTU0YjQxOTU4YzFiMTJjMiIsImF0dHIiOiJ1cm46b2lkOjEuMi43NTIuMjkuNC4xMyIsImxvYSI6Imh0dHA6XC9cL2lkLmVsZWduYW1uZGVuLnNlXC9sb2FcLzEuMFwvbG9hMyIsInJlcWlkIjoiZjZlN2QwNjFhMjMyOTNiMDA1M2RjN2IwMzhhMDRkYWQiLCJkb2NzIjoxfSwiZXhwIjoxNDk2MzIxNTc0LCJpYXQiOjE0OTYzMjE1MTQsImp0aSI6Ijc4YjMyZDI0YTdkMjA4ZmYifQ.Us6ZNWy_X2nsFbKvUn1PXZJ6aBXm4orLd9aErhYIcowZBTo1Yo909Rn-zwNPN3JDtkCu5fwwoYEe7ynd2TbIygJBA-IQc7c0VEFJsN2hkgFYgvLTTiUd9gS83bC8zxsN1IuGpBtJ7Cuc93yqQw4WP9hgNWdEgSl1GCngu_ZiBS8

<a name="normative-references"></a>
## 3. Normative References

<a name="rfc2119"></a>**[RFC2119]**

> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="rfc7519"></a>**[RFC7519]**

> [Jones, M., Bradley, J., and N. Sakimura, "JSON Web Token
              (JWT)", RFC 7519, DOI 10.17487/RFC7519, May 2015,
              ](http://www.rfc-editor.org/info/rfc7519).

<a name="eln-0609"></a>**[ELN-0609]**

> DSS Extension for Federated Central Signing Services - Version 1.1.

<a name="rsig-pp-1"></a>**[RSIG-PP-1]**

> European Standard prEN 419241-1 - Trustworthy Systems Supporting Server Signing - Part 1:
General System Security Requirements

<a name="rsig-pp-2"></a>**[RSIG-PP-2]**

> European Standard prEN 419241-2 - Trustworthy Systems Supporting Server Signing - Part 2:
Protection profile for QSCD for Server Signing
