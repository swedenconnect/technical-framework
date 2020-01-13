<img src="img/sweden-connect.png"></img>

# XML Profile for Signature Validation Assertion (SVA) Tokens

### Version 0.1 - 2020-01-06 - *Draft version*

*ELN-0617-v1.0*

---

## Table of Contents

## 1. Introduction
The Signature Validation Token (SVT) specification \[[SVT](#svt)\] defines the basic token to support signature validation in a way that can significantly extend the lifetime of a signature.

This document defines a profile for implementing SVT with a signed XML document. This document defines the following aspect of SVT usage:

- How to include reference data related to XML signatures and XML documents in an SVT.
- How to add an SVT token to a XML signature.

XML documents can have any number of signature elements, signing an arbitrary number of fragments of XML documents. The actual signature element may be included in the signed XML document (enveloped), include the signed data (enveloping) or may be separate from the signed content (detached).

To provide a generic solution for any type of XML signature an SVT is added to each XML signature element within the XML signature `<ds:Object>` element.

### 1.1. Requirements Notation

The key words **MUST**, **MUST** **NOT**, **REQUIRED**, **SHALL**, **SHALL** **NOT**, **SHOULD**, **SHOULD** **NOT**, **RECOMMENDED**, **MAY**, and **OPTIONAL** in this document are to be interpreted as described in BCP 14 \[[RFC2119](#rfc2119)\] \[[RFC8174](#rfc8174)\] when, and only when, they appear in all capitals, as shown here.

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behavior that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.

### 1.2. Definitions
Definitions in \[[SVT](#svt)\] applies also to this document.


### 1.2. Notatioin

#### 1.2.1 References to XML elements from XML Schemas

When referring to elements from the W3C XML Signature namespace
(`http://www.w3.org/2000/09/xmldsig\#`) the following syntax is used:

-  `<ds:Signature>`

When referring to elements from the ETSI XAdES XML Signature namespace
(`http://uri.etsi.org/01903/v1.3.2#`) the following syntax is used:

-  `<xades:CertDigest>`

When referring to elements defined in this document
(`http://id.swedenconnect.se/svt/1.0/sig-prop/ns`) the following syntax is used:

-  `<svt:Element>`

## 2. SVT in XML documents

When SVT is provided for XML signatures then one SVT SHALL be provided for each XML signature.

An SVT embedded within the XML signature element SHALL be placed in a  `<svt:SignatureValidationToken>` as defined in section 2.1.1.

### 2.1.1. SignatureValidationToken Signature Property

The `<svt:SignatureValidationToken>` element SHALL be placed in a `<ds:SignatureProperty>` element in accordance with \[[XMLDsig](xmldsig)\]. The `<ds:SignatureProperty>` element SHALL be placed inside a `<ds:SignatureProperties>` element inside a `<ds:Object>` element inside a `<ds:Signature>` element.

The `<svt:SignatureValidationToken>` element is defined by the following XML Schema:

```
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
    targetNamespace="http://id.swedenconnect.se/svt/1.0/sig-prop/ns"
    xmlns:svt="http://id.swedenconnect.se/svt/1.0/sig-prop/ns">
    <xs:element name="SignatureValidationToken" type="svt:SignatureValidationTokenType"/>
    <xs:complexType name="SignatureValidationTokenType">
        <xs:simpleContent>
            <xs:extension base="xs:string"> </xs:extension>
        </xs:simpleContent>
    </xs:complexType>
</xs:schema>
```

The SVT token SHALL be included as a string representation of the SVT JWT. Note that this is the string representation of the JWT without further encoding. The SVT MUST NOT be represented by the Base64 encoded bytes of the JWT string.

Example:
```
<ds:Signature Id="MySignatureId">
  ...
  <ds:Object>
    <ds:SignatureProperties>
      <ds:SignatureProperty Target="#MySignatureId">
        <svt:SignatureValidationToken>
              eyJ0eXAiOiJKV1QiLCJhb...2aNZ
        </svt:SignatureValidationToken>
      </ds:SignatureProperty>
    </ds:SignatureProperties>
  </ds:Object>
</ds:Signature>

```

## 3. SVT Claims
### 3.1. Signature reference data

The SVT SHALL contain a SigReference claims object that SHALL contain the following data:

Claim  | Value
--|--
`id` | The Id of the XML signature, if present
`sig_hash` | The hash over the signature value bytes
`sb_hash` | The hash over the canonicalized `<ds:SignedInfo>` element (The bytes the XML signature algorithm has signed to generated the signature value).


### 3.2. Signed Data reference data

An SVT according to this profile SHALL contain one instance of the SignedData claims object for each `<ds:Reference>` element in the `<ds:SignedInfo>` element. The SignedData claims object shall contain the following data:

Claim  | Value
--|--
`ref`  |  The value of the URI attribute of the corresponding `<ds:Reference>` element.
`hash`  |  The hash of all bytes identified corresponding `<ds:Reference>` element after applying all identified canonicalization and transformation algorithms. These are the same bytes that is hashed by the hash value in the `<ds:DigestValue>` element inside the `<ds:Reference>` element.


### 3.3. Signer certificate references

The SVT SHALL contain a CertReference claims object. The type claim of the CertReference claims object SHALL be either `cert`, `chain`, `cert_hash` or `cert_and_chain_hash`.

- The `cert` type SHALL be used when signature validation was performed using a single certificate not present in the target XML signature.
- The `chain` type SHALL be used when signature validation was performed using a certificate chain where some or all of the certificates in the chain is not present in the target signature.
- The `cert_hash` type SHALL be used when signature validation was performed using a single certificate that is present in the target XML signature.
- The `cert_and_chain_hash` type SHALL be used when signature validation was performed using a certificate chain where all of the certificates in the chain is present in the target signature.


**Note:** The `cert` type MUST NOT be used with a XAdES signatures where the signing certificate in the target signature is bound to the signature through a `<xades:CertDigest>` element.


<a name="normative-references"></a>
## 4. Normative References

<a name="rfc2119"></a>
**[RFC2119]**

> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="rfc5280"></a>
**[RFC5280]**

> [D. Cooper, S. Santesson, S. Farrell, S. Boeyen, R. Housley, W. Polk, Internet
> X.509 Public Key Infrastructure Certificate and Certificate Revocation List (CRL)
> Profile, May 2008](http://www.ietf.org/rfc/rfc5280.txt).

<a name="rfc8174"></a>
**[RFC8174]**

> [Leiba, B., Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words,
> May 2017](http://www.ietf.org/rfc/rfc8174.txt).

<a name="xmldsig"></a>
**[XMLDsig]**

> [XML Signature Syntax and Processing Version 1.1 - W3C Recommendation 11
> April 2013](https://www.w3.org/TR/2013/REC-xmldsig-core1-20130411/).

<a name="eidregistry"></a>
**\[EidRegistry\]**
> [Registry for identifiers assigned by the Swedish e-identification
> board](https://docs.swedenconnect.se/technical-framework/updates/ELN-0603_-_Registry_for_Identifiers.html).

<a name="svt"></a>
**\[SVT\]**
> [Signature Validation Token (SVT)](https://github.com/swedenconnect/technical-framework/blob/feature/is-109-sva-token/ELN-0615%20-%20Signature%20Validation%20Token%20-%20SVT.md)
