<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# OpenID Connect Claims and Scopes Specification for Sweden Connect

### Version 1.0 - 2023-12-12 - *Draft version*

Registration number: **TBD**

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (DIGG)</a>, 2015-2023. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirement key words](#requirement-key-words)

2. [**Claims**](#claims)

	2.1. [eIDAS Claims](#eidas-claims)
	
	2.1.1. [Provisional Identifier](#provisional-identifier)
	
	2.1.2. [Provisional Identifier Persistence Indicator](#provisional-identifier-persistence-indicator)
	
	2.1.3. [Mapped Swedish Personal Identity Number](#mapped-swedish-personal-identity-number)

	2.1.4. [Mapped Swedish Coordination Number](#mapped-swedish-coordination-number)

	2.1.5. [Identity Binding Level](#identity-binding-level)
	
	2.1.6. [eIDAS Person Identifier](#eidas-person-identifier)

4. [**References**](#references)

---

<a name="introduction"></a>
## 1. Introduction

This specification extends the "Claims and Scopes Specification for the Swedish OpenID Connect Profile",
\[[OIDC.Sweden.Claims](#oidc-sweden-claims)\], with OpenID Connect claims and scopes for usage within 
the Sweden Connect federation and Swedish eID Framework.

<a name="requirement-key-words"></a>
### 1.1. Requirement key words

The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”,
“SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” are to be
interpreted as described in \[[RFC2119](#rfc2119)\].

These keywords are capitalized when used to unambiguously specify
requirements over protocol features and behavior that affect the
interoperability and security of implementations. When these words are
not capitalized, they are meant in their natural-language sense.

<a name="claims"></a>
## 2. Claims

This section defines a set of claims that extend the claims defined in 
\[[OIDC.Sweden.Claims](#oidc-sweden-claims)\], and the set of standard claims defined 
in \[[RFC7515](#rfc7515)\] and section 5.1 of \[[OpenID.Core](#openid-core)\]. A full listing of
standard claims can be found in the [IANA JSON Web Token Claims Registry](https://www.iana.org/assignments/jwt/jwt.xhtml#claims), \[[IANA-Reg](#iana-reg)\].

The claims and defined in this specification are named in a collision-resistant manner, as described
in JSON Web Token (JWT), \[[RFC7515](#rfc7515)\], specification. All claims and scopes defined within
this specification are prefixed with the namespace `https://id.swedenconnect.se/claim/`.

<a name="eidas-claims"></a>
### 2.1. eIDAS Claims

This section defines how identity attributes received from, or in conjunction with, an eIDAS
authentication is represented as OpenID claims within the Sweden Connect federation.

<a name="provisional-identifier"></a>
#### 2.1.1. Provisional Identifier

**Claim:** `https://id.swedenconnect.se/claim/prid`

**Description:** Provisional Identifier used to represent a subject that has been authenticated
by the Swedish eIDAS Connector. See section 3.3.1 of \[[SAML.SC.Attributes](#saml-sc-attributes)\]
for details.

**Type:** String

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.4` \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="provisional-identifier-persistence-indicator"></a>
#### 2.1.2. Provisional Identifier Persistence Indicator

**Claim:** `https://id.swedenconnect.se/claim/pridPersistence`

**Description:** Indicator for the expected persistence of the `prid` claim.
See section 3.3.1 of \[[SAML.SC.Attributes](#saml-sc-attributes)\] for details.

**Type:** String, where the possible values are `A`, `B` or `C`. See \[[SC.Constructed](#sc-constructed-attr)\] for details.

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.5` \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="mapped-swedish-personal-identity-number"></a>
#### 2.1.3. Mapped Swedish Personal Identity Number

**Claim:** `https://id.swedenconnect.se/claim/mappedPersonalIdentityNumber`

**Description:** A Swedish civic registration number (”personnummer”). This claim is used to represent
a Swedish civic registration number that was the result of a query from the Swedish eIDAS Connector
to an identity matching service after the subject was authenticated at a foreign eIDAS node. See section
3.3.2 of \[[SAML.SC.Attributes](#saml-sc-attributes)\] for details.

Normally a Swedish civic registration number is represented using the claim 
`https://id.oidc.se/claim/personalIdentityNumber` defined in 
\[[OIDC.Sweden.Claims](#oidc-sweden-claims)\], but in order to avoid consumption of this claim
without checking its binding strength, i.e., how trustworthy the process of binding the Swedish 
identity to the identity attributes from the eIDAS authentication is, the identity number is
represented in a separate claim. See [Identity Binding Level](#identity-binding-level) below.

**Type:** String where the format is 12 digits without hyphen.

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.16` \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="mapped-swedish-coordination-number"></a>
#### 2.1.4. Mapped Swedish Coordination Number

**Claim:** `https://id.swedenconnect.se/claim/mappedCoordinationNumber`

**Description:** A Swedish coordination number (”samordningsnummer”). This claim is used to represent
a Swedish coordination number that was the result of a query from the Swedish eIDAS Connector
to an identity matching service after the subject was authenticated at a foreign eIDAS node. See section
3.3.2 of \[[SAML.SC.Attributes](#saml-sc-attributes)\] for details.

Normally a Swedish coordination number is represented using the claim 
`https://id.oidc.se/claim/coordinationNumber` defined in 
\[[OIDC.Sweden.Claims](#oidc-sweden-claims)\], but for the same reasons as described for the 
`mappedPersonalIdentityNumber` claim above, a mapped coordination number is represented in a separate
claim.

**Type:** String where the format is 12 digits without hyphen.

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.16` \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="identity-binding-level"></a>
#### 2.1.5. Identity Binding Level

**Claim:** `https://id.swedenconnect.se/claim/identityBindingLevel`

**Description:** An URI identifying the "binding process" for a `mappedPersonalIdentityNumber` or
`mappedCoordinationNumber` claim. See section 3.3.2 of \[[SAML.SC.Attributes](#saml-sc-attributes)\]
and \[[SC.ID-Binding](#sc-id-bidning)\] for details.

**Type:** URI. Possible values are defined in section 3 of \[[SC.ID-Binding](#sc-id-bidning)\].

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.6` \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="eidas-person-identifier"></a>
#### 2.1.6. eIDAS Person Identifier

**Claim:** `https://id.swedenconnect.se/claim/eidasPersonIdentifier`

**Description:** A claim that holds the value for the eIDAS Person Identifier attribute, `http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier`. This value is issued by the foreign
eIDAS node and within the eIDAS federation this is the unique user identifier. See \[[eIDAS.Attributes](#eidas-attr)\].

**Type:** String

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.7` \[[SAML.SC.Attributes](#saml-sc-attributes)\]

> Within eIDAS, the corresponding SAML attribute is: `http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier` \[[eIDAS.Attributes](#eidas-attr)\].

<a name="references"></a>
## 4. References

<a name="rfc2119"></a>
**\[RFC2119\]**
> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="openid-core"></a>
**\[OpenID.Core\]**
> [Sakimura, N., Bradley, J., Jones, M., de Medeiros, B. and C. Mortimore, "OpenID Connect Core 1.0", August 2015](https://openid.net/specs/openid-connect-core-1_0.html).

<a name="rfc7515"></a>
**\[RFC7515\]**
> [Jones, M., Bradley, J., and N. Sakimura, “JSON Web Token (JWT)”, May 2015](https://tools.ietf.org/html/rfc7515).

<a name="iana-reg"></a>
**\[IANA-Reg\]**
> [IANA JSON Web Token Claims Registry](https://www.iana.org/assignments/jwt/jwt.xhtml#claims).

<a name="oidc-sweden-claims"></a>
**\[OIDC.Sweden.Claims\]**
> [Claims and Scopes Specification for the Swedish OpenID Connect Profile - Version 1.0](https://www.oidc.se/specifications/swedish-oidc-claims-specification-1_0.html).

<a name="saml-sc-attributes"></a>
**\[SAML.SC.Attributes\]**
> [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html).

<a name="sc-constructed-attr"></a>
**\[SC.Constructed\]**
> [eIDAS Constructed Attributes Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/11_-_eIDAS_Constructed_Attributes_Specification_for_the_Swedish_eID_Framework.html).

<a name="sc-id-bidning"></a>
**\[SC.ID-Binding\]**
> [Binding of eIDAS Identities to Records in the Swedish Population Register](https://docs.swedenconnect.se/technical-framework/Identity_Binding.html).

<a name="eidas-attr"></a>
**\[eIDAS.Attributes\]**
> [eIDAS SAML Attribute Profile, version 1.2, 21 May 2019](https://docs.swedenconnect.se/technical-framework/mirror/eidas/eIDAS_SAML_Attribute_Profile_v1.2-FINAL.pdf).

<a name="skv704"></a>
**\[SKV704\]**
> [Skatteverket, SKV 704 Utgåva 8,
> Personnummer](https://docs.swedenconnect.se/technical-framework/mirror/skv/skv704-8.pdf).

<a name="skv707"></a>
**\[SKV707\]**
> [Skatteverket, SKV 707, Utgåva 2,
> Samordningsnummer](https://docs.swedenconnect.se/technical-framework/mirror/skv/skv707-2.pdf).

<a name="skv709"></a>
**\[SKV709\]**
> [Skatteverket, SKV 709, Utgåva 8, Organisationsnummer](https://docs.swedenconnect.se/technical-framework/mirror/skv/skv709-8.pdf).

<a name="iso3166"></a>
**\[ISO3166\]**
> Codes for the representation of names of countries and their
> subdivisions Part 1: Country codes, ISO standard, ISO 3166-1.

<a name="sigsap"></a>
**\[SigSAP\]**
> [Signature Activation Protocol for Federated Signing](https://docs.swedenconnect.se/technical-framework/latest/13_-_Signature_Activation_Protocol.html).

<a name="dssext"></a>
**\[DSSExt\]**
> [DSS Extension for Federated Central Signing Services](https://docs.swedenconnect.se/technical-framework/latest/09_-_DSS_Extension_for_Federated_Signing_Services.html).

