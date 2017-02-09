<img src="img/eln-logo.png"></img>

# Implementation Profile for BankID Identity Providers within the Swedish eID Framework

### Version 1.0 - 2017-02-01 
#### *Draft version*

*ELN-0612-v1.0*

---

## Table of Contents

---

<a name="introduction"></a>
## 1. Introduction

This profile defines how a SAML Identity Provider that offers authentication using the Swedish BankID technology should implement its services to be compliant with the Swedish eID Framework specifications.

The BankID interface for authentication and signature, the Relying Party Interface, is described in the "BankID Relying Party Guidelines", \[[BankID_Spec](#bankid_spec)\], specification. This specification MUST be fully implemented and supported by BankID Identity Providers compliant
with the Swedish eID Framework specifications.

This deployment profile extends the "Deployment Profile for the Swedish eID Framework", 
\[[EidProfile](#eid-profile)\], with requirements and recommendations for Service Providers 
using BankID via a SAML Identity Provider and for Identity Providers offering BankID authentication
and signature services.

<a name="requirements-notation"></a>
### 1.1. Requirements Notation

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
document are to be interpreted as described in \[[RFC2119](#rfc2119)\].

The use of SHOULD, SHOULD NOT, and RECOMMENDED reflects broad consensus
on deployment practices intended to foster both interoperability and
guarantees of security and confidentiality needed to satisfy the
requirements of many organizations that engage in the use of federated
identity. Deviating may limit a deployment's ability to technically
interoperate without additional negotiation, and should be undertaken
with caution.

<a name="references-to-saml-20-standards-and-profiles"></a>
### 1.2. References to SAML 2.0 Standards and Profiles

When referring to elements from the SAML 2.0 core specification \[[SAML2Core](#saml2core)\],
the following syntax is used:

-   `<saml2p:Element>` – for elements from the SAML 2.0 Protocol
    namespace.

-   `<saml2:Element>` – for elements from the SAML 2.0 Assertion
    namespace.

When referring to elements from the SAML 2.0 metadata specifications,
the following syntax is used:

-   `<md:Element>` – for elements defined in \[[SAML2Meta](#saml2meta)\].

-   `<mdattr:Element>` – for elements defined in \[[SAML2MetaAttr](#saml2metaattr)\].

## 2. Usage of BankID

### 2.2. BankID Methods and Applications

Currently, there are three flavours of BankID:

* Mobile BankID - End users use the "BankID app" on their mobile devices to authenticate or perform a signature. In these cases the user certificate is stored in the app and protected by a personal code.
* "BankID on file" - End users use the desktop program "BankID Security Application" to authenticate or perform a signature. The user certificate is stored in a file on the computer and is protected by the user password.
* "BankID on card" - End users make use of the same desktop program as described above, but the certificate is placed on a smart card. The user private key is unlocked using the PIN-pad on the smart card reader.

The three above methods are all "BankID", but historically relying parties have made a difference between "Mobile BankID" and "BankID" (the original desktop version). 
> More about "this device" and "other device" ...

### 2.1. The Relying Party Interface

### 2.3. Representation as Identity Providers

> Discussion whether there should be separate IdP:s for BankID and Mobile BankID, or even "BankID on card".
> This profile should allow either of the following:
> 
> * Each BankID "method" is its own IdP, or,
> * One BankID IdP that supports all methods.

<a name="metadata"></a>
## 2. Metadata

### 2.1. BankID Identity Provider

### 2.2. Service Providers using BankID

> An SP needs to explicitly require release of BankID-specific attributes.

### 2.3. Signature Services using BankID

## 3. Authentication

### 3.1. Selection of BankID

> Discovery within the IdP or before hand.

### 3.2. Authentication Requests

> An `AuthnRequest` needs to be signed.

### 3.3. Authentication Responses

#### 3.4. Attribute release

> Extends "Natural Personal Identity with Civic Registration Number", `http://id.elegnamnden.se/ap/1.0/pnr-01`.

## 5. Signatures (Authentication for Signature)

An Identity Provider conforming to the Swedish eID Framework is obliged to handle requests received from Signature Services as described in section 7, “Authentication for Signature”, of \[[EidProfile](#eid-profile)\]. This section further specifies how a BankID Identity Provider should support “authentication for signature”.A BankID Identity Provider that receives an `<saml2p:AuthnRequest>` message from a Signature Service MUST initiate a BankID signature operation.

### 5.1. Displaying of Signature Message

The BankID client (App or desktop program) comprises a text box in which the signature message is displayed for the user. 
A BankID Identity Provider SHOULD NOT display the signature message in any other way than 
in this text box. The message is passed to the BankID server using the `userVisibleData` parameter according to section 12.2.1 of \[[BankID_Spec](#bankid_spec)\].

If the `<saml2p:AuthnRequest>` message contains a `SignMessage` extension, the contents of this message should be displayed for the user in the BankID signature text box.A BankID Identity Provider MUST only process `SignMessage` elements having their `MimeType` attribute set to `text`<sup>1</sup> . For any other values (`text/html` or `text/markdown`), the Identity Provider MUST respond with an error.If the `<saml2p:AuthnRequest>` message does not contain a `SignMessage` extension, the Identity Provider MUST make use of a default signature message. How this message is constructed is the responsibility of the Identity Provider, but it MUST be obvious for the user who is the requesting party, i.e., the Service Provider that has ordered the signature operation<sup>2</sup>.> \[1\]: If the `MimeType` attribute is not set, `text` is the default value.
> 
> \[2\]: For this purpose, the `<mdui:DisplayName>` element of the Signature Service’s metadata entry, is a good and generic choice.  

## 6. Non-functional Requirements

## 7. Recommendations

### 7.1. User Interface Recommendations

## 8. References

<a name="rfc2119"></a>
**\[RFC2119\]**
> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="saml2core"></a>
**\[SAML2Core\]**
> [OASIS Standard, Assertions and Protocols for the OASIS Security
> Assertion Markup Language (SAML) V2.0, March
> 2005](http://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf).

<a name="saml2meta"></a>
**\[SAML2Meta\]**
> [OASIS Standard, Metadata for the OASIS Security Assertion Markup
> Language (SAML) V2.0, March
> 2005](http://docs.oasis-open.org/security/saml/v2.0/saml-metadata-2.0-os.pdf).

<a name="saml2metaattr"></a>
**\[SAML2MetaAttr\]**
> [OASIS Committee Specification, SAML V2.0 Metadata Extension for
> Entity Attributes Version 1.0, August
> 2009](http://docs.oasis-open.org/security/saml/Post2.0/sstc-metadata-attr.html).

<a name="bankid-spec"></a>
**\[BankID_Spec\]**
> [BankID Relying Party Guidelines, version 2.13](https://www.bankid.com/assets/bankid/rp/bankid-relying-party-guidelines-v2.13.pdf).
> 
> *Check [www.bankid.com/rp/info](https://www.bankid.com/rp/info) for lastest version.*

<a name="eid-profile"></a>
**\[EidProfile\]**
> Deployment Profile for the Swedish eID Framework.


