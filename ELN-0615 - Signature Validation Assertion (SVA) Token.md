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
Content of claims in a SVA token are specified using the claims data types in the following table:

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

#### 2.2.2. SVA token claims

The SVA token JWT SHALL contain claims according to the following table.

Name | Data Type | Value | Presence
--- | --- | --- | ---
`jti`  | **String** | A "JWT ID" registered claim according to \[[RFC7519](#rfc7519)\]. It is RECOMMENDED that the identifier holds a headecimal string representation of a 128 bit unsigned integer. |MANDATORY
`iss`  | **StringOrURI**  | A "Issuer" registered claim according to \[[RFC7519](#rfc7519)\]. An arbitrary unique identifier of the SVA issuer. This value SHOULD have the value of an URI identifier based on a domain owned by the issuer. | MANDATORY
`iat`  | **NumericDate**  | An "Issued At" registered claim according to \[[RFC7519](#rfc7519)\] expressig the time when this SVA token was issued  | MANDATORY
`aud`  | **\[StringOrURI\]** or **StringOrURI** | An "Audience" registered claim according to \[[RFC7519](#rfc7519)\]. The audience claim is an array of one or more identifiers, identifying intended recipients of the SVA token. Each identifier MAY identify a single entity, a group of entities or a common policy adopted by a group of entites. If only one value is provided it MAY be provided as a single StringOrURI value instead of as an array of values.| OPTIONAL
`exp`  | **NumericDate**  | An **Expiration Time** registered claim according to \[[RFC7519](#rfc7519)\] expressig the time when services and responsibilities related to this SVA token is no longer provided by the SVA Issuer. The precice meaning of the expiration time claim is defined by local policy. See implementation note below <sup>2</sup>   | OPTIONAL
`sig_val_assertion`  | **Object\<SigValAssertion\>**  | Signature validation assertion claims for this SVA token extending the standard registered JTW claims above. | MANDATORY

> \[2\]: An SVA token asserts that a certain validation process was undertaken at a certain instance of time. This fact never changes and never expires. However, some aspects of the SVA claim such as liability for false claims or service provision related to a specific SVA token may stop after a certain period of time, such as a service where an old SVA token can be upgraded to a new SVA token signed with fresh keys and algorithms.


#### 2.2.3. Claim object classes

##### 2.2.3.1. The SigValAssertion object
The sva_claims ClaimsObject contains the following values:

Name | Data Type | Value | Presence
--- | --- | --- | ---
`ver` | **String** | Version. This version is indicated by the value "1.0" | MANDATORY
`profile`| **StringOrURI** | Name of a profile applied to this speicification that defines conventions of content of specific claims and extension points.| OPTIONAL
`hash_algo` | **URI** | The URI identifier of the hash algorithm used to provide hash values within the SVA token claims. The URI identifier SHALL be one defined in \[[RFC6931](#rfc6931)\] or in the IANA registry defined by this RFC. | MANDATORY
`cert_ref`  | **Object\<CertReference\>**  | Information about certificates that MAY be used to validate the signature on this SVA token. | OPTIONAL
`sig`  | **\[Object\<Signature\>\]**   | The `sig` claim provide information about validated signatures as an array of **Signature** objects. If the SVA token contains signature validation assertions for more than one signature, then each signature is represented by a separate **Signature** object. An SVA token MUST contain at least one Signature object | MANDATORY
`ext` | **MAP\<String\>** | Extension point for additional claims related to the SVA token. Extension claims are added at the discresion of the SVA Issuer but MUST follow any conventions defined in a profile of this specification (see section 3) |  OPTIONAL

##### 2.2.3.2. The Signature claims object
The Signature object contains claims related to signature validation assertioins for one signature and contains the following values:

Name | Data Type | Value | Presence
--- | --- | --- | ---
`sig_ref`  | **Object\<SigReference\>** | Reference information identifying the target signature. | MANDATORY |
|`sig_data` | **\[Object\<SignedData\>\]** | Array of references to Signed Data signed by the target signature. | MANDATORY  |
|`signer_cert_ref` | **Object\<CertReference\>** | Reference to signer certificate and optionally reference to a supporting certificate chain that was used to validate the target signature. | MANDATORY |
|`sig_val` | **\[Object\<PolicyValidation\>\]** | Array of results of signature validation according to defined validation procedures. | MANDATORY |
|`time_val` | **\[Object\<TimeValidation\>\]**  | Array of results of time verification validating proof that the target signature has existed at specific instances of time in the past. | OPTIONAL |
`ext` | **MAP\<String\>** | Extension point for additional claims related to the target signature. Extension claims are added at the discresion of the SVA Issuer but MUST follow any conventions defined in a profile of this specification (see section 3) |  OPTIONAL

##### 2.2.3.3. The SigReference claims object

Name | Data Type | Value | Presence
--- | --- | --- | ---
`id`  | **String**  | Optional identifier assigned to the target signature.  |  OPTIONAL
`sig_hash`  | **Base64Binary** | Hash value of the target signature value. | MANDATORY
`sb_hash` | **Base64Binary** | Hash value of the Signed Bytes of the target signature. | MANDATORY

##### 2.2.3.4. The SignedData claims object

Name | Data Type | Value | Presence
--- | --- | --- | ---
`ref` | **String** | Reference identifier identifying the data or data fragment covered by the target signature. | MANDATORY
`hash`  | **Base64Binary** | Hash of the data covered by the target signature | MANDATORY

##### 2.2.3.5. The PolicyValidation claims object

Name | Data Type | Value | Presence
--- | --- | --- | ---
`pol`  | **StringOrURI** | Identifier of the policy governing the validation process  | MANDATORY
`res`  | **String** | Result of the validation process. The value MUST be one of "PASSED", "FAILED" or "INDETERMINATE" as defined by  \[[ETSI EN 319 102-1](#etsi319102-1)\]| MANDATORY
`msg` | **String** | An optional message describing the result. | OPTIONAL
`ext` | **MAP\<String\>** | Extension for additional information about the validation result.  | OPTIONAL


##### 2.2.3.6. The TimeVerification claims object


Name | Data Type | Value | Presence
--- | --- | --- | ---
`time`  | **NumericDate** | The verified time  | MANDATORY
`type`  | **StringOrURI** | Identifier of the type of evidence of time | MANDATORY
`iss` | **StringOrURI** | Identifier of the entity that issued the evidence of time | MANDATORY
`iss_cert_ref`  | **Object\<CertReference\>** | Reference to the certificate and certificate chain used to validate the signature on the validated evidence of time | OPTIONAL
`id` | **String** | Unique identifier assigned to the evidence of time  |  OPTIONAL
`val` | **\[Object\<PolicyValidation\>\]**  | Array of results of validation of the time evidence according to defined validation procedures.  |  OPTIONAL
`ext` | **MAP\<String\>** | Extension for additional information about the signature validation result.  | OPTIONAL

##### 2.2.3.7. The CertReference claims object



Name | Data Type | Value | Presence
--- | --- | --- | ---
`type` | **StringOrURI** | An identifier of the type of reference provided in the ref claim. The type identifier MUST be one of the identifiers defined below or a URI identifier | MANDATORY
`ref` | **\[String\]** | An array of string parameters according to conventions defined by the type identifier  | MANDATORY

The following type identifiers are defined:
Identifer | Ref data content
--- | ---
`cert` |  One string holding a Base64 encoded X.509 certificate
`chain` | Array of Base64 encoded X.509 certificates. The certificates MUST be stored in the order starting with the end entity certificate. Any following certificate must be able to validate the signature on the previous certificate in the array.
`cert_hash` | Base64 encoded hash value over the target X.509 certificate
`cert_and_chain_hash` | Two Base64 encoded hash values. The first hash value is the hash over the target end entity certificate and the next hash is the hash over the certificate chain included in the target signature. This type identifier MUST NOT be used if the certificate chain is not provided in the target signature. The chain hash is calculated over the concatenated bytes of the chain certificate exactly in the order they appear in the target signature. If an external chain not provided in the target signature was used, then the `chain` type SHOULD be used.



#### 2.2.3. SVA JOSE header

The SVA token JWT MUST contain the following JODE header parameters in acccordance with section 5 of \[[RFC7519](#rfc7519)\].

JOSE Header | value
--- | ---
`typ`  | This parameter MUST have the string value "JWT" (upper case).
`alg`  | Specifying the algorithm used to sign the SVA token JWT using a value specified in \[[RFC7518](#rfc7518)\]. The specified signature hash algorithm SHOULD be identical to, and MUST be of equivalent or better strength compared with, the hash algorithm specified in the SigValAssertion claims object `hash_algo` claim.



## 3. Profiles
Each signed document and signature type will have to define the precise content and use of several claims in the SVA token.

Each profile MUST as a minimum define:

- How to specify reference to Signed Data content of the signed document.
- How to make reference to the target signature and the Signed Bytes of the signature
- How references should be made to certificates supporting the signature
- Whether each signature is supported by it's own SVA token, or whether one SVA token may support multiple signatures of the same document.
- Explicit information on how to perform signature validation based on an SVA token, if applicable.
- How to attach an SVA token to a document signature or signed document, if applicable.


## 4. Signature Validation with SVA Token

Signature validation based on an SVA token SHALL follow the following basic steps.

1. Locate all available SVA tokens available for the signed document that is relevant for the target signature.
2. Select the most recent SVA token that can be successfylly validated and meets the requirement of the relying party
3. Verify the integrity of the signature and the Signed Bytes of the target signature.
4.


## 5. Examples

The following example illustrates a basic SVA token according to this specification issued for a signed PDF document.

SVA token JWT:

```
eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzUxMiJ9.eyJhdWQiOiJodHRwOlwvXC9leGFtcGxlLmNvbVwvYXVkaWVuY2UxIiw
ic2lnX3ZhbF9hc3NlcnRpb24iOnsic2lnIjpbeyJleHQiOm51bGwsInNpZ192YWwiOlt7Im1zZyI6IlBhc3NlZCBiYXN
pYyBzaWduYXR1cmUgdmFsaWRhdGlvbiIsImV4dCI6bnVsbCwicmVzIjoiUEFTU0VEIiwicG9sIjoiaHR0cDpcL1wvaWQ
uc3dlZGVuY29ubmVjdC5zZVwvc3ZhXC9zaWd2YWwtcG9saWN5XC9jaGFpblwvMDEifV0sInNpZ19yZWYiOnsic2lnX2h
hc2giOiJcL3o1NTY2dVVET2QrVTFOMXZkdG5IRytMUDRGNGkycnhQaHFOQzdldjJwZ01WZTNWcUczMWtlY2dYME9waXV
cL2Z4ZVdGNDZWRXozenJqOHhTS0V6R0tBPT0iLCJpZCI6bnVsbCwic2JfaGFzaCI6IkFFUmU5RTZFZmd1YkppTmNacEl
NOUJCRVZnSHgrQ2NqdkdxYjJ1bDI4MFJDdkoyeU1WTmVGaFJ5M2VmeFpSK2JGR2FBUGNSekhCZTZZd2Q1NEFIZVBRPT0
ifSwic2lnbmVyX2NlcnRfcmVmIjp7InJlZiI6WyJOU3VGTVwvdkorYmVCbFF0UVR6bWNZaDV4N0w4V0M5RTFLUEhSQTF
pb05PbEtWR2JsYTlVUnpZY3Npc0F4MmJjc3FPaGt2VlRjM21LOUU2YWcwN2hmYXc9PSJdLCJ0eXBlIjoiY2VydF9oYXN
oIn0sInNpZ19kYXRhX3JlZiI6W3sicmVmIjoiMCA3NDY5NyA3OTY5OSAzNzg4MSIsImhhc2giOiJiOEVMMU1vVTRxeFl
JMXJraXNrOG9xOGlRM0xyRG95Y2tabm9IVmNOY1BTWmlHeTZLdVwvK1FQWnhnSnBnbEZ5NURSK2JidjJqZWpOejZBK2Y
5emVTd2c9PSJ9XSwidGltZV92YWwiOlt7InZhbCI6W3sibXNnIjpudWxsLCJleHQiOm51bGwsInJlcyI6IlBBU1NFRCI
sInBvbCI6Imh0dHA6XC9cL2lkLnN3ZWRlbmNvbm5lY3Quc2VcL3N2YVwvc2lndmFsLXBvbGljeVwvdHJ1c3RcLzAxIn1
dLCJleHQiOm51bGwsImlzc19jZXJ0X3JlZiI6eyJyZWYiOlsiT2VuSSs0MzRKaGJ2ZkRudGZWXC84ck94RzdGa3Z5amF
LVkphVnFJRkJYb2hWaEFlNWZLOGFub3YxUzY4OHI3S2JhbCtmdnBhSDFqOGliZzUyUUJ5MVBRPT0iXSwidHlwZSI6ImN
lcnRfaGFzaCJ9LCJpc3MiOiJodHRwczpcL1wvc3dlZGVuY29ubmVjdC5zZVwvdmFsaWRhdG9yIiwidGltZSI6MTU3ODM
zODk5NCwiaWQiOiIyNDM4MjE0OThlOGFjNzIiLCJ0eXBlIjoiaHR0cDpcL1wvaWQuc3dlZGVuY29ubmVjdC5zZVwvc3Z
hXC90aW1ldmFsLXR5cGVcL3BkZi1zdmEtdGltZXN0YW1wXC8wMSJ9XX1dLCJleHQiOnsibmFtZTIiOiJ2YWwyIiwibmF
tZTEiOiJ2YWwxIn0sInZlciI6IjEuMCIsInByb2ZpbGUiOiJQREYiLCJoYXNoX2FsZ28iOiJodHRwOlwvXC93d3cudzM
ub3JnXC8yMDAxXC8wNFwveG1sZW5jI3NoYTUxMiIsImNlcnRfcmVmIjp7InJlZiI6WyJNSUlCNlRDQ0FVdWdBd0lCQWd
JRVhIQVh1REFLQmdncWhrak9QUVFEQWpBNU1Rc3dDUVlEVlFRR0V3SlRSVEVPTUF3R0ExVUVDZ3dGU1VSelpXTXhHakF
ZQmdOVkJBTU1FVTl3Wlc1VFFVMU1JRVZEUXlCVVpYTjBNQjRYRFRFNU1ESXlNakUxTXprek5sb1hEVEl3TURJeU1qRTF
Nemt6Tmxvd09URUxNQWtHQTFVRUJoTUNVMFV4RGpBTUJnTlZCQW9NQlVsRWMyVmpNUm93R0FZRFZRUUREQkZQY0dWdVU
wRk5UQ0JGUTBNZ1ZHVnpkRENCbXpBUUJnY3Foa2pPUFFJQkJnVXJnUVFBSXdPQmhnQUVBWndEQU5WU1hQNWVOd09WOTh
aOWFxek5cL3dIWkFVaThhanVjMHBTbTBsSUk1dkFNcFNFdmt5YlR6U1dFZFwvZFJEUHVSYm5HMXF3dVJ4RHpCSXFXb2N
IRzZBRzBjbGRoTFZDbDR2VjNUODlQVUFMOWRHUmIxOHVXbndUVU9ZYnU5YzhaeXVFNzlZT3dmaklKc3FLQVwvUEJjY3B
pMkRnMzUxOW82UzJJeXd4V05ITlB3S01Bb0dDQ3FHU000OUJBTUNBNEdMQURDQmh3SkNBTmNReG1lUTRuOHpZMmxxcnR
qaG85TVFLbWJZdU96b1d6NUpvXC80ZCs5T09SWjBVOVEwejhEK0lFdEtUNGRkRGZvVUwwYjBvQ0dPVjdPMHhjM2p6TGx
BTkFrRThrNHZWMDg3Y2I0WjZLWDJRdE5FSGYxcVlveUV5YjVRS1ludThrakZrdkZraFE3VnEzR0RRRjNkR2tMMjZGRWF
TTDBnNkN2cFlHemIzZVwvY3FXb3pGNWc9PSJdLCJ0eXBlIjoiY2VydCJ9fSwiaXNzIjoiaHR0cHM6XC9cL3N3ZWRlbmN
vbm5lY3Quc2VcL3ZhbGlkYXRvciIsImlhdCI6MTU3ODMzOTAzNywianRpIjoiYzIwZGFmMjI0NjQyNTAzMzBkYTA1YTQ
3Njk1MDgwMjAifQ.AfNraBf_CPX5zgMjZS7w6RCxjxj-_bdksJ8eG3pNBOml7YhtnkBFpoqDsaz1FstDthppAeHkLD7f
IEkb-Xmn1J6sAKdhQ9ayz92K02MkW-mkoYeQsYk2OomLMUh11kw-v1_QWrYxcUlSiVpDF1WU6-q6uOAoar5OFOpNDlmC
jAFb9Xou
```
Decoded JWT Header:
```
{"typ":"JWT","alg":"ES512"}

```
Decoded JWT Claims
```
{
  "jti" : "c20daf22464250330da05a4769508020",
  "iss" : "https://swedenconnect.se/validator",
  "iat" : 1578339037,
  "aud" : "http://example.com/audience1",
  "sig_val_assertion" : {
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
      "sig_ref" : {
        "id" : null,
        "sig_hash" : "/z5566uUDOd+U1N1vdtnHG+LP4F4i2rxPhqNC7ev2pgMVe3VqG31kecgX0Opiu/fxeWF46
                      VEz3zrj8xSKEzGKA==",
        "sb_hash" : "AERe9E6EfgubJiNcZpIM9BBEVgHx+CcjvGqb2ul280RCvJ2yMVNeFhRy3efxZR+bFGaAPcR
                     zHBe6Ywd54AHePQ=="
      },
      "sig_data_ref" : [ {
        "ref" : "0 74697 79699 37881",
        "hash" : "b8EL1MoU4qxYI1rkisk8oq8iQ3LrDoyckZnoHVcNcPSZiGy6Ku/+QPZxgJpglFy5DR+bbv2jej
                  Nz6A+f9zeSwg=="
      } ],
      "signer_cert_ref" : {
        "ref" : [ "NSuFM/vJ+beBlQtQTzmcYh5x7L8WC9E1KPHRA1ioNOlKVGbla9URzYcsisAx2bcsqOhkvVTc3
        mK9E6ag07hfaw==" ],
        "type" : "cert_hash"
      },
      "sig_val" : [ {
        "msg" : "Passed basic signature validation",
        "ext" : null,
        "res" : "PASSED",
        "pol" : "http://id.swedenconnect.se/sva/sigval-policy/chain/01"
      } ],
      "time_val" : [ {
        "val" : [ {
          "msg" : null,
          "ext" : null,
          "res" : "PASSED",
          "pol" : "http://id.swedenconnect.se/sva/sigval-policy/trust/01"
        } ],
        "ext" : null,
        "iss_cert_ref" : {
          "ref" : [ "OenI+434JhbvfDntfV/8rOxG7FkvyjaKVJaVqIFBXohVhAe5fK8anov1S688r7Kbal+fvpa
                     H1j8ibg52QBy1PQ==" ],
          "type" : "cert_hash"
        },
        "iss" : "https://swedenconnect.se/validator",
        "time" : 1578338994,
        "id" : "243821498e8ac72",
        "type" : "http://id.swedenconnect.se/sva/timeval-type/pdf-sva-timestamp/01"
      } ]
    } ],
    "ext" : {
      "name2" : "val2",
      "name1" : "val1"
    }
  }
}

```






## 6. Normative References