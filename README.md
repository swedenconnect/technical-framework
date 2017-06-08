<img src="img/eln-logo.png"></img>

# Technical Specifications for the Swedish eID Framework

This repository comprises the specifications of the Swedish eID Framework.

### About

The specifications in this branch are the latest development of the Swedish eID Framework. The latest official release
can be found in the [march-2017 branch](https://github.com/elegnamnden/technical-framework/tree/march-2017).

### Feedback and Questions

If you have feedback or questions regarding the Technical Framework make a post to the "Tekniskt ramverk"-thread on <https://forum.eidasweb.se>.

### Releases

For official and draft releases of the Swedish eID Framework, see the [releases section](https://github.com/elegnamnden/technical-framework/releases).

The releases can also be found under <http://elegnamnden.github.io/technical-framework/>.

## Contents

#### Tekniskt ramverk för Svensk e-legitimation

An overview document (in Swedish) that describes the different parts of the Swedish eID Framework.

> [ELN-0600 - Tekniskt ramverk - Svensk e-legitimation](ELN-0600%20-%20Tekniskt%20ramverk%20-%20Svensk%20e-legitimation.md)

> This document will be translated into English.

#### Deployment Profile for the Swedish eID Framework

This is the main specification for the Swedish eID Framework. It defines a SAML profile including metadata, request- and response processing as well as extensions for signature services.

> [ELN-0602 - Deployment Profile for the Swedish eID Framework](ELN-0602%20-%20Deployment%20Profile%20for%20the%20Swedish%20eID%20Framework.md)

#### Registry for identifiers assigned by the Swedish e-identification board

This document defines the structure for identifiers assigned by the Swedish e-identification board and provides a registry for assigned identifiers.

> [ELN-0603 - Registry for Identifiers](ELN-0603%20-%20Registry%20for%20Identifiers.md)

#### Attribute Specification for the Swedish eID Framework

This document specifies an attribute profile for the Swedish eID Framework. The attribute profile defines attributes for use within the Swedish eID Framework, and a number of defined attribute sets that may be referenced by other documents as means to specify specific attribute release requirements.

> [ELN-0604 - Attribute Specification for the Swedish eID Framework](ELN-0604%20-%20Attribute%20Specification%20for%20the%20Swedish%20eID%20Framework.md)

#### Entity Categories for the Swedish eID Framework

This specification contains the Entity Category definitions that are defined for the Swedish eID Framework and that should be supported by Service Providers and Identity Providers that are part of the federation.

> [ELN-0606 - Entity Categories for the Swedish eID Framework](ELN-0606%20-%20Entity%20Categories%20for%20the%20Swedish%20eID%20Framework.md)

#### Implementation Profile for using OASIS DSS in Central Signing Services

This document specifies an implementation profile for exchange of sign requests and responses using the OASIS DSS protocol, enhanced by the DSS Extensions for Federated Central Signing Services.

> [ELN-0607 - Implementation Profile for using DSS in Central Signing Services](ELN-0607%20-%20Implementation%20Profile%20for%20using%20DSS%20in%20Central%20Signing%20Services.md)

#### Certificate profile for certificates issued by Central Signing services

This document specifies a certificate profile for certificates issued by a signature service within the Swedish eID federation.

> [ELN-0608 - Certificate Profile for Central Signing Services](ELN-0608%20-%20Certificate%20Profile%20for%20Central%20Signing%20Services.md)

#### DSS Extension for Federated Central Signing Services

This specifications defines elements that extends the `<dss:SignRequest>` and `<dss:SignResponse>` elements of the OASIS DSS protocol.

> [ELN-0609 - DSS Extension for Federated Signing Services](ELN-0609%20-%20DSS%20Extension%20for%20Federated%20Signing%20Services.md)

#### Discovery within the Swedish eID Framework

Current version is deprecated. Currently the Swedish eID Framework does not impose any requirements on how service discovery should be performed.

Work is ongoing to present an updated specification for discovery.

#### eIDAS Constructed Attribute Specification for the Swedish eID Framework

This document extends “Attribute Specification for the Swedish eID Framework”, providing specifications for constructed attributes.

The concept of constructed attributes is introduced in Swedish national authentication nodes (proxy nodes) delivering identity assertions to Swedish Service Providers based on user authentication with a foreign eID.

> [ELN-0611 - eIDAS Constructed Attributes Specification for the Swedish eID Framework](ELN-0611%20-%20eIDAS%20Constructed%20Attributes%20Specification%20for%20the%20Swedish%20eID%20Framework.md)

#### Implementation Profile for BankID Identity Providers within the Swedish eID Framework

Implementation profile for Identity Providers implementing BankID support.

> [ELN-0612 - BankID Profile for the Swedish eID Framework](ELN-0612%20-%20BankID%20Profile%20for%20the%20Swedish%20eID%20Framework.md)

---

### Updates to the current version of the specifications

> [Updates to the Swedish eID Framework](Updates%20to%20the%20Swedish%20eID%20Framework.md) - 2017-06-08

## Older versions

Older version of the specification are stored in the following branches:

+ june-2014 - For the June 2014 release
+ april-2015 - For the April 2015 release
+ october-2015 - For the October 2015 release
