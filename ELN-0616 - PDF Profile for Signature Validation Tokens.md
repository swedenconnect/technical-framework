<img src="img/sweden-connect.png"></img>

# PDF Profile for Signature Validation Assertion (SVA) Tokens

### Version 0.1 - 2020-01-06 - *Draft version*

*ELN-0616-v1.0*

---

## Table of Contents

## 1. Introduction
The Signature Validation Token (SVT) specification \[[SVT](#svt)\] defines a the basic token to support signature validation in a way that can significantly extend the lifetime of a signature.

This document defines a profile for implementing SVT with a signed PDF document. This document defines the following aspect of SVT usage:

- How to include reference data related to PDF signatures and PDF documents in an SVT.
- How to add an SVT token to a PDF document.

PDF document signatures are added as incremental updates to the signed PDF document and signs all data of the PDF document up until the current signature. When more than one signature is added to a PDF document. The previous signature is signed by the next signature and can't be updated with additional data after this event.

To minimize the impact on PDF documents with multiple signatures and to stay backwards compatible with PDF software that do not understand SVT, PDF documents add one SVT token for all signatures of the PDF as an extension to a document timestamp added to the signed PDF as an incremental update. This SVT covers all signatures of the signed SVT.
<a name="requirements-notation"></a>
### 1.1. Requirements Notation

The key words **MUST**, **MUST** **NOT**, **REQUIRED**, **SHALL**, **SHALL** **NOT**, **SHOULD**, **SHOULD** **NOT**, **RECOMMENDED**, **MAY**, and **OPTIONAL** in this document are to be interpreted as described in BCP 14 \[[RFC2119](#rfc2119)\] \[[RFC8174](#rfc8174)\] when, and only when, they appear in all capitals, as shown here.

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behavior that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.


<a name="definitions"></a>
### 1.2. Definitions
Definitions in \[[SVT](#svt)\] applies also to this document.

## 2. SVT in PDF documents

An SVT added to a signed PDF document SHALL be added to a document timestamp accordance with ISO 32000-2:2017 \[[PDF](pdf)\].

The document timestamp contains an RFC 3161 time stamp token (TSTInfo) in EncapsulatedContentInfo of the CMS signature. The SVT SHALL be added to the timestamp token (TSTInfo) as an Extension object as defined in 2.1.1.

### 2.1.1. SVT extension to time stamp tokens

The SVT extension is an Extension suitable to be included in TSTInfo as defined by \[[RFC3161](rfc3161)\] <sup>1</sup>.

The SVT extension is identified by the Object Identifier (OID) `1.2.752.201.5.2` as defined in \[[EidRegistry](eidregistry)\].

This extension data (OCTET STRING) holds the bytes of SVT JWT, represented by a UTF-8 encoded string.

This extension SHALL NOT be marked critical.

> 1. Extensions in time stamp tokens according to \[[RFC3161](rfc3161)\] are imported from the definition of X.509 certificate extensions defined in \[[RFC5280](rfc5280)\].

## 3. SVT Claims
### 3.1. Signature reference data

The SVT SHALL contain a SigReference claims object that SHALL contain the following data:

Claim  | Value
--|--
`id` | Absent or a Null value
`sig_hash` | The hash over the signature value bytes
`sb_hash` | The hash over the DER encoded `SignedAttributes` in `SignerInfo`


### 3.2. Signed Data reference data

An SVT according to this profile SHALL contain exactly one instance of the SignedData claims object. The SignedData claims object shall contain the following data:

Claim  | Value
--|--
`ref`  |  The string representation of the **ByteRange** value of the PDF signature dictionary of the target signature. This is a sequence of integers separated by space where each integer pair specifies start index and length of a byte range.
`hash`  |  The hash of all bytes identified by the **ByteRange** value. This is the concatenation of all byte ranges identified by the **ByteRange** value.


### 3.3. Signer certificate references

The SVT SHALL contain a CertReference claims object. The type claim of the CertReference claims object SHALL be either `cert`, `chain`, `cert_hash` or `cert_and_chain_hash`.

- The `cert` type SHALL be used when signature validation was performed using a single certificate not present in the target PDF signature.
- The `chain` type SHALL be used when signature validation was performed using a certificate chain where some or all of the certificates in the chain is not present in the target signature.
- The `cert_hash` type SHALL be used when signature validation was performed using a single certificate that is present in the target PDF signature.
- The `cert_and_chain_hash` type SHALL be used when signature validation was performed using a certificate chain where all of the certificates in the chain is present in the target signature.


**Note:** The `cert` type MUST NOT be used with a PAdES signatures (SubFiler in the signature dictionary is set to "ETSI.CAdES.detached") where the signing certificate in the target signature is bound to the signature through ESSCertID or ESSCertIDv2 \[[RFC5035](rfc55035)\].


<a name="normative-references"></a>
## 4. Normative References

<a name="rfc2119"></a>
**[RFC2119]**

> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="rfc3161"></a>
**[RFC3161]**

> [Adams, C., Cain, P., Pinkas, D., Zuccherato, R., Internet X.509 Public Key
> Infrastructure Time-Stamp Protocol (TSP), August 2001](http://www.ietf.org/rfc/rfc3161.txt).

<a name="rfc5280"></a>
**[RFC5280]**

> [D. Cooper, S. Santesson, S. Farrell, S. Boeyen, R. Housley, W. Polk, Internet
> X.509 Public Key Infrastructure Certificate and Certificate Revocation List (CRL)
> Profile, May 2008](http://www.ietf.org/rfc/rfc5280.txt).

<a name="rfc5035"></a>
**[RFC5035]**

> [Shaad, J., Enhanced Security Services (ESS) Update: Adding CertID Algorithm
> Agility, August 2007](http://www.ietf.org/rfc/rfc5035.txt).

<a name="rfc8174"></a>
**[RFC8174]**

> [Leiba, B., Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words,
> May 2017](http://www.ietf.org/rfc/rfc8174.txt).

<a name="pdf"></a>
**[PDF]**

> [ISO 32000-2:2017, Document management - Portable Document Format - Part 2:
> PDF 2.0, July 2017](https://www.iso.org/obp/ui/#iso:std:iso:32000:-2:ed-1:v1:en).

<a name="eidregistry"></a>
**\[EidRegistry\]**
> [Registry for identifiers assigned by the Swedish e-identification
> board](https://docs.swedenconnect.se/technical-framework/updates/ELN-0603_-_Registry_for_Identifiers.html).

<a name="svt"></a>
**\[SVT\]**
> [Signature Validation Token (SVT)](https://github.com/swedenconnect/technical-framework/blob/feature/is-109-sva-token/ELN-0615%20-%20Signature%20Validation%20Token%20-%20SVT.md)
