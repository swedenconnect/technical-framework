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
`sig_val_assert`  | **Object\<SigValAssertion\>**  | Signature validation assertion claims for this SVA token extending the standard registered JTW claims above. | MANDATORY

> \[2\]: An SVA token asserts that a certain validation process was undertaken at a certain instance of time. This fact never changes and never expires. However, some aspects of the SVA claim such as liability for false claims or service provision related to a specific SVA token may stop after a certain period of time, such as a service where an old SVA token can be upgraded to a new SVA token signed with fresh keys and algorithms.


#### 2.2.3. Claim object classes

##### 2.2.3.1. The SigValAssertion object
The sva_claims ClaimsObject contains the following values:

Name | Data Type | Value | Presence
--- | --- | --- | ---
`ver` | **String** | Version. This version is indicated by the value "1.0" | MANDATORY
`profile`| **StringOrURI** | Name of a profile applied to this speicification that defines conventions of content of specific claims and extension points.| OPTIONAL
`hash_algo`  | **URI** | The URI identifier of the hash algorithm used to provide hash values within the SVA token claims. The URI identifier SHALL be one defined in \[[RFC6931](#rfc6931)\] or in the IANA registry defined by this RFC. | MANDATORY
`chain`  | \[**Base64Binary**\]  | An optional array of DER encoded chain of certificates that MAY be used to validate signature that signs the SVA token. The first certificate in the chain must hold the public key that is used to validate the SVA token signature and any folloing certificates MAY be used to verify the first certificate  | OPTIONAL
`sig`  | **\[Object\<Signature\>\]**   | The `sig` claim provide information about validated signatures as an array of **Signature** objects. If the SVA token contains signature validation assertions for more than one signature, then each signature is represented by a separate **Signature** object. An SVA token MUST contain at least one Signature object | MANDATORY
`ext` | **MAP\<String\>** | Extension point for additional claims related to the SVA token. Extension claims are added at the discresion of the SVA Issuer but MUST follow any conventions defined in a profile of this specification (see section 3) |  OPTIONAL

##### 2.2.3.2. The Signature claims object
The Signature object contains claims related to signature validation assertioins for one signature and contains the following values:

Name | Data Type | Value | Presence
--- | --- | --- | ---
`ref`  | **Object\<Reference\>** | Reference information identifying the target signature. | MANDATORY |
|`sig_data` | **\[Object\<SignedData\>\]** | Array of references to Signed Data signed by the target signature. | MANDATORY  |
|`cert_hash` | **Base64Binary** | Hash of the signing certificate or equivalent public key container used to validate the target signature. | MANDATORY |
| `chain_hash` | **Base64Binary** | Hash of the concattenated bytes of the certificate chain provided in the target signature.| MANDATORY
|`sig_val` | **\[Object\<PolicyValidation\>\]** | Array of results of signature validation according to defined validation procedures. | MANDATORY |
|`time_val` | **\[Object\<TimeValidation\>\]**  | Array of results of time verification validating proof that the target signature has existed at specific instances of time in the past. | OPTIONAL |
`ext` | **MAP\<String\>** | Extension point for additional claims related to the target signature. Extension claims are added at the discresion of the SVA Issuer but MUST follow any conventions defined in a profile of this specification (see section 3) |  OPTIONAL

##### 2.2.3.3. The Reference claims object

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
`cert_hash`  | **Base64Binary** | Hash of the certificate or equivalent public key token of the signer of the validated evidence of time  | OPTIONAL
`id` | **String** | Unique identifier assigned to the evidence of time  |  OPTIONAL
`val` | **\[Object\<PolicyValidation\>\]**  | Array of results of validation of the time evidence according to defined validation procedures.  |  OPTIONAL
`ext` | **MAP\<String\>** | Extension for additional information about the signature validation result.  | OPTIONAL


2.2.3. SVA JWT header

## 3. Profiles
XML and PDF etc defined in other documents


## 4. Signature Validation with SVA Token

## 5. Examples

The following example illustrates a basic SVA token according to this specification issued for a signed PDF document.

SVA token JWT:

```
eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzUxMiJ9.eyJhdWQiOiJodHRwOlwvXC9leGFtcGxlLmNvbVwvYXV
kaWVuY2UxIiwiaXNzIjoiaHR0cHM6XC9cL3N3ZWRlbmNvbm5lY3Quc2VcL3ZhbGlkYXRvciIsInNpZ19
2YWxfYXNzZXJ0Ijp7InNpZyI6W3siZXh0IjpudWxsLCJyZWYiOnsic2lnX2hhc2giOiJcL3o1NTY2dVV
ET2QrVTFOMXZkdG5IRytMUDRGNGkycnhQaHFOQzdldjJwZ01WZTNWcUczMWtlY2dYME9waXVcL2Z4ZVd
GNDZWRXozenJqOHhTS0V6R0tBPT0iLCJpZCI6bnVsbCwic2JfaGFzaCI6IkFFUmU5RTZFZmd1YkppTmN
acElNOUJCRVZnSHgrQ2NqdkdxYjJ1bDI4MFJDdkoyeU1WTmVGaFJ5M2VmeFpSK2JGR2FBUGNSekhCZTZ
Zd2Q1NEFIZVBRPT0ifSwic2lnX3ZhbCI6W3sibXNnIjoiUGFzc2VkIGJhc2ljIHNpZ25hdHVyZSB2YWx
pZGF0aW9uIiwiZXh0IjpudWxsLCJyZXMiOiJQQVNTRUQiLCJwb2wiOiJodHRwOlwvXC9pZC5zd2VkZW5
jb25uZWN0LnNlXC9zdmFcL3NpZ3ZhbC1wb2xpY3lcL2NoYWluXC8wMSJ9XSwiY2VydF9oYXNoIjoiTlN
1Rk1cL3ZKK2JlQmxRdFFUem1jWWg1eDdMOFdDOUUxS1BIUkExaW9OT2xLVkdibGE5VVJ6WWNzaXNBeDJ
iY3NxT2hrdlZUYzNtSzlFNmFnMDdoZmF3PT0iLCJjaGFpbl9oYXNoIjoiTlN1Rk1cL3ZKK2JlQmxRdFF
Uem1jWWg1eDdMOFdDOUUxS1BIUkExaW9OT2xLVkdibGE5VVJ6WWNzaXNBeDJiY3NxT2hrdlZUYzNtSzl
FNmFnMDdoZmF3PT0iLCJzaWdfZGF0YSI6W3sicmVmIjoiMCA3NDY5NyA3OTY5OSAzNzg4MSIsImhhc2g
iOiJiOEVMMU1vVTRxeFlJMXJraXNrOG9xOGlRM0xyRG95Y2tabm9IVmNOY1BTWmlHeTZLdVwvK1FQWnh
nSnBnbEZ5NURSK2JidjJqZWpOejZBK2Y5emVTd2c9PSJ9XSwidGltZV92YWwiOltdfV0sImV4dCI6eyJ
uYW1lMiI6InZhbDIiLCJuYW1lMSI6InZhbDEifSwidmVyIjoiMS4wIiwiY2hhaW4iOlsiTUlJQjZUQ0N
BVXVnQXdJQkFnSUVYSEFYdURBS0JnZ3Foa2pPUFFRREFqQTVNUXN3Q1FZRFZRUUdFd0pUUlRFT01Bd0d
BMVVFQ2d3RlNVUnpaV014R2pBWUJnTlZCQU1NRVU5d1pXNVRRVTFNSUVWRFF5QlVaWE4wTUI0WERURTV
NREl5TWpFMU16a3pObG9YRFRJd01ESXlNakUxTXprek5sb3dPVEVMTUFrR0ExVUVCaE1DVTBVeERqQU1
CZ05WQkFvTUJVbEVjMlZqTVJvd0dBWURWUVFEREJGUGNHVnVVMEZOVENCRlEwTWdWR1Z6ZERDQm16QVF
CZ2NxaGtqT1BRSUJCZ1VyZ1FRQUl3T0JoZ0FFQVp3REFOVlNYUDVlTndPVjk4WjlhcXpOXC93SFpBVWk
4YWp1YzBwU20wbElJNXZBTXBTRXZreWJUelNXRWRcL2RSRFB1UmJuRzFxd3VSeER6QklxV29jSEc2QUc
wY2xkaExWQ2w0dlYzVDg5UFVBTDlkR1JiMTh1V253VFVPWWJ1OWM4Wnl1RTc5WU93ZmpJSnNxS0FcL1B
CY2NwaTJEZzM1MTlvNlMySXl3eFdOSE5Qd0tNQW9HQ0NxR1NNNDlCQU1DQTRHTEFEQ0Jod0pDQU5jUXh
tZVE0bjh6WTJscXJ0amhvOU1RS21iWXVPem9XejVKb1wvNGQrOU9PUlowVTlRMHo4RCtJRXRLVDRkZER
mb1VMMGIwb0NHT1Y3TzB4YzNqekxsQU5Ba0U4azR2VjA4N2NiNFo2S1gyUXRORUhmMXFZb3lFeWI1UUt
ZbnU4a2pGa3ZGa2hRN1ZxM0dEUUYzZEdrTDI2RkVhU0wwZzZDdnBZR3piM2VcL2NxV296RjVnPT0iXSw
icHJvZmlsZSI6IlBERiIsImhhc2hfYWxnbyI6Imh0dHA6XC9cL3d3dy53My5vcmdcLzIwMDFcLzA0XC9
4bWxlbmMjc2hhNTEyIn0sImlhdCI6MTU3ODE3NTA4OSwianRpIjoiZWEwYWIxMDcyNTAzMjhiNTg5YjE
0MGI0N2NmZjQxOGQifQ.ACIzxnOgD3jjGEoq_48jcZBfmVViRHfT_y-uUr0yN2PBK7pi9bNJVbCe51mq
9ho1RGSzJpqKFQBBUcFfPiLBgN8qAJSszbWdpADlBg7jv1ILe5UsgWzMGYbX2pvKsE_VdbJqhHVtvqRG
I5gIlJPvZZ6vZTofvLZ7q6QyrXdbHFMW2JZH
```
Decoded JWT Header:
```
{"typ":"JWT","alg":"ES512"}

```
Decoded JWT Claims
```
{
  "jti" : "ea0ab107250328b589b140b47cff418d",
  "iss" : "https://swedenconnect.se/validator",
  "iat" : 1578175089,
  "aud" : "http://example.com/audience",
  "sig_val_assert" : {
    "ver" : "1.0",
    "profile" : "PDF",
    "hash_algo" : "http://www.w3.org/2001/04/xmlenc#sha512",
    "chain" : [ "MIIB6TCCAUugAwIBAgIEXHAXuDAKBggqhkjOPQQDAjA5MQswCQYDVQQGEwJTRTE
                 OMAwGA1UECgwFSURzZWMxGjAYBgNVBAMMEU9wZW5TQU1MIEVDQyBUZXN0MB4XDT
                 E5MDIyMjE1MzkzNloXDTIwMDIyMjE1MzkzNlowOTELMAkGA1UEBhMCU0UxDjAMB
                 gNVBAoMBUlEc2VjMRowGAYDVQQDDBFPcGVuU0FNTCBFQ0MgVGVzdDCBmzAQBgcq
                 hkjOPQIBBgUrgQQAIwOBhgAEAZwDANVSXP5eNwOV98Z9aqzN/wHZAUi8ajuc0pS
                 m0lII5vAMpSEvkybTzSWEd/dRDPuRbnG1qwuRxDzBIqWocHG6AG0cldhLVCl4vV
                 3T89PUAL9dGRb18uWnwTUOYbu9c8ZyuE79YOwfjIJsqKA/PBccpi2Dg3519o6S2
                 IywxWNHNPwKMAoGCCqGSM49BAMCA4GLADCBhwJCANcQxmeQ4n8zY2lqrtjho9MQ
                 KmbYuOzoWz5Jo/4d+9OORZ0U9Q0z8D+IEtKT4ddDfoUL0b0oCGOV7O0xc3jzLlA
                 NAkE8k4vV087cb4Z6KX2QtNEHf1qYoyEyb5QKYnu8kjFkvFkhQ7Vq3GDQF3dGkL
                 26FEaSL0g6CvpYGzb3e/cqWozF5g==" ],
    "sig" : [ {
      "ref" : {
        "sig_hash" : "/z5566uUDOd+U1N1vdtnHG+LP4F4i2rxPhqNC7ev2pgMVe3VqG31kecgX0
                      Opiu/fxeWF46VEz3zrj8xSKEzGKA==",
        "sb_hash" : "AERe9E6EfgubJiNcZpIM9BBEVgHx+CcjvGqb2ul280RCvJ2yMVNeFhRy3ef
                     xZR+bFGaAPcRzHBe6Ywd54AHePQ=="
      },
      "sig_data" : [ {
        "ref" : "0 74697 79699 37881",
        "hash" : "b8EL1MoU4qxYI1rkisk8oq8iQ3LrDoyckZnoHVcNcPSZiGy6Ku/+QPZxgJpglF
                  y5DR+bbv2jejNz6A+f9zeSwg=="
      } ],
      "cert_hash" : "NSuFM/vJ+beBlQtQTzmcYh5x7L8WC9E1KPHRA1ioNOlKVGbla9URzYcsisA
                     x2bcsqOhkvVTc3mK9E6ag07hfaw==",
      "chain_hash" : "NSuFM/vJ+beBlQtQTzmcYh5x7L8WC9E1KPHRA1ioNOlKVGbla9URzYcsis
                      Ax2bcsqOhkvVTc3mK9E6ag07hfaw==",
      "sig_val" : [ {
        "pol" : "http://id.swedenconnect.se/sva/sigval-policy/chain/01",
        "res" : "PASSED",
        "msg" : "Passed basic signature validation"
      } ],
      "time_val" : [ ]
    } ],
    "ext" : {
      "name1" : "val1",
      "name2" : "val2"
    }
  }
}
```






## 6. Normative References


## Appendix A. Deleted stuff

#### 2.1.1. Principles of trust
This technical specification makes no claims about when it is suitable to use an SVA token to support validation of old signatures or under what circumstances it is necessary to actually verify the original signature also after considerable time. It should be noted however that no validation of electronic signatures is possible withour relying on validatiton statements from trusted authorities such as:

- The certificate is a statement by a trusted authority that the named subject is to sole entity in control of the private signing key.
- The certificate reovocation list or OCSP response is a statement that a certificate was valid (or at least not revoked) at a certain point of time.
- A time stamp is a statment that some information existed at a certain instance of time.

In this context, the SVA should be regared as comparable statment that requires the issuer to be trustworthy and not compromized in the same way that traditional signature validation requires that the issuer of the signer certificate is trustworthy and not compromized.

The risk introduced when validating an old signature is that all stored evidence of validity must be verified and if verification of a signle token fails, the whole chain of proof fails. In this scenario, the SVA may offer a more managable risk management by providing one sigle verifiable statment of validity based on a trusted verification process perfomed when the evidence were relatively new and fresh.
