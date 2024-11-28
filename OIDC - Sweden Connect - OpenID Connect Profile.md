<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# OpenID Connect Profile for Sweden Connect

### Version 1.0 - 2024-11-28 - *Draft version*

Registration number: **TBD**

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (Digg)</a>, 2015-2024. All Rights Reserved.
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

    2.3. [Token Endpoint Requirements](#op-token-endpoint-requirements)
    
    2.3.1. [Client Authentication Requirements](#client-authentication-requirements)
    
    2.3.2. [Token Response Requirements](#token-response-requirements)

    2.4. [eIDAS Requirements](#eidas-requirements)

3. [**Relying Party Requirements**](#relying-party-requirements)

    3.1. [Authentication Request Requirements](#client-authentication-request-requirements)

    3.2. [Client Registration and Metadata Requirements](#client-registration-and-metadata-requirements)

4. [**References**](#references)

---

<a name="introduction"></a>
## 1. Introduction

This profile is an extension of [The Swedish OpenID Connect Profile](#oidc-sweden-profile), \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\], for the [Sweden Connect](https://www.swedenconnect.se) identity federation.

The profile aims to get a baseline security and to facilitate interoperability between relying parties and OpenID providers within the Sweden Connect identity federation.

> **Note:** This version of the profile does not address features concerning "Signature Services" and requirements for "authentication for Signature" that are specified in the corresponding Sweden Connect SAML deployment profile, \[[SC.SAML.Profile](#sc-saml-profile)\]. Nor does the profile specify how OpenID Provider metadata and Relying Party/Client metadata is distributed and made available to the members of the federation. This will be added in future versions of the profile.

<a name="requirements-notation-and-conventions"></a>
### 1.1. Requirements Notation and Conventions

The keywords “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” are to be interpreted as described in \[[RFC2119](#rfc2119)\].

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behaviour that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.

<a name="conformance"></a>
### 1.2. Conformance

This profile defines requirements for OpenID Connect Relying Parties (clients) and OpenID Providers (identity providers), and the interaction between them. 

Components compliant with this profile MUST adhere to the requirements of [The Swedish OpenID Connect Profile](#oidc-sweden-profile), \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] along with the extensions and requirements stated in the rest of this profile.

When a component compliant with this profile is interacting with other components compliant with this profile, all components MUST fully conform to the features and requirements of this specification. Any interaction with components that are not compliant with this profile is out of scope for this specification.

<a name="openid-provider-requirements"></a>
## 2. OpenID Provider Requirements

An OpenID Provider compliant with this profile MUST adhere to the requirements stated in \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] along with the additions declared below.

<a name="openid-provider-discovery-and-metadata-requirements"></a>
### 2.1. OpenID Provider Discovery and Metadata Requirements

OpenID Providers MUST follow the requirements stated in section 5.2 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] with the following additions:

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

- If the `prompt` parameter is not present in an authentication request, the OpenID Provider MUST treat this request as if it would contain the `prompt` parameter with a value of `login`, meaning that a user (re-)authentication is required, no matter the state of the current user session at the provider.

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

<a name="op-token-endpoint-requirements"></a>
### 2.3. Token Endpoint Requirements

This section extends section 3 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] with additional requirements for Token endpoint requests and responses.

<a name="client-authentication-requirements"></a>
#### 2.3.1. Client Authentication Requirements

OpenID Providers compliant with this profile MUST adhere with section 3.1.1 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] with the following addition:

In the context of the Sweden Connect federation, the OpenID Provider MUST NOT accept any other client authentication methods than `private_key_jwt`, or, if a bilateral agreement exists with a Relying Party, mutual TLS authentication.

Mutual TLS authentication may be `tls_client_auth` or `self_signed_tls_client_auth`, and the requirements stated in section 2 of \[[RFC8705](#rfc8705)\] MUST be followed. 

<a name="token-response-requirements"></a>
#### 2.3.2. Token Response Requirements

The contents of the Access Token issued in a Token response MUST NOT reveal any information about the user's identity or the authentication process.

Section 4.2 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] states:
> An OpenID Provider compliant with this profile MUST NOT release any identity claims in the ID Token, or via the UserInfo endpoint, if they have not been explicitly requested via scope and/or claims request parameters, or indirectly by a policy known, and accepted, by the involved parties. 

If the Access Token is a cleartext JWT holding user identity data, information that the Relying Party may not be authorized to access may be leaked. Therefore, it is RECOMMENDED that opaque strings are used as Access Tokens.

Note: An OpenID Provider that also acts as an OAuth2 Authorization Server may of course issue JWT Access Tokens. The above requirement only applies to the Access Tokens that are issued during authentication (i.e., for granting access to the UserInfo endpoint).

<a name="relying-party-requirements"></a>
## 3. Relying Party Requirements

An OpenID Connect Relying Party (Client) compliant with this profile MUST adhere to the requirements stated in \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] along with the additions declared below.

<a name="client-authentication-request-requirements"></a>
### 3.1. Authentication Request Requirements

For all authentication requests where the Relying Party expects the user to authenticate itself, the RP SHOULD include the `prompt` request parameter and assign the `login` value. This is to prevent un-wanted SSO. See section 2.1.4 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\].

It is RECOMMENDED that Relying Parties send authentication requests containing Request Objects, i.e., the request parameters are included in a JWT, and its encoding is assigned to the `request` parameter according to section 6.1 of \[[OpenID.Core](#openid-core)\]. It is also RECOMMENDED that the Request Object JWT is signed.

> The above recommendation gives a higher level of security, and may be changed to an imperative requirement in future versions of this profile.


<a name="client-registration-and-metadata-requirements"></a>
### 3.2. Client Registration and Metadata Requirements

Relying Parties compliant with this profile MUST follow the requirements stated in section 6 of \[[OIDC.Sweden.Profile](#oidc-sweden-profile)\] with the additions stated below.

The Relying Party/Client metadata MUST contain the following additional parameters:

- The `contacts` parameter holding at least one email address of people/groups responsible for the Relying Party.

- The `client_name` parameter holding the client presentation name. This name may be presented to the end-user by the OpenID Provider during authentication. The name MUST be given in Swedish (`sv`) and English (`en`).

- The `logo_uri` parameter containing a URL referencing a logotype for the Relying Party. This logotype may be displayed by the OpenID Provider for the end-user during authentication. The URL MUST use the HTTPS-scheme and point to a valid image file. It is RECOMMENDED that the image file is in SVG-format. The parameter MAY be given for different languages.

- The `client_uri` parameter containing a URL that is the home page for the Relying Party. This link may be used by the OpenID Provider when interacting with the user. The URL MUST use the HTTPS-scheme and point to a valid web page. The parameter MAY be given for different languages.

> TODO: Organization?

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
  ...
}
```

See further requirements concerning client metadata in section 2 of \[[OpenID.Registration](#openid-registration)\].


> **Note:** This version of the profile does not specify how client metadata is registered at/distributed to the OpenID Providers of the federation. Future versions will include OpenID Federation and alternative mechanisms for distributing client metadata.

<a name="references"></a>
## 4. References

<a name="rfc2119"></a>
**\[RFC2119\]**
> [Bradner, S., Key words for use in RFCs to Indicate Requirement Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="openid-core"></a>
**\[OpenID.Core\]**
> [Sakimura, N., Bradley, J., Jones, M., de Medeiros, B. and C. Mortimore, "OpenID Connect Core 1.0", August 2015] (https://openid.net/specs/openid-connect-core-1_0.html).

<a name="openid-discovery"></a>
**\[OpenID.Discovery\]**
> [Sakimura, N., Bradley, J., Jones, M. and E. Jay, "OpenID Connect Discovery 1.0", August 2015](https://openid.net/specs/openid-connect-discovery-1_0.html).

<a name="openid-registration"></a>
**\[OpenID.Registration\]**
> [Sakimura, N., Bradley, J., and M. Jones, “OpenID Connect Dynamic Client Registration 1.0,” November 2014](https://openid.net/specs/openid-connect-registration-1_0.html).

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
> [Signature Extension for OpenID Connect - Version 1.1](https://www.oidc.se/specifications/oidc-signature-extension-1_1.html).

<a name="sc-saml-profile"></a>
**\[SC.SAML.Profile\]**
> [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).
