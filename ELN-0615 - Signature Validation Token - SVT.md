<img src="img/sweden-connect.png"></img>

# Signature Validation Token (SVT)

### Version 0.1 - 2020-01-06 - *Draft version*

*ELN-0615-v1.0*

---

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirements Notation](#requirements-notation)

    1.2. [Definitions](#definitions)

2. [**Signature validation token**](#signature-validation-token)

    2.1. [Function](#function)

    2.2. [Signature Validation Token Syntax](#signature-validation-token-syntax)

    2.2.1. [Data types](#data-types)

    2.2.2. [Signature Validation token JWT claims](#signature-validation-token-jwt-claims)

    2.2.3. [Claim object classes](#claim-object-classes)

    2.2.3.1. [The SigValidation object](#the-sigvalidation-object)

    2.2.3.2. [The Signature claims object](#the-signature-claims-object)

    2.2.3.3. [The SigReference claims object](#the-sigreference-claims-object)

    2.2.3.4. [The SignedData claims object](#the-signeddata-claims-object)

    2.2.3.5. [The PolicyValidation claims object](#the-policyvalidation-claims-object)

    2.2.3.6. [The TimeVerification claims object](#the-timeverification-claims-object)

    2.2.3.7. [The CertReference claims object](#the-certreference-claims-object)

    2.2.4. [SVT JOSE header](#svt-jose-header)

3. [**Profiles**](#profiles)

4. [**Signature Validation with signature validation token**](#signature-validation-with-signature-validation-token)

5. [**Examples**](#examples)

6. [**Normative References**](#normative-references)

<a name="introduction"></a>
## 1. Introduction
Electronic signatures have a limited lifespan where they can be validated and determined to be authentic. Many factors may contribute to make it harder to validate electronic signatures over time such as:

- Trusted information about the validity of the signing certificate is not available
- No proof of time when the signature was actually created
- Algorithms used to create the signature is no longer considered secure
- Services necessary to validate the signature are no longer available
- Inability to verify supporting evidence such as, CA certificates, OCSP responses, revocation lists or time stamps

The challenge to validate an electronic signature is increasing with time to the point where it simply is impossible to verify the actual signature with sufficient level of assurance.

Current existing standards such as the ETSI AdES profiles for CMS, XML and PDF signatures can be used to prolong the lifetime of a signature by storing data that supports validation of the signature beyond the lifetime of the signing certificate. The problem with this approach is that the amount of information that must be stored with the signature is growing over time. The growing amount of information and signed objects that must be validated in order to verify the original signature is growing in complexity to the point where it may become infeasible to validate the original signature.

The signature validation token (SVT) defined in this document takes a fundamentally different approach to the problem by providing an evidence that asserts the validity of a signature. The SVT is issued by a trusted authority and asserts that a particular signature was successfully validated according to defined procedures at a certain time. The basic idea and intent behind the SVT is that once the SVT is issued by a trusted authority, any future validation of that signature is satisfied by validating the SVT without any need to also validate the original signature.

This approach drastically reduces the complexity of signature validation of old signatures for the simple reason that validating the SVT just requires validation of the signature over the SVT. The SVT can be signed with keys and algorithms that makes it valid for a considerable time in the future and the SVT can be re-issued with fresh keys and signature to extend the lifetime of the original signature validity, if necessary.

<a name="requirements-notation"></a>
### 1.1. Requirements Notation

The key words **MUST**, **MUST** **NOT**, **REQUIRED**, **SHALL**, **SHALL** **NOT**, **SHOULD**, **SHOULD** **NOT**, **RECOMMENDED**, **MAY**, and **OPTIONAL** in this document are to be interpreted as described in BCP 14 \[[RFC2119](#rfc2119)\] \[[RFC8174](#rfc8174)\] when, and only when, they appear in all capitals, as shown here.

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behavior that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.


<a name="definitions"></a>
### 1.2. Definitions

This document use the following defined terms <sup>1</sup>:

Term | Meaning
--- | ---
Signed Data  | The data covered by a particular signature. This is typically equivalent to the signed document and represents the data that the signer intended to sign. In some cases, such as in some XML signatures, the signed data can be the collection of several data fragments each referenced by the signature. In the case of PDF, this is the data covered by the "ByteRange" parameter in the signature dictionary.
Signed Bytes  | These are the actual bytes of data that was hashed and signed by the signature algorithm. In most cases this is not the actual Signed Data, but a collection of signature metadata that includes references (hash) of the Signed Data as well as information about algorithms and other data bound to a signature. In XML this is the canonicalized SignedInfo element and in CMS/PDF signatures this is the DER encoded SignedAttributes structure.

> \[1\]: When these terms are used in their defined meaning, they appear with a capitalized first letter as shown in the table.


<a name="signature-validation-token"></a>
## 2. Signature validation token

<a name="function"></a>
### 2.1. Function

The function of the Signature Validation Token (SVT) is to capture evidence of signature validity at one instance of secure signature validation process and to use that evidence to eliminate the need to perform any repeated cryptographic validation of the original signature value as well as reliance on any hash values bound to that signature. The SVT achieves this through binding the following information to a specific electronic signature though external evidence:

- Unique identification of the signature
- The data and metadata signed by the signature
- The signer's certificate that was validated as part of signature validation
- The certificate chain that was used to validate the signer's certificate
- Assertion that this signature was validated, when validation was performed, which procedures that was used to validate the signature and the outcome of the validation
- Assertion that evidence of time when the signature is known to have existed was validated, which procedures that was used to validate the time of existence and the outcome of the validation

Using an SVT is equivalent to validating a signed document in a system once and then using that document multiple times without revalidating the signature for each usage. Such procedure is common in systems where the document is residing in a safe and trusted execution environment where it is protected against modification during usage. The SVT simply allows the time and environment where the document can be stored and used to expand beyond a local controlled environment and a short instance of time.

Using the SVT, the signed document can be validated once using a reliable trusted service and then that SVT can be used to extend reliance of that secure validation process. The SVT is therefore not only a valuable tool to extend the lifetime of a signed document, but also a useful tool to deploy and use one secure external validation service instead of having a close integration between signature validation and document usage.

<a name="signature-validation-token-syntax"></a>
### 2.2. Signature Validation Token Syntax
The SVT is carried in a JSON Web Token (JWT) in accordance with \[[RFC7519](#rfc7519)\].

<a name="data-types"></a>
### 2.2.1. Data types
Content of claims in an SVT are specified using the claims data types in the following table:

Claims Data Type | JSON Data Type | Description
---|---|---
**String**  | string  | An arbitrary case sensitive string value.
**Base64Binary**  | string  | String representation of Base-64 encoded byte array of binary data.
**StringOrURI**  | string  | As defined in \[[RFC7519](#rfc7519)\]. (A JSON string value, with the additional requirement that while arbitrary string values MAY be used, any value containing a ":" character MUST be a URI).
**URI**  | string  | A valid URI
**Integer**  | number  | A 32 bit signed integer value (from -2<sup>31</sup> to 2<sup>31</sup> - 1).
**Long**  | number  |  A 64 bit signed integer value (from -2<sup>63</sup> to 2<sup>63</sup> - 1).
**NumericDate**  |  number |  As defined in \[[RFC7519](#rfc7519)\]. (A JSON numeric value representing the number of seconds from 1970-01-01T00:00:00Z UTC until the specified UTC date/time, ignoring leap seconds.)
**Boolean**  | boolean  | The explicit value true or false.
**Object\<Class\>**  | object  | A JSON object holding a claims object of a class defined in this document (see section 2.2.2).
**Map\<Type\>**  | object  | A JSON object with name value pairs where the value is an object of the specified Type in the notation. Example: Map\<String\> according to this notation is a JSON object with name value pairs where all values are of type String.
**Array**  | array  |  An array of values of a specific data type as defined in this table. An array is expressed in this specification by square brackets. E.g. **\[String\]** indicates an array of String values and **\[Object\<DocHash\>\]** indicates an array of DocHash objects.
**Null** | null | Representing an absent value. A claim with a null value is equivalent with an absent claim in this specification.

<a name="signature-validation-token-jwt-claims"></a>
#### 2.2.2. Signature Validation token JWT claims

The signature validation token JWT SHALL contain claims according to the following table.

Name | Data Type | Value | Presence
--- | --- | --- | ---
`jti`  | **String** | A "JWT ID" registered claim according to \[[RFC7519](#rfc7519)\]. It is RECOMMENDED that the identifier holds a hexadecimal string representation of a 128 bit unsigned integer. |MANDATORY
`iss`  | **StringOrURI**  | A "Issuer" registered claim according to \[[RFC7519](#rfc7519)\]. An arbitrary unique identifier of the SVT issuer. This value SHOULD have the value of an URI identifier based on a domain owned by the issuer. | MANDATORY
`iat`  | **NumericDate**  | An "Issued At" registered claim according to \[[RFC7519](#rfc7519)\] expressing the time when this SVT was issued  | MANDATORY
`aud`  | **\[StringOrURI\]** or **StringOrURI** | An "Audience" registered claim according to \[[RFC7519](#rfc7519)\]. The audience claim is an array of one or more identifiers, identifying intended recipients of the SVT. Each identifier MAY identify a single entity, a group of entities or a common policy adopted by a group of entities. If only one value is provided it MAY be provided as a single StringOrURI value instead of as an array of values.| OPTIONAL
`exp`  | **NumericDate**  | An "Expiration Time" registered claim according to \[[RFC7519](#rfc7519)\] expressing the time when services and responsibilities related to this SVT is no longer provided by the SVT Issuer. The precise meaning of the expiration time claim is defined by local policy. See implementation note below <sup>2</sup>   | OPTIONAL
`sig_val_claims` | **Object\<SigValidation\>**  | Signature validation claims for this SVT extending the standard registered JTW claims above. | MANDATORY

> \[2\]: An SVT asserts that a certain validation process was undertaken at a certain instance of time. This fact never changes and never expires. However, some aspects of the SVT such as liability for false claims or service provision related to a specific SVT may stop after a certain period of time, such as a service where an old SVT can be upgraded to a new SVT signed with fresh keys and algorithms.


<a name="claim-object-classes"></a>
#### 2.2.3. Claim object classes

<a name="the-sigvalidation-object"></a>
##### 2.2.3.1. The SigValidation object
The SigValidation claims object holds all custom claims of the SVT JWT and contains the following parameters:

Name | Data Type | Value | Presence
--- | --- | --- | ---
`ver` | **String** | Version. This version is indicated by the value "1.0" | MANDATORY
`profile`| **StringOrURI** | Name of a profile applied to this specification that defines conventions of content of specific claims and extension points.| OPTIONAL
`hash_algo` | **URI** | The URI identifier of the hash algorithm used to provide hash values within the SVT. The URI identifier SHALL be one defined in \[[RFC6931](#rfc6931)\] or in the IANA registry defined by this RFC. | MANDATORY
`cert_ref`  | **Object\<CertReference\>**  | Information about certificates that MAY be used to validate the signature on this SVT. | OPTIONAL
`sig`  | **\[Object\<Signature\>\]**   | Information about validated signatures as an array of Signature objects. If the SVT contains signature validation evidence for more than one signature, then each signature is represented by a separate Signature object. At least one Signature object MUST be present. | MANDATORY
`ext` | **MAP\<String\>** | Extension point for additional claims related to the SVT. Extension claims are added at the discretion of the SVT Issuer but MUST follow any conventions defined in a profile of this specification (see section 3) |  OPTIONAL

<a name="the-signature-claims-object"></a>
##### 2.2.3.2. The Signature claims object
The Signature object contains claims related to signature validation evidence for one signature and contains the following parameters:

Name | Data Type | Value | Presence
--- | --- | --- | ---
`sig_ref`  | **Object\<SigReference\>** | Reference information identifying the target signature. | MANDATORY |
|`sig_data` | **\[Object\<SignedData\>\]** | Array of references to Signed Data signed by the target signature. | MANDATORY  |
|`signer_cert_ref` | **Object\<CertReference\>** | Reference to signer certificate and optionally reference to a supporting certificate chain that was used to validate the target signature. | MANDATORY |
|`sig_val` | **\[Object\<PolicyValidation\>\]** | Array of results of signature validation according to defined validation procedures. | MANDATORY |
|`time_val` | **\[Object\<TimeValidation\>\]**  | Array of results of time verification validating proof that the target signature has existed at specific instances of time in the past. | OPTIONAL |
`ext` | **MAP\<String\>** | Extension point for additional claims related to the target signature. Extension claims are added at the discretion of the SVT Issuer but MUST follow any conventions defined in a profile of this specification (see section 3) |  OPTIONAL

<a name="the-sigreference-claims-object"></a>
##### 2.2.3.3. The SigReference claims object

The SigReference claims object provides information to used to match the Signature claims object to a specific target signature and to verify the inteigrity of the target siganture value and Signed Bytes.

Name | Data Type | Value | Presence
--- | --- | --- | ---
`id`  | **String**  | Optional identifier assigned to the target signature.  |  OPTIONAL
`sig_hash`  | **Base64Binary** | Hash value of the target signature value. | MANDATORY
`sb_hash` | **Base64Binary** | Hash value of the Signed Bytes of the target signature. | MANDATORY

<a name="the-signeddata-claims-object"></a>
##### 2.2.3.4. The SignedData claims object

The SignedData claims object provides information used to verify the target signature references to Signed Data as well as to verify the integrity of all data signed by the target signature.

Name | Data Type | Value | Presence
--- | --- | --- | ---
`ref` | **String** | Reference identifier identifying the data or data fragment covered by the target signature. | MANDATORY
`hash`  | **Base64Binary** | Hash of the data covered by the target signature | MANDATORY

<a name="the-policyvalidation-claims-object"></a>
##### 2.2.3.5. The PolicyValidation claims object

The PolicyValidation claims object provide information about the result of a validation process according to a speicific policy.

Name | Data Type | Value | Presence
--- | --- | --- | ---
`pol`  | **StringOrURI** | Identifier of the policy governing the validation process  | MANDATORY
`res`  | **String** | Result of the validation process. The value MUST be one of "PASSED", "FAILED" or "INDETERMINATE" as defined by  \[[ETSI EN 319 102-1](#etsi319102-1)\]| MANDATORY
`msg` | **String** | An optional message describing the result. | OPTIONAL
`ext` | **MAP\<String\>** | Extension for additional information about the validation result.  | OPTIONAL


<a name="the-timeverification-claims-object"></a>
##### 2.2.3.6. The TimeVerification claims object

The TimeVerification claims object provide information about the result of validating time evidence asserting that the target signature existed at a particular time in the past.

Name | Data Type | Value | Presence
--- | --- | --- | ---
`time`  | **NumericDate** | The verified time  | MANDATORY
`type`  | **StringOrURI** | Identifier of the type of evidence of time | MANDATORY
`iss` | **StringOrURI** | Identifier of the entity that issued the evidence of time | MANDATORY
`iss_cert_ref`  | **Object\<CertReference\>** | Reference to the certificate and certificate chain used to validate the signature on the validated evidence of time | OPTIONAL
`id` | **String** | Unique identifier assigned to the evidence of time  |  OPTIONAL
`val` | **\[Object\<PolicyValidation\>\]**  | Array of results of validation of the time evidence according to defined validation procedures.  |  OPTIONAL
`ext` | **MAP\<String\>** | Extension for additional information about the signature validation result.  | OPTIONAL

<a name="the-certreference-claims-object"></a>
##### 2.2.3.7. The CertReference claims object

The CertReference claims object allows reference to a single certificate or a chain of certificates, either by providing the actual certificate data or by providing a hash reference for certificates that can be located in the target signature.

Name | Data Type | Value | Presence
--- | --- | --- | ---
`type` | **StringOrURI** | An identifier of the type of reference provided in the ref claim. The type identifier MUST be either one of the identifiers defined below, an identifier speicified by the selected profile, or a URI identifier | MANDATORY
`ref` | **\[String\]** | An array of string parameters according to conventions defined by the type identifier  | MANDATORY

The following type identifiers are defined:

Identifer | Ref data content
--- | ---
`cert` |  One string holding a Base64 encoded X.509 certificate
`chain` | Array of Base64 encoded X.509 certificates. The certificates MUST be stored in the order starting with the end entity certificate. Any following certificate must be able to validate the signature on the previous certificate in the array.
`cert_hash` | Base64 encoded hash value over the target X.509 certificate
`cert_and_chain_hash` | Two Base64 encoded hash values. The first hash value is the hash over the target end entity certificate and the next hash is the hash over the certificate chain included in the target signature. This type identifier MUST NOT be used if the certificate chain is not provided in the target signature. The chain hash is calculated over the concatenated bytes of the chain certificate exactly in the order they appear in the target signature. If an external chain not provided in the target signature was used, then the `chain` type SHOULD be used.



<a name="svt-jose-header"></a>
#### 2.2.4. SVT JOSE header

The SVT JWT MUST contain the following JOSE header parameters in accordance with section 5 of \[[RFC7519](#rfc7519)\].

JOSE Header | value
--- | ---
`typ`  | This parameter MUST have the string value "JWT" (upper case).
`alg`  | Specifying the algorithm used to sign the SVT JWT using a value specified in \[[RFC7518](#rfc7518)\]. The specified signature hash algorithm SHOULD be identical to, and MUST be of equivalent or better strength compared with, the hash algorithm specified in the SigValAssertion claims object `hash_algo` claim.



<a name="profiles"></a>
## 3. Profiles
Each signed document and signature type will have to define the precise content and use of several claims in the SVT.

Each profile MUST as a minimum define:

- How to specify reference to Signed Data content of the signed document.
- How to make reference to the target signature and the Signed Bytes of the signature
- How references should be made to certificates supporting the signature
- Whether each signature is supported by it's own SVT, or whether one SVT may support multiple signatures of the same document.
- Explicit information on how to perform signature validation based on an SVT, if applicable.
- How to attach an SVT to a document signature or signed document, if applicable.


<a name="signature-validation-with-signature-validation-token"></a>
## 4. Signature Validation with signature validation token

Signature validation based on an SVT SHALL follow the following basic steps.

1. Locate all available Tokens available for the signed document that is relevant for the target signature.
2. Select the most recent SVT that can be successfully validated and meets the requirement of the relying party
3. Verify the integrity of the signature and the Signed Bytes of the target signature using the `sig_ref` claim.
4. Verify that the SignedData reference in the original signature matches the reference values in the sig_data_ref claim.
5. Verify the integrity of referenced Signed Data using provided hash values in the sig_data_ref claim.
6. Obtain the verified certificates supporting the asserted signature validation through the signer_cert_ref claim.
7. Verify that signature validation policy results satisfies the requirements of the relying party.
8. Verify that verified time results satisfies the context within which the signed document is used.

After validating these steps, signature validity is established as well as the trusted signer certificate binding the identity of the signer to the signature.

<a name="examples"></a>
## 5. Examples

The following example illustrates a basic SVT according to this specification issued for a signed PDF document.

Signature validation token JWT:

```
eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzUxMiJ9.eyJhdWQiOiJodHRwOlwvXC9leGFtcGxlLmNvbVwvYXVkaWVuY2UxIiw
iaXNzIjoiaHR0cHM6XC9cL3N3ZWRlbmNvbm5lY3Quc2VcL3ZhbGlkYXRvciIsImlhdCI6MTU3ODM5NTg5MywianRpIjo
iM2UwNjEwNzlhOTkxMDcxYTVkMmRjZmQyZWUxYzY3OTQiLCJzaWdfdmFsX2NsYWltcyI6eyJzaWciOlt7ImV4dCI6bnV
sbCwic2lnX3ZhbCI6W3sibXNnIjoiUGFzc2VkIGJhc2ljIHNpZ25hdHVyZSB2YWxpZGF0aW9uIiwiZXh0IjpudWxsLCJ
yZXMiOiJQQVNTRUQiLCJwb2wiOiJodHRwOlwvXC9pZC5zd2VkZW5jb25uZWN0LnNlXC9zdnRcL3NpZ3ZhbC1wb2xpY3l
cL2NoYWluXC8wMSJ9XSwic2lnX3JlZiI6eyJzaWdfaGFzaCI6IlwvejU1NjZ1VURPZCtVMU4xdmR0bkhHK0xQNEY0aTJ
yeFBocU5DN2V2MnBnTVZlM1ZxRzMxa2VjZ1gwT3BpdVwvZnhlV0Y0NlZFejN6cmo4eFNLRXpHS0E9PSIsImlkIjpudWx
sLCJzYl9oYXNoIjoiQUVSZTlFNkVmZ3ViSmlOY1pwSU05QkJFVmdIeCtDY2p2R3FiMnVsMjgwUkN2SjJ5TVZOZUZoUnk
zZWZ4WlIrYkZHYUFQY1J6SEJlNll3ZDU0QUhlUFE9PSJ9LCJzaWduZXJfY2VydF9yZWYiOnsicmVmIjpbIk5TdUZNXC9
2SitiZUJsUXRRVHptY1loNXg3TDhXQzlFMUtQSFJBMWlvTk9sS1ZHYmxhOVVSelljc2lzQXgyYmNzcU9oa3ZWVGMzbUs
5RTZhZzA3aGZhdz09Il0sInR5cGUiOiJjZXJ0X2hhc2gifSwic2lnX2RhdGFfcmVmIjpbeyJyZWYiOiIwIDc0Njk3IDc
5Njk5IDM3ODgxIiwiaGFzaCI6ImI4RUwxTW9VNHF4WUkxcmtpc2s4b3E4aVEzTHJEb3lja1pub0hWY05jUFNaaUd5Nkt
1XC8rUVBaeGdKcGdsRnk1RFIrYmJ2Mmplak56NkErZjl6ZVN3Zz09In1dLCJ0aW1lX3ZhbCI6W3sidmFsIjpbeyJtc2c
iOm51bGwsImV4dCI6bnVsbCwicmVzIjoiUEFTU0VEIiwicG9sIjoiaHR0cDpcL1wvaWQuc3dlZGVuY29ubmVjdC5zZVw
vc3Z0XC9zaWd2YWwtcG9saWN5XC90cnVzdFwvMDEifV0sImV4dCI6bnVsbCwiaXNzX2NlcnRfcmVmIjp7InJlZiI6WyJ
PZW5JKzQzNEpoYnZmRG50ZlZcLzhyT3hHN0ZrdnlqYUtWSmFWcUlGQlhvaFZoQWU1Zks4YW5vdjFTNjg4cjdLYmFsK2Z
2cGFIMWo4aWJnNTJRQnkxUFE9PSJdLCJ0eXBlIjoiY2VydF9oYXNoIn0sImlzcyI6Imh0dHBzOlwvXC9zd2VkZW5jb25
uZWN0LnNlXC92YWxpZGF0b3IiLCJ0aW1lIjoxNTc4Mzk1ODg1LCJpZCI6ImUyZWNkMWU5ODY2ZjdjYiIsInR5cGUiOiJ
odHRwOlwvXC9pZC5zd2VkZW5jb25uZWN0LnNlXC9zdnRcL3RpbWV2YWwtdHlwZVwvcGRmLXN2YS10aW1lc3RhbXBcLzA
xIn1dfV0sImV4dCI6eyJuYW1lMiI6InZhbDIiLCJuYW1lMSI6InZhbDEifSwidmVyIjoiMS4wIiwicHJvZmlsZSI6IlB
ERiIsImhhc2hfYWxnbyI6Imh0dHA6XC9cL3d3dy53My5vcmdcLzIwMDFcLzA0XC94bWxlbmMjc2hhNTEyIiwiY2VydF9
yZWYiOnsicmVmIjpbIk1JSUI2VENDQVV1Z0F3SUJBZ0lFWEhBWHVEQUtCZ2dxaGtqT1BRUURBakE1TVFzd0NRWURWUVF
HRXdKVFJURU9NQXdHQTFVRUNnd0ZTVVJ6WldNeEdqQVlCZ05WQkFNTUVVOXdaVzVUUVUxTUlFVkRReUJVWlhOME1CNFh
EVEU1TURJeU1qRTFNemt6TmxvWERUSXdNREl5TWpFMU16a3pObG93T1RFTE1Ba0dBMVVFQmhNQ1UwVXhEakFNQmdOVkJ
Bb01CVWxFYzJWak1Sb3dHQVlEVlFRRERCRlBjR1Z1VTBGTlRDQkZRME1nVkdWemREQ0JtekFRQmdjcWhrak9QUUlCQmd
VcmdRUUFJd09CaGdBRUFad0RBTlZTWFA1ZU53T1Y5OFo5YXF6Tlwvd0haQVVpOGFqdWMwcFNtMGxJSTV2QU1wU0V2a3l
iVHpTV0VkXC9kUkRQdVJibkcxcXd1UnhEekJJcVdvY0hHNkFHMGNsZGhMVkNsNHZWM1Q4OVBVQUw5ZEdSYjE4dVdud1R
VT1lidTljOFp5dUU3OVlPd2ZqSUpzcUtBXC9QQmNjcGkyRGczNTE5bzZTMkl5d3hXTkhOUHdLTUFvR0NDcUdTTTQ5QkF
NQ0E0R0xBRENCaHdKQ0FOY1F4bWVRNG44elkybHFydGpobzlNUUttYll1T3pvV3o1Sm9cLzRkKzlPT1JaMFU5UTB6OEQ
rSUV0S1Q0ZGREZm9VTDBiMG9DR09WN08weGMzanpMbEFOQWtFOGs0dlYwODdjYjRaNktYMlF0TkVIZjFxWW95RXliNVF
LWW51OGtqRmt2RmtoUTdWcTNHRFFGM2RHa0wyNkZFYVNMMGc2Q3ZwWUd6YjNlXC9jcVdvekY1Zz09Il0sInR5cGUiOiJ
jZXJ0In19fQ.ABX86yxICFISWcuEZeGnxV-H-F4eWcVvTUegS7wdR2znB4Nj_xvg6laMGFOByMlZCp4ck2H7WukKYhNC
7qfPbXDXARtjhhVrb_1qyQhs3aGnZsvvBaq9oKw52EibdgSutLDEndcpEo-d719M8RDxdwPXIQzCUTTUJT8R94m9xyL6
2aNZ
```
Decoded JWT Header:
```
{"typ":"JWT","alg":"ES512"}

```
Decoded JWT Claims
```
{
  "jti" : "3e061079a991071a5d2dcfd2ee1c6794",
  "iss" : "https://swedenconnect.se/validator",
  "iat" : 1578395893,
  "aud" : "http://example.com/audience1",
  "sig_val_claims" : {
    "ver" : "1.0",
    "profile" : "PDF",
    "hash_algo" : "http://www.w3.org/2001/04/xmlenc#sha512",
    "cert_ref" : {
      "ref" : [ "MIIB6TCCAUugAwIBAgIEXHAXuDAKBggqhkjOPQQDAjA5MQswCQYDVQQGEwJTRTEOMAwGA1UECgw
                 FSURzZWMxGjAYBgNVBAMMEU9wZW5TQU1MIEVDQyBUZXN0MB4XDTE5MDIyMjE1MzkzNloXDTIwMD
                 IyMjE1MzkzNlowOTELMAkGA1UEBhMCU0UxDjAMBgNVBAoMBUlEc2VjMRowGAYDVQQDDBFPcGVuU
                 0FNTCBFQ0MgVGVzdDCBmzAQBgcqhkjOPQIBBgUrgQQAIwOBhgAEAZwDANVSXP5eNwOV98Z9aqzN
                 /wHZAUi8ajuc0pSm0lII5vAMpSEvkybTzSWEd/dRDPuRbnG1qwuRxDzBIqWocHG6AG0cldhLVCl
                 4vV3T89PUAL9dGRb18uWnwTUOYbu9c8ZyuE79YOwfjIJsqKA/PBccpi2Dg3519o6S2IywxWNHNP
                 wKMAoGCCqGSM49BAMCA4GLADCBhwJCANcQxmeQ4n8zY2lqrtjho9MQKmbYuOzoWz5Jo/4d+9OOR
                 Z0U9Q0z8D+IEtKT4ddDfoUL0b0oCGOV7O0xc3jzLlANAkE8k4vV087cb4Z6KX2QtNEHf1qYoyEy
                 b5QKYnu8kjFkvFkhQ7Vq3GDQF3dGkL26FEaSL0g6CvpYGzb3e/cqWozF5g==" ],
      "type" : "cert"
    },
    "sig" : [ {
      "ext" : null,
      "sig_val" : [ {
        "msg" : "Passed basic signature validation",
        "ext" : null,
        "res" : "PASSED",
        "pol" : "http://id.swedenconnect.se/svt/sigval-policy/chain/01"
      } ],
      "sig_ref" : {
        "sig_hash" : "/z5566uUDOd+U1N1vdtnHG+LP4F4i2rxPhqNC7ev2pgMVe3VqG31kecgX0Opiu/fxeWF46
                      VEz3zrj8xSKEzGKA==",
        "id" : null,
        "sb_hash" : "AERe9E6EfgubJiNcZpIM9BBEVgHx+CcjvGqb2ul280RCvJ2yMVNeFhRy3efxZR+bFGaAPcR
                     zHBe6Ywd54AHePQ=="
      },
      "signer_cert_ref" : {
        "ref" : [ "NSuFM/vJ+beBlQtQTzmcYh5x7L8WC9E1KPHRA1ioNOlKVGbla9URzYcsisAx2bcsqOhkvVTc3
                   mK9E6ag07hfaw==" ],
        "type" : "cert_hash"
      },
      "sig_data_ref" : [ {
        "ref" : "0 74697 79699 37881",
        "hash" : "b8EL1MoU4qxYI1rkisk8oq8iQ3LrDoyckZnoHVcNcPSZiGy6Ku/+QPZxgJpglFy5DR+bbv2jej
                  Nz6A+f9zeSwg=="
      } ],
      "time_val" : [ {
        "val" : [ {
          "msg" : null,
          "ext" : null,
          "res" : "PASSED",
          "pol" : "http://id.swedenconnect.se/svt/sigval-policy/trust/01"
        } ],
        "ext" : null,
        "iss_cert_ref" : {
          "ref" : [ "OenI+434JhbvfDntfV/8rOxG7FkvyjaKVJaVqIFBXohVhAe5fK8anov1S688r7Kbal+fvpa
                     H1j8ibg52QBy1PQ==" ],
          "type" : "cert_hash"
        },
        "iss" : "https://swedenconnect.se/validator",
        "time" : 1578395885,
        "id" : "e2ecd1e9866f7cb",
        "type" : "http://id.swedenconnect.se/svt/timeval-type/pdf-sva-timestamp/01"
      } ]
    } ],
    "ext" : {
      "name2" : "val2",
      "name1" : "val1"
    }
  }
}

```

> Note: The order of the JSON objects has been rearranged from the order they appear in the JWT to increase readablilty. Line breaks in the decoded example are also inserted for readablilty. These are not allowed in valid JSON data.

<a name="normative-references"></a>
## 6. Normative References

<a name="rfc2119"></a>
**[RFC2119]**

> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="rfc6931"></a>
**[RFC6931]**

> [Eastlake 3rd, D., Additional XML Security Uniform Resource Identifiers
> (URIs), April 2013](http://www.ietf.org/rfc/rfc6931.txt).

<a name="rfc7518"></a>
**[RFC7518]**

> [Jones, M., JSON Web Algorithms (JWA),
> May 2015](http://www.ietf.org/rfc/rfc7518.txt).

<a name="rfc7519"></a>
**[RFC7519]**

> [Jones, M., Bradley, J., Sakimura, N., JSON Web Token (JWT),
> May 2015](http://www.ietf.org/rfc/rfc7518.txt).

<a name="rfc8174"></a>
**[RFC8174]**

> [Leiba, B., Ambiguity of Uppercase vs Lowercase in RFC 2119 Key Words,
> May 2017](http://www.ietf.org/rfc/rfc8174.txt).

<a name="etsi319102-1"></a>
**[ETSI EN 319 102-1]**

> [ETSI - Electronic Signatures and Infrastructures (ESI); Procedures for
> Creation and Validation of AdES Digital Signatures; Part 1: Creation and
> Validation](https://www.etsi.org/deliver/etsi_en/319100_319199/31910201/01.01.01_60/en_31910201v010101p.pdf).
