<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# OpenID Connect Profile for Sweden Connect

### Version 1.1 – 2026-10-07 – Draft

Registration number: **2024-7674**

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (Digg)</a>, 2015-2026. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirements Notation and Conventions](#requirements-notation-and-conventions)
    
    1.2. [Conformance](#conformance)

2. [**OpenID Provider Requirements**](#openid-provider-requirements)

    2.1. [OpenID Provider Discovery and Metadata Requirements](#openid-provider-discovery-and-metadata-requirements)

    2.2. [Authentication Request Requirements](#op-authentication-request-requirements)

    2.2.1. [Single Sign-on Processing](#single-sign-on-processing)

    2.2.2. [User Message Request Parameter](#user-message-request-parameter)
    
    2.2.3. [Requested Authentication Provider Parameter](#requested-authentication-provider-parameter)

    2.2.4. [Requested Authentication Context Class Reference (acr)](#requested-authentication-context-class-reference)

    2.3. [Token Endpoint Requirements](#op-token-endpoint-requirements)
    
    2.3.1. [Client Authentication Requirements](#client-authentication-requirements)
    
    2.3.2. [Token Response Requirements](#token-response-requirements)
    
    2.3.3. [ID Token Issuance](#id-token-issuance)

    2.4. [Signature Extension Support](#signature-extension-support)

3. [**Relying Party Requirements**](#relying-party-requirements)

    3.1. [Authentication Request Requirements](#client-authentication-request-requirements)

    3.1.1. [Requesting Authentication Context Class Reference](#requesting-authentication-context-class-reference)

    3.2. [Client Registration and Metadata Requirements](#client-registration-and-metadata-requirements)

4. [**Security Requirements**](#security-requirements)

5. [**References**](#references)

6. [**Changes between versions**](#changes-between-versions)

---

<a name="introduction"></a>
## 1. Introduction

This profile is an extension of [The Swedish OpenID Connect Profile](#oidc-sweden-profile), \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\], for the [Sweden Connect](https://www.swedenconnect.se) identity federation.

The profile aims to get a baseline security and to facilitate interoperability between relying parties and OpenID providers within the Sweden Connect identity federation.

<a name="requirements-notation-and-conventions"></a>
### 1.1. Requirements Notation and Conventions

The keywords “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” are to be interpreted as described in \[[RFC2119](#rfc2119)\].

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behaviour that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.

<a name="conformance"></a>
### 1.2. Conformance

This profile defines requirements for OpenID Connect Relying Parties (clients) and OpenID Providers (identity providers), and the interaction between them. 

Components compliant with this profile MUST adhere to the requirements of [The Swedish OpenID Connect Profile](#oidc-sweden-profile), \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] along with the extensions and requirements stated in the rest of this profile.

<a name="openid-provider-requirements"></a>
## 2. OpenID Provider Requirements

An OpenID Provider compliant with this profile MUST adhere to the requirements stated in \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] along with the additions declared below.

<a name="openid-provider-discovery-and-metadata-requirements"></a>
### 2.1. OpenID Provider Discovery and Metadata Requirements

The following requirements concerning OpenID Provider Metadata documents apply in addition to section 5.2 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\]:

- The OP Metadata document SHOULD contain a `service_documentation` parameter having as its value a URL pointing to a resource containing human-readable information about the OP (for example, information about client registration). See section 3 of \[[OpenID.Discovery](#openid-discovery)\].

- The OP Metadata document MUST contain the `ui_locales_supported` parameter, and its value MUST contain English (`en`) and Swedish (`sv`), and MAY contain support for other languages. See section 3 of \[[OpenID.Discovery](#openid-discovery)\].

> **Note:** This version of the profile does not specify how OpenID Provider Metadata documents are made available to the Relying Parties/Clients of the federation. Future versions will include OpenID Federation and alternative mechanisms for distributing metadata.

<a name="op-authentication-request-requirements"></a>
### 2.2. Authentication Request Requirements

<a name="single-sign-on-processing"></a>
#### 2.2.1. Single Sign-on Processing

Sweden Connect is a national identity federation and the Relying Parties of the federation generally have no organizational affinity, other than they use the same OpenID Providers for authentication of their users. Therefore, the feature of Single Sign-on by relying on a user's security context/session at an OpenID Provider that is used by several, non-connected, Relying Parties, should be used with great care. 

This profile states the following requirements regarding the re-use of user sessions:

- An OpenID Provider within the Sweden Connect federation MUST NOT allow user sessions to exceed 60 minutes. 

- If the `prompt` parameter is not present in an authentication request, it is RECOMMENDED that the OpenID Provider treat the request as if it contained the `prompt` parameter with the value `login`, meaning that user (re-)authentication is required, regardless of the state of the current user session at the OpenID Provider.

- If the `prompt` parameter is present and its value is set to `none` (meaning that the Relying Party wishes to make use of an existing user security context/session, i.e., SSO), the following requirements apply:

    - If the security context/user session has expired, the OP MUST respond with an error holding the error code `login_required`.
    
    - If the original authentication process, which led to the establishment of the security context, was created based on the request from another Relying Party than the sender of the current request, the OP MUST respond with an error holding the error code `login_required`. <br /><br />The exception to this requirement is that an OP is allowed to maintain a configuration of "groups of Relying Parties", where SSO is allowed. How this configuration is maintained is out of scope for this profile.  
    
    - If the original authentication process, which led to the establishment of the security context, was performed using another authentication method or `acr` (Authentication Context Class Reference) than what is requested in the current authentication request, the OP MUST respond with an error holding the error code `login_required`.
    
    - If the original authentication process, which led to the establishment of the security context, involved user consent for a set of claims, and the current authentication request contains a request for a different set of identity claims, the OP MUST respond with an error holding the error code `interaction_required`.

See section 3.1.2.1 of \[[OpenID.Core](#openid-core)\] and section 2.1.4 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] regarding further requirements for the `prompt` request parameter.

<a name="user-message-request-parameter"></a>
#### 2.2.2. User Message Request Parameter

It is RECOMMENDED that OpenID Providers compliant with this profile supports the `https://id.oidc.se/param/userMessage` request parameter according to section 2.1 of \[[OIDC.Sweden.RPar](#oidc-sweden-rpar)\]. This parameter gives the Relying Party the possibility to request that a message (set by the RP) is displayed to the user during the authentication process.

OpenID Providers that support the `https://id.oidc.se/param/userMessage` request parameter MUST include the `https://id.oidc.se/disco/userMessageSupported` parameter in its Metadata document (see section 3.3.1 of \[[OIDC.Sweden.RPar](#oidc-sweden-rpar)\]). If MIME types other than `text/plain` is supported, the OP MUST include the `https://id.oidc.se/disco/userMessageSupportedMimeTypes` parameter and as its value state all supported MIME types.

<a name="requested-authentication-provider-parameter"></a>
#### 2.2.3. Requested Authentication Provider Parameter

An OpenID Provider that acts as a proxy for underlying authentication mechanisms SHOULD support the `https://id.oidc.se/param/authnProvider` request parameter extension (see section 2.2 of \[[OIDC.Sweden.RPar](#oidc-sweden-rpar)\]).

OpenID Providers that support the `https://id.oidc.se/param/authnProvider` request parameter, MUST declare this support in its Metadata document using the `https://id.oidc.se/disco/authnProviderSupported` parameter, see section 3.2 of \[[OIDC.Sweden.RPar](#oidc-sweden-rpar)\].

<a name="requested-authentication-context-class-reference"></a>
#### 2.2.4. Requested Authentication Context Class Reference (acr)

This section does not add any requirements. It clarifies how an OpenID Provider processes requested Authentication Context Class Reference values, based on \[[OpenID.Core](#openid-core)\], \[[OpenID.Registration](#openid-registration)\] and \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\]. See Section [3.1](#client-authentication-request-requirements) for how a Relying Party should request these values.

A Relying Party can request Authentication Context Class Reference values in the following ways:

- Using the `acr_values` request parameter.
- Using the `default_acr_values` client metadata parameter. These values apply to requests that contain neither the `acr_values` parameter nor an `acr` claim in the `claims` parameter.
- Using the `claims` request parameter, by including the `acr` claim with a `value` or `values` member.

When `acr_values` or `default_acr_values` is used, the `acr` claim is requested as a Voluntary Claim (Section 3.1.2.1 of \[[OpenID.Core](#openid-core)\] and Section 2 of \[[OpenID.Registration](#openid-registration)\]). This means that:

- The OpenID Provider does not fail the authentication because it cannot use any of the requested values.
- The OpenID Provider may authenticate the end-user using an Authentication Context Class other than the requested ones. The `acr` claim in the ID Token then holds the Authentication Context Class Reference that the performed authentication satisfied (Section 2 of \[[OpenID.Core](#openid-core)\]).

Only when the `acr` claim is requested as an Essential Claim using the `claims` parameter is the OpenID Provider bound by the requested values. If none of them can be used to authenticate the end-user, the OpenID Provider must not proceed with the authentication, and should respond with an `unmet_authentication_requirements` error, see Section 2.2 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\].

<a name="op-token-endpoint-requirements"></a>
### 2.3. Token Endpoint Requirements

This section extends section 3 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] with additional requirements for Token endpoint requests and responses.

<a name="client-authentication-requirements"></a>
#### 2.3.1. Client Authentication Requirements

The following requirements apply in addition to the requirements stated in section 3.1.1 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\].

In the context of the Sweden Connect federation, the OpenID Provider MUST NOT accept any other client authentication methods than `private_key_jwt`, or, if a bilateral agreement exists with a Relying Party, mutual TLS authentication.

Mutual TLS authentication may be `tls_client_auth` or `self_signed_tls_client_auth`, and the requirements stated in section 2 of \[[RFC8705](#rfc8705)\] MUST be followed. 

<a name="token-response-requirements"></a>
#### 2.3.2. Token Response Requirements

The contents of the Access Token issued in a Token response MUST NOT reveal any information about the user's identity or the authentication process.

Section 4.2 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] states:
> An OpenID Provider compliant with this profile MUST NOT release any identity claims in the ID Token, or via the UserInfo endpoint, if they have not been explicitly requested via scope and/or claims request parameters, or indirectly by a policy known, and accepted, by the involved parties. 

If the Access Token is a cleartext JWT holding user identity data, information that the Relying Party may not be authorized to access may be leaked. Therefore, it is RECOMMENDED that opaque strings are used as Access Tokens.

Note: An OpenID Provider that also acts as an OAuth2 Authorization Server may of course issue JWT Access Tokens. The above requirement only applies to the Access Tokens that are issued during authentication (i.e., for granting access to the UserInfo endpoint).

<a name="id-token-issuance"></a>
#### 2.3.3. ID Token Issuance

Section 3.2.1 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] provides requirements for the ID Token contents. This section adds additional requirements that OpenID Providers compliant with this profile MUST adhere to.

Section 5.5.1.1 of \[[OpenID.Core](#openid-core)\] (and \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\]) states that the `acr` claim is a Voluntary Claim, unless the Relying Party requests it as an Essential Claim using the `claims` request parameter. Since the Authentication Context Class Reference is central within Sweden Connect, it is RECOMMENDED that OpenID Providers compliant with this profile include the `acr` claim in the ID Token even when it has not been requested as essential.


<a name="signature-extension-support"></a>
### 2.4. Signature Extension Support

Section 7 of \[[SC.SAML.Profile](#sc-saml-profile)\] specifies that a SAML Identity Provider
compliant with Sweden Connect needs to support the "authentication for signature" feature. By doing so, a Signature Service that acts as a Relying Party against the Identity Provider can request the user's approval for a signature, meaning that a sign message is displayed by the Identity Provider during user authentication.

Consequently, a Sweden Connect OpenID Provider, i.e., an OpenID Provider compliant with this profile, MUST support the "Signature Extension for OpenID Connect" specification \[[OIDC.Sweden.Sign](#oidc-sweden-sign)\] with the following additions and clarifications:

- The OpenID Provider MUST support the Signature Approval use case as defined in Section 2.2 of \[[OIDC.Sweden.Sign](#oidc-sweden-sign)\], and MAY support the Signing use case as defined in Section 2.1 of \[[OIDC.Sweden.Sign](#oidc-sweden-sign)\].

- The OpenID Provider MUST display a user interface for the user (directly or via an authentication device) that makes it clear that the user is performing a signature operation.

- The OpenID Provider MUST NOT save the user's authentication in its session at the OP for later re-use in SSO scenarios. This requirement exists to prevent the authentication from a signature approval operation from being re-used when an ID Token is issued for a later authentication request.

See also Section 5.3 of \[[SC.OIDC.Metadata](#sc-oidc-metadata)\] for a clarification of metadata requirements regarding OpenID Provider signature extension support.

<a name="relying-party-requirements"></a>
## 3. Relying Party Requirements

An OpenID Connect Relying Party (Client) compliant with this profile MUST adhere to the requirements stated in \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] along with the additions declared below.

<a name="client-authentication-request-requirements"></a>
### 3.1. Authentication Request Requirements

For all authentication requests where the Relying Party expects the user to authenticate itself, the Relying Party SHOULD include the `prompt` request parameter and assign the `login` value. This is to prevent un-wanted SSO. See section 2.1.4 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\].

It is RECOMMENDED that Relying Parties send authentication requests containing Request Objects, i.e., the request parameters are included in a JWT, and its encoding is assigned to the `request` parameter according to section 6.1 of \[[OpenID.Core](#openid-core)\]. It is also RECOMMENDED that the Request Object JWT is signed.

<a name="requesting-authentication-context-class-reference"></a>
#### 3.1.1. Requesting Authentication Context Class Reference

A Relying Party that requests Authentication Context Class Reference values using the `acr_values` request parameter or the `default_acr_values` client metadata parameter needs to take into account that the OpenID Provider may authenticate the end-user using an Authentication Context Class other than the requested ones, see Section [2.2.4](#requested-authentication-context-class-reference). The Relying Party therefore needs to check the `acr` claim in the received ID Token (Section 3.1.3.7 of \[[OpenID.Core](#openid-core)\]).

A Relying Party that requires the end-user to be authenticated according to a specific Authentication Context Class, or one of a specific set of classes, SHOULD request the `acr` claim as an Essential Claim using the `claims` parameter, and list the accepted Authentication Context Class Reference value or values. In these cases the Relying Party SHOULD NOT include the `acr_values` parameter in the request, see Section 2.1.6 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\].

The example below shows a `claims` parameter where the Relying Party accepts authentication according to either assurance level 3 or assurance level 4. The OpenID Provider has to authenticate the end-user according to one of the listed values, and the `acr` claim in the ID Token holds the value that was used.

```json
{
  "id_token" : {
    "acr" : {
      "essential" : true,
      "values" : [
        "http://id.elegnamnden.se/loa/1.0/loa3",
        "http://id.elegnamnden.se/loa/1.0/loa4"
      ]
    }
  }
}
```

<a name="client-registration-and-metadata-requirements"></a>
### 3.2. Client Registration and Metadata Requirements

Relying Parties compliant with this profile MUST follow the requirements stated in section 6 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] with the additions stated below.

The Relying Party/Client metadata MUST contain the following additional parameters:

- The `contacts` parameter holding at least one email address of people/groups responsible for the Relying Party.

- The `client_name` parameter holding the client presentation name. This name may be presented to the end-user by the OpenID Provider during authentication. The name MUST be given in Swedish (`sv`) and English (`en`).

- The `logo_uri` parameter containing a URL referencing a logotype for the Relying Party. This logotype may be displayed by the OpenID Provider for the end-user during authentication. The URL MUST use the HTTPS-scheme and point to a valid image file. It is RECOMMENDED that the image file is in SVG-format. The parameter MAY be given for different languages.

- The `client_uri` parameter containing a URL that is the home page for the Relying Party. This link may be used by the OpenID Provider when interacting with the user. The URL MUST use the HTTPS-scheme and point to a valid web page. The parameter MAY be given for different languages.

Also, it is RECOMMENDED, that a Relying Party includes the `organization_name` claim and provides its human-readable organization name in Swedish and English. See section 5.2.2 of \[[OpenID.Federation](#openid-federation)\]. 

**Example:**

```json
{
  ...
  "contacts": [
    "operations@example.com"
  ],
  "client_name#en": "The Example Service",
  "client_name#sv": "Exempeltjänsten",
  "logo_uri": "https://www.example.com/logo.svg",
  "client_uri#en": "https://www.example.com",
  "client_uri#sv": "https://www.example.com/sv",
  "organization_name#en" : "Example Organization",
  "organization_name#sv" : "Exempelorganisationen"
  ...
}
```

See further requirements concerning client metadata in section 2 of \[[OpenID.Registration](#openid-registration)\].


> **Note:** This version of the profile does not specify how client metadata is registered at/distributed to the OpenID Providers of the federation. Future versions will include OpenID Federation and alternative mechanisms for distributing client metadata.

<a name="security-requirements"></a>
## 4. Security Requirements

Entities compliant with this profile MUST adhere to \[[SC.Security](#sc-security)\] as well as Section 7 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\], where the requirements from \[[SC.Security](#sc-security)\] take precedence in case of conflicting requirements.

<a name="references"></a>
## 5. References

<a name="rfc2119"></a>
**\[RFC2119\]**
> [Bradner, S., Key words for use in RFCs to Indicate Requirement Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="openid-core"></a>
**\[OpenID.Core\]**
> [Sakimura, N., Bradley, J., Jones, M., de Medeiros, B. and C. Mortimore, "OpenID Connect Core 1.0", August 2015](https://openid.net/specs/openid-connect-core-1_0.html).

<a name="openid-discovery"></a>
**\[OpenID.Discovery\]**
> [Sakimura, N., Bradley, J., Jones, M. and E. Jay, "OpenID Connect Discovery 1.0", August 2015](https://openid.net/specs/openid-connect-discovery-1_0.html).

<a name="openid-registration"></a>
**\[OpenID.Registration\]**
> [Sakimura, N., Bradley, J., and M. Jones, "OpenID Connect Dynamic Client Registration 1.0 incorporating errata set 2", December 2023](https://openid.net/specs/openid-connect-registration-1_0.html).

<a name="openid-federation"></a>
**\[OpenID.Federation\]**
> [Hedberg, R., Jones, M.B., Solberg, A.Å., Bradley, J., De Marco, G. and V. Dzhuvinov, "OpenID Federation 1.0"](https://openid.net/specs/openid-federation-1_0.html).

<a name="rfc7515"></a>
**\[RFC7515\]**
> [Jones, M., Bradley, J., and N. Sakimura, “JSON Web Token (JWT)”, May 2015](https://tools.ietf.org/html/rfc7515).

<a name="rfc8705"></a>
**\[RFC8705\]**
> [B. Campbell, J. Bradley, N. Sakimura, T. Lodderstedt, "OAuth 2.0 Mutual-TLS Client Authentication and Certificate-Bound Access Tokens", February 2020](https://datatracker.ietf.org/doc/html/rfc8705).

<a name="iana-reg"></a>
**\[IANA-Reg\]**
> [IANA JSON Web Token Claims Registry](https://www.iana.org/assignments/jwt/jwt.xhtml#claims).

<a name="oidc-sweden-profile"></a>
**\[OIDC.Sweden.Profile\]**
> [The Swedish OpenID Connect Profile - version 1.0](https://www.oidc.se/specifications/swedish-oidc-profile-1_0.html).

<a name="oidc-sweden-claims"></a>
**\[OIDC.Sweden.Claims\]**
> [Claims and Scopes Specification for the Swedish OpenID Connect Profile - Version 1.0](https://www.oidc.se/specifications/swedish-oidc-claims-specification-1_0.html).

<a name="oidc-sweden-rpar"></a>
**\[OIDC.Sweden.RPar\]**
> [Authentication Request Parameter Extensions for the Swedish OpenID Connect Profile - Version 1.1](https://www.oidc.se/specifications/request-parameter-extensions-1_1.html).

<a name="oidc-sweden-sign"></a>
**\[OIDC.Sweden.Sign\]**
> [Signature Extension for OpenID Connect - Version 1.2](https://www.oidc.se/specifications/oidc-signature-extension-1_2.html).

<a name="sc-security"></a>
**\[SC.Security\]**
> [Sweden Connect – Security Requirements 1.0](https://docs.swedenconnect.se/federation/security-requirements.html).

<a name="sc-oidc-metadata"></a>
**\[SC.OIDC.Metadata\]**
> [Sweden Connect – OpenID Connect Metadata Requirements 1.0](https://docs.swedenconnect.se/federation/oidc-metadata-requirements.html).

<a name="sc-saml-profile"></a>
**\[SC.SAML.Profile\]**
> [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).

<a name="changes-between-versions"></a>
## 6. Changes between versions

Changes between version 1.0 and version 1.1:

- Section 2.4, Signature Extension Support, was added. It defines the requirements for OpenID Provider support of the Signature Extension specified in [Signature Extension for OpenID Connect - Version 1.1](https://www.oidc.se/specifications/oidc-signature-extension-1_1.html).

- Section 4, Security Requirements, was added.

- In Section 2.2.1, a requirement that an OP MUST treat a request without a `prompt` parameter as a request where `login` is supplied, to a recommendation. The reason for this is to avoid breaking existing implementations.


