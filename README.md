<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</div>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Technical Specifications for the Swedish eID Framework

This repository comprises the specifications of the Swedish eID Framework.

### About

The specifications in this branch are the latest development of the Swedish eID Framework. The latest official release
can be found in the [june-2018 branch](https://github.com/swedenconnect/technical-framework/tree/june-2018).

### Feedback and Questions

If you have feedback or questions regarding the Technical Framework make a post to the "Tekniskt ramverk"-thread on <https://forum.eidasweb.se>.

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

#### Deployment Profile for the Swedish eID Framework

This is the main specification for the Swedish eID Framework. It defines a SAML profile including metadata, request- and response processing as well as extensions for signature services.

> [02 - Deployment Profile for the Swedish eID Framework](02%20-%20Deployment%20Profile%20for%20the%20Swedish%20eID%20Framework.md)

#### Swedish eID Framework - Registry for identifiers

This document defines the structure for identifiers assigned by the Swedish Agency for Digital Government (DIGG) and provides a registry for assigned identifiers.

> [03 - Registry for Identifiers](03%20-%20Registry%20for%20Identifiers.md)

#### Attribute Specification for the Swedish eID Framework

This document specifies an attribute profile for the Swedish eID Framework. The attribute profile defines attributes for use within the Swedish eID Framework, and a number of defined attribute sets that may be referenced by other documents as means to specify specific attribute release requirements.

> [04 - Attribute Specification for the Swedish eID Framework](04%20-%20Attribute%20Specification%20for%20the%20Swedish%20eID%20Framework.md)

#### Entity Categories for the Swedish eID Framework

This specification contains the Entity Category definitions that are defined for the Swedish eID Framework and that should be supported by Service Providers and Identity Providers that are part of the federation.

> [06 - Entity Categories for the Swedish eID Framework](06%20-%20Entity%20Categories%20for%20the%20Swedish%20eID%20Framework.md)

#### Implementation Profile for using OASIS DSS in Central Signing Services

This document specifies an implementation profile for exchange of sign requests and responses using the OASIS DSS protocol, enhanced by the DSS Extensions for Federated Central Signing Services.

> [07 - Implementation Profile for using DSS in Central Signing Services](07%20-%20Implementation%20Profile%20for%20using%20DSS%20in%20Central%20Signing%20Services.md)

#### Certificate Profile for Certificates Issued by Central Signing Services

This document specifies a certificate profile for certificates issued by a signature service.

> [08 - Certificate Profile for Central Signing Services](08%20-%20Certificate%20Profile%20for%20Central%20Signing%20Services.md)

#### DSS Extension for Federated Central Signing Services

This specification defines elements that extend the `<dss:SignRequest>` and `<dss:SignResponse>` elements of the OASIS DSS protocol.

> [09 - DSS Extension for Federated Signing Services](09%20-%20DSS%20Extension%20for%20Federated%20Signing%20Services.md)

#### Discovery within the Swedish eID Framework

Current version is deprecated. Currently the Swedish eID Framework does not impose any requirements on how service discovery should be performed.

Work is ongoing to present an updated specification for discovery.

#### eIDAS Constructed Attribute Specification for the Swedish eID Framework

This document extends “Attribute Specification for the Swedish eID Framework”, providing specifications for constructed attributes.

The concept of constructed attributes is introduced in Swedish national authentication nodes (proxy nodes) delivering identity assertions to Swedish Service Providers based on user authentication with a foreign eID.

> [11 - eIDAS Constructed Attributes Specification for the Swedish eID Framework](11%20-%20eIDAS%20Constructed%20Attributes%20Specification%20for%20the%20Swedish%20eID%20Framework.md)

#### Implementation Profile for BankID Identity Providers within the Swedish eID Framework

Implementation profile for Identity Providers implementing BankID support.

> [12 - BankID Profile for the Swedish eID Framework](12%20-%20BankID%20Profile%20for%20the%20Swedish%20eID%20Framework.md)

#### Signature Activation Protocol for Federated Signing

This document specifies a Signature Activation Protocol (SAP) and its data elements for implementation of Sole Control Assurance Level 2 (SCAL2) according the European standards prEN 419241 - Trustworthy Systems Supporting Server Signing.

> [13 - Signature Activation Protocol for Federated Signing](13%20-%20Signature%20Activation%20Protocol.md)

#### Principal Selection in SAML Authentication Requests

This specification defines an element that may be included in the Extensions element of a SAML AuthnRequest where the requesting Service Provider can specify matching criteria that may be used by the Identity Provider to select the particular user that should be authenticated.

> [14 - Principal Selection in SAML Authentication Requests](14%20-%20Principal%20Selection%20in%20SAML%20Authentication%20Requests.md)

---

## Older versions

Older version of the specification are stored in the following branches:

+ june-2014 - For the June 2014 release
+ april-2015 - For the April 2015 release
+ october-2015 - For the October 2015 release
+ march-2017 - For the March 2017 release

---

Copyright &copy; 2017-2020, [Sweden Connect](https://swedenconnect.se). Licensed under version 2.0 of the [Apache License](http://www.apache.org/licenses/LICENSE-2.0).
