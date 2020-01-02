<img src="img/sweden-connect.png"></img>

# Signature Validation Assertion (SVA) Token

### Version 1.0 - 2020-01-02 - *Draft version*

*ELN-0615-v1.0*

---

## Table of Contents

## 1. Introduction
Electronic signatures have a limited lifespan where they can be validated and determined to be authentic. Many factors may contribute to make it harder to validate electronic signatures over time such as:

- Trusted information about the validity of the signing certificate is not available
- No proof of time when the signature was actually created
- Algorithms used to create the signature is no longer considered secure
- Services necessary to validate the signature are no longer available
- Inability to verify supporting evidence such as, CA certificates, OCSP responses, revociation lists or simestamps

The challenge to validate an electronic signature is increasing with time to the point where it simply is impossible to verify the actual signature with sufficient level of assurance.

Current existing standards such as the ETSI AdES profiles for CMS, XML adn PDF signatures can be used to prolong the lifetime of signaure by storing data that supports validation of the signature beyond the lifetime of the signing certificate. The problem with this approach is that the amount of information that must be stored with the signature is growing over time. The growing amount of information and signed objects that must be validated in order to verify the original signature is growing in complexity to the point where it may become infesible to validate the original signatue.

The signatue validation assertion (SVA) defined in this document takes a fundamentally different approach to the problem by providing an assertion that asserts the validity of a signature. The SVA is issued by a trusted authority and assertes that a particular signature was successfully validated according to defined procedures at a certain time. The basic idea and intent behind the SVA that once the SVA is issued by a trusted authority, any future validation of that signature is satisfied by validating the SVA only withou any need to validate the original signature.

This approach drastically reduces the complexity of signature validation of old signatures for the simple reason that validating the SVA only requires validation of one signature (in the most optimal case). The signature over the SVA. The SVA can be signed with keys and algorithms that makes it valid for a considerable time in the future and if needed, the SVA can be re-issued with fresh keys and signature to extend the liftime of the original signature validity.

### 1.1. Requirements Notation

The key words **MUST**, **MUST** **NOT**, **REQUIRED**, **SHALL**, **SHALL** **NOT**, **SHOULD**, **SHOULD** **NOT**, **RECOMMENDED**, **MAY**, and **OPTIONAL** in this document are to be interpreted as described in BCP 14 \[[RFC2119](#rfc2119)\] \[[RFC8174](#rfc8174)\] when, and only when, they appear in all capitals, as shown here.

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behaviour that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.


### 1.1 Definitions

This document use the following defined terms <sup>1</sup>:

Term | Meaning
--- | ---
Signed Data  | The data covered by a particular signature. This is typically equivalent to the signed document and represents the data that the signer intended to sign. In some cases, such as in some XML signatures, the signed data can be the colleciton of several data fragments each referenced by the signature. In the case of PDF, this is the data covered by the "ByteRange" parameter in the signature dictionary.
Signed Bytes  | These are the actual bytes of data that was hashed and signed by the signature algorithm. In most cases this is not the actual Signed Data, but a collection of signature metadata that includes references (hash) of the Signed Data as well as information about algorithms and other data bound to a signature. In XML this is the canonicalized SignedInfo element and in CMS/PDF signatures this is the DER encoded SignedAttributes structure.

> \[1\]: When these terms are used in their defined meaning, they appear with a capitalized first letter as shown in the table.


## 2. SVA Token

### 2.1 Function

The intention of the SVA token is to eliminate the need to preform any cryptographic validation of the original signature and to apply any of the cryptograhpic algorithms specified by the original signature. This is achieved mainly through three main functions:

- The primary function of the SVA is to authenticate exactly the same information about a signed document that could be authenticated through the original signature without having to apply any of the orignal signature algorithms or keys. This is essential in order to allow the choice of algoritms to be upgraded if and when any used algorithms no longer is regared secure.
- The second function of the SVA is to assert how and when the signature was validated and the result of this validation process.
- The third function of the SVA is to assert any validated proof of time that asserts the existence of this signature and how that proof of time was validated.

The SVA enabled relying party application SHALL have access to at least the following trusted information about the orignial signature after validating the SVA token:

- The authenticated original signature values
- The authenticated original Signed Bytes
- The authenticated Signed Data
- The authenticated signer certificate.
- The authenticated certificate chain originally used to verify the signer certificates
- Information about how the signature was validated and when
- Information about any instances time when it has been verified that this signature existed

#### 2.1.1 Principles of trust
This technical specification makes no claims about when it is suitable to use an SVA token to support validation of old signatures and under what circumstances it is necessary to actually verify the original signature also after considerable time. It should be noted however that no validation of electronic signatures is possible withour relying on validatiton statements from trusted authorities such as:

- The certificate is a statement by a trusted authority that the named subject is to sole entity in control of the private signing key.
- The certificate reovocation list or OCSP response is a statement that a certificate was valid (or at least not revoked) at a certain point of time.
- A time stamp is a statment that some information existed at a certain instance of time.

In this context, the SVA should be regared as comparable statment that requires the issuer to be trustworthy and not compromized in the same way that traditional signature validation requires that the issuer of the signer certificate is trustworthy and not compromized.

The risk introduced when validating an old signature is that all stored evidence of validity must be verified and if verification of a signle token fails, the whole chain of proof fails. In this scenario, the SVA may offer a more managable risk management by providing one sigle verifiable statment of validity based on a trusted verification process perfomed when the evidence were relatively new and fresh.

### 2.2 SVA Token Syntax
The SVA token is carried in a JSON Web Token (JWT) in accordance with \[[RFC7519](#rfc7519)\].

#### 2.2.1 Standard JWT claims

Name | Claims | Value | Precence
--- | --- | --- | ---
jti  | JWT ID | A string identifier holding a String representation of a hexadecimal integer of at least 128 bit size. |MANDATORY
iss  | Issuer  | An arbitrary unique identifier of the SVA issuer. This value should have the value of an URI identifier using a domain owned by the issuer. | MANDATORY
exp | Expiry time  | The time when this SVA expires. It is a matter of local policy whether an SVA should expire. Absent expiration date has the meaning that this SVA is regared as valid for as long as it can be reliably verified by the relying party | OPTIONAL
iat  | Issue time   | The time when this SVA was issued  | MANDATORY
aud  | Audience  | An arbitrary identifier of the intended audience for this SVA. This identifier MAY identify a an identity of an entity or group, a contract or a policy that is meaningful to the target audience |


#### 2.2.1 SVA claims

##### 2.2.1.1 The sig object

##### 2.2.1.2 The ref object

##### 2.2.1.2 The doc_hash object

##### 2.2.1.2 The result object

##### 2.2.1.2 The verified_times object


## 3 Profiles
XML and PDF etc defined in other documents


## 4 Signature Validation with SVA Token
