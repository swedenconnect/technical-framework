<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Binding of eIDAS Identity to Record in the Swedish Population Register

### 2023-06-08 (draft)

This document contains information about the binding processes that  
associate a Swedish identity number to an eIDAS notified edID.

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (DIGG)</a>, 2023. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

2. [**The Identity Binding Service**](#the-identity-binding-service)

    2.1. [Making a Binding](#making-a-binding)
    
    2.2. [eIDAS-node Queries](#eidas-node-queries)

3. [**Identity Binding Levels**](#identity-binding-levels)

    3.1. [Basic Binding](#basic-binding)
    
    3.2. [Enhanced Binding](#enhanced-binding)
    
    3.3. [Verified Binding](#verified-binding)
    
4. [**Identity Binding Processes**](#identity-binding-processes)

    4.1. [Essential Matching of Record in the Population Register](#essential-matching-population-register)

    4.2. [Elevated Matching of Record in the Poulation Register](#elevated-matching-population-register)
    
    4.3. [Nordic Identification Number Found in the Population Register](#nordic-id-in-population-register)

    4.4. [Use of Swedish eID](#use-of-swedish-eid)
    
    4.5. [A Relative to End-user has Confirmed the Binding](#confirmed-by-relative)
 
    4.6. [Passport or ID-card Scanning](#passport-or-id-card-scanning)
    
5. [**Versions**](#versions)
    
<a name="introduction"></a>
## 1. Introduction

Public relying parties in Sweden commonly use the Swedish personal 
identity number (a.k.a. personnummer) or the Swedish coordination 
number (a.k.a. samordningsnummer) as the primary identifier to carry 
out the authorisation of the authenticated user. These attributes are 
not part of an eIDAS assertion. 

By providing an Identity Binding Service, end-users can associate 
their eIDAS notified eID with their record in the Swedish population 
register. And, in such manner, end-users gain access to many more 
digital services.

<a name="the-identity-binding-service"></a>
## 2. The Identity Binding Service
The Identity Binding Service is a part of Sweden's digital 
infrastructure. For users that have an eIDAS notified eID, it 
provides support in binding processes, which give end-users ability 
to associate their eID to a record in the Swedish pouplation register. 
As records are matched, then the identity binding can be utilized 
by the Swedish eIDAS-node when the end-user logs in to a digital 
service in Sweden. The assertion that is provided to relying party 
includes attributes from eIDAS as well as attributes from the 
Identity Binding Service.


The Identity Binding Service can be used by the end-users, who are 
authenticated through eIDAS, in those cases when:
- the end-user has a registered record in terms of Swedish personal identity number (a.k.a. personnummer) or the Swedish coordination number (a.k.a. samordningsnummer) in the Swedish population register, and
- the end-user has chosen to associate this record to her/his eIDAS notified eID.

When end-user's Swedish records are linked to her/his eID, the Swedish eIDAS-node can 
provide this information in the assertion to relying party.

<a name="making-a-binding"></a>
### 2.1. Making a Binding
Identity binding can be made through a number of different [Identity Binding Processes](#identity-binding-processes). 
These processes are run separately or in combinations and can result in linked 
identifications based on three different levels of confidence. See also 
[section 3, "Identity Binding Levels"](#identity-binding-levels)

> TODO: Include links to https://elegitimation.se and other resources where we describe
the ID-matching service.
    
<a name="eidas-node-queries"></a>
### 2.2. eIDAS-node Queries

The identity bindings of the Identity Binding service will be accessible for the
Swedish eIDAS-node via a query-API. During an eIDAS authentication the Swedish eIDAS-node
will query this API for a binding between the attributes presented in the assertion 
received from the foreign node and a Swedish personal identity number. If such a
binding exists two attributes will be added to the resulting assertion delivered to
the Swedish relying party (service provider). These attributes are:

- `urn:oid:1.2.752.201.3.16` (mappedPersonalIdentityNumber) - Contains the Swedish
personal identity number that was bound to the eIDAS identity.

- `urn:oid:1.2.752.201.3.6` (personalIdentityNumberBinding) - Contains an URI that
represents the [Identity Binding Level](#identity-binding-levels).

See also sections 2.5, "eIDAS Natural Person Attribute Set", and 3.3.2, "The mappedPersonalIdentityNumber and personalIdentityNumberBinding Attributes", of [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/updates/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html) for more information
about attribute release during an eIDAS authentication.

<a name="identity-binding-levels"></a>
## 3. Identity Binding Levels
Identity Bindings are provided in three different levels of confidence. 
These levels can be used in the authorisation process by the relying party. 

<a name="basic-binding"></a>
### 3.1. Basic Binding (A)

**URI:** `http://id.swedenconnect.se/id-binding/level/basic`

**Description:** Level of confidence in binding as a result from an automated decision process when the eIDAS attributes from the foreign eID are matched to an individual's record in the Swedish population register.

The following processes must have been applied:
- `http://id.swedenconnect.se/id-binding/process/registered` ([4.1](#essential-matching-population-register))
- `http://id.swedenconnect.se/id-binding/process/populationregister` ([4.2](#elevated-matching-population-register))
    
<a name="enhanced-binding"></a>
### 3.2. Enhanced Binding (B)

**URI:** `http://id.swedenconnect.se/id-binding/level/enhanced`

**Description:** In addition to meeting all the requirements for basic level, 
the binding can be endorsed with a higher confidence when the process 
`http://id.swedenconnect.se/id-binding/process/nordicid` ([4.3](#nordic-id-in-population-register)) 
can match attribute in the assertion from eIDAS to a registered Nordic identification number in the Swedish population register.

In summary, following processes must have been applied:
- `http://id.swedenconnect.se/id-binding/process/registered` ([4.1](#essential-matching-population-register))
- `http://id.swedenconnect.se/id-binding/process/populationregister` ([4.2](#elevated-matching-population-register))
- `http://id.swedenconnect.se/id-binding/process/nordicid` ([4.3](#nordic-id-in-population-register))
    
<a name="verified-binding"></a>
### 3.3. Verified Binding (C)

**URI:** `http://id.swedenconnect.se/id-binding/level/verified`

**Description:** A mix of processes must be applied in order to achieve the 
highest level of confidence in record matching. It requires the process `http://id.swedenconnect.se/id-binding/process/registered` ([4.1](#essential-matching-population-register)) combined with one of the following processes:
- `http://id.swedenconnect.se/id-binding/process/swedish-eid` ([4.4](#use-of-swedish-eid))
- `http://id.swedenconnect.se/id-binding/process/relative` ([4.5](#confirmed-by-relative))
- `http://id.swedenconnect.se/id-binding/process/iddoc-scanning` ([4.6](#passport-or-id-card-scanning))
    
<a name="identity-binding-processes"></a>
## 4. Identity Binding Processes

This section contains a detailed description of the matching processes that
are used by the Identity Binding Service. Each process is identified with an URI.

> Note: The process URI:s are not part of a resulting SAML assertion. However, they will
be stored in matching records and log entries.

<a name="essential-matching-population-register"></a>
### 4.1. Essential Matching of Record in the Population Register

**URI:** `http://id.swedenconnect.se/id-binding/process/registered`

**Description:** A record based on the identification number provided by the end-user 
is found in the Swedish pouplation register. It belongs to a living natural person and 
the value for birthday in record is matched to the birthday attribute from eIDAS. 

<a name="elevated-matching-population-register"></a>
### 4.2. Elevated Matching of Record in the Population Register

**URI:** `http://id.swedenconnect.se/id-binding/process/populationregister`

**Description:** Name attributes from eIDAS is matched to record in population register. 
Population register show that person has emigrated and doesn't live in Sweden. A wide 
search in population register show that there are no other records found with the 
same birthday and name, thus decision for record matching can be made unambiguously.

<a name="nordic-id-in-population-register"></a>
### 4.3. Nordic Identification Number Found in the Population Register

**URI:** `http://id.swedenconnect.se/id-binding/process/nordicid`

**Description:** Record in population register contains an identification number from 
other Nordic country and this number can be found in the assetion from eIDAS. 

<a name="use-of-swedish-eid"></a>
### 4.4. Use of Swedish eID

**URI:** `http://id.swedenconnect.se/id-binding/process/swedish-eid`

**Description:** The end-user, who has been authenticated with a foreign eID, can 
prove binding to the Swedish identity number by signing a confirmation with 
her/his Swedish eID.

**Additional requirements:** Assurance for the Swedish eID must be minimum at 
level 3 in accordance of the 
[Swedish Trust Framework](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation) 
(a.k.a. [Tillitsramverk för 
Svensk e-legitimation](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation)). 
Using eID for this purpose must also be approved by the 
eID provider.
    
<a name="confirmed-by-relative"></a>
### 4.5. A Relative to End-user has Confirmed the Binding

**URI:** `http://id.swedenconnect.se/id-binding/process/relative`

**Description:** A relative to the end-user, can log in with her/his Swedish eID 
and verify binding by signing a confirmation. Relationship must be official and 
findable in the Swedish population register. Example of relationship is husband, 
wife, parent and child. 

**Additional requirements:** Relative must be at least 18 years old and have a 
Swedish eID that meet same requirements as in section [4.2](#use-of-swedish-eid) above.

<a name="passport-or-id-card-scanning"></a>
### 4.5. Passport or ID-card Scanning

**URI:** `http://id.swedenconnect.se/id-binding/process/iddoc-scanning`

**Description:** The end-user, who has been authenticated with a foreign eID, can 
prove binding to the Swedish identity number by reading chip from a Swedish 
identity document, such as passport or ID-card.

<a name="versions"></a>
## 5. Versions

- 2023-04-24: First draft version
- 2023-06-08: Revision of draft

