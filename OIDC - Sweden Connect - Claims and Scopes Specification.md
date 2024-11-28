<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# OpenID Connect Claims and Scopes Specification for Sweden Connect

### Version 1.0 - 2024-11-28 - *Draft version*

Registration number: **TBD**

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (Digg)</a>, 2015-2024. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirements Notation and Conventions](#requirements-notation-and-conventions)

2. [**Claims**](#claims)

	2.1. [eIDAS Claims](#eidas-claims)
	
	2.1.1. [Provisional Identifier](#provisional-identifier)
	
	2.1.2. [Provisional Identifier Persistence Indicator](#provisional-identifier-persistence-indicator)
	
	2.1.3. [Mapped Swedish Personal Identity Number](#mapped-swedish-personal-identity-number)

	2.1.4. [Mapped Swedish Coordination Number](#mapped-swedish-coordination-number)

	2.1.5. [Identity Binding](#identity-binding)
	
	2.1.6. [eIDAS Person Identifier](#eidas-person-identifier)

    2.1.7. [eIDAS Country](#eidas-country)

3. [**Scopes**](#scopes)

    3.1. [eIDAS Scopes](#eidas-scopes)
    
    3.1.1. [eIDAS Natural Person Identity](#eidas-natural-person-identity)

    3.1.2. [eIDAS Natural Person with Swedish Identity](#eidas-natural-person-with-swedish-identity)
    
    3.1.3. [Additional eIDAS Claims](#additional-eidas-claims)

4. [**References**](#references)

Appendix A: [**Conversion of eIDAS Attributes**](#conversion-of-eidas-attributes)

---

<a name="introduction"></a>
## 1. Introduction

This specification extends the "Claims and Scopes Specification for the Swedish OpenID Connect Profile", \[[OIDC.Sweden.Claims](#oidc-sweden-claims)\], with OpenID Connect claims and scopes for usage within the Sweden Connect federation and Swedish eID Framework.

<a name="requirements-notation-and-conventions"></a>
### 1.1. Requirements Notation and Conventions

The keywords “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” are to be interpreted as described in \[[RFC2119](#rfc2119)\].

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behaviour that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.

<a name="claims"></a>
## 2. Claims

This section defines a set of claims that extend the claims defined in \[[OIDC.Sweden.Claims](#oidc-sweden-claims)\], and the set of standard claims defined in \[[RFC7515](#rfc7515)\] and section 5.1 of \[[OpenID.Core](#openid-core)\]. A full listing of standard claims can be found in the [IANA JSON Web Token Claims Registry](https://www.iana.org/assignments/jwt/jwt.xhtml#claims), \[[IANA-Reg](#iana-reg)\].

The claims defined in this specification are named in a collision-resistant manner, as described in JSON Web Token (JWT), \[[RFC7515](#rfc7515)\], specification. All claims defined within this specification are prefixed with the namespace `https://id.swedenconnect.se/claim/`.

<a name="eidas-claims"></a>
### 2.1. eIDAS Claims

This section defines how identity attributes received from, or in conjunction with, an eIDAS authentication is represented as OpenID claims within the Sweden Connect federation. 

[Appendix A: Conversion of eIDAS Attributes](#conversion-of-eidas-attributes) presents a full listing of all eIDAS attributes and how they map to OpenID Connect claims. The sub-sections below define additional claims that may be added by the Swedish eIDAS-node.

<a name="provisional-identifier"></a>
#### 2.1.1. Provisional Identifier

**Claim:** `https://id.swedenconnect.se/claim/prid`

**Description:** Provisional Identifier used to represent a subject that has been authenticated by the Swedish eIDAS Connector. See section 3.3.1 of \[[SAML.SC.Attributes](#saml-sc-attributes)\] for details.

**Type:** String

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.4` (prid) - \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="provisional-identifier-persistence-indicator"></a>
#### 2.1.2. Provisional Identifier Persistence Indicator

**Claim:** `https://id.swedenconnect.se/claim/pridPersistence`

**Description:** Indicator for the expected persistence of the `prid` claim. See section 3.3.1 of \[[SAML.SC.Attributes](#saml-sc-attributes)\] for details.

**Type:** String, where the possible values are `A`, `B` or `C`. See \[[SC.Constructed](#sc-constructed-attr)\] for details.

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.5` (pridPersistence) - \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="mapped-swedish-personal-identity-number"></a>
#### 2.1.3. Mapped Swedish Personal Identity Number

**Claim:** `https://id.swedenconnect.se/claim/mappedPersonalIdentityNumber`

**Description:** A Swedish civic registration number ("personnummer"). This claim is used to represent a Swedish civic registration number that was the result of a query from the Swedish eIDAS Connector to the identity binding service after the subject was authenticated at a foreign eIDAS node. See section 3.3.2 of \[[SAML.SC.Attributes](#saml-sc-attributes)\] for details.

Normally a Swedish civic registration number is represented using the claim `https://id.oidc.se/claim/personalIdentityNumber` defined in \[[OIDC.Sweden.Claims](#oidc-sweden-claims)\], but in order to avoid consumption of this claim without checking how the binding was made, i.e., how trustworthy the process of binding the Swedish 
identity to the identity attributes from the eIDAS authentication is, the identity number is represented in a separate claim. See [Identity Binding](#identity-binding) below.

**Type:** String where the format is 12 digits without a hyphen.

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.16` (mappedPersonalIdentityNumber) - \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="mapped-swedish-coordination-number"></a>
#### 2.1.4. Mapped Swedish Coordination Number

**Claim:** `https://id.swedenconnect.se/claim/mappedCoordinationNumber`

**Description:** A Swedish coordination number ("samordningsnummer"). This claim is used to represent a Swedish coordination number that was the result of a query from the Swedish eIDAS Connector to the identity binding service after the subject was authenticated at a foreign eIDAS node. See section 3.3.2 of \[[SAML.SC.Attributes](#saml-sc-attributes)\] for details.

Normally a Swedish coordination number is represented using the claim `https://id.oidc.se/claim/coordinationNumber` defined in \[[OIDC.Sweden.Claims](#oidc-sweden-claims)\], but for the same reasons as described for the `mappedPersonalIdentityNumber` claim above, a mapped coordination number is represented in a separate claim.

**Type:** String where the format is 12 digits without a hyphen.

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.16` (mappedPersonalIdentityNumber) - \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="identity-binding"></a>
#### 2.1.5. Identity Binding

**Claim:** `https://id.swedenconnect.se/claim/identityBinding`

**Description:** A semicolon separated list of URI:s identifying the "binding process(es)" for a `mappedPersonalIdentityNumber` or `mappedCoordinationNumber` claim. See section 3.3.2 of \[[SAML.SC.Attributes](#saml-sc-attributes)\] and \[[SC.ID-Binding](#sc-id-bidning)\] for details.

**Type:** Semicolon separated list of URI:s. Possible values are defined in section 3 of \[[SC.ID-Binding](#sc-id-bidning)\].

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.6` (personalIdentityNumberBinding) - \[[SAML.SC.Attributes](#saml-sc-attributes)\]

<a name="eidas-person-identifier"></a>
#### 2.1.6. eIDAS Person Identifier

**Claim:** `https://id.swedenconnect.se/claim/eidasPersonIdentifier`

**Description:** A claim that holds the value for the eIDAS Person Identifier attribute, `http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier`. This value is issued by the foreign eIDAS node, and within the eIDAS federation this is the unique user identifier. See \[[eIDAS.Attributes](#eidas-attr)\].

**Type:** String

**Corresponding SAML Attribute:** `urn:oid:1.2.752.201.3.7` (eidasPersonIdentifier) - \[[SAML.SC.Attributes](#saml-sc-attributes)\]

> Within eIDAS, the corresponding SAML attribute is: `http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier` \[[eIDAS.Attributes](#eidas-attr)\].

<a name="eidas-country"></a>
#### 2.1.7. eIDAS Country

**Claim:** `https://id.swedenconnect.se/claim/eidasCountry`

**Description:** A claim that identifies the eIDAS member state that is providing the claims of the subject.

**Type:** String representing country in \[[ISO3166-1](#iso3166-1)\] Alpha-2 or \[[ISO3166-3](#iso3166-3)\] syntax. 

**Corresponding SAML Attribute:** No specific SAML attribute exists for "eIDAS country". However, the generic `urn:oid:2.5.4.6` (c) attribute is included in assertions issued by the Swedish eIDAS node.

<a name="scopes"></a>
## 3. Scopes

This section defines a set of scope that extends the claims defined in section 3 of \[[OIDC.Sweden.Claims](#oidc-sweden-claims)\].

The scopes defined in this specification are named in a collision-resistant manner, as described in JSON Web Token (JWT), \[[RFC7515](#rfc7515)\], specification. All scopes defined within this specification are prefixed with the namespace `https://id.swedenconnect.se/scope/`.

<a name="eidas-scopes"></a>
### 3.1. eIDAS Scopes

Section 3 of \[[OIDC.Sweden.Claims](#oidc-sweden-claims)\] states the following:

> Many Relying Parties that use OpenID Connect to authenticate users cannot solely depend on the user's session at the OpenID Provider and the `sub` claim to log in the user to the RP application. In the context of Swedish eID there are some obvious claims that are regarded to be "primary" identity claims by Relying Parties, for example, a Swedish personal identity number. Such claims are needed by the Relying Party in order to log in a user to its application. Therefore, this specification's scope definitions will define that some claims are to be delivered in the ID Token so that a Relying Party can fully log in a user without having to make a, potentially, unnecessary call to the UserInfo endpoint.

The above is true also for Relying Parties authenticating users against the Swedish eIDAS Connector.

<a name="eidas-natural-person-identity"></a>
#### 3.1.1. eIDAS Natural Person Identity

**Scope:** `https://id.swedenconnect.se/scope/eidasNaturalPersonIdentity`

**Description:** A scope that defines a claim set that provides identity information for a natural person authenticated via the Swedish eIDAS-node (via a eIDAS member state). 

| Requested Claims | Description/comment | Reference |
| :--- | :--- | :--- |
| `https://id.swedenconnect.se/claim/prid` | Provisional identifier | This specification - \[[2.1.1](#provisional-identifier)\] |
| `https://id.swedenconnect.se/claim/pridPersistence` | Persistence indicator for the above `prid` claim | This specification - \[[2.1.2](#provisional-identifier-persistence-indicator)\] |
| `https://id.swedenconnect.se/claim/eidasPersonIdentifier` | eIDAS Person Identifier | This specification - \[[2.1.6](#eidas-person-identifier)\] |

**Claims Parameter Equivalent:**

```json
{
  "userinfo" : {
    "https://id.swedenconnect.se/claim/prid" : { "essential" : true },
    "https://id.swedenconnect.se/claim/pridPersistence" : { "essential" : true },
    "https://id.swedenconnect.se/claim/eidasPersonIdentifier": { "essential" : true },
  },
  "id_token" : {
    "https://id.swedenconnect.se/claim/prid" : { "essential" : true },
    "https://id.swedenconnect.se/claim/pridPersistence" : { "essential" : true }
  }
}
```


**Note:** It is RECOMMENDED that Swedish Relying Parties use the `https://id.swedenconnect.se/claim/prid` claim as a primary identity for a user identified using eIDAS and therefore this claim will be available in the ID Token. The eIDAS Person Identifier, which is the identifier issued by the member state eIDAS-node, may be logged/saved by the Relying Party for potential future use in contacts with the member state node. 


<a name="eidas-natural-person-with-swedish-identity"></a>
#### 3.1.2. eIDAS Natural Person with Swedish Identity

**Scope:** `https://id.swedenconnect.se/scope/eidasSwedishIdentity`

**Description:** The Swedish eIDAS Connector has an integration against an "Identity Binding Service" holding bindings between eIDAS eID identities and Swedish identities (see \[[SC.ID-Binding](#sc-id-bidning)\] for details). If this scope is requested by a Relying Party, the eIDAS Connector will check if there exists a binding between the user's eIDAS identity and a Swedish identity, and if so, make those claims available for the Relying Party.

| Requested Claims | Description/comment | Reference |
| :--- | :--- | :--- |
| `https://id.swedenconnect.se/claim/`<br />`mappedPersonalIdentityNumber` | A Swedish civic registration number ("personnummer") that was the result of a query  from the Swedish eIDAS Connector to the identity binding service after the subject was authenticated at a foreign eIDAS node. | This specification - \[[2.1.3](#mapped-swedish-personal-identity-number)\] |
| `https://id.swedenconnect.se/claim/`<br />`mappedCoordinationNumber` | A Swedish coordination number ("samordningsnummer") that was the result of a query  from the Swedish eIDAS Connector to the identity binding service after the subject was authenticated at a foreign eIDAS node. | This specification - \[[2.1.4](#mapped-swedish-coordination-number)\] |
| `https://id.swedenconnect.se/claim/`<br />`identityBinding` | Identification of the binding process(es) that were applied to obtain the binding between the eIDAS identity and the `mappedPersonalIdentityNumber` or `mappedCoordinationNumber`. See \[[SC.ID-Binding](#sc-id-bidning)\]. | This specification - \[[2.1.5](#identity-binding)\] |

**Claims Parameter Equivalent:**

```
{
  "userinfo" : {
    "https://id.swedenconnect.se/claim/mappedPersonalIdentityNumber" : null,
    "https://id.swedenconnect.se/claim/mappedCoordinationNumber" : null,
    "https://id.swedenconnect.se/claim/identityBinding" : null
  }
}
```

**Note:** None of the claims are marked as "essential" since the eIDAS Connector will only deliver the claims if an identity binding exists. Also, the scope definition states that the claims should be delivered via the UserInfo endpoint and not directly in the ID Token. The reason for this is that a mapped identity can never be seen as a primary eIDAS identity (since the claims are only delivered if a binding exists).

**Note (ii):** The `mappedPersonalIdentityNumber` and `mappedCoordinationNumber` claims are mutually exclusive. A user has bound his or hers eIDAS identity to a Swedish civic registration number ("personnummer") **or** a Swedish coordination number ("samordningsnummer"), never both.

<a name="additional-eidas-claims"></a>
#### 3.1.3. Additional eIDAS Claims

Not all eIDAS attributes/claims listed in [Appendix A](#conversion-of-eidas-attributes) are covered by the above scope definitions. This section is an informational text informing Relying Parties how to obtain additional claims for an eIDAS authentication.

- To obtain name and date of birth claims, include the `https://id.oidc.se/scope/naturalPersonInfo` scope (section 3.1 of  \[[OIDC.Sweden.Claims](#oidc-sweden-claims)\]).

- For the transaction identifier holding the ID of the SAML assertion delivered from the foreign member state (as described in section 2.5 of \[[SAML.SC.Attributes](#saml-sc-attributes)\]), include an explicit claim request for the `txn` claim ([[RFC8417](#rfc8417)\]).

- For the country code of the eIDAS country at which the user was authenticated (as described in section 2.5 of \[[SAML.SC.Attributes](#saml-sc-attributes)\]), include an explicit claim request for the `https://id.swedenconnect.se/claim/eidasCountry` claim ([2.1.7](#eidas-country)).

- For all other optional eIDAS attributes (see [Appendix A](#conversion-of-eidas-attributes)), an explicit claim request should be included. These claims SHOULD NOT be marked as "essential" since they are not mandatory according to \[[eIDAS.Attributes](#eidas-attr)\]. 

> Section 2.2.1 of \[[eIDAS.Attributes](#eidas-attr)\] defines the eIDAS Minimum Dataset for Natural Persons. This set comprises of the eIDAS attributes FamilyName, FirstName, DateOfBirth and PersonIdentifier. In order for a Relying Party to obtain the corresponding OpenID Connect claims from an eIDAS authentication it should specify the `https://id.oidc.se/scope/naturalPersonInfo` and `https://id.swedenconnect.se/scope/eidasNaturalPersonIdentity` scopes in an authentication request sent to the Swedish eIDAS Connector.


<a name="references"></a>
## 4. References

<a name="rfc2119"></a>
**\[RFC2119\]**
> [Bradner, S., Key words for use in RFCs to Indicate Requirement Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="openid-core"></a>
**\[OpenID.Core\]**
> [Sakimura, N., Bradley, J., Jones, M., de Medeiros, B. and C. Mortimore, "OpenID Connect Core 1.0", August 2015] (https://openid.net/specs/openid-connect-core-1_0.html).

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
> [Binding eIDAS Identities to Records in the Swedish Population Register](https://docs.swedenconnect.se/technical-framework/Identity_Binding.html).

<a name="eidas-attr"></a>
**\[eIDAS.Attributes\]**
> [eIDAS SAML Attribute Profile, version 1.4, 31 October 2023](https://docs.swedenconnect.se/technical-framework/mirror/eidas/eIDAS_SAML_Attribute_Profile_v1.4_final.pdf).

<a name="oidc-iac"></a>
**\[OIDC.IAC\]**
> [T. Lodderstedt, D. Fett, M. Haine, A. Pulido, K. Lehmann, K. Koiwai, "OpenID Connect for Identity Assurance Claims Registration 1.0", October 2024](https://openid.net/specs/openid-connect-4-ida-claims-1_0-final.html).

<a name="rfc8417"></a>
**\[RFC8417\]**
> [P. Hunt, M. Jones, W. Denniss, M. Ansari, "Security Event Token (SET)", July 2018](https://tools.ietf.org/html/rfc8417).

<a name="iso3166-1"></a>
**\[ISO3166-1\]**
> [ISO, "ISO 3166-1:2020. Codes for the representation of names of countries and their subdivisions -- Part 1: Country codes", 2020](https://www.iso.org/standard/72482.html).

<a name="iso3166-3"></a>
**\[ISO3166-3\]**
> [ISO, "ISO 3166-3:2020. Codes for the representation of names of countries and their subdivisions -- Part 3: Code for formerly used names of countries", 2020](https://www.iso.org/standard/72482.html).

<a name="conversion-of-eidas-attributes"></a>
## Appendix A: Conversion of eIDAS Attributes

This section provides a listing of how the eIDAS attributes for natural persons defined in section 2.2 of \[[eIDAS.Attributes](#eidas-attr)\] are mapped to their corresponding OpenID Connect claims.

> Also see section 3.3.3 of \[[SAML.SC.Attributes](#saml-sc-attributes)\] where a corresponding mapping between eIDAS attributes and Sweden Connect SAML attributes is presented.

| eIDAS attribute | Claim | Reference |
| :--- | :--- | :--- |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/PersonIdentifier` - PersonIdentifier | `https://id.swedenconnect.se/claim/`<br />`eidasPersonIdentifier` | This specification |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/CurrentFamilyName` - FamilyName | `family_name` | \[[OpenID.Core](#openid-core)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/CurrentGivenName` - FirstName | `given_name` | \[[OpenID.Core](#openid-core)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/DateOfBirth` - DateOfBirth | `birthdate` | \[[OpenID.Core](#openid-core)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/BirthName` - BirthName | `birth_family_name`<br />`birth_given_name`<br />`birth_middle_name` | \[[OIDC.IAC](#oidc-iac)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/PlaceOfBirth` - PlaceOfBirth | `place_of_birth` | \[[OIDC.IAC](#oidc-iac)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/CurrentAddress` - CurrentAddress | `address` | \[[OpenID.Core](#openid-core)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/Gender` - Gender | `gender` | \[[OpenID.Core](#openid-core)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/Nationality` - Nationality | `nationalities` | \[[OIDC.IAC](#oidc-iac)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/CountryOfBirth` - CountryOfBirth | `place_of_birth.country` | \[[OIDC.IAC](#oidc-iac)\] |
| `http://eidas.europa.eu/attributes/`<br >`naturalperson/TownOfBirth` - TownOfBirth | `place_of_birth.locality` | \[[OIDC.IAC](#oidc-iac)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/CountryOfResidence` - CountryOfResidence | `address.country` | \[[OpenID.Core](#openid-core)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/PhoneNumber` - PhoneNumber | `phone_number` | \[[OpenID.Core](#openid-core)\] |
| `http://eidas.europa.eu/attributes/`<br />`naturalperson/EmailAddress` - EmailAddress | `email` | \[[OpenID.Core](#openid-core)\] |



