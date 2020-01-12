<img src="img/sweden-connect.png"></img>

# PDF Profile for Signature Validation Assertion (SVA) Tokens

### Version 0.1 - 2020-01-06 - *Draft version*

*ELN-0616-v1.0*

---

## Table of Contents

## 1. Introduction
The Signature Validation Token (SVT) specification \[[SVT](#svt)\] defines a the basic token to support signature validation in a way that can significantly extend the lifetime of a signature.

This document defines a profile for implementing SVT with a signed PDF document. This document defines the following aspect of SVT usage:

- How to inlcude reference data related to PDF signatures and PDF documents in an SVT.
- How to add an SVT token to a PDF document.

<a name="requirements-notation"></a>
### 1.1. Requirements Notation

The key words **MUST**, **MUST** **NOT**, **REQUIRED**, **SHALL**, **SHALL** **NOT**, **SHOULD**, **SHOULD** **NOT**, **RECOMMENDED**, **MAY**, and **OPTIONAL** in this document are to be interpreted as described in BCP 14 \[[RFC2119](#rfc2119)\] \[[RFC8174](#rfc8174)\] when, and only when, they appear in all capitals, as shown here.

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behavior that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.


<a name="definitions"></a>
### 1.2. Definitions
Definitions in \[[SVT](#svt)\] applies also to this document.

## 2. SVT in PDF documents

PDF document signatures are added as incremental updates to the signed PDF document and signs all data of the PDF doucment up until the current signature. When more than one signature is added to a PDF document. The previous signature is signed by the next signature and can't be updated with additional data after this event.

To minimize the impapact on PDF documetns with mutliple signatures and to stay backwards compatible with PDF software that do not under stand SVT, PDF docuements add one SVT token for all signatures of the PDF as an extension to a docuement timestamp added to the signed PDF as an incremental update. This SVT conevers all signatures of the signed SVT.

The document timestamp extended with an SVT is a document timesatmp in accordance with ISO 32000-2:2017 (The PDF standard) holding an RFC 3161 time stamp token (TSTInfo) in EncapsulatedContentInfo of the CMS signature. The SVT is stored in the time satmp token (TSTInfo) as an Extension object as defined in 2.1.1.

### 2.1.1. SVT extension to time stamp tokens

The SVT extension is identified by the following Object Identifier (OID).

>









## 3. SVT Claims
### 3.1. Signature reference data

Specify the source of signature and Signed Bytes


### 3.2. Signed Data reference data

Specify the number of SignedData objects.
Specify what information that goes into the SignedData object.

### 3.3. Signer certificate references

Specify what type of cert reference to include for PDF signatures



<a name="normative-references"></a>
## 6. Normative References

<a name="rfc2119"></a>
**[RFC2119]**

> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="rfc8174"></a>
**[RFC8174]**

> [Leiba, B., Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words,
> May 2017](http://www.ietf.org/rfc/rfc8174.txt).

<a name="svt"></a>
**\[SVT\]**
> [Signature Validation Token (SVT)](https://github.com/swedenconnect/technical-framework/blob/feature/is-109-sva-token/ELN-0615%20-%20Signature%20Validation%20Token%20-%20SVT.md)
