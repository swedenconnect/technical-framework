<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# PDF Profile for Signature Validation Tokens

### Version 1.0 - 2020-01-24 - *Draft version*

Registration number: **2020-61**

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (DIGG)</a>, 2015-2020. All Rights Reserved.
</p>

## Table of Contents


---

<a name="introduction"></a>
## 1. Introduction

The "Signature Validation Token" specification \[[SVT](#svt)\] defines a basic token to support signature validation in a way that can significantly extend the lifetime of a signature.

This specification defines a profile for implementing SVT with a signed PDF document, and defines the following aspects of SVT usage:

- How to include reference data related to PDF signatures and PDF documents in an SVT.
- How to add an SVT token to a PDF document.

PDF document signatures are added as incremental updates to the signed PDF document and signs all data of the PDF document up until the current signature. When more than one signature is added to a PDF document the previous signature is signed by the next signature and can not be updated with additional data after this event.

To minimize the impact on PDF documents with multiple signatures and to stay backwards compatible with PDF software that do not understand SVT, PDF documents add one SVT token for all signatures of the PDF as an extension to a document timestamp added to the signed PDF as an incremental update. This SVT covers all signatures of the signed SVT.

<a name="requirements-notation"></a>
### 1.1. Requirements Notation

The key words **MUST**, **MUST** **NOT**, **REQUIRED**, **SHALL**, **SHALL** **NOT**, **SHOULD**, **SHOULD** **NOT**, **RECOMMENDED**, **MAY**, and **OPTIONAL** in this document are to be interpreted as described in BCP 14 \[[RFC2119](#rfc2119)\] \[[RFC8174](#rfc8174)\] when, and only when, they appear in all capitals, as shown here.

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behavior that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.

<a name="definitions"></a>
### 1.2. Definitions
The definitions in \[[SVT](#svt)\] apply also to this document.

<a name="svt-in-pdf-documents"></a>
## 2. SVT in PDF Documents

An SVT added to a signed PDF document SHALL be added to a document timestamp accordance with ISO 32000-2:2017 \[[PDF](pdf)\].

The document timestamp contains an RFC 3161 timestamp token (TSTInfo) in EncapsulatedContentInfo of the CMS signature. The SVT SHALL be added to the timestamp token (TSTInfo) as an Extension object as defined in [section 2.1.1](#svt-extension-to-timestamp-tokens).

<a name="svt-extension-to-timestamp-tokens"></a>
### 2.1.1. SVT Extension to Timestamp Tokens

The SVT extension is an Extension suitable to be included in TSTInfo as defined by \[[RFC3161](rfc3161)\]<sup>*</sup>.

The SVT extension is identified by the Object Identifier (OID) `1.2.752.201.5.2` as defined in \[[EidRegistry](eidregistry)\].

This extension data (OCTET STRING) holds the bytes of SVT JWT, represented as a UTF-8 encoded string.

This extension SHALL NOT be marked critical.

> [\*\]: Extensions in timestamp tokens according to \[[RFC3161](rfc3161)\] are imported from the definition of the X.509 certificate extensions defined in \[[RFC5280](rfc5280)\].

<a name="svt-claims"></a>
## 3. SVT Claims

<a name="signature-reference-data"></a>
### 3.1. Signature Reference Data

The SVT SHALL contain a **SigReference** claims object that SHALL contain the following data:

Claim | Value
--- | ---
`id` | Absent or a **Null** value.
`sig_hash` | The hash over the signature value bytes.
`sb_hash` | The hash over the DER encoded `SignedAttributes` in `SignerInfo`.


<a name="signed-data-reference-data"></a>
### 3.2. Signed Data Reference Data

An SVT according to this profile SHALL contain exactly one instance of the **SignedData** claims object. The **SignedData** claims object shall contain the following data:

Claim  | Value
--- | ---
`ref`  | The string representation of the **ByteRange** value of the PDF signature dictionary of the target signature. This is a sequence of integers separated by space where each integer pair specifies the start index and length of a byte range.
`hash` | The hash of all bytes identified by the **ByteRange** value. This is the concatenation of all byte ranges identified by the **ByteRange** value.

<a name="signer-certificate-references"></a>
### 3.3. Signer Certificate References

The SVT SHALL contain a **CertReference** claims object. The `type` claim of the **CertReference** claims object SHALL be either `cert`, `chain`, `cert_hash` or `cert_and_chain_hash`.

- The `cert` type SHALL be used when signature validation was performed using a single certificate not present in the target PDF signature.
- The `chain` type SHALL be used when signature validation was performed using a certificate chain where some or all of the certificates in the chain are not present in the target signature.
- The `cert_hash` type SHALL be used when signature validation was performed using a single certificate that is present in the target PDF signature.
- The `cert_and_chain_hash` type SHALL be used when signature validation was performed using a certificate chain where all of the certificates in the chain are present in the target signature.

**Note:** The `cert` type MUST NOT be used with a PAdES signatures (SubFiler in the signature dictionary is set to "ETSI.CAdES.detached") where the signing certificate in the target signature is bound to the signature through ESSCertID or ESSCertIDv2 \[[RFC5035](rfc55035)\].


## 4. JOSE header

### 4.1. SVT signing key reference

The SVT JOSE Header must contain one of the following header parameters in accordance with \[[RFC7515](#rfc7515)\], for storing a reference to the public key used to verify the signature on the SVT:

Header Parameter | Value
--- | ---
`x5c` | Holds an X.509 certificate \[[RFC5280](rfc5280)\] or a chain of certificates. The certificte holding the public key that verifies the signature on the SVT MUST be the first certificate in the chain.
`kid`  | A key identifier holding the Base64 encoded hash value of the certificate that can verify the signature on the SVT. The hash algorithm MUST be the same hash algorithm used when signing the SVT as specified by the `alg` header parameter. The referenced certificate SHOULD be the same certificate taht was used to sign the document timestamp that contains the SVT.


<a name="normative-references"></a>
## 5. Normative References

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

<a name="rfc7515"></a>
**[RFC7515]**
> [Jones, M., Bradley, J., Sakimura, N., JSON Web Signature (JWS), May 2015](https://www.ietf.org/rfc/rfc7515.txt).

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
> [Swedish eID Framework - Registry for identifiers](https://docs.swedenconnect.se/technical-framework/latest/03_-_Registry_for_Identifiers.html).

<a name="svt"></a>
**\[SVT\]**
> [Signature Validation Token](https://docs.swedenconnect.se/technical-framework/updates/15_-_Signature_Validation%_Token.html).
