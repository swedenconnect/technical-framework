<img src="img/eln-logo.png"></img>

# Updates to the Swedish eID Framework

### 2017-05-24

## Table of Contents

1. [Introduction](#introduction)

  1.1. [Normative References](#normative-references)

2. [Updates](#updates)

  E.1 [Scoping in Authentication Requests sent by Signature Services](#e1)

<a name="Introduction"></a>
## 1. Introduction

This document contains updates to the current version of the Swedish eID Framework. The current version of the Swedish eID Framework is published on [http://elegnamnden.github.io/technical-framework](http://elegnamnden.github.io/technical-framework/), and comprises of specifications that are listed as “normative references” in chapter [1.1](#normative-references).

The updates presented in this document will be suggested to be part of the next official version of the Swedish eID Framework, and parties are
not required to implement, or support, a suggested update until it is part of a Swedish eID Framework specification. However, Identity Providers are strongly advised to implement the updates in this document that concerns interoperability issues and/or covers a specific functionality that is handled by the Identity Provides.

For each update the following is covered:

-   The reason for the update.

-   The parties that will be affected by the change.

The update document represents changes that are not “substantive”. The changes focus on clarifications to ambiguous or conflicting
specification text, and are intended to reduce interoperability problems within the Swedish eID federation.

In this document, update change instructions are presented with surrounding context as necessary to make the intent clear. Original specification text is often presented as follows, with problem text highlighted in bold:

* "This is an original specification. **This is text that needs to be changed.**"

New specification text is typically presented as follows, with new or changed text highlighted in bold:

* "This is an original specification. **This is the new text that was added in the errata.**"

<a name="normative-references"></a>
### 1.1. Normative References


**\[EidProfile\]**
> [Deployment Profile for the Swedish eID Framework, version 1.4](http://elegnamnden.github.io/technical-framework/latest/ELN-0602_-_Deployment_Profile_for_the_Swedish_eID_Framework.html)

<a name="updates"></a>
## 2. Updates

<a name="e1"></a>
### E.1. Scoping in Authentication Requests sent by Signature Services

**Updates**: Version 1.4 of the “[Deployment Profile for the Swedish eID Framework](http://elegnamnden.github.io/technical-framework/latest/ELN-0602_-_Deployment_Profile_for_the_Swedish_eID_Framework.html)”

An instance of a Signature Service may be used by several services representing different SAML Service Providers within an organization, and the Identity Provider processing the "authentication for signature" request may need to obtain configuration for the "original" Service Provider in order to fulfill its service. Therefore, section 7.2, "Authentication Requests", of \[EidProfile\] has been extended with the following:

**New**:

**It is RECOMMENDED that the `<saml2p:Scoping>` element containing a `<saml2p:RequesterID>` element holding the entityID of the Service Provider at which the user authenticated for the current session is included in the `<saml2p:AuthnRequest>` message.**

    <saml2p:Scoping>
      <saml2p:RequesterID>http://www.origsp.com/sp</saml2:RequesterID>
    </saml2p:Scoping>

