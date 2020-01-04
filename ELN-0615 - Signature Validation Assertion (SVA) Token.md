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


### 1.1. Definitions

This document use the following defined terms <sup>1</sup>:

Term | Meaning
--- | ---
Signed Data  | The data covered by a particular signature. This is typically equivalent to the signed document and represents the data that the signer intended to sign. In some cases, such as in some XML signatures, the signed data can be the colleciton of several data fragments each referenced by the signature. In the case of PDF, this is the data covered by the "ByteRange" parameter in the signature dictionary.
Signed Bytes  | These are the actual bytes of data that was hashed and signed by the signature algorithm. In most cases this is not the actual Signed Data, but a collection of signature metadata that includes references (hash) of the Signed Data as well as information about algorithms and other data bound to a signature. In XML this is the canonicalized SignedInfo element and in CMS/PDF signatures this is the DER encoded SignedAttributes structure.

> \[1\]: When these terms are used in their defined meaning, they appear with a capitalized first letter as shown in the table.


## 2. SVA Token

### 2.1. Function

The function of the SVA token is to capture evidence of signature validity at one instance of secure signature validation process and to use that evicdence to eliminate the need to preform any repeated cryptographic validation of the original signature value as well as reliance on any hash values bound to that signature. The SVA token achieves this through binding the following information to a specific electronic singature though external evidence:

- Unique identification of the signature
- The data and metadata signed by the signature
- The signer's certificate that was validated as part of signature validation
- The certificate chain that was used to validate the signer's certificate
- Assertion that this signature was validated, when validaton was performed, which procedures that was used to validate the signature and the outcome of the validation
- Assertion that evidence of time when the signature is known to have existed was validated, which procedures that was used to validate the time of existance and the outcome of the validation

Using an SVA token is equivalent to validating a signed document in a system once and then using that document multipple times without revalidating the signature for each usage. Such procedure is common in systems where the document is residing in a safe and trusted environment where it is unlikely to be modified between usages. The SVA token simply allows the time and environment where the document can be stored and used to expand beyond a local controlled environment and a short instance of time.

Using the SVA token, the signed document can be validated once using a reliable trusted service and then that SVA token can be used to extend reliance of that secure validation process. The SVA token is therefore not only a valuable tool to extend the lifetime of a signed document, but also a useful tool to deploy and use one secure external validation service instead of having a close integration between signature validation and document usage.

