<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# Binding of eIDAS Attributes to Swedish Personal Identity Numbers

### 2023-04-24 (draft)

This document contains information about the identity binding process where 
an identity received from an eIDAS assertion is bound to a Swedish personal
identity number.

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

    4.1. [Matching Against the Population Register](#matching-against-the-population-register)
    
    4.2. [Use of Swedish eID](#use-of-swedish-eid)
    
    4.3. [Attestation from Relative](#attestation-from-relative)
    
    4.4. [Foreign Identity Present in the Population Register](#foreign-identity-present-in-the-population-register)

    4.5. [Passport or ID-card Scanning](#passport-or-id-card-scanning)
    
5. [**Versions**](#versions)
    
<a name="introduction"></a>
## 1. Introduction

This document contains information about the identity binding process where 
an identity received from an eIDAS assertion is bound to a Swedish personal
identity number.

> TODO: more ...

<a name="the-identity-binding-service"></a>
## 2. The Identity Binding Service

The process, or processes, of binding a foreign identity to a Swedish personal identity
number is the responsibility of the Identity Binding service.  

> TODO: Include links to https://elegitimation.se and other resources where we describe
the ID-matching service.

<a name="making-a-binding"></a>
### 2.1. Making a Binding

> TODO: A short description of the web-service that the user logs in to and makes the
binding. No details, we just need to mention that such a service exists.
    
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
represents the "binding level", see [section 3, "Identity Binding Levels"](#identity-binding-levels) below.

See sections 2.5, "eIDAS Natural Person Attribute Set", and 3.3.2, "The mappedPersonalIdentityNumber and personalIdentityNumberBinding Attributes", of [Attribute Specification for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/updates/04_-_Attribute_Specification_for_the_Swedish_eID_Framework.html) for more information
about attribute release during an eIDAS authentication.

<a name="identity-binding-levels"></a>
## 3. Identity Binding Levels

An identity binding that connects a foreign identity with a Swedish personal identity number ("personnummer" or "samordningsnummer") can be made using different processes. These processes
are of different strength, and the trustworthiness of a binding is therefore determined by
an "Identity Binding Level".

This section defines the three levels that are used to represent this trustworthiness and
a relying party should decide the required level based on the security requirements of the service. 

<a name="basic-binding"></a>
### 3.1. Basic Binding

**URI:** `http://id.swedenconnect.se/id-binding/level/basic`

**Description:** A basic binding where the identity attributes received from the foreign
eIDAS-node matches an individual's record in the population register.

The process `http://id.swedenconnect.se/id-binding/process/populationregister` 
([4.1](#matching-against-the-population-register)) must have been applied.

    
<a name="enhanced-binding"></a>
### 3.2. Enhanced Binding

**URI:** `http://id.swedenconnect.se/id-binding/level/enhanced`

**Description:** Enhanced binding. Apart from meeting all requirements for the basic level, the binding has been strengthened with additional steps. 

The process `http://id.swedenconnect.se/id-binding/process/populationregister` 
([4.1](#matching-against-the-population-register)) must have been applied as well
as at least one of the following processes:

- `http://id.swedenconnect.se/id-binding/process/relative` ([4.3](#attestation-from-relative))
    
<a name="verified-binding"></a>
### 3.3. Verified Binding

**URI:** `http://id.swedenconnect.se/id-binding/level/verified`

**Description:** Verified binding. The binding has been verified with strong and trustworthy processes as listed below:

The process `http://id.swedenconnect.se/id-binding/process/populationregister` must have
been applied as well as at least one of the following processes:

- `http://id.swedenconnect.se/id-binding/process/swedish-eid` ([4.2](#use-of-swedish-eid))

- `http://id.swedenconnect.se/id-binding/process/presentbinding` ([4.4](#foreign-identity-present-in-the-population-register))

- `http://id.swedenconnect.se/id-binding/process/iddoc-scanning` ([4.5](#passport-or-id-card-scanning))
    
<a name="identity-binding-processes"></a>
## 4. Identity Binding Processes

This section contains a detailed description of the processes of binding identities that
are possible to perform. Each process is identified with a URI.

> Note: The process URI:s are not part of a resulting SAML assertion. However, they will
be stored in matching records and log entries.

<a name="matching-against-the-population-register"></a>
### 4.1. Matching Against the Population Register

**URI:** `http://id.swedenconnect.se/id-binding/process/populationregister`

**Description:** ...

> TODO: Based on the matching in Navet, there can be different strengths on this
matching. Should we have several URI:s? I suggest that we don't since it will be
too much to handle.

<a name="use-of-swedish-eid"></a>
### 4.2. Use of Swedish eID

**URI:** `http://id.swedenconnect.se/id-binding/process/swedish-eid`

**Description:** The individual making a binding holds an approved<sup>1</sup> Swedish 
eID that is used to sign an attestation of the correctness of the binding.

TODO: more

> **\[1\]:** The Swedish eID must .... (Svensk e-legitimation, godkänd av DIGG) ...
    
<a name="attestation-from-relative"></a>
### 4.3. Attestation from Relative

**URI:** `http://id.swedenconnect.se/id-binding/process/relative`

**Description:** A relative to the person making the binding uses an approved
Swedish eID (see [4.2](#use-of-swedish-eid) above) to attest the correctness
of the binding.

> Note: Only relationships registered in the Swedish population register will
be allowed.

<a name="foreign-identity-present-in-the-population-register"></a>
### 4.4. Foreign Identity Present in the Population Register

**URI:** `http://id.swedenconnect.se/id-binding/process/presentbinding`

**Description:** For some countries a foreign personal identity number may be
present in the Swedish population register. More ...

<a name="passport-or-id-card-scanning"></a>
### 4.5. Passport or ID-card Scanning

**URI:** `http://id.swedenconnect.se/id-binding/process/iddoc-scanning`

**Description:** A passport ...

<a name="versions"></a>
## 5. Versions

- 2023-04-24: First draft version


