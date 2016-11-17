# Technical Specifications for the Swedish eID Framework #

This repository comprises the specifications of the Swedish eID Framework.

## About

The specifications in this branch (october-2015-updates) are draft updates to the latest official release of the Swedish eID Framework (found in the master branch and in the [releases](https://github.com/elegnamnden/technical-framework/releases) section of this repository).

The changes made to the specifications aim to integrate the eIDAS Framework into the Swedish eID Framework. Read more about eIDAS and the Swedish eID Framework on the [eIDAS Wiki](https://github.com/elegnamnden/eidas/wiki).

### Draft releases

* [Draft release 2016-11-16](https://github.com/elegnamnden/technical-framework/releases/tag/20161116-draft-release)
* [Draft release 2016-08-30](https://github.com/elegnamnden/technical-framework/releases/tag/20160830-draft-release)

### Feedback

If you have comments on the draft specifications, please [let us know](mailto:martin.lindstrom@litsec.se,stefan@aaa-sec.com).

## Contents

The master branch of the repository contains the currently active specifications.

#### Tekniskt ramverk för Svensk e-legitimation

An overview document (in Swedish) that describes the different parts of the Swedish eID Framework.

> This document will be translated into English.

#### Deployment Profile for the Swedish eID Framework

This is the main specification for the Swedish eID Framework. It defines a SAML profile including metadata, request- and response processing as well as extensions for signature services. 

#### Registry for identifiers assigned by the Swedish e-identification board

This document defines the structure for identifiers assigned by the Swedish e-identification board and provides a registry for assigned identifiers.

#### Attribute Specification for the Swedish eID Framework

This document specifies an attribute profile for the Swedish eID Framework. The attribute profile defines attributes for use within the Swedish eID Framework, and a number of defined attribute sets that may be referenced by other documents as means to specify specific attribute release requirements.

#### Entity Categories for the Swedish eID Framework

This specification contains the Entity Category definitions that are defined for the Swedish eID Framework and that should be supported by Service Providers and Identity Providers that are part of the federation.

#### Implementation Profile for using OASIS DSS in Central Signing Services

This document specifies an implementation profile for exchange of sign requests and responses using the OASIS DSS protocol, enhanced by the DSS Extensions for Federated Central Signing Services.

#### Certificate profile for certificates issued by Central Signing services

This document specifies a certificate profile for certificates issued by a signature service within the Swedish eID federation.

#### DSS Extension for Federated Central Signing Services

This specifications defines elements that extends the `<dss:SignRequest>` and `<dss:SignResponse>` elements of the OASIS DSS protocol.

#### Discovery within the Swedish eID Framework

Current version is deprecated. Currently the Swedish eID Framework does not impose any requirements on how service discovery should be performed.

Work is ongoing to present an updated specification for discovery.

> The Swedish eID Framework comprises a Discovery Service that has as i<ts purpose to supply Service Providers with user selected Identity Providers for authentication within the federation. This specifications defines how discovery is implemented.

#### eIDAS Constructed Attribute Specification for the Swedish eID Framework

This document extends “Attribute Specification for the Swedish eID Framework”, providing specifications for constructed attributes.

The concept of constructed attributes is introduced in Swedish national authentication nodes (proxy nodes) delivering identity assertions to Swedish Service Providers based on user authentication with a foreign eID.

## Updates to the current version of the specifications

Updates to the current version of the specification should be performed in the "october-2015-updates" branch except for any changes that need to be performed in the "Updates to the Swedish eID Framework.docx" document.

#### Rules for updating specifications

- When editing a file make sure that MS Word's "Track changes" feature is turned on.

- For each update to a specification that has any real meaning also make a note about it in the "Changes between versions" section of the specification.

- For each specification being updated make sure that its version is reflected in versions.md.

- Leave the **tracked-changes** directory empty until a merge to master is made (i.e., when a new version of the Technical Framework is released).

- Before a merge to master (release), do the following:

  + Copy all files to the **tracked changes** directory.
  + For each specification in the main directory, go through it and approve all changes and then turn of "highlight changes".
  
- If changes are made to the OASIS-document, make sure to generate a word file named `ELN-0609 - Bilaga Tekniskt ramverk - DSS Extension for Federated Signing Services.docx` before pushing an update to the remote repo.
  

## Older versions

Older version of the specification are stored in the following branches:

+ april-2014 - For the June 2014 release
+ june-2015 - For the June 2015 release
+ october-2015 - For the October 2015 release (this is also the current release/master).


