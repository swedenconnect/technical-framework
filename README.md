<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Technical Specifications for the Swedish eID Framework

This repository comprises the specifications of the Swedish eID Framework.

### About

The specifications in this branch are the latest development of the Swedish eID Framework. The latest official release
can be found in the [november-2021 branch](https://github.com/swedenconnect/technical-framework/tree/november-2021).

### Feedback and Questions

If you have feedback or questions regarding the Technical Framework join the 
[Sweden Connect Slack Workspace](https://swedenconnect.slack.com).

Click <a href="mailto:martin@idsec.se?subject= I would like to join the SwedenConnect Slack Workspace">here</a> to ask for an invitation.

### The Working Group

The [Working Group for the Swedish eID Framework](working-group/wg.md) is responsible of development of future versions of the framework. 

### Releases

For official and draft releases of the Swedish eID Framework, see the [releases section](https://github.com/swedenconnect/technical-framework/releases).

The releases can also be found under <https://docs.swedenconnect.se/technical-framework/>.

## Contents

#### Introduction to the Swedish eID Framework

An overview document that describes the different parts of the Swedish eID Framework.

> [Introduction to the Swedish eID Framework](00%20-%20Swedish%20eID%20Framework%20-%20Introduction.md) (in English)

> [Tekniskt ramverk - Introduktion](00%20-%20Tekniskt%20ramverk%20-%20Introduktion.md) (in Swedish)

#### Swedish eID Framework - Registry for identifiers

This document defines the structure for identifiers assigned by the Swedish Agency for Digital Government (DIGG) and provides a registry for assigned identifiers.

> [03 - Registry for Identifiers](03%20-%20Registry%20for%20Identifiers.md)

### Authentication Specifications

Below follows a listing of all specifications concerning user authentication.

> OpenID Connect will be introduced as an alternative to SAML. Therefore we point out the protocol for the specifications below.

#### SAML: Deployment Profile for the Swedish eID Framework

This is the main specification for the Swedish eID Framework. It defines a SAML profile including metadata, request- and response processing as well as extensions for signature services.

> [02 - Deployment Profile for the Swedish eID Framework](02%20-%20Deployment%20Profile%20for%20the%20Swedish%20eID%20Framework.md)

#### SAML: Attribute Specification for the Swedish eID Framework

This document specifies an attribute profile for the Swedish eID Framework. The attribute profile defines attributes for use within the Swedish eID Framework, and a number of defined attribute sets that may be referenced by other documents as means to specify specific attribute release requirements.

> [04 - Attribute Specification for the Swedish eID Framework](04%20-%20Attribute%20Specification%20for%20the%20Swedish%20eID%20Framework.md)

#### SAML: Entity Categories for the Swedish eID Framework

This specification contains the Entity Category definitions that are defined for the Swedish eID Framework and that should be supported by Service Providers and Identity Providers that are part of the federation.

> [06 - Entity Categories for the Swedish eID Framework](06%20-%20Entity%20Categories%20for%20the%20Swedish%20eID%20Framework.md)

#### eIDAS Constructed Attribute Specification for the Swedish eID Framework

This document extends “Attribute Specification for the Swedish eID Framework”, providing specifications for constructed attributes.

The concept of constructed attributes is introduced in Swedish national authentication nodes (proxy nodes) delivering identity assertions to Swedish Service Providers based on user authentication with a foreign eID.

> [11 - eIDAS Constructed Attributes Specification for the Swedish eID Framework](11%20-%20eIDAS%20Constructed%20Attributes%20Specification%20for%20the%20Swedish%20eID%20Framework.md)

#### SAML: Implementation Profile for BankID Identity Providers within the Swedish eID Framework

SAML implementation profile for Identity Providers implementing BankID support.

> [12 - BankID Profile for the Swedish eID Framework](12%20-%20BankID%20Profile%20for%20the%20Swedish%20eID%20Framework.md)

#### SAML: Principal Selection in SAML Authentication Requests

This specification defines an element that may be included in the Extensions element of a SAML AuthnRequest where the requesting Service Provider can specify matching criteria that may be used by the Identity Provider to select the particular user that should be authenticated.

> [14 - Principal Selection in SAML Authentication Requests](14%20-%20Principal%20Selection%20in%20SAML%20Authentication%20Requests.md)

### Signature Specifications

Below follows a listing of the specifications we define for Federated Central Signing Services.

#### Implementation Profile for using OASIS DSS in Central Signing Services

This document specifies an implementation profile for exchange of sign requests and responses using the OASIS DSS protocol, enhanced by the DSS Extensions for Federated Central Signing Services.

> [07 - Implementation Profile for using DSS in Central Signing Services](07%20-%20Implementation%20Profile%20for%20using%20DSS%20in%20Central%20Signing%20Services.md)

#### Certificate Profile for Certificates Issued by Central Signing Services

This document specifies a certificate profile for certificates issued by a signature service.

> [08 - Certificate Profile for Central Signing Services](08%20-%20Certificate%20Profile%20for%20Central%20Signing%20Services.md)

#### DSS Extension for Federated Central Signing Services

This specification defines elements that extend the `<dss:SignRequest>` and `<dss:SignResponse>` elements of the OASIS DSS protocol.

> [09 - DSS Extension for Federated Signing Services](09%20-%20DSS%20Extension%20for%20Federated%20Signing%20Services.md)

#### Signature Activation Protocol for Federated Signing

This document specifies a Signature Activation Protocol (SAP) and its data elements for implementation of Sole Control Assurance Level 2 (SCAL2) according the European standards prEN 419241 - Trustworthy Systems Supporting Server Signing.

> [13 - Signature Activation Protocol for Federated Signing](13%20-%20Signature%20Activation%20Protocol.md)

#### *Signature Validation Tokens*

The draft specifications "15 - Signature Validation Token", "16 - PDF Profile for Signature Validation Tokens" and "17 - XML Profile for Signature Validation Tokens" are no longer part of the Swedish eID Framework specifications, and have been replaced by the following IETF drafts:

- [https://datatracker.ietf.org/doc/draft-santesson-svt/](https://datatracker.ietf.org/doc/draft-santesson-svt/)
- [https://datatracker.ietf.org/doc/draft-santesson-svt-pdf/](https://datatracker.ietf.org/doc/draft-santesson-svt-pdf/)
- [https://datatracker.ietf.org/doc/draft-santesson-svt-xml/](https://datatracker.ietf.org/doc/draft-santesson-svt-xml/)

See https://github.com/swedenconnect/IETF-SVT for the repository that is hosting this work.

---

## Older versions

Older version of the specifications are stored in the following branches:

+ [june-2014](https://github.com/swedenconnect/technical-framework/tree/june-2014) - For the June 2014 release
+ [april-2015](https://github.com/swedenconnect/technical-framework/tree/april-2015) - For the April 2015 release
+ [october-2015](https://github.com/swedenconnect/technical-framework/tree/october-2015) - For the October 2015 release
+ [march-2017](https://github.com/swedenconnect/technical-framework/tree/march-2017) - For the March 2017 release
+ [june-2018](https://github.com/swedenconnect/technical-framework/tree/june-2018) - For the June 2018 release
+ [january-2020](https://github.com/swedenconnect/technical-framework/tree/january-2020) - For the January 2020 release

---

Copyright &copy; [The Swedish Agency for Digital Government (DIGG)](https://www.digg.se), 2015-2023. All Rights Reserved.
