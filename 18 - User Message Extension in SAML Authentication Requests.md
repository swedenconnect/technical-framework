<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# User Message Extension in SAML Authentication Requests

### Version 1.0 - 2024-12-04

Registration number: **2024-7673**

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (Digg)</a>, 2015-2024. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Requirements Notation](#requirements-notation)

    1.2. [XML Namespace References](#xml-namespace-references)

    1.3. [Structure](#structure)

2. [**Data elements**](#data-elements)

3. [**Usage Requirements**](#usage-requirements)

    3.1. [Identity Provider Requirements](#identity-provider-requirements)
    
    3.2. [Service Provider Requirements](#service-provider-requirements)

4. [**Examples**](#examples)
 
5. [**Schemas**](#schemas)

6. [**Normative References**](#normative-references)

7. [**Changes between versions**](#changes-between-versions)

<a name="introduction"></a>
## 1. Introduction

When a Service Provider requests authentication of a user, the Service Provider may want to pass a message along for the user to see during the authentication phase at the Identity Provider. Normally, an Identity Provider displays information about the requesting Service Provider for the user based on the registered presentation data from the SP's SAML metadata entry. This information is static and its purpose is to show for the user that he or she is still in the context of the Service Provider.

By using dynamic user messages to be displayed at the Identity Provider side (possibly in an authentication device such as a mobile phone), the Service Provider may further strengthen the coupling to its current context. Examples of messages can be information about the purpose of the authentication or warnings and prompts for the user to not authenticate based on another person's request. 

This specification defines the `<umsg:UserMessage>` element that may be included in the `<saml2p:Extensions>` element of a SAML `<saml2p:AuthnRequest>` where the requesting Service Provider can specify a message text that is to be displayed by the Identity Provider during the user authentication process.

<a name="requirements-notation"></a>
### 1.1. Requirements Notation

The keywords **MUST**, **MUST** **NOT**, **REQUIRED**, **SHALL**,
**SHALL** **NOT**, **SHOULD**, **SHOULD** **NOT**, **RECOMMENDED**,
**MAY**, and **OPTIONAL** are to be interpreted as described in
\[[RFC2119](#rfc2119)\].

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behaviour that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.

<a name="xml-namespace-references"></a>
### 1.2. XML Namespace References

The prefix **umsg:** stands for the User Message Extension XML schema namespace `http://id.swedenconnect.se/authn/1.0/user-message/ns`. 

The prefix **saml2:** stands for the OASIS SAML 2 Assertion schema namespace `urn:oasis:names:tc:SAML:2.0:assertion`.

The prefix **saml2p:** stands for the OASIS SAML 2 Protocol schema namespace `urn:oasis:names:tc:SAML:2.0:protocol`.

The prefix **md:** stands for the OASIS SAML 2 Metadata schema namespace `urn:oasis:names:tc:SAML:2.0:metadata`.

<a name="structure"></a>
### 1.3. Structure

This specification uses the following typographical conventions in text:
`<LocalElement>`, `<ns:ForeignElement>`, `Attribute`, **Datatype**,
`OtherCode`.

<a name="data-elements"></a>
## 2. Data elements

This specification defines the element `<UserMessage>` to be included in the `<Extensions>` element of an `AuthnRequest`. 

This element MAY included by a Service Provider asking the Identity Provider to display a given message for the user during the authentication phase. The element has the following elements and attributes:

`<Message>` \[One or more\]
> Element that holds the user message for a specific language. See below.

`mimeType`
> The MIME type for the text contained in all `Message` elements. This specification defines two possible values that are `text/plain` (where ;charset=UTF-8 is an implicit condition) and `text/markdown`<sup>1</sup>. If no value is given for this field, `text/plain` MUST be assumed. Other profiles MAY add support for additional MIME types.

The following schema fragment defines the `<UserMessage>` element:

```
<xs:element name="UserMessage" type="umsg:UserMessageType"/>

<xs:complexType name="UserMessageType">
  <xs:sequence>
    <xs:element name="Message" type="umsg:MessageType" minOccurs="1" maxOccurs="unbounded"/>
  </xs:sequence>
  <xs:attribute name="mimeType" type="xs:string" default="text/plain">
    <xs:annotation>
      <xs:documentation>The format of the user message(s)</xs:documentation>
    </xs:annotation>
  </xs:attribute>
  <xs:anyAttribute namespace="##any" processContents="lax"/>
</xs:complexType>
```

The `<Message>` element is defined by the following schema definition:

```
<xs:complexType name="MessageType">
  <xs:simpleContent>
    <xs:extension base="xs:base64Binary">
      <xs:attribute ref="xml:lang" use="required"/>
      <xs:anyAttribute namespace="##any" processContents="lax"/>
    </xs:extension>
  </xs:simpleContent>
</xs:complexType>
```

The `<Message>` element contains the Base64-encoding of the UTF-8 string holding the message to display to the user for a specific language.

The required `xml:lang` attribute contains the language tag for the message's language according to \[[BCP47](#bcp47)\].

> **\[1\]**: The Markdown dialect, and potential restrictions for tags, is not regulated in this specification. However, the Markdown SHOULD NOT contain HTML-tags for security reasons.

<a name="usage-requirements"></a>
## 3. Usage Requirements

<a name="identity-provider-requirements"></a>
### 3.1. Identity Provider Requirements

An Identity Provider that supports the `<umsg:UserMessage>` extension MUST declare this support in its metadata entry by declaring the `http://id.swedenconnect.se/general-ec/1.0/supports-user-message` entity category (see section 6.3 of \[[SC.SAML.EntCat](#sc-saml-entcat)\]).

Identity Providers compliant with this specification MUST support the `text/plain` and `text/markdown` MIME types.

An OpenID Provider MUST NOT display a user message unless the user is being authenticated. Thus, if the `IsPassive`-flag of the authentication request is set to `true`, the Identity Provider MUST NOT display the user message.

An Identity Provider that receives a `<umsg:UserMessage>` extension containing user messages in several languages SHOULD display the message that best matches the user's current locale at the Identity Provider. If no message matches the user's current locale, the Identity Provider SHOULD select the first message from the list.

An Identity Provider MUST refuse to display a message if it does not support a given MIME type. It MAY respond with an error if a non-supported MIME type is received.

Should a message contain illegal characters, or any other constructs not accepted by the Identity Provider, the Identity Provider MAY choose not to display the message, or filter the message before displaying it.

The Identity Provider MUST be able to handle messages containing line breaks.

<a name="service-provider-requirements"></a>
### 3.2. Service Provider Requirements

A Service Provider SHOULD check whether an Identity Provider supports the `<umsg:UserMessage>` extension before including it in a `<saml2p:AuthnRequest>` element. This is done by checking the Identity Provider metadata entry for the presence of the `http://id.swedenconnect.se/general-ec/1.0/supports-user-message` entity category (see [3.1](#identity-provider-requirements) above).

A Service Provider MUST NOT supply user messages that contains integrity sensitive information. The message will be displayed for the user **before** he or she is authenticated.

<a name="examples"></a>
## 4. Examples

Example of supplying a user message in Swedish ("Jag vill logga in till example.com") and in
English ("I wish to login to example.com"):

```
...
<saml2p:Extensions>
  <umsg:UserMessage xmlns:umsg="http://id.swedenconnect.se/authn/1.0/user-message/ns"
                    mimeType="text/plain">
    <umsg:Message xml:lang="sv">
      SmFnIHZpbGwgbG9nZ2EgaW4gdGlsbCBleGFtcGxlLmNvbQ==
    </umsg:Message>
    <umsg:Message xml:lang="en">
      SSB3aXNoIHRvIGxvZ2luIHRvIGV4YW1wbGUuY29t
    </umsg:Message>
  </umsg:UserMessage>
</saml2p:Extensions>
...
```

<a name="schemas"></a>
## 5. Schemas

The following XML schema defines the `http://id.swedenconnect.se/authn/1.0/user-message/ns` namespace:

```
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
           targetNamespace="http://id.swedenconnect.se/authn/1.0/user-message/ns"
           xmlns:umsg="http://id.swedenconnect.se/authn/1.0/user-message/ns">

  <xs:import namespace="http://www.w3.org/XML/1998/namespace" schemaLocation="http://www.w3.org/2001/xml.xsd"/>

  <xs:annotation>
    <xs:documentation>
      Schema location URL: https://docs.swedenconnect.se/schemas/authn/1.0/UserMessage-1.0.xsd
    </xs:documentation>
  </xs:annotation>

  <xs:element name="UserMessage" type="umsg:UserMessageType"/>

  <xs:complexType name="UserMessageType">
    <xs:annotation>
      <xs:documentation>List of user messages (in different languages)</xs:documentation>
    </xs:annotation>
    <xs:sequence>
      <xs:element name="Message" type="umsg:MessageType" minOccurs="1" maxOccurs="unbounded"/>
    </xs:sequence>
    <xs:attribute name="mimeType" type="xs:string" default="text/plain">
      <xs:annotation>
        <xs:documentation>The MIME type of the user message(s)</xs:documentation>
      </xs:annotation>
    </xs:attribute>
    <xs:anyAttribute namespace="##any" processContents="lax"/>
  </xs:complexType>

  <xs:complexType name="MessageType">
    <xs:annotation>
      <xs:documentation>
        The Base64-encoding of UTF-8 string holding the user message.
      </xs:documentation>
    </xs:annotation>
    <xs:simpleContent>
      <xs:extension base="xs:base64Binary">
        <xs:attribute ref="xml:lang" use="required"/>
        <xs:anyAttribute namespace="##any" processContents="lax"/>
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>

</xs:schema>
```

<a name="normative-references"></a>
## 6. Normative References

<a name="rfc2119"></a>
**\[RFC2119\]**
> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="bcp47"></a>
**\[BCP47\]**
> [Tags for Identifying Languages, September 2009](https://www.rfc-editor.org/rfc/rfc5646.txt).

<a name="saml2core"></a>
**\[SAML2Core\]**
> [OASIS Standard, Assertions and Protocols for the OASIS Security
> Assertion Markup Language (SAML) V2.0, March
> 2005](http://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf).

<a name="sc-saml-entcat"></a>
**\[SC.SAML.EntCat\]**
> [Entity Categories for the Swedish eID Framework](https://docs.swedenconnect.se/technical-framework/updates/06_-_Entity_Categories_for_the_Swedish_eID_Framework.html).

<a name="changes-between-versions"></a>
## 7. Changes between versions

This is the first version of this specification.
