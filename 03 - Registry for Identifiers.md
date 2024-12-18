<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Sweden Connect - Registry for identifiers

### Version 1.8 - 2024-12-04

Registration number: **2019-309**

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (Digg)</a>, 2015-2024. All Rights Reserved.
</p>

## Table of Contents

1. [**Background**](#background)

2. [**Structure**](#structure)

    2.1. [URI Identifiers](#uri-identifiers)

    2.2. [OID Identifiers](#oid-identifiers)

3. [**Assigned Identifiers**](#assigned-identifiers)

    3.1. [URL Identifiers](#url-identifiers)

    3.1.1. [Authentication Context URIs](#authentication-context-uris)
    
    3.1.1.1. [Authentication Context URIs for Swedish Non-residents](#authentication-context-uris-for-swedish-non-residents)
    
    3.1.1.2. [Authentication Context URIs for Uncertified Providers](#authentication-context-uris-for-uncertified-providers)

    3.1.2. [Attribute Sets](#attribute-sets)

    3.1.3. [Entity Category Identifiers](#entity-category-identifiers)

    3.1.3.1. [Service Entity Categories](#service-entity-categories)

    3.1.3.2. [Entity Categories for Service Properties](#entity-categories-for-service-properties)

    3.1.3.3. [Entity Categories for Service Type](#entity-categories-for-service-type)

    3.1.3.4. [Entity Categories for Service Contract](#entity-categories-for-service-contract)
    
    3.1.3.5. [General Entity Categories](#general-entity-categories)

    3.1.4. [SAML Protocol Status Codes](#saml-protocol-status-codes)

    3.1.5. [Central Signing](#central-signing)

    3.1.6. [Authentication Context](#authentication-context)

    3.1.7. [Sign Response Status Codes](#sign-response-status-codes)

    3.1.8. [Name Registration Authorities](#name-registration-authorities)

    3.1.9. [eIDAS Identifiers](#eidas-identifiers)

    3.1.9.1. [eIDAS Proxy Service Aliases](#eidas-proxy-service-aliases)

    3.1.9.2. [eIDAS Connector Aliases](#eidas-connector-aliases)
    
    3.1.9.3. [Identity Binding Processes](#identity-binding-processes)

    3.2. [OID Identifiers](#oid-identifiers3)

    3.2.1. [ASN.1 Declarations](#asn1-declarations)

4. [**References**](#references)

5. [**Changes between versions**](#changes-between-versions)

<a name="background"></a>
## 1. Background

The implementation of a Swedish infrastructure for electronic
identification and electronic signature requires various types of
identifiers to represent objects in protocols and data structures.

This document defines the structure for identifiers assigned by the Sweden Connect Framework and provides a registry for assigned identifiers.

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

The basic structure of identifiers assigned by the Sweden Connect Framework is based on the following components:

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

The node assigned to the Swedish E-identification Board/Sweden Connect is: **1.2.752.201**.

This represents a hierarchical structure of nodes in the following
sequence:

-   1 = ISO
-   2 = ISO member body
-   752 = The Swedish Standardization Institute (SIS-ITS)
-   201 = Swedish E-identification Board (see note below)

This node is used as the Prefix (root node) for all OID identifiers in
this registry, using the following structure:

**1.2.752.201.{category}.{identifier}**

OID identifiers according to this structure assign a node for each
category and an identifier node under this category node. No node in
this structure is assigned as version node. Version is handled, when
necessary, within the identifier portion of the OID, typically by
assigning a new identifier.

**Note**: The OID 1.2.752.201 was assigned to the Swedish E-identification Board, but
this organisation has been overtaken by the Swedish Agency for Digital Government (Digg) who 
now uses this OID arc for the Sweden Connect Framework.

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
\[[SE.Trust](#se-trust)\] and \[[SC.SAML.Profile](#sc-saml-profile)\].

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/loa/1.0/loa1` | Assurance level 1. | \[[SE.Trust](#se-trust)\] |
| `http://id.elegnamnden.se/loa/1.0/loa2` | Assurance level 2. | \[[SE.Trust](#se-trust)\] |
| `http://id.elegnamnden.se/loa/1.0/loa3` | Assurance level 3. | \[[SE.Trust](#se-trust)\] |
| `http://id.elegnamnden.se/loa/1.0/loa4` | Assurance level 4. | \[[SE.Trust](#se-trust)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-low`<sup>\*</sup> | Authentication accordance to eIDAS assurance level low for non-notified and notified eID schemes. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-sub`<sup>\*</sup> | Authentication accordance to eIDAS assurance level substantial for non-notified and notified eID schemes. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-high`<sup>\*</sup> | Authentication accordance to eIDAS assurance level high for non-notified and notified eID schemes. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-nf-low`<sup>\*</sup> | Authentication accordance to eIDAS assurance level low using an eID scheme that MUST be notified. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub`<sup>\*</sup> | Authentication accordance to eIDAS assurance level substantial using an eID scheme that MUST be notified. | \[[eIDAS](#eidas)\] |
| `http://id.elegnamnden.se/loa/1.0/eidas-nf-high`<sup>\*</sup> | Authentication accordance to eIDAS assurance level high using an eID scheme that MUST be notified. | \[[eIDAS](#eidas)\] |


**NOTE:** eIDAS assurance levels low, substantial and high have the
following `AuthnContextClassRef` URI:s defined by the EU commission:

-   `http://eidas.europa.eu/LoA/low`

-   `http://eidas.europa.eu/NotNotified/LoA/low` (for non-notified eID schemes)

-   `http://eidas.europa.eu/LoA/substantial`

-   `http://eidas.europa.eu/NotNotified/LoA/substantial` (for non-notified eID schemes)

-   `http://eidas.europa.eu/LoA/high`

-   `http://eidas.europa.eu/NotNotified/LoA/high` (for non-notified eID schemes)

> \[*\]: The authentication context URI:s are intended to be used to represent authentication
over the eIDAS authentication framework using an official eIDAS-connector. Authorization to 
issue assertions using these authentication context URI:s is determined by declaration of the
"assurance certification" for the connector (see section 2.1.3 of \[[SC.SAML.Profile](#sc-saml-profile)\]).

<a name="authentication-context-uris-for-swedish-non-residents"></a>
##### 3.1.1.1. Authentication Context URIs for Swedish Non-residents

The Swedish assurance framework, \[[SE.Trust](#se-trust)\], states that a Swedish eID
according to any of the defined assurance levels must only be issued to an individual holding
a Swedish personal identity number (personnummer) or a Swedish coordination number 
(samordningsnummer).

In some cases, a certified eID-issuer may also issue eIDs to persons that do not hold
a Swedish identity number (non-residents). If this is the case, and the original 
identification of the person has a strength that corresponds to the requirements 
put in \[[SE.Trust](#se-trust)\], a certified Identity Provider or OpenID Provider MAY use the URIs
defined below:

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.swedenconnect.se/loa/1.0/`<br/>`loa2-nonresident` | A URI that is indented to be used by a level 2-certified providers that authenticate a non-resident eID holder according to assurance level 2 - `http://id.elegnamnden.se/loa/1.0/loa2`. | This document |
| `http://id.swedenconnect.se/loa/1.0/`<br/>`loa3-nonresident` | A URI that is indented to be used by a level 3-certified providers that authenticate a non-resident eID holder according to assurance level 3 - `http://id.elegnamnden.se/loa/1.0/loa3`. | This document |
| `http://id.swedenconnect.se/loa/1.0/`<br/>`loa4-nonresident` | A URI that is indented to be used by a level 4-certified providers that authenticate a non-resident eID holder according to assurance level 4 - `http://id.elegnamnden.se/loa/1.0/loa4`. | This document |

**Note:** An Identity Provider, or OpenID Provider, that includes any of the above URIs in an issued assertion/ID Token, MUST NOT provide the Swedish personal identity number as an identity attribute/claim. 
This is per definition since these URIs are intended to be used for non-residents (i.e., they do not hold a Swedish identity number).

<a name="authentication-context-uris-for-uncertified-providers"></a>
##### 3.1.1.2. Authentication Context URIs for Uncertified Providers

The assurance levels defined in section [3.1.1](#authentication-context-uris) may only be used by Identity Providers, or OpenID Providers, that have been reviewed and approved by the Swedish Agency for Digital Government (Digg) according to \[[SE.Trust](#se-trust)\]. For providers that have not undergone a review process but make a self declaration to be compliant with \[[SE.Trust](#se-trust)\] this specification defines the following authentication context URIs:

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.swedenconnect.se/loa/1.0/`<br/>`uncertified-loa2` | URI that is indented to be used by uncertified providers that make a self declaration of providing an assurance level comparable to Assurance level 2 - `http://id.elegnamnden.se/loa/1.0/loa2`. | This document |
| `http://id.swedenconnect.se/loa/1.0/`<br/>`uncertified-loa3` | URI that is indented to be used by uncertified providers that make a self declaration of providing an assurance level comparable to Assurance level 3 - `http://id.elegnamnden.se/loa/1.0/loa3`. | This document |

Proxy providers that have eIDAS authentication as an option MUST NOT use the eIDAS authentication context URIs defined in section [3.1.1](#authentication-context-uris), instead they should use:

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.swedenconnect.se/loa/1.0/`<br />`uncertified-eidas-low` | Should be used if a proxy IdP receives `http://id.elegnamnden.se/loa/1.0/eidas-low` or `http://id.elegnamnden.se/loa/1.0/eidas-nf-low` in an assertion from the official Swedish eIDAS-connector. | This document |
| `http://id.swedenconnect.se/loa/1.0/`<br />`uncertified-eidas-sub` | Should be used if a proxy IdP receives `http://id.elegnamnden.se/loa/1.0/eidas-sub` or `http://id.elegnamnden.se/loa/1.0/eidas-nf-sub` in an assertion from the official Swedish eIDAS-connector. | This document |
| `http://id.swedenconnect.se/loa/1.0/`<br />`uncertified-eidas-high` | Should be used if a proxy IdP receives `http://id.elegnamnden.se/loa/1.0/eidas-high` or `http://id.elegnamnden.se/loa/1.0/eidas-nf-high` in an assertion from the official Swedish eIDAS-connector. | This document |

<a name="attribute-sets"></a>
#### 3.1.2. Attribute Sets

Identifiers for attribute sets defined in the Sweden Connect SAML Attribute Specification.

| **Identifier** | **URL** | **Object** | **Reference** |
| :--- | :--- | :--- | :--- |
| ELN-AP-Pseudonym-01  | `http://id.elegnamnden.se/ap/1.0/pseudonym-01` | Pseudonym identity attribute set.  | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| ELN-AP-NaturalPerson-01 | `http://id.elegnamnden.se/ap/1.0/natural-person-01` | Personal identity without civic registration number attribute set. | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| ELN-AP-Pnr-01 | `http://id.elegnamnden.se/ap/1.0/pnr-01` | Personal identity with civic registration number attribute set. | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| ELN-AP-OrgPerson-01 | `http://id.elegnamnden.se/ap/1.0/org-person-01` | Organizational identity attribute set. | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| ELN-AP-eIDAS-NatPer-01 | `http://id.elegnamnden.se/ap/1.0/eidas-natural-person-01` | Natural person identity for the eIDAS Framework. | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| DIGG-AP-HSAid-01 | `http://id.swedenconnect.se/ap/1.0/hsaid-01` | Natural Person Identity with HSA-ID | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |

<a name="entity-category-identifiers"></a>
#### 3.1.3. Entity Category Identifiers

Identifiers for categories of service entities, specified as an “Entity Attribute” in the SAML federation metadata.

<a name="service-entity-categories"></a>
##### 3.1.3.1. Service Entity Categories

Identifiers for entity categories representing alternative sets of requirements.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/`<br />`ec/1.0/loa2-pnr` | Service consuming/providing assertions based on assurance level 2, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/pnr-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.elegnamnden.se/`<br />`ec/1.0/loa3-pnr` | Service consuming/providing assertions based on assurance level 3, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/pnr-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.swedenconnect.se/`<br />`ec/sc/uncertified-loa3-pnr` | Service consuming/providing assertions based on uncertified-loa3, as defined above, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/pnr-01`. | |
| `http://id.elegnamnden.se/`<br />`ec/1.0/loa4-pnr` | Service consuming/providing assertions based on assurance level 4, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/pnr-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.elegnamnden.se/`<br />`ec/1.0/eidas-naturalperson` | Service consuming/providing assertions based on any eIDAS assurance level, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/eidas-natural-person-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.elegnamnden.se/`<br />`ec/1.0/eidas-pnr-delivery` | Service providing assertions to eIDAS services via Swedish eIDAS-node | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.swedenconnect.se/`<br />`ec/1.0/loa3-hsaid` | Service consuming/providing assertions based on assurance level 3, implementing the attribute set `http://id.swedenconnect.se/ap/1.0/hsaid-01`. |  |
| `http://id.swedenconnect.se/`<br />`ec/sc/uncertified-loa3-hsaid` | Service consuming/providing assertions based on uncertified-loa3, as defined above, implementing the attribute set `http://id.swedenconnect.se/ap/1.0/hsaid-01`. | |
| `http://id.swedenconnect.se/`<br />`ec/1.0/loa2-orgid` | Service consuming/providing assertions based on assurance level 2, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/org-person-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.swedenconnect.se/`<br />`ec/1.0/loa3-orgid` | Service consuming/providing assertions based on assurance level 3, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/org-person-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.swedenconnect.se/`<br />`ec/1.0/loa4-orgid` | Service consuming/providing assertions based on assurance level 4, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/org-person-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.swedenconnect.se/`<br />`ec/1.0/loa2-name` | Service consuming/providing assertions based on assurance level 2, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/natural-person-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.swedenconnect.se/`<br />`ec/1.0/loa3-name` | Service consuming/providing assertions based on assurance level 3, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/natural-person-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.swedenconnect.se/`<br />`ec/1.0/loa4-name` | Service consuming/providing assertions based on assurance level 4, implementing the attribute set `http://id.elegnamnden.se/ap/1.0/natural-person-01`. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |

<a name="entity-categories-for-service-properties"></a>
##### 3.1.3.2. Entity Categories for Service Properties

Identifiers for defined service properties.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/sprop/1.0/mobile-auth` | Service adapted to require/provide user authentication based on mobile devices. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.elegnamnden.se/sprop/1.0/scal2` | Service adapted to support authentication requests from signature services supporting Sole Control Assurance Level 2 (SCAL2). | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |

<a name="entity-categories-for-service-type"></a>
##### 3.1.3.3. Entity Categories for Service Type

Identifiers for defined service types.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/st/1.0/sigservice` | Electronic signature service | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.elegnamnden.se/st/1.0/public-sector-sp` | Public sector Service Provider | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.elegnamnden.se/st/1.0/private-sector-sp` | Private sector Service Provider | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |

<a name="entity-categories-for-service-contract"></a>
##### 3.1.3.4. Entity Categories for Service Contract

Service Contract Entity Category identifiers are indented for performing service matching based on contracts, or business agreements, between providing and consuming services.

All Service Contract identifiers are prefixed with `http://id.swedenconnect.se/contract/<org>`, where `org` is the identifier for the defining organization.

The Sweden Connect Framework specifications do not define any Service Contract identifiers, instead the federation operator, or other parties, may define identifiers suitable for representing how consuming and providing services should be matched based on their respective agreements.

<a name="general-entity-categories"></a>
##### 3.1.3.5. General Entity Categories

An entity category of the General Entity Category type is a category that does not fit into any of the other category types regarding definitions and matching rules.

General category identifiers are prefixed with `http://id.swedenconnect.se/general-ec`.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.swedenconnect.se/general-ec/`<br />`1.0/secure-authenticator-binding` | Indicator that a secure authenticator binding is required, or supported.  | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.swedenconnect.se/general-ec/`<br />`1.0/accepts-coordination-number` | Category for opt-in for the acceptance of Swedish coordination numbers in the personalIdentityNumber attribute.  | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |
| `http://id.swedenconnect.se/general-ec/`<br />`1.0/supports-user-message` | Indicator that an Identity Provider supports the `UserMessage` authentication request extension, see \[[SC.SAML.UMsg](#sc-saml-umsg)\]. | \[[SC.SAML.EntCat](#sc-saml-entcat)\] |


<a name="saml-protocol-status-codes"></a>
#### 3.1.4. SAML Protocol Status Codes

Status code identifiers for use in SAML Response messages. The list
below extends the list of second-level status codes defined in section
3.2.2.2 of \[[SAML2Core](#saml2core)\].

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/status/1.0/cancel` | Status code representing a cancelled operation. | \[[SC.SAML.Profile](#sc-saml-profile)\] |
| `http://id.elegnamnden.se/status/1.0/fraud` | Status code indicating a fraudulent request. | \[[SC.SAML.Profile](#sc-saml-profile)\] |
| `http://id.elegnamnden.se/status/1.0/possibleFraud` | Status code indicating a possible fraudulent request. | \[[SC.SAML.Profile](#sc-saml-profile)\] |

<a name="central-signing"></a>
#### 3.1.5. Central Signing

Identifiers used in the protocol for requesting services form a central signing service.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/csig/1.0/dss-ext/ns` | **Deprecated**. XML schema name space for the protocol extensions to the OASIS DSS protocol (version 1.0). |  |
| `http://id.elegnamnden.se/csig/1.0/eid2-dss/profile` | **Deprecated**. Implementation profile identifier for the protocol extensions to the OASIS DSS protocol (version 1.0). |  |
| `http://id.elegnamnden.se/csig/1.1/dss-ext/ns` | XML schema name space for the protocol extensions to the OASIS DSS protocol (version 1.1). | \[[SC.DSS.Ext](#sc-dss-ext)\] |
| `http://id.elegnamnden.se/csig/1.1/dss-ext/profile` | Implementation profile identifier for the protocol extensions to the OASIS DSS protocol (version 1.1). | \[[SC.DSS.Profile](#sc-dss-profile)\] |
| `http://id.elegnamnden.se/csig/1.1/sap/ns` | XML schema name space for the Signature Activation Protocol, extending version 1.1 of the DSS protocol extension | \[[SC.SAP](#sc-sap)\] |

<a name="authentication-context"></a>
#### 3.1.6. Authentication Context

Identifiers associated with the Authentication Context X.509 extension

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/auth-cont/1.0/saci` | XML schema namespace for SAML Authentication Context Information in the Authentication Context X.509 certificate extension | \[[RFC7773](#rfc7773)\] |
| `http://id.swedenconnect.se/auth-cont/1.0/ext-auth-info` | XML schema namespace for Extended Authentication Information in the Authentication Context X.509 certificate extension | \[[SC.Cert.Profile](#sc-cert-profile)\] |

<a name="sign-response-status-codes"></a>
#### 3.1.7. Sign Response Status Codes

Status code identifiers for the DSS Extension for Central Signing services. The following identifiers provide defined status codes for inclusion in a `<ResultMinor>` element of the `<Result>` element of a sign response message according to the OASIS standard “Digital Signature Service Core Protocols, Elements, and Bindings Version 1.0” \[[OASIS-DSS](#oasis-dss)\].

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/sig-status/1.0/req-expired` | The time window for the signature request has expired. | \[[SC.DSS.Profile](#sc-dss-profile)\] |
| `http://id.elegnamnden.se/sig-status/1.0/user-mismatch` | The authenticated user does not match the signer identity attributes in the request. | \[[SC.DSS.Profile](#sc-dss-profile)\] |
| `http://id.elegnamnden.se/sig-status/1.0/unsupported-loa` | The requested level of assurance for user authentication is not supported. | \[[SC.DSS.Profile](#sc-dss-profile)\] |
| `http://id.elegnamnden.se/sig-status/1.0/sigmessage-error` | A requirement to display sign message was included in the sign request, but the sign service could not establish that the sign message was displayed to the user. | \[[SC.DSS.Profile](#sc-dss-profile)\] |
| `http://id.elegnamnden.se/sig-status/1.0/user-cancel` | The end user cancelled the signature operation. | \[[SC.DSS.Profile](#sc-dss-profile)\] |
| `http://id.swedenconnect.se/sig-status/1.1/authn-failed` | The authentication during the signature operation failed. |  \[[SC.DSS.Profile](#sc-dss-profile)\] |
| `http://id.swedenconnect.se/sig-status/1.1/security-violation` | The Signature Service, or Identity Provider authenticating the end user, has detected a security violation (such as a possible fraud). |  \[[SC.DSS.Profile](#sc-dss-profile)\] |

<a name="name-registration-authorities"></a>
#### 3.1.8. Name Registration Authorities

Some protocols require a URI identifier to uniquely identify the entity responsible for a particular namespace.

| **URL** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.elegnamnden.se/eln/name-registration-authority` | Identifying the Swedish e-Identification Board<sup>*</sup> as name registration authority, responsible for a particular namespace. | \[[SC.Cert.Profile](#sc-cert-profile)\] |

> \[*\]: This also covers the Swedish Agency for Digital Government (Digg) which has overtaken the Swedish E-identification Board's assignments.

<a name="eidas-identifiers"></a>
#### 3.1.9. eIDAS Identifiers

This section defines identifiers used within the Sweden Connect Framework to integrate with the eIDAS Framework.

<a name="eidas-proxy-service-aliases"></a>
##### 3.1.9.1. eIDAS Proxy Service Aliases

Each country within the eIDAS federation provides an eIDAS Proxy Service that is a Proxy Identity Provider for the authentication services within that specific country. The entityID identifier for an eIDAS Proxy Service in another country is not known to a Swedish Service Provider, but there are cases in which the Swedish Service Provider needs to refer to a specific eIDAS Proxy Service. Therefore, this specification defines a URI identifier format for eIDAS Proxy Service aliases. The format is as follows:

**`http://id.swedenconnect.se/eidas/1.0/proxy-service/{country-code}`**

where `{country-code}` is the country identifier in ISO 3166-1 alpha-2 format \[[ISO 3166](#iso3166)\].

> A consumer of an eIDAS Proxy Service alias URI MUST accept the country code part of the URI in both lower and upper case letters.

<a name="eidas-connector-aliases"></a>
##### 3.1.9.2. eIDAS Connector Aliases

A Swedish Identity Provider that delivers authentication services to eIDAS, via the Swedish eIDAS Proxy Service, will receive the entityID of the Service Provider from another country that has requested user authentication in a `<saml2p:RequesterID>` element of the authentication request. Along with this information, the Swedish Proxy Service will also include another `RequesterID` element that holds the "eIDAS Connector alias" URI, telling from which country the requesting Service Provider resides.

The format of this alias is as follows:

**`http://id.swedenconnect.se/eidas/1.0/connector/{country-code}`**

where `{country-code}` is the country identifier in ISO 3166-1 alpha-2 format \[[ISO 3166](#iso3166)\].

> A consumer of an eIDAS Connector alias URI MUST accept the country code part of the URI in both lower and upper case letters.

<a name="identity-binding-processes"></a>
##### 3.1.9.3. Identity Binding Processes

Section 3.3.2 of \[[SC.SAML.Attrs](#sc-saml-attrs)\] describes how the `personalIdentityNumberBinding` attribute is assigned with one or more "Identity Binding Process URI:s" after an identity binding. The possible values are: 

| **URI** | **Object** | **Reference** |
| :--- | :--- | :--- |
| `http://id.swedenconnect.se/`<br />`id-binding/process/populationregister` | Unique match of name and birth date between eIDAS identity and the Swedish Population register. | \[[ID-Binding](#id-binding)\] |
| `http://id.swedenconnect.se/`<br />`id-binding/process/swedish-eid` | Digitally signed attestation using a Swedish eID. | \[[ID-Binding](#id-binding)\] |

The [Binding eIDAS Identities to Records in the Swedish Population Register](#id-binding) (\[[ID-Binding](#id-binding)\]) document defines the above processes in detail. 

<a name="oid-identifiers3"></a>
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
| 1.2.752.201.5.1 | Authentication Context Extension | \[[RFC7773](#rfc7773)\] |
| 1.2.752.201.5.2 | Signature Validation Token Extension | \[[SVT-PDF](#svt-pdf)\] |
| 1.2.752.201.2.1 | Object identifier for the Signature Validation Token RFC 3161 timestamp policy | |
| 1.2.752.201.3.1 | Organization Affiliation Attribute | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.2 | Transaction Identifier | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.3 | Authentication Context Parameters | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.4 | Provisional ID | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.5 | Provisional ID Persistence Indicator | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.6 | Personal Identity Number Binding URI | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.7 | eIDAS Person Identifier | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.8 | Birth name | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.9 | eIDAS Natural Person Address | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.10 | User Certificate | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.11 | User Signature | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.12 | Signature Activation Data | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.13 | Authentication Server Signature | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.14 | Sign Message Digest | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.15 | Previous Personal Identity Number | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |
| 1.2.752.201.3.16 | Mapped Personal Identity Number | \[[SC.SAML.Attrs](#sc-saml-attrs)\] |

<a name="asn1-declarations"></a>
#### 3.2.1. ASN.1 Declarations

Object Identifier Registry for Sweden Connect<sup>*</sup>

    id-eleg OBJECT IDENTIFIER ::= {iso(1) member-body(2) se(752) e-legitimationsnamnden(201)}

    -- Sweden Connect arcs
    id-mod    OBJECT IDENTIFIER ::= { id-eleg 0 }    -- ASN.1 modules
    id-test   OBJECT IDENTIFIER ::= { id-eleg 1 }    -- OIDs for test
    id-pol    OBJECT IDENTIFIER ::= { id-eleg 2 }    -- Policy
    id-attr   OBJECT IDENTIFIER ::= { id-eleg 3 }    -- Attributes
    id-qcs    OBJECT IDENTIFIER ::= { id-eleg 4 }    -- QC Statement
    id-ce     OBJECT IDENTIFIER ::= { id-eleg 5 }    -- Cert Extensions

    -- Sweden Connect Modules
    id-mod-auth-context-88 OBJECT IDENTIFIER ::= { id-mod 1 }    -- Used in RFC 7773
    id-mod-auth-context-08 OBJECT IDENTIFIER ::= { id-mod 2 }    -- Used in RFC 7773

    -- Sweden Connect OIDs for test

    -- Sweden Connect Policies
    id-pol-svt-ts-policy         OBJECT IDENTIFIER ::= { id-pol 1 }     -- SVT RFC 3161 timestamp policy

    -- Sweden Connect Attributes
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
    id-attr-sign-message-digest  OBJECT IDENTIFIER ::= { id-attr 14 }   -- Sign message digest
    id-attr-previous-pid-number  OBJECT IDENTIFIER ::= { id-attr 15 }   -- Previous personal identity number
    id-attr-mapped-pid-number    OBJECT IDENTIFIER ::= { id-attr 16 }   -- Mapped personal identity number
    
    -- Sweden Connect QC Statement extension
    id-qcs-sid         OBJECT IDENTIFIER ::= { id-qcs 1 }   -- Semantics Identifiers
    id-qcs-statement   OBJECT IDENTIFIER ::= { id-qcs 2 }   -- QC statements

    -- Sweden Connect Certificate Extensions
    id-ce-authContext  OBJECT IDENTIFIER ::= { id-ce 1 }    -- Auth context extension used in RFC 7773
    id-ce-svt          OBJECT IDENTIFIER ::= { id-ce 2 }    -- Signature Validation Token extension

> \[*\]: The OID 1.2.752.201 was assigned to the Swedish E-identification Board, but this organisation has been overtaken by the Swedish Agency for Digital Government (Digg) who now uses this OID arc for the Sweden Connect Framework.

<a name="references"></a>
## 4. References

<a name="saml2core"></a>
**\[SAML2Core\]**
> [OASIS Standard, Assertions and Protocols for the OASIS Security
> Assertion Markup Language (SAML) V2.0, March 2005](http://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf)

<a name="oasis-dss"></a>
**\[OASIS-DSS\]**
> [Digital Signature Service Core Protocols, Elements, and Bindings
> Version 1.0.](http://docs.oasis-open.org/dss/v1.0/oasis-dss-core-spec-v1.0-os.html)

<a name="se-trust"></a>
**\[SE.Trust\]**
> [Tillitsramverket för Svensk e-legitimation](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation).

<a name="rfc7773"></a>
**\[RFC7773\]**
> [RFC7773: Authentication Context Certificate Extension](https://tools.ietf.org/html/rfc7773).

<a name="sc-saml-profile"></a>
**\[SC.SAML.Profile\]**
> [Deployment Profile for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/02_-_Deployment_Profile_for_the_Swedish_eID_Framework.html).

<a name="sc-saml-entcat"></a>
**\[SC.SAML.EntCat\]**
> [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html).

<a name="sc-saml-attrs"></a>
**\[SC.SAML.Attrs\]**
> [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/latest/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html).

<a name="sc-saml-umsg"></a>
**\[SC.SAML.UMsg\]**
> [User Message Extension in SAML Authentication Requests](https://docs.swedenconnect.se/technical-framework/latest/18_-_User_Message_Extension_in_SAML_Authentication_Requests.html).

<a name="sc-dss-ext"></a>
**\[SC.DSS.Ext\]**
> [DSS Extension for Federated Central Signing Services](https://docs.swedenconnect.se/technical-framework/latest/09_-_DSS_Extension_for_Federated_Signing_Services.html).

<a name="sc-sap"></a>
**\[SC.SAP\]**
> [Signature Activation Protocol for Federated Signing](https://docs.swedenconnect.se/technical-framework/latest/13_-_Signature_Activation_Protocol.html).

<a name="sc-dss-profile"></a>
**\[SC.DSS.Profile\]**
> [Implementation Profile for Using OASIS DSS in Central Signing Services](https://docs.swedenconnect.se/technical-framework/latest/07_-_Implementation_Profile_for_using_DSS_in_Central_Signing_Services.html).

<a name="sc-cert-profile"></a>
**\[SC.Cert.Profile\]**
> [Certificate profile for certificates issued by Central Signing services](https://docs.swedenconnect.se/technical-framework/latest/08_-_Certificate_Profile_for_Central_Signing_Services.html)

<a name="id-binding"></a>
**\[ID-Binding\]**
> [Binding eIDAS Identities to Records in the Swedish Population Register](https://docs.swedenconnect.se/technical-framework/Identity_Binding.html)

<a name="svt-pdf"></a>
**\[SVT-PDF\]**
> [PDF Signature Validation Token](https://datatracker.ietf.org/doc/draft-santesson-svt-pdf/).

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

**Changes between version 1.7 and version 1.8:**

- The document name was changed to "Sweden Connect - Registry for identifiers" from "Swedish eID Framework - Registry for identifiers".

- Section 3.1.7, "Sign Response Status Codes", were extended with error codes for `authn-failed` and `security-violation`.

- Section 3.1.9.3, "Identity Binding Processes", was introduced where binding process URI:s for matching eIDAS identities to Swedish identity numbers are listed.

- The `http://id.swedenconnect.se/general-ec/1.0/supports-user-message` entity category was added to section, 3.1.3.5, "General Entity Categories".

**Changes between version 1.6 and version 1.7:**

- Section, 3.1.3.5, "General Entity Categories", was introduced and `http://id.swedenconnect.se/general-ec/1.0/secure-authenticator-binding` and `http://id.swedenconnect.se/general-ec/1.0/accepts-coordination-number` was added.

- In section 3.2, an object identifier (OID) for Signature Validation Token extension was added and one OID for an SVT timestamp policy.

- Added service entity categories `http://id.swedenconnect.se/ec/1.0/loa3-orgid` and `http://id.swedenconnect.se/ec/1.0/loa3-name` to section 3.1.3.1.

- In section 3.2, the attributes for "previous personal identity number" (`1.2.752.201.3.15`) and  "mapped personal identity number" (`1.2.752.201.3.16`) were added.

- Section 3.1.3.1, "Service Entity Categories", was updated with categories for loaX-name and loaX-orgid.

- Authentication context URIs for non-residents and uncertified providers were added to sections 3.1.1.1 and 3.1.1.2.

**Changes between version 1.5 and version 1.6:**

- The specification was renamed from "Registry for identifiers assigned by the Swedish e-identification board" to "Swedish eID Framework - Registry for identifiers".

- The authentication context URIs `http://id.swedenconnect.se/loa/1.0/uncertified-loa3` and `http://id.swedenconnect.se/loa/1.0/uncertified-loa3-sigmessage` were introduced in sections 3.1.1 and 3.1.1.1, and the service entity category `http://id.swedenconnect.se/ec/sc/uncertified-loa3-pnr` was added to section 3.1.3.1.

- A description of Service Contract Entity Categories was added to section 3.1.3.4.

- In section 3.1.1, the EU commission `AuthnContextClassRef` URI:s for non-notified schemes were changed.

- Section 3.1.9.2, "eIDAS Connector Aliases", defining the URI format for representing country affiliation of eIDAS connector services, was added.

- The link for the "Tillitsramverk för Svensk e-legitimation" specification was updated.

- Added the attribute SignMessageDigest (1.2.752.201.3.14) to section 3.2.

- The Sign Message Authentication Context URIs defined in section 3.1.1.1 are deprecated.

- The XML Schema namespace identifier `http://id.swedenconnect.se/auth-cont/1.0/ext-auth-info` was added. This XML Schema defines an XML extension for the Authentication Context Extension to provide extended authentication information.

- Associating the OID registry with Sweden Connect.

- Aligned registered module OID:s with RFC 7773.

- Adding a new extension OID for Signature Validation Tokens in timestamp extensions.

- Added attribute set and service entity categories for HSA-ID.

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
