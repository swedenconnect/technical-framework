<img src="img/sweden-connect.png"></img>

# Swedish eID Framework - Registry for identifiers

### Version 1.6 - 2019-08-14 - *Draft version*

*ELN-0603-v1.6*

---

## Table of Contents

1. [**Background**](#background)

2. [**Structure**](#structure)

    2.1. [URI Identifiers](#uri-identifiers)

    2.2. [OID Identifiers](#oid-identifiers)

3. [**Assigned Identifiers**](#assigned-identifiers)

    3.1. [URL Identifiers](#url-identifiers)

    3.1.1. [Authentication Context URIs](#authentication-context-uris)

    3.1.1.1. [Sign Message Authentication Context URIs](#sign-message-authentication-context-uris)

    3.1.2. [Attribute Sets](#attribute-sets)

    3.1.3. [Entity Category Identifiers](#entity-category-identifiers)

    3.1.3.1. [Service Entity Categories](#service-entity-categories)

    3.1.3.2. [Entity Categories for Service Properties](#entity-categories-for-service-properties)

    3.1.3.3. [Entity Categories for Service Type](#entity-categories-for-service-type)
    
    3.1.3.4. [Entity Categories for Service Contract](#entity-categories-for-service-contract)

    3.1.4. [SAML Protocol Status Codes](#saml-protocol-status-codes)

    3.1.5. [Central Signing](#central-signing)

    3.1.6. [Authentication Context](#authentication-context)

    3.1.7. [Sign Response Status Codes](#sign-response-status-codes)

    3.1.8. [Name Registration Authorities](#name-registration-authorities)

    3.1.9. [eIDAS Identifiers](#eidas-identifiers)

    3.1.9.1. [eIDAS Proxy Service Aliases](#eidas-proxy-service-aliases)

    3.2. [OID Identifiers](#oid-identifiers)

    3.2.1. [ASN.1 Declarations](#asn1-declarations)

4. [**References**](#references)

5. [**Changes between versions**](#changes-between-versions)

<a name="background"></a>
## 1. Background

The implementation of a Swedish infrastructure for electronic
identification and electronic signature requires various types of
identifiers to represent objects in protocols and data structures.

This document defines the structure for identifiers assigned by the Swedish eID Framework
and provides a registry for assigned identifiers.

The following types of identifiers are assigned in this document:

-   URI (Uniform Resource Identifier)

-   OID (Object Identifier)

This registry is limited to registering assigned identifiers.
Identifiers in this registry are typically defined within the context of
a separate specification, which defines the semantic meaning of the
identifier within the context of a particular protocol and/or data
structure. Where applicable, this registry provides references to the
documents where the exact meaning of each identifier is defined.

<a name="structure"></a>
## 2. Structure

The basic structure of identifiers assigned by the Swedish eID Framework is based on the following components:

| **Parameter** | **Description** |
| ---| ---|
| **Prefix** | The leading portion of the identifier that associates the identifier with this registry and identifies the Swedish e-identification board or Sweden Connect as the assigner of the identifier. |
| **Category** | A code for the category of an identifier. Each category is a defined context for a collection of identifiers within the scope of a protocol, service or object type. |
| **Version** (optional) | An indicator of the version of the object represented by this identifier. The exact semantic of the version indicator, if present, is defined within each category. |
| **Identifier** | A sequence of characters or numbers (according to the syntax of the identifier type), which distinguish this identifier among all other identifiers within a particular prefix, category and version. |

<a name="uri-identifiers"></a>
### 2.1. URI Identifiers

All URI identifiers in this registry are of URL type (Uniform Resource
Locator), assigned under the prefixes `http://id.elegnamnden.se` and `http://id.swedenconnect.se`.

These URL identifiers are defined using the following structure:

* **`http://id.elegnamnden.se/{category}[/{version}]/{identifier}`**, or,
* **`http://id.swedenconnect.se/{category}[/{version}]/{identifier}`**.

<a name="oid-identifiers"></a>
### 2.2. OID Identifiers

An object identifier consists of a node in a hierarchically-assigned
namespace, formally defined using the ITU-T's ASN.1 standard, X.690.
Successive numbers of the nodes, starting at the root of the tree,
identify each node in the tree. Designers set up new nodes by
registering them under the node's registration authority. The root of
the tree contains the following three arcs:

-   0: ITU-T
-   1: ISO
-   2: joint-iso-itu-t

Object identifiers are in this document represented as a string
containing a sequence of integers separated by a dot (“.”), e.g.
2.3.4.25, where each integer represents a node in the hierarchy.

The node assigned to the Swedish e-identification board is: **1.2.752.201**.

This represents a hierarchical structure of nodes in the following
sequence:

-   1 = ISO
-   2 = ISO member body
-   752 = The Swedish Standardization Institute (SIS-ITS)
-   201 = Swedish e-identification board

This node is used as the Prefix (root node) for all OID identifiers in
this registry, using the following structure:

**1.2.752.201.{category}.{identifier}**

OID identifiers according to this structure assign a node for each
category and an identifier node under this category node. No node in
this structure is assigned as version node. Version is handled, when
necessary, within the identifier portion of the OID, typically by
assigning a new identifier.

<a name="assigned-identifiers"></a>
## 3. Assigned Identifiers

<a name="url-identifiers"></a>
### 3.1. URL Identifiers

The following category codes are defined:

| **Code** | **Category** |
| --- | --- |
| **loa** | Level of Assurance. Identifiers representing level of assurance for federated identity (Tillitsnivå). |
| **ac** | Attribute profile. |
| **ec** | Entity Category. Generic service type declarations for service matching. |
| **sprop** | Service Property. Specific entity category identifiers for specific service property. |
| **st** | Service Type. Specific entity category identifiers for defined types of services in the federation. |
| **contract** | Service contract. Specific entity category identifiers for declaring contract, or business agreement, affiliation within a federation. |
| **csig** | Central Signing Service – Identifiers used by the central signing service infrastructure. |
| **auth-cont** | Authentication context information schema. |
| **status** | SAML Protocol status codes. |
| **sig-status** | Sign response status codes. |
| **eidas** | Identifiers used for integration with the eIDAS Framework. |
| **ns** | XML Schema namespaces. |

<a name="authentication-context-uris"></a>
#### 3.1.1. Authentication Context URIs

Authentication Context URIs representing assurance levels (Tillitsnivåer) relevant to 
\[[TillitRamv](#tillitramv)\] and \[[EidDeploy](#eiddeploy)\]. 

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/loa/1.0/loa1` | Assurance level 1. | \[[TillitRamv](#tillitramv)\] |
| `http://id.elegnamnden.se/loa/1.0/loa2` | Assurance level 2. | \[[TillitRamv](#tillitramv)\] |
| `http://id.elegnamnden.se/loa/1.0/loa3` | Assurance level 3. | \[[TillitRamv](#tillitramv)\] |
| `http://id.swedenconnect.se/loa/1.0/`<br/>`uncertified-loa3` | A URI that is indented to be used by uncertified providers that make a self declaration of providing an assurance level comparable to Assurance level 3 - `http://id.elegnamnden.se/loa/1.0/loa3`. | |
| `http://id.elegnamnden.se/loa/1.0/loa4` | Assurance level 4. | \[[TillitRamv](#tillitramv)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-low` | Authentication accordance to eIDAS assurance level low for non-notified and notified eID schemes. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-sub` | Authentication accordance to eIDAS assurance level substantial for non-notified and notified eID schemes. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-high` | Authentication accordance to eIDAS assurance level high for non-notified and notified eID schemes. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-nf-low` | Authentication accordance to eIDAS assurance level low using an eID scheme that MUST be notified. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub` | Authentication accordance to eIDAS assurance level substantial using an eID scheme that MUST be notified. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-nf-high` | Authentication accordance to eIDAS assurance level high using an eID scheme that MUST be notified. | \[[eIDAS](#eidas)\] |


**NOTE:** eIDAS assurance levels low, substantial and high have the
following `AuthnContextClassRef` URI:s defined by the EU commission:

-   `http://eidas.europa.eu/LoA/low`

-   `http://eidas.europa.eu/NotNotified/LoA/low` (for non-notified eID schemes)

-   `http://eidas.europa.eu/LoA/substantial`

-   `http://eidas.europa.eu/NotNotified/LoA/substantial` (for non-notified eID schemes)

-   `http://eidas.europa.eu/LoA/high`

-   `http://eidas.europa.eu/NotNotified/LoA/high` (for non-notified eID schemes)

<a name="sign-message-authentication-context-uris"></a>
#### 3.1.1.1. Sign Message Authentication Context URIs

Authentication Context URIs extending the above URIs with specific
meaning for use with authentication requests that includes a sign
message that must be displayed to the user (see section 7 of
\[[EidDeploy](#eiddeploy)\]).

| **URL** | **Object** |
| :--- | :--- |
| `http://id.elegnamnden.se/loa/1.0/loa2-sigmessage` | Authentication according to assurance level 2 with extended requirements for displaying signature messages. |
| `http://id.elegnamnden.se/loa/1.0/loa3-sigmessage` | Authentication according to assurance level 3 with extended requirements for displaying signature messages. |
| `http://id.swedenconnect.se/loa/1.0/`<br/>`uncertified-loa3-sigmessage` | Authentication according to uncertified-loa3, as defined above, with extended requirements for displaying signature messages. |  |
| `http://id.elegnamnden.se/loa/1.0/loa4-sigmessage` | Authentication according to assurance level 4 with extended requirements for displaying signature messages. |
| `http://id.elegnamnden.se/loa/1.0/eidas-low-sigm` | Authentication accordance to eIDAS assurance level low (notified or non-notified eID schemes) with extended requirements for displaying signature messages. |
| `http://id.elegnamnden.se/loa/1.0/eidas-sub-sigm` | Authentication accordance to eIDAS assurance level substantial (notified or non-notified eID schemes) with extended requirements for displaying signature messages. |
| `http://id.elegnamnden.se/loa/1.0/eidas-high-sigm` | Authentication accordance to eIDAS assurance level high (notified or non-notified eID schemes) with extended requirements for displaying signature messages. |
| `http://id.elegnamnden.se/loa/1.0/eidas-nf-low-sigm` | Authentication accordance to eIDAS assurance level low using an eID scheme that MUST be notified, with extended requirements for displaying signature messages. |
| `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub-sigm` | Authentication accordance to eIDAS assurance level substantial using an eID scheme that MUST be notified, with extended requirements for displaying signature messages. |
| `http://id.elegnamnden.se/loa/1.0/eidas-nf-high-sigm` | Authentication accordance to eIDAS assurance level high with an eID scheme that MUST be notified, with extended requirements for displaying signature messages. |


<a name="attribute-sets"></a>
#### 3.1.2. Attribute Sets

Identifiers for attribute sets defined in the Attribute Profile
Specification for the Swedish eID Framework.

| **Identifier** | **URL** | **Object** | **Reference** |
| :--- | :--- | :--- | :--- |
| ELN-AP-Pseudonym-01  | `http://id.elegnamnden.se/ap/1.0/pseudonym-01` | Pseudonym identity attribute set.  | \[[EidAttributes](#eidattributes)\] |
| ELN-AP-NaturalPerson-01 | `http://id.elegnamnden.se/ap/1.0/natural-person-01` | Personal identity without civic registration number attribute set. | \[[EidAttributes](#eidattributes)\] |
| ELN-AP-Pnr-01 | `http://id.elegnamnden.se/ap/1.0/pnr-01` | Personal identity with civic registration number attribute set. | \[[EidAttributes](#eidattributes)\] |
| ELN-AP-OrgPerson-01 | `http://id.elegnamnden.se/ap/1.0/org-person-01` | Organizational identity attribute set. | \[[EidAttributes](#eidattributes)\] |
| ELN-AP-eIDAS-NatPer-01 | `http://id.elegnamnden.se/ap/1.0/eidas-natural-person-01` | Natural person identity for the eIDAS Framework. | \[[EidAttributes](#eidattributes)\] |

<a name="entity-category-identifiers"></a>
#### 3.1.3. Entity Category Identifiers

Identifiers for categories of service entities, specified as an “Entity Attribute” in the federation metadata.

<a name="service-entity-categories"></a>
##### 3.1.3.1. Service Entity Categories

Identifiers for entity categories representing alternative sets of requirements.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/ec/1.0/loa2-pnr` | Service consuming/providing assertions based on assurance level 2, implementing the attribute set ”ELN-AP-Pnr-01”. | \[[EidEntityCat](#eidentitycat)\] |
| `http://id.elegnamnden.se/ec/1.0/loa3-pnr` | Service consuming/providing assertions based on assurance level 3, implementing the attribute set ”ELN-AP-Pnr-01”. | \[[EidEntityCat](#eidentitycat)\] |
| `http://id.swedenconnect.se/ec/sc/`<br/>`uncertified-loa3-pnr` | Service consuming/providing assertions based on uncertified-loa3, as defined above, implementing the attribute set ”ELN-AP-Pnr-01”. | |
| `http://id.elegnamnden.se/ec/1.0/loa4-pnr` | Service consuming/providing assertions based on assurance level 4, implementing the attribute set ”ELN-AP-Pnr-01”. | \[[EidEntityCat](#eidentitycat)\] |
| `http://id.elegnamnden.se/ec/1.0/eidas-naturalperson` | Service consuming/providing assertions based on any eIDAS assurance level, implementing the attribute set “ELN-AP-eIDAS-NatPer-01”. | \[[EidEntityCat](#eidentitycat)\] |
| `http://id.elegnamnden.se/ec/1.0/eidas-pnr-delivery` | Service providing assertions to eIDAS services via Swedish eIDAS-node | \[[EidEntityCat](#eidentitycat)\] |

<a name="entity-categories-for-service-properties"></a>
##### 3.1.3.2. Entity Categories for Service Properties

Identifiers for defined service properties.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/sprop/1.0/mobile-auth` | Service adapted to require/provide user authentication based on mobile devices. | \[[EidEntityCat](#eidentitycat)\] |
| `http://id.elegnamnden.se/sprop/1.0/scal2` | Service adapted to support authentication requests from signature services supporting Sole Control Assurance Level 2 (SCAL2). | \[[EidEntityCat](#eidentitycat)\] |

<a name="entity-categories-for-service-type"></a>
##### 3.1.3.3. Entity Categories for Service Type

Identifiers for defined service types.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/st/1.0/sigservice` | Electronic signature service | \[[EidEntityCat](#eidentitycat)\] |
| `http://id.elegnamnden.se/st/1.0/public-sector-sp` | Public sector Service Provider | \[[EidEntityCat](#eidentitycat)\] |
| `http://id.elegnamnden.se/st/1.0/private-sector-sp` | Private sector Service Provider | \[[EidEntityCat](#eidentitycat)\] |

<a name="entity-categories-for-service-contract"></a>
##### 3.1.3.4. Entity Categories for Service Contract

Service Contract Entity Category identifiers are indented for performing service matching based on contracts, or business agreements, between providing and consuming services.

All Service Contract identifiers are prefixed with `http://id.swedenconnect.se/contract/<org>`, where `org` is the identifier for the defining organization.

The Swedish eID Framework specifications do not define any Service Contract identifiers. Instead the federation operator, or other parties, may define identifiers suitable for representing how consuming and providing services should be matched based on their respective agreements.


<a name="saml-protocol-status-codes"></a>
#### 3.1.4. SAML Protocol Status Codes

Status code identifiers for use in SAML Response messages. The list
below extends the list of second-level status codes defined in section
3.2.2.2 of \[[SAML2Core](#saml2core)\].

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/status/1.0/cancel` | Status code representing a cancelled operation. | \[[EidDeploy](#eiddeploy)\] |
| `http://id.elegnamnden.se/status/1.0/fraud` | Status code indicating a fraudulent request. | \[[EidDeploy](#eiddeploy)\] |
| `http://id.elegnamnden.se/status/1.0/possibleFraud` | Status code indicating a possible fraudulent request. | \[[EidDeploy](#eiddeploy)\] |

<a name="central-signing"></a>
#### 3.1.5. Central Signing

Identifiers used in the protocol for requesting services form a central signing service.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/csig/1.0/dss-ext/ns` | **Deprecated**. XML schema name space for the protocol extensions to the OASIS DSS protocol (version 1.0). |  |
| `http://id.elegnamnden.se/csig/1.0/eid2-dss/profile` | **Deprecated**. Implementation profile identifier for the protocol extensions to the OASIS DSS protocol (version 1.0). |  |
| `http://id.elegnamnden.se/csig/1.1/dss-ext/ns` | XML schema name space for the protocol extensions to the OASIS DSS protocol (version 1.1). | \[[EidDSSExt](#eiddssext)\] |
| `http://id.elegnamnden.se/csig/1.1/dss-ext/profile` | Implementation profile identifier for the protocol extensions to the OASIS DSS protocol (version 1.1). | \[[EidCSignProf](#eidcsignprof)\] |
| `http://id.elegnamnden.se/csig/1.1/sap/ns` | XML schema name space for the Signature Activation Protocol, extending version 1.1 of the DSS protocol extension | \[[EidSigSAP](#eidsigsap)\] |

<a name="authentication-context"></a>
#### 3.1.6. Authentication Context

Identifiers associated with the Authentication Context X.509 extension

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/auth-cont/1.0/saci` | XML schema name space for SAML Authentication Context Information in the Authentication Context X.509 certificate extension | \[[AuthContExt](#authcontext)\] |

<a name="sign-response-status-codes"></a>
#### 3.1.7. Sign Response Status Codes

Status code identifiers for the DSS Extension for SAML based Central Signing service. The following identifiers provide defined status codes
for inclusion in a `<ResultMinor>` element of the `<Result>` element of a sign response message according to the OASIS standard “Digital Signature Service Core Protocols, Elements, and Bindings Version 1.0” \[[OASIS-DSS](#oasis-dss)\].

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/sig-status/1.0/req-expired` | The time window for the signature request has expired. | \[[EidCSignProf](#eidcsignprof)\] |
| `http://id.elegnamnden.se/sig-status/1.0/user-mismatch` | The authenticated user does not match the signer identity attributes in the request. | \[[EidCSignProf](#eidcsignprof)\] |
| `http://id.elegnamnden.se/sig-status/1.0/unsupported-loa` | The requested level of assurance for user authentication is not supported. | \[[EidCSignProf](#eidcsignprof)\] |
| `http://id.elegnamnden.se/sig-status/1.0/sigmessage-error` | A requirement to display sign message was included in the sign request, but the sign service could not establish that the sign message was displayed to the user. | \[[EidCSignProf](#eidcsignprof)\] |
| `http://id.elegnamnden.se/sig-status/1.0/user-cancel` | The end user cancelled the signature operation. | \[[EidCSignProf](#eidcsignprof)\] |

<a name="name-registration-authorities"></a>
#### 3.1.8. Name Registration Authorities

Some protocols require a URI identifier to uniquely identify the entity responsible for a particular namespace.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/eln/name-registration-authority` | Identifying the Swedish e-Identification Board as name registration authority, responsible for a particular name space. | \[[CertProf](#certprof)\] |

<a name="eidas-identifiers"></a>
#### 3.1.9. eIDAS Identifiers

This section defines identifiers used within the Swedish eID Framework to integrate with the eIDAS Framework.

<a name="eidas-proxy-service-aliases"></a>
##### 3.1.9.1. eIDAS Proxy Service Aliases

Each country within the eIDAS federation provides an eIDAS Proxy Service that is a Proxy Identity Provider for the authentication services within that specific country. The entityID identifier for an eIDAS Proxy Service in another country is not known to a Swedish Service Provider, but there are cases in which the Swedish Service Provider needs to refer to a specific eIDAS Proxy Service. Therefore, this specification defines an URI identifier format for eIDAS Proxy Service aliases. The format is as follows:

**`http://id.swedenconnect.se/eidas/1.0/proxy-service/{country-code}`**

where `{country-code}` is the country identifier in ISO 3166-1 alpha-2 format \[[ISO 3166](#iso3166)\].

> A consumer of an eIDAS Proxy Service alias URI MUST accept the country code part of the URI in both lower and upper case letters.

<a name="oid-identifiers"></a>
### 3.2. OID Identifiers

Defined categories:

| **Code** | **Category** |
| :--- | :--- |
| **0** | ASN.1 modules |
| **1** | Test identifiers |
| **2** | Policy identifiers |
| **3** | Attribute identifiers |
| **4** | ”Qualified Certificate” Statement identifiers (RFC 3739) |
| **5** | X.509 certificate extension identifiers |

The following OIDs are defined in the ASN.1 declarations in [3.2.1](#asn1-declarations):

| **OID** | **Object** | **Reference** |
| :--- | :--- | :--- |
| 1.2.752.201.5.1 | Authentication Context extension | \[[AuthContExt](#authcontext)\] |
| 1.2.752.201.3.1 | Organization Affiliation Attribute | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.2 | Transaction Identifier | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.3 | Authentication Context Parameters | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.4 | Provisional ID | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.5 | Provisional ID Persistence Indicator | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.6 | Personal Identity Number Binding URI | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.7 | eIDAS Person Identifier | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.8 | Birth name | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.9 | eIDAS Natural Person Address | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.10 | User Certificate | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.11 | User Signature | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.12 | Signature Activation Data | \[[EidAttributes](#eidattributes)\] |
| 1.2.752.201.3.13 | Authentication Server Signature | \[[EidAttributes](#eidattributes)\] |

<a name="asn1-declarations"></a>
#### 3.2.1. ASN.1 Declarations

    -- Object Identifier Registry for the Swedish E-identification board

    id-eleg OBJECT IDENTIFIER ::= {iso(1) member-body(2) se(752) e-legitimationsnamnden(201)}

    -- E-legnamnden arcs
    id-mod    OBJECT IDENTIFIER ::= { id-eleg 0 }    -- ASN.1 modules
    id-test   OBJECT IDENTIFIER ::= { id-eleg 1 }    -- OIDs for test
    id-pol    OBJECT IDENTIFIER ::= { id-eleg 2 }    -- Policy
    id-attr   OBJECT IDENTIFIER ::= { id-eleg 3 }    -- Attributes
    id-qcs    OBJECT IDENTIFIER ::= { id-eleg 4 }    -- QC Statement
    id-ce     OBJECT IDENTIFIER ::= { id-eleg 5 }    -- Cert Extensions

    -- E-legnamnden modules

    id-mod-qcAuthContext OBJECT IDENTIFIER ::= { id-mod 1 }

    -- E-legnamnden OIDs for test

    -- E-legnamnden Policy

    -- E-legnamnden Attributes
    id-attr-org-affiliation      OBJECT IDENTIFIER ::= { id-attr 1 }    -- Organizational affiliation
    id-attr-transaction-id       OBJECT IDENTIFIER ::= { id-attr 2 }    -- Transaction identifier
    id-attr-auth-context-params  OBJECT IDENTIFIER ::= { id-attr 3 }    -- Authentication context parameters
    id-attr-prid                 OBJECT IDENTIFIER ::= { id-attr 4 }    -- Provisional ID
    id-attr-prid-persistence     OBJECT IDENTIFIER ::= { id-attr 5 }    -- Provisional ID persistence indicator
    id-attr-pnr-binding          OBJECT IDENTIFIER ::= { id-attr 6 }    -- Personal Identity Number binding URI
    id-attr-eidas-pid            OBJECT IDENTIFIER ::= { id-attr 7 }    -- eIDAS Person Identifier
    id-attr-birth-name           OBJECT IDENTIFIER ::= { id-attr 8 }    -- Birth name    
    id-attr-eidas-np-address     OBJECT IDENTIFIER ::= { id-attr 9 }    -- eIDAS Natural Person Address    
    id-attr-user-certificate     OBJECT IDENTIFIER ::= { id-attr 10 }   -- User certificate    
    id-attr-user-signature       OBJECT IDENTIFIER ::= { id-attr 11 }   -- User signature    
    id-attr-sad                  OBJECT IDENTIFIER ::= { id-attr 12 }   -- Signature activation data
    id-attr-auth-srv-signature   OBJECT IDENTIFIER ::= { id-attr 13 }   -- Authentication server signature

    -- E-legnamnden QC Statement extension
    id-qcs-sid         OBJECT IDENTIFIER ::= { id-qcs 1 }   -- Semantics Identifiers
    id-qcs-statement   OBJECT IDENTIFIER ::= { id-qcs 2 }   –- QC statements

    -- E-legnamnden Certificate Extensions
    id-ce-authContext  OBJECT IDENTIFIER ::= { id-ce 1 }

<a name="references"></a>
## 4. References

<a name="saml2core"></a>
**\[SAML2Core\]**
> [OASIS Standard, Assertions and Protocols for the OASIS Security
> Assertion Markup Language (SAML) V2.0, March 2005](http://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf).

<a name="oasis-dss"></a>
**\[OASIS-DSS\]**
> [Digital Signature Service Core Protocols, Elements, and Bindings
> Version 1.0.](http://docs.oasis-open.org/dss/v1.0/oasis-dss-core-spec-v1.0-os.html)

<a name="tillitramv"></a>
**\[TillitRamv\]**
> [Tillitsramverk för Svensk e-legitimation version 1.4](http://elegnamnden.github.io/technical-framework/mirror/elegnamnden/Tillitsramverk-for-Svensk-e-legitimation-1.4.pdf).

<a name="authcontext"></a>
**\[AuthContExt\]**
> [RFC 7773: Authentication Context Certificate Extension](https://tools.ietf.org/html/rfc7773).

<a name="eiddeploy"></a>
**\[EidDeploy\]**
> [Deployment Profile for the Swedish eID Framework](http://elegnamnden.github.io/technical-framework/updates/ELN-0602_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).

<a name="eidentitycat"></a>
**\[EidEntityCat\]**
> [Entity Categories for the Swedish eID Framework](http://elegnamnden.github.io/technical-framework/updates/ELN-0606_-_Entity_Categories_for_the_Swedish_eID_Framework.html).

<a name="eiddssext"></a>
**\[EidDSSExt\]**
> [DSS Extension for Federated Central Signing Services](http://elegnamnden.github.io/technical-framework/latest/ELN-0609_-_DSS_Extension_for_Federated_Signing_Services.html).

<a name="eidsigsap"></a>
**\[EidSigSAP\]**
> [Signature Activation Protocol for Federated Signing](http://elegnamnden.github.io/technical-framework/latest/ELN-0613_-_Signature_Activation_Protocol.html).

<a name="eidcsignprof"></a>
**\[EidCSignProf\]**
> [Implementation Profile for Using OASIS DSS in Central Signing
> Services](http://elegnamnden.github.io/technical-framework/latest/ELN-0607_-_Implementation_Profile_for_using_DSS_in_Central_Signing_Services.html).

<a name="certprof"></a>
**\[CertProf\]**
> [Certificate profile for certificates issued by Central Signing services](http://elegnamnden.github.io/technical-framework/latest/ELN-0608_-_Certificate_Profile_for_Central_Signing_Services.html)

<a name="eidattributes"></a>
**\[EidAttributes\]**
> [Attribute Specification for the Swedish eID Framework](http://elegnamnden.github.io/technical-framework/latest/ELN-0604_-_Attribute_Specification_for_the_Swedish_eID_Framework.html).

<a name="eidas"></a>
**\[eIDAS\]**
> REGULATION (EU) No 910/2014 OF THE EUROPEAN PARLIAMENT AND OF THE
> COUNCIL of 23 July 2014 on electronic identification and trust
> services for electronic transactions in the internal market and
> repealing Directive 1999/93/EC. Including implementation acts of the
> regulation and associated technical specifications.

<a name="iso3166"></a>
**\[ISO 3166\]**
> Country Codes - ISO 3166, [https://www.iso.org/iso-3166-country-codes.html](https://www.iso.org/iso-3166-country-codes.html).

<a name="changes-between-versions"></a>
## 5. Changes between versions

**Changes between version 1.5 and version 1.6:**

- The specification was renamed from "Registry for identifiers assigned by the Swedish e-identification board" to "Swedish eID Framework - Registry for identifiers". 

- The authentication context URIs `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` and `http://id.swedenconnect.se/loa/1.0/uncertified-loa3-sigmessage` were introduced in sections 3.1.1 and 3.1.1.1, and the service entity category `http://id.swedenconnect.se/ec/sc/uncertified-loa3-pnr` was added to section 3.1.3.1.

- A description of Service Contract Entity Categories was added to section 3.1.3.4.

- In section 3.1.1, the EU commission `AuthnContextClassRef` URI:s for non-notified schemes were changed.

**Changes between version 1.4 and version 1.5:**

- Added identifier for the service property entity category `http://id.elegnamnden.se/sprop/1.0/scal2`

- Added XML Schema name space identifier `http://id.elegnamnden.se/csig/1.1/sap/ns`. This XML Schema defines XML elements related to the Signature Activation Protocol.

- Added Semantics Identifiers section 3.1.8 to define a name registration authority URI necessary to express a provisional ID attribute in an X.509 certificate according to ETSI EN 319 412-1.

- Added Authentication Context URI:s `http://id.elegnamnden.se/loa/1.0/eidas-nf-low` and `http://id.elegnamnden.se/loa/1.0/eidas-nf-low-sigm` to section 3.1.1.

- Added section 3.1.9, "eIDAS Identifiers", that describes the format for eIDAS Proxy Service Alias URI identifiers.

**Changes between version 1.3 and version 1.4:**

-   Attributes and URI:s for the eIDAS Framework was added.

-   The SAML status code identifier
    `http://id.elegnamnden.se/status/1.0/cancel` was added to be used in SAML
    Response messages to indicate a cancelled operation.

- Added the SAML status code identifiers `http://id.elegnamnden.se/status/1.0/fraud` and `http://id.elegnamnden.se/status/1.0/possibleFraud` were added to be used in SAML Response messages to alert fraudulent requests.

-   Added attribute definitions for “Birth name”, “User certificate”,
    “User signature”, "Authentication Server Signature" and “Signature activation data”. See chapter 3.2.

-  Added the Service Type Entity Categories `http://id.elegnamnden.se/st/1.0/public-sector-sp` and `http://id.elegnamnden.se/st/1.0/private-sector-sp` to section 3.1.3.3.

**Changes between version 1.2 and version 1.3:**

-   Object identifiers for the attributes “Transaction identifier”,
    “Authentication Context Parameters”, “Provisional ID” and
    “Provisional ID quality indicator” were defined and added to section
    3.2.

-   Chapter 3.1.7, “XML Schema namespaces”, was removed since the “Level
    of Assurance context class declarations” are deprecated and thus,
    the namespace `http://id.elegnamnden.se/ns/1.0/loa-context-params`
    is no longer part of the Swedish eID Framework.

-   Authentication Context URIs for use by signature services during
    authentication was added to section 3.1.1.

-   Service entity categories for future use within the eIDAS Framework
    were added to section 3.1.3.1.

-   The status code identifier
    `http://id.elegnamnden.se/sig-status/1.0/sigmessage-error` was added
    to section 3.1.6 and the signature response status code `http://id.elegnamnden.se/sig-status/1.0/user-cancel` was added to section 3.1.7.

**Changes between version 1.1 and version 1.2:**

-   URI identifiers for Attribute Profiles as specified in \[AttrProf\]
    were introduced.

**Changes between version 1.0 and version 1.1:**

-   In chapter 3.1.3.1, “Service Entity Categories”, service entity
    categories for Level of Assurance 2 and 4 were introduced.

-   Chapter 3.1.7, “XML Schema namespaces”, was added.

-   Typos were fixed.