### 2.2. SVA Token Syntax
The SVA token is carried in a JSON Web Token (JWT) in accordance with \[[RFC7519](#rfc7519)\].

### 2.2.1. Data types
Content of claims in a SVA token MUST comply with a specified Claims Data Type according to the following table:

Claims Data Type | JSON Data Type | Description
---|---|---
**String**  | string  | Any case sensitive string value.
**Base64Binary**  | string  | String representation of Base-64 encoded byte array of binary data.
**StringOrURI**  | string  | As defined in \[[RFC7519](#rfc7519)\]. (A JSON string value, with the additional requirement that while arbitrary string values MAY be used, any value containing a ":" character MUST be a URI).
**URI**  | string  | The string MUST be a valid URI 
**Integer**  | number  | A 32 bit signed integer value (A value from -2<sup>31</sup> to 2<sup>31</sup> - 1).
**Long**  | number  |  A 64 bit signed integer value (A value from -2<sup>63</sup> to 2<sup>63</sup> - 1).
**NumericDate**  |  number |  As defined in \[[RFC7519](#rfc7519)\]. (A JSON numeric value representing the number of seconds from 1970-01-01T00:00:00Z UTC until the specified UTC date/time, ignoring leap seconds.)
**Boolean**  | boolean  | the explicit value true or false.
**Object\<Class\>**  | object  | A JSON object holding a claims object of a class defined in this document (see section 2.2.2).
**Map\<Type\>**  | object  | A JSON object with one or more named values where each value is of the declared Type. Example: Map\<String\> according to this notation is equivalent to a Java object of type Map\<String, String\>. The Map key class declaration is omitted in this type notation as the name of a JSON value is allways a string value.
**Array**  | array  |  An array of values of a specific data type as defined in this table. An array is expressed in this specification by square brackets. E.g. **\[String\]** is an expression of an array of String values and **\[doc_hash\]** is an array of ClaimsObject of type doc_hash.
**Null** | null | Representing an absent value. A claim with a null value is equivalent with an absent claim in this specification.

#### 2.2.2. SVA token claims

The SVA token JWT SHALL contain claims according to the following table.

Name | Data Type | Value | Precence
--- | --- | --- | ---
`jti`  | **String** | A "JWT ID" registered claim according to \[[RFC7519](#rfc7519)\]. It is RECOMMENDED that the identifier holds a headecimal string representation of a 128 bit unsigned integer. |MANDATORY
`iss`  | **StringOrURI**  | A "Issuer" registered claim according to \[[RFC7519](#rfc7519)\]. An arbitrary unique identifier of the SVA issuer. This value SHOULD have the value of an URI identifier based on a domain owned by the issuer. | MANDATORY
`iat`  | **NumericDate**  | An "Issued At" registered claim according to \[[RFC7519](#rfc7519)\] expressig the time when this SVA token was issued  | MANDATORY
`aud`  | **\[StringOrURI\]** or **StringOrURI** | An "Audience" registered claim according to \[[RFC7519](#rfc7519)\]. The audience claim is an array of one or more identifiers, identifying intended recipients of the SVA token. Each identifier MAY identify a single entity, a group of entities or a common policy adopted by a group of entites. If only one value is provided it MAY be provided as a single StringOrURI value instead of as an array of values.| OPTIONAL
`exp`  | **NumericDate**  | An **Expiration Time** registered claim according to \[[RFC7519](#rfc7519)\] expressig the time when services and responsibilities related to this SVA token is no longer provided by the SVA Issuer. The precice meaning of the expiration time claim is defined by local policy. See implementation note below <sup>2</sup>   | OPTIONAL
`sva_claims`  | **Object\<SVAClaims\>**  | One instance of the `sva_claims` **ClaimsObject** as defined in section 2.2.3.1  | MANDATORY

> \[2\]: An SVA token asserts that a certain validation process was undertaken at a certain instance of time. This fact never changes and never expires. However, some aspects of the SVA claim such as liability for false claims or service provision related to a specific SVA token may stop after a certain period of time, such as a service where an old SVA token can be upgraded to a new SVA token signed with fresh keys and algorithms.


#### 2.2.3. Claim object classes

##### 2.2.3.1. The SVAClaims object
The sva_claims ClaimsObject contains the following values:

Name | Data Type | Value | Precence
--- | --- | --- | ---
`ver` | **String** | Version. This version is indicated by the value "1.0" | MANDATORY
`hash_algo`  | **URI** | The URI identifier of the hash algorithm used to provide hash values within the SVA token claims. The URI identifier SHALL be one defined in \[[RFC6931](#rfc6931)\] or in the IANA registry defined by this RFC. | MANDATORY
`chain`  | \[**Base64Binary**\]  | An optional array of DER encoded chain of certificates that MAY be used to validate signature that signs the SVA token. The first certificate in the chain must hold the public key that is used to validate the SVA token signature and any folloing certificates MAY be used to verify the first certificate  | OPTIONAL
`sig`  | **\[Object\<Signature\>\]**   | The `sig` **ClaimsObject** represent the claims related to a single signature. If the SVA token contains signature validation assertions for more than one signature, then each signature is represented by a separate `sig` **ClaimsObject**. An SVA token MUST contain at least one `sig` **ClaimsObject**  | MANDATORY

##### 2.2.3.2. The Signature object
The sig ClaimsObject contains claims related to signature validation assertioins for one signature and contains the following values:

Name | Data Type | Value | Precence
--- | --- | --- | ---
`type` | **String** | The identifier of the type of signature covered by this sig ClaimsObject. Type identifiers are defined by profiles of this specification specifying the use of SVA tokens with different types of signed documents. See section 3. | MANDATORY
`ref`  | **Object\<Reference\>** | Reference information identifying the target signature and the Signed Bytes of the signature. | MANDATORY |
|`cert_hash` | **Base64Binary** | The hash value of the signing certificate used to validate the target signature. | MANDATORY |
| `chain_hash` | **Base64Binary** | Hash value of the concattenated bytes of the certificate chain provided in the target signature including the certificate of the signer. The order of the certificates in the target chain must be identical to the order of certificates as they appear in the target signature.| MANDATORY
|`doc_hash` | **Object\<DocHash\>** | Providing hash values and references to Signed Data signed by the target signature. | MANDATORY  |
|`result` | **Object\<Result\>** | Information about the results of signature validation according to defined validation procedures. | MANDATORY |
|`verified_times` | **Object\<VerifiedTimes\>**  | Collection of assertions that the target signature has been verified to exist at specific instances of time in the past. | OPTIONAL |

##### 2.2.3.3. The Reference ClaimsObject

Name | Data Type | Value | Precence
--- | --- | --- | ---
`id`  | **String**  | Optional identifier assigned to the target signature. The source of this identifier is defined by a SVA token profile according to section 3  |  OPTIONAL
`sig_hash`  | **Base64Binary** | Hash value of the target signature value | MANDATORY
`sb_hash` | **Base64Binary** | Hash value of the Signed Bytes of the target signature | MANDATORY

##### 2.2.3.4. The DocHash ClaimsObject

##### 2.2.3.5. The Result ClaimsObject

##### 2.2.3.6. The VerifiedTimes ClaimsObject

##### 2.2.3.7. The PolicyValidation ClaimsObject

##### 2.2.3.7. The Extension ClaimsObject


2.2.3. SVA JWT header

## 3. Profiles
XML and PDF etc defined in other documents


## 4. Signature Validation with SVA Token

## 5. Examples

## 6. Normative References


## Appendix A. Deleted stuff

#### 2.1.1. Principles of trust
This technical specification makes no claims about when it is suitable to use an SVA token to support validation of old signatures or under what circumstances it is necessary to actually verify the original signature also after considerable time. It should be noted however that no validation of electronic signatures is possible withour relying on validatiton statements from trusted authorities such as:

- The certificate is a statement by a trusted authority that the named subject is to sole entity in control of the private signing key.
- The certificate reovocation list or OCSP response is a statement that a certificate was valid (or at least not revoked) at a certain point of time.
- A time stamp is a statment that some information existed at a certain instance of time.

In this context, the SVA should be regared as comparable statment that requires the issuer to be trustworthy and not compromized in the same way that traditional signature validation requires that the issuer of the signer certificate is trustworthy and not compromized.

The risk introduced when validating an old signature is that all stored evidence of validity must be verified and if verification of a signle token fails, the whole chain of proof fails. In this scenario, the SVA may offer a more managable risk management by providing one sigle verifiable statment of validity based on a trusted verification process perfomed when the evidence were relatively new and fresh.
