
<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Binding of eIDAS Identities to Records in the Swedish Population Register

### 2024-05-08

This document contains information about the processes that bind a Swedish identification number to an eIDAS notified eID.

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (DIGG)</a>, 
2023-2024. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

2. [**The Identity Binding Service**](#the-identity-binding-service)

    2.1. [Making a Binding](#making-a-binding)
    
    2.2. [eIDAS-node Queries](#eidas-node-queries)
    
3. [**Identity Binding Processes**](#identity-binding-processes)

    3.1. [Unique Record in the Population Register](#population-register)
    
    3.2. [Nordic Identification Number Corresponding to Population Register Record](#nordic-id)

    3.3. [Use of Swedish eID](#user-with-swedish-eid)
    
    3.4. [Relative Confirms Binding](#confirmed-by-relative)
 
4. [**Versions**](#versions)
    
<a name="introduction"></a>
## 1. Introduction

In Sweden, public relying parties commonly utilize the Swedish personal identity number (a.k.a. personnummer) or the Swedish coordination number (a.k.a. samordningsnummer) as the primary identifier for authorizing authenticated users. However, these identifiers are not part of an eIDAS assertion and can't be received from another country, even if the user holds such as Swedish identity number.

By utilizing the Sweden Connect Identity Binding Service, end-users can associate their eIDAS eID with their record in the Swedish population register. This process enables end-users to access a broader range of Swedish digital services. 


<a name="the-identity-binding-service"></a>
## 2. The Identity Binding Service

The Identity Binding Service is a part of the Swedish eIDAS infrastructure. It supports users with eIDAS-notified eIDs by facilitating binding processes, allowing them to link their eID to a record in the Swedish population register.

Once records are successfully associated to the user's eID, this identity binding can be leveraged by the Swedish eIDAS node when an end-user attempts to log in to a Swedish digital service using their foreign eID. The resulting assertion provided to the relying party includes attributes from eIDAS, as well as attributes 
from the Identity Binding Service.

The Identity Binding Service can be used by end-users, who are authenticated through eIDAS under specific conditions:

- The end-user must have a registered record in terms of Swedish personal identity number (a.k.a. personnummer) or Swedish coordination number (a.k.a. samordningsnummer) in the Swedish population register.
- The end-user must opt to associate this record to his or hers eIDAS notified eID.

Once an end-user's Swedish record is linked to hir or her foreing eID, the Swedish eIDAS node can include this information in the assertion provided to the relying party.


<a name="making-a-binding"></a>
### 2.1. Making a Binding

A user can make an identity binding through various [Identity Binding Processes](#identity-binding-processes). These processes are run independently or in combination, aimed at achieving a clear and unambiguous identity binding.
    
<a name="eidas-node-queries"></a>
### 2.2. eIDAS-node Queries

The identity bindings that are created and stored by the end-user in a private area of the Identity Binding service can be accessible from the Swedish eIDAS node through a query API. 

During a process of eIDAS authentication, the Swedish eIDAS node will use this API to check for a binding between the attributes presented in the assertion received from the eIDAS node outside Sweden. If such a binding exists, two attributes will be included in the resulting assertion provided to the Swedish relying 
party (service provider). These attributes are:

- `urn:oid:1.2.752.201.3.16` (mappedPersonalIdentityNumber) - Contains the Swedish
personal identity number that is associated to the eIDAS identity.

- `urn:oid:1.2.752.201.3.6` (personalIdentityNumberBinding) - Contains URI:s that represents the [Identity Binding Processes](#identity-binding-processes).

See also sections 2.5, "eIDAS Natural Person Attribute Set", and 3.3.2, "The mappedPersonalIdentityNumber and personalIdentityNumberBinding Attributes", of [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/updates/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html) for more information about attribute release during an eIDAS authentication.

    
<a name="identity-binding-processes"></a>
## 3. Identity Binding Processes

This section contains a detailed description of the matching processes that are used by the Identity Binding Service. Each process is identified with an URI.

The prerequisites for all bindings described below are the following: The end-user has been authenticated using a foreign eID. Attributes provided via eIDAS, along with the end-user's statement of her/his Swedish identity number, meet the prerequisites for user registration. This verification includes:

- confirming the record in the Swedish population register,
- ensuring it belongs to a living natural person,
- validating that attribute values from eIDAS assertion correspond to the date of birth and names registered in the record. 

Moreover, the end-user has accepted the terms of use and created a private storage in the Identity Binding Service.

**Note:** If the above steps uniquely corresponds to exactly one record in the Swedish population register, the binding `http://id.swedenconnect.se/id-binding/process/populationregister` ([3.1](#population-register)) will be created, but, if the birth date and name information from the eIDAS assertion matches more than one record from the population register, other processes (as described below) need to be applied for a binding to be completed.

<a name="population-register"></a>
### 3.1. Unique Record in the Population Register

**URI:** `http://id.swedenconnect.se/id-binding/process/populationregister`

**Description:** The provided date of birth and name information from the eIDAS assertion uniquely matches only one record in the population register. 

A detailed search in the population register confirms that there is a low risk of confusion, with no other records found that could potentially lead to ambiguity. The end-user holds a 
machine-readable copy of the record retrieved from the Swedish population register. It is stored in the user's private storage and can be securely bound to end-user's eID in an unambiguous manner.

<a name="nordic-id"></a>
### 3.2. Nordic Identification Number Corresponding to Population Register Record

**URI:** `http://id.swedenconnect.se/id-binding/process/nordicid`

**Description:** The end-user holds a machine-readable copy of the record retrieved from the Swedish population register. This record includes an identification number from a Nordic country, which corresponds to the number found in the eIDAS assertion.

<a name="user-with-swedish-eid"></a>
### 3.3. Use of Swedish eID

**URI:** `http://id.swedenconnect.se/id-binding/process/swedish-eid`

**Description:** The end-user has digitally signed an attestation connecting an eIDAS identity number to a record retrieved from the Swedish population register using a Swedish eID. Using this process the user proves the he or she holds both the eIDAS identity (received from the eIDAS authentication) and the Swedish identity number (received from the digital signature).

**Additional requirements:** Assurance level for the eID must be minimum at level 3 in accordance of the 
[Swedish Trust Framework](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation) 
(a.k.a. [Tillitsramverk för Svensk e-legitimation](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation)). 
Using the eID for this purpose must also be approved by the eID provider.
    
<a name="confirmed-by-relative"></a>
### 3.4. Relative Confirms Binding

**URI:** `http://id.swedenconnect.se/id-binding/process/relative`

**Description:** A relative of the end-user logs in to the Identity Binding Service and vouches for the end-user to retrieve a machine-readable copy of the record from the Swedish population register. The relative digitally signs this attestation.

The relationship must be officially registered in the Swedish population register, and valid examples of such relationships include spouses, parents, and children.

**Additional requirements:** The relative must be at least 18 years old and use an eID that meets the same requirements as in section [3.3](#user-with-swedish-eid) above.


<a name="versions"></a>
## 4. Versions

- 2024-05-08: Updated according to the latest legal agreements. The binding level is no longer used. Instead a set of identity binding process URL:s represent the binding.

- 2023-06-09: First version.

