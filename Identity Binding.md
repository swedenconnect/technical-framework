
<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Binding eIDAS Identities to Records in the Swedish Population Register

### 2024-11-22

Registration number: **2024-7672**

This document outlines the process for binding an eIDAS-notified electronic identity (eID) to an individual's personal identification number in the Swedish Population Register.

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (Digg)</a>, 
2023-2024. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

2. [**The Identity Binding Service**](#the-identity-binding-service)

    2.1. [Making a Binding](#making-a-binding)
    
    2.2. [eIDAS-node Queries](#eidas-node-queries)
    
3. [**Identity Binding Processes**](#identity-binding-processes)

    3.1. [Unique Record in the Population Register](#population-register)
    
    3.2. [Use of Swedish eID](#user-with-swedish-eid)
 
4. [**Versions**](#versions)
    
<a name="introduction"></a>
## 1. Introduction

In Sweden, public relying parties frequently use the Swedish personal identity number (a.k.a. personnummer) or the Swedish coordination number (a.k.a. samordningsnummer) as the primary identifier for authorizing authenticated users. However, these identifiers are not included in eIDAS assertions and can not be received from another country, even if the user holds such as Swedish identity number.

By utilizing the Sweden Connect Identity Binding Service, users can bind their eIDAS eID to their record in the Swedish population register. This process is aimed at supporting users to access a broader range of Swedish digital services, enhancing cross-border digital interactions.

<a name="the-identity-binding-service"></a>
## 2. The Identity Binding Service

The Identity Binding Service is a part of the Swedish eIDAS infrastructure. It supports users with eIDAS-notified eID:s to bind their eID to a record in the Swedish population register.

Once the binding is successfully completed, the Swedish eIDAS node can deliver this association when the user logs in to a Swedish digital service using their foreign eID. The assertion provided to the relying party includes both attributes from eIDAS eID and the Identity Binding Service.

To use the Identity Binding Service, the following conditions must be met:

- The ser must have a registered record in the Swedish Population Register, either as a Swedish personal identity number (a.k.a. personnummer) or Swedish coordination number (a.k.a. samordningsnummer).

- The user must choose to bind this record to his or hers eIDAS-notified eID.

Once a user's Swedish record is bound to their foreign eID, the Swedish eIDAS node can include this information in assertions provided to Swedish relying parties.

<a name="making-a-binding"></a>
### 2.1. Making a Binding

A user can make an identity binding through various [Identity Binding Processes](#identity-binding-processes). These processes are run independently or in combination, aimed at achieving a clear and unambiguous identity binding.
    
<a name="eidas-node-queries"></a>
### 2.2. eIDAS-node Queries

The identity bindings created by the user are stored in a private storage area. This private area is accessible only to the user and, with explicit user consent, to the Swedish eIDAS node through a protected query API.

During the eIDAS authentication process, the Swedish eIDAS node will, with the user's consent, use this API to check for a binding between the attributes presented in the assertion received from another member state's eIDAS node. If such a binding exists, an attribute set will be included in the resulting assertion provided to the Swedish relying party (service provider). These attribute set includes the following attributes:

- `urn:oid:1.2.752.201.3.16` (mappedPersonalIdentityNumber) - Contains the Swedish personal identity number that is associated to the eIDAS identity.

- `urn:oid:1.2.752.201.3.6` (personalIdentityNumberBinding) - Contains URI:s that represents the [Identity Binding Processes](#identity-binding-processes).

See also sections 2.5, "eIDAS Natural Person Attribute Set", and 3.3.2, "The mappedPersonalIdentityNumber and personalIdentityNumberBinding Attributes", of [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/updates/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html) for more information about attribute release during an eIDAS authentication.
    
<a name="identity-binding-processes"></a>
## 3. Identity Binding Processes

This section contains a detailed description of the binding processes that are used by the Identity Binding Service. Each process is identified with a URI.

To perform the identity binding process, a user must meet the following requirements:

- The user must be authenticated using an eIDAS eID at an assurance level of Substantial or High.

- The combination of attributes from the eIDAS assertion and the data returned from the Swedish Population Register, based on the user's declaration of their Swedish identity number, must meet the following criteria:

    - The record in the Swedish Population Register must exist,
    - the record must belong to living natural person, and,
    - the attribute values from eIDAS assertion must correspond with the date of birth and names registered in the record.

- The user must accept the terms of use and consent to creation of a private storage area that belongs to the user.

**Note:** If the above steps uniquely corresponds to exactly one record in the Swedish population register, the binding `http://id.swedenconnect.se/id-binding/process/populationregister` ([3.1](#population-register)) will be created, but, if the birthdate and name information from the eIDAS assertion matches more than one record from the population register, other processes (as described below) need to be applied for a binding to be completed.

<a name="population-register"></a>
### 3.1. Unique Record in the Population Register

**URI:** `http://id.swedenconnect.se/id-binding/process/populationregister`

**Description:** The provided date of birth and name information from the eIDAS assertion uniquely matches one, and exactly one, record in the population register. 

A detailed search in the population register confirms that there is a low risk of confusion, with no other records found that could potentially lead to ambiguity. The end-user holds a machine-readable copy of the record retrieved from the Swedish population register. It is stored in the user's private storage and can be securely bound to user's eID in an unambiguous manner.

<a name="user-with-swedish-eid"></a>
### 3.2. Use of Swedish eID

**URI:** `http://id.swedenconnect.se/id-binding/process/swedish-eid`

**Description:** The user has digitally signed an attestation connecting an eIDAS identity number to a record retrieved from the Swedish population register using a Swedish eID. Using this process the user proves that he or she holds both the eIDAS identity (received from the eIDAS-notified eID) and the Swedish identity number (received from the digital signature).

**Additional requirements:** Assurance level for the Swedish eID must be minimum at level 3 in accordance of the [Swedish Trust Framework](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation) (a.k.a. [Tillitsramverk för Svensk e-legitimation](https://www.digg.se/digitala-tjanster/e-legitimering/tillitsnivaer-for-e-legitimering/tillitsramverk-for-svensk-e-legitimation)). Using the eID for this purpose must also be approved by the eID provider.

<a name="versions"></a>
## 4. Versions

- 2024-11-22: Updated version where the bindings for Nordic eID:s and relative confirmation were removed due to legal reasons.

- 2024-05-08: Updated according to the latest legal agreements. The binding level is no longer used, instead a set of identity binding process URL:s represent the binding.

- 2023-06-09: First version.
