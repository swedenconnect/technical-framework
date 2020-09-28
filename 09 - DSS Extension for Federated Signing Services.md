<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# DSS Extension for Federated Central Signing Services

### Version 1.4 - 2020-09-28 - *Draft version*

Registration number: **2019-314** (*previously: ELN-0609*)

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (DIGG)</a>, 2015-2020. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Terminology](#terminology)

    1.1.1. [Key words](#key-words)

    1.1.2. [Structure](#structure)

    1.1.3. [Definitions](#definitions)

    1.2. [Schema Organization and Namespaces](#schema-organization-and-namespaces)

    1.3. [Common Data Types](#common-data-types)

    1.3.1. [String values](#string-values)

    1.3.2. [URI Values](#uri-values)

    1.3.3. [Time Values](#time-values)

    1.3.4. [MIME Types for &lt;dss:TransformedData&gt;](#mime-types-for-dsstransformeddata)

2. [**Common Protocol Structures**](#common-protocol-structures)

    2.1. [Type AnyType](#type-anytype)

3. [**Federated Signing DSS Extensions**](#federated-signing-dss-extensions)

    3.1. [Element &lt;SignRequestExtension&gt;](#element-signrequestextension)

    3.1.1. [Type CertRequestPropertiesType](#type-certrequestpropertiestype)

    3.1.1.1. [Type RequestedAttributesType](#type-requestedattributestype)

    3.1.2. [Element &lt;SignMessage&gt;](#element-signmessage)

    3.2. [Element &lt;SignResponseExtension&gt;](#element-signresponseextension)

    3.2.1. [Type SignerAssertionInfoType](#type-signerassertioninfotype)

    3.2.1.1. [Type ContextInfoType](#type-contextinfotype)

    3.2.1.2. [Type SAMLAssertionsType](#type-samlassertionstype)

    3.2.2. [Type CertificateChainType](#type-certificatechaintype)

4. [**Extensions to &lt;dss:InputDocuments&gt; and &lt;dss:SignatureObject&gt;**](#extensions-to-dssinputdocuments-and-dsssignatureobject)

    4.1. [Element &lt;SignTasks&gt;](#element-signtasks)

    4.1.1. [Element &lt;SignTaskData&gt;](#element-signtaskdata)

    4.1.1.1. [Type AdESObjectType](#type-adesobjecttype)

5. [**Signing Sign Requests and Responses**](#signing-sign-requests-and-responses)

6. [**Normative References**](#normative-references)

7. [**Changes between versions**](#changes-between-versions)

Appendix A. [**XML Schema**](#appendix-a.xml-schema)

<a name="introduction"></a>
## 1. Introduction

This specifications defines elements that extend the
`<dss:SignRequest>` and `<dss:SignResponse>` elements of
\[[OASIS-DSS](#dss)\].

One element `<SignRequestExtension>` is defined for extending sign
requests and one element `<SignResponseExtension>` is defined for
extending sign responses. The `<SignTasks>` element extends the
`<dss:InputDocuments>` element of sign requests and
`<dss:SignatureObject>` element of sign responses.

These extensions to the DSS protocols provide essential protocol
elements in a scenario where:

-   The user's signature is requested by a service with which the user
    has an active session and where this service has authenticated the
    user using a SAML assertion.

-   The service provider holds the data to be signed.

-   The central signing service is requested to authenticate the user
    with the same Identity Provider that was used to authenticate the
    user to the Service Provider.

This particular use case is relevant when a user logs in to a service
using a federated identity, where the user at some point is required to
sign some data such as a tax declaration or payment transaction. The
user is forwarded to the signing service together with a sign request
from the Service Provider, specifying the information to be signed
together with the conditions for signing. After completed signing, the
user is returned to the Service Provider together with a sign response
from which the Service Provider can assemble a complete signed document,
signed by the user.

This scenario requires more information in both sign requests and sign
responses than the original DSS core standard provides, and it also
requires the capability to let the service provider sign the sign
request.

<a name="terminology"></a>
### 1.1. Terminology

<a name="key-words"></a>
#### 1.1.1.  Key words

The key words *MUST*, *MUST NOT*, *REQUIRED*, *SHALL*, *SHALL NOT*,
*SHOULD*, *SHOULD NOT*, *RECOMMENDED*, *MAY*, and *OPTIONAL* are to be
interpreted as described in \[[RFC 2119](#rfc2119)\].

These keywords are capitalized when used to unambiguously specify
requirements over protocol features and behavior that affect the
interoperability and security of implementations.

When these words are not capitalized, they are meant in their
natural-language sense.

<a name="structure"></a>
#### 1.1.2. Structure

This specification uses the following typographical conventions in text:
`<ThisSpecifictionElements>`, `<ns:ForeignElement>`, Attribute,
**Datatype**, OtherCode.

Listings of DSS schemas appear like this.

<a name="definitions"></a>
#### 1.1.3.  Definitions

**Identity Provider**

> An Identity Provider that is assigned to authenticate the signer.

**Signing Service**

> A Signing Service that receives sign requests and responds with sign
> responses according to this specification.

**Service Provider**

> A service that has identified the signer through the user's Identity
> Provider and requests that the signer signs some data using the
> Central Signing Service.

<a name="schema-organization-and-namespaces"></a>
### 1.2. Schema Organization and Namespaces

The structures described in this specification are contained in the XML
schema for this protocol \[[Csig-XSD](#csig-xsd)\]. All schema
listings in the current document are excerpts from the complete XML
schema. 

This schema is associated with the following XML namespace:

`http://id.elegnamnden.se/csig/1.1/dss-ext/ns`

Compliance with this specification requires support of the latest version of 
the \[[Csig-XSD](#csig-xsd)\] schema which is 1.1.2.

If a future, non backwards compatible, version of this specification is needed, it will use a
different namespace.

Conventional XML namespace prefixes are used in the schema:

-   The prefix `csig`: stands for the this specification's XML schema
    namespace \[[Csig-XSD](#csig-xsd)\].

-   The prefix `dss`: stands for the DSS core namespace
    \[[OASIS-DSS](#dss)\].

-   The prefix `ds`: stands for the W3C XML Signature namespace
    \[[XMLDSIG](#xmldsig)\].

-   The prefix `xs`: stands for the W3C XML Schema namespace
    \[[Schema1](#schema1)\].

-   The prefix `saml`: stands for the OASIS SAML Schema namespace
    \[[SAML2.0](#saml)\].

-   The prefix `xades`: stands for the ETSI XAdES Schema namespace
    \[[XAdES](#xades)\].

Applications MAY use different namespace prefixes, and MAY use whatever
namespace defaulting/scoping conventions they desire, as long as they
are compliant with the Namespaces in XML specification
\[[XML-ns](#xml-ns)\].

The following schema fragment defines the XML namespaces and other
header information for this specification's core XML schema:

```
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    elementFormDefault="qualified"
    xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
    targetNamespace="http://id.elegnamnden.se/csig/1.1/dss-ext/ns"
    xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dss="urn:oasis:names:tc:dss:1.0:core:schema"
    xmlns:csig="http://id.elegnamnden.se/csig/1.1/dss-ext/ns">
    <xs:import namespace="urn:oasis:names:tc:SAML:2.0:assertion"
        schemaLocation="saml-schema-assertion-2.0.xsd"/>
```

<a name="common-data-types"></a>
### 1.3. Common Data Types

The following sections define how to use and interpret common data types
that appear throughout the specification.

<a name="string-values"></a>
#### 1.3.1. String values

All string values have the type **xs:string**, which is built in to the
W3C XML Schema Datatypes specification \[[Schema2](#schema2)\]. Unless
otherwise noted in this specification or particular profiles, all
strings in this specification MUST consist of at least one
non-whitespace character (whitespace is defined in the XML
Recommendation \[[XML](#xml)\] Section 2.3).

Unless otherwise noted in this specification, all elements that have the
XML Schema **xs:string** type, or a type derived from that, MUST be
compared using an exact binary comparison. In particular,
implementations MUST NOT depend on case insensitive string comparisons,
normalization or trimming of whitespace, or conversion of
locale-specific formats such as numbers or currency. This requirement is
intended to conform to the W3C working-draft Requirements for String
Identity, Matching, and String Indexing \[[W3C-CHAR](https://www.w3.org/TR/WD-charreq/)\].

<a name="uri-values"></a>
#### 1.3.2. URI Values

All SAML URI reference values have the type **xs:anyURI**, which is
built in to the W3C XML Schema Datatypes specification
\[[Schema2](#schema2)\].

Unless otherwise indicated in this specification, all URI reference
values used within defined elements or attributes MUST consist of at
least one non-whitespace character, and are REQUIRED to be absolute
\[[RFC 3986](#rfc3986)\].

Note that this specification makes use of URI references as identifiers,
such as status codes, format types, attribute and system entity names,
etc. In such cases, it is essential that the values be both unique and
consistent, such that the same URI is never used at different times to
represent different underlying information.

<a name="time-values"></a>
#### 1.3.3. Time Values

All time values have the type **xs:dateTime**, which is built in to the
W3C XML Schema Datatypes specification \[[Schema2](#schema2)\], and
MUST be expressed in UTC form, with no time zone component.

Implementations SHOULD NOT rely on time resolution finer than
milliseconds. Implementations MUST NOT generate time instants that
specify leap seconds.

<a name="mime-types-for-dsstransformeddata"></a>
#### 1.3.4. MIME Types for &lt;dss:TransformedData&gt;

The following MIME type is defined for transformed data included in a
`<dss:Base64Data>` element within a `<dss:TransformedData>`
element in a `<dss:SignRequest>`.

**application/cms-signed-attributes**

> This MIME type identifies that the data contained in the
> `<dss:Base64Data>` element, is a DER encoded CMS signed attributes
> structure \[[RFC 5652](#rfc5652)\]. This data is useful when signing
> a PDF document in cases where the whole PDF document is not included
> in the request. The signature on a PDF document is generated by
> signing the hash of a CMS signed attributes structure representing the
> PDF document to be signed. These signed attributes include data that
> a Signing Service may want to check before signing, such as the
> claimed signing time.

<a name="common-protocol-structures"></a>
## 2. Common Protocol Structures

The following sections describe XML structures and types that are used
in multiple places.

<a name="type-anytype"></a>
### 2.1. Type AnyType

The **AnyType** complex type allows arbitrary XML element content within
an element of this type (see section 3.2.1 Element Content
\[[XML](#xml)\]).

```
<xs:complexType name="AnyType">
  <xs:sequence>
    <xs:any processContents="lax" minOccurs="0" maxOccurs="unbounded" />
  </xs:sequence>
</xs:complexType>
```

<a name="federated-signing-dss-extensions"></a>
## 3. Federated Signing DSS Extensions

This section defines elements that extend the `<dss:SignRequest>`
and `<dss:SignResponse>` elements of the DSS Signing Protocol.

<a name="element-signrequestextension"></a>
### 3.1. Element &lt;SignRequestExtension&gt;

The `<SignRequestExtension>` element allows a requesting service to
add essential sign request information to a DSS Sign request. When
present, this element MUST be included in the `<dss:OptionalInputs>`
element in a DSS Sign Request. This element's
**SignRequestExtensionType** complex type includes the following
attributes and elements:

`Version` \[Optional\] (Default `1.1`)

> The version of this specification supported by the sender. If absent, 
> the version value defaults to "1.1". 

> This attribute provides means for the receiving
> service to determine the expected semantics of the request based on the
> protocol version. 

> The receiving service MUST use the same version
> in the resulting response, see [section 3.2](#element-signresponseextension).
> If the receiving service does not support the requested version, the service 
> MUST refuse to process the request and respond with an error message where 
> `<dss:ResultMajor>` is set to `urn:oasis:names:tc:dss:1.0:resultmajor:RequesterError`
> and the `<dss:ResultMinor>` is set to `urn:oasis:names:tc:dss:1.0:resultminor:NotSupported`.

`<RequestTime>` \[Required\]

> The time when this request was created.

`<saml:Conditions>` \[Required\]

> Conditions that MUST be evaluated when assessing the validity of
> and/or when using the Sign Request. See Section 2.5 of
> \[[SAML2.0](#saml)\]for additional information on how to evaluate
> conditions.
>
> This element MUST include the attributes `NotBefore` and `NotOnOrAfter`
> and MUST include the element `<saml:AudienceRestriction>` which in
> turn MUST contain one `<saml:Audience>` element, specifying the
> return URL for any resulting Sign Response message.

`<Signer>` \[Optional\]

> The identity of the signer expressed as a sequence of SAML attributes
> using the **saml:AttributeStatementType** complex type. If this
> element is present, then the Signing Service MUST verify that the
> authenticated identity of the signer is consistent with the attributes
> in this element.

`<IdentityProvider>` \[Required\]

> The SAML entityID of the Identity Provider that MUST be used to
> authenticate the signer before signing. The entitID value is specified
> using the **saml:NameIDType** complex type and MUST include a `Format`
> attribute with the value
> `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`.

`<AuthnProfile>` \[Optional\]

> An opaque string that can be used to inform the Signing Service about specific
> requirements regarding the user authentication at the given Identity Provider (see above).
> This specification does not define any possible values or semantics for the element.

> **Note:** If this element is set, the `Version` attribute of the `SignRequestExtension` element MUST be set to "1.4" or higher. Implementations prior to version 1.4 of this specification do not support the element.

`<SignRequester>` \[Required\]

> The SAML entityID of the service that sends this request to the
> Signing Service. The entityID value is specified using the
> **saml:NameIDType** complex type and MUST include a `Format` attribute
> with the value `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`.

`<SignService>` \[Required\]

> The SAML entityID of the service to which this Sign Request is sent.
> The entityID value is specified using the **saml:NameIDType** complex
> type and MUST include a `Format` attribute with the value
> `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`.

`<RequestedSignatureAlgorithm>` \[Optional\]

> An identifier of the signature algorithm the requesting service
> prefers when generating the requested signature.

`<SignMessage>` \[Optional\]

> Optional sign message with information to the signer about the
> requested signature.

`<CertRequestProperties>` \[Optional\]

> An optional set of requested properties of the signature certificate
> that is generated as part of the signature process.

`<OtherRequestInfo>` \[Optional\]

> Any additional inputs to the request extension.

The following schema fragment defines the `<SignRequestExtension>`
element and its **SignRequestExtensionType** complex type:

```
<xs:element name="SignRequestExtension" type="csig:SignRequestExtensionType" />

<xs:complexType name="SignRequestExtensionType">
  <xs:sequence>
    <xs:element ref="csig:RequestTime" />
    <xs:element ref="saml:Conditions" />
    <xs:element ref="csig:Signer" minOccurs="0" />
    <xs:element ref="csig:IdentityProvider" />
    <xs:element name="AuthnProfile" type="xs:string" minOccurs="0" />
    <xs:element ref="csig:SignRequester" />
    <xs:element ref="csig:SignService" />
    <xs:element ref="csig:RequestedSignatureAlgorithm" minOccurs="0" />
    <xs:element ref="csig:CertRequestProperties" minOccurs="0" />
    <xs:element ref="csig:SignMessage" minOccurs="0" />
    <xs:element ref="csig:OtherRequestInfo" minOccurs="0" />
  </xs:sequence>
  <xs:attribute name="Version" type="xs:string" use="optional" default="1.1" />
</xs:complexType>
```

<a name="type-certrequestpropertiestype"></a>
#### 3.1.1. Type CertRequestPropertiesType

The **CertRequestPropertiesType** complex type is used to specify
requested properties of the signature certificate that is associated
with the generated signature.

The **CertRequestPropertiesType** complex type has the following
attributes and elements:

`CertType` \[Default "PKC"\]

> An enumeration of certificate types, default "PKC". The supported
> values are "PKC", "QC" and "QC/SSCD". "QC" means that the certificate
> is requested to be a Qualified Certificate according to legal
> definitions in national law governing the issuer. "QC/SSCD" means a
> Qualified Certificate where the private key is declared to be residing
> within a Secure Signature Creation Device according to national law.
> "PKC" (Public Key Certificate) means a certificate that is not a
> Qualified Certificate.

`<saml:AuthnContextClassRef>` \[Optional\]

> URI(s) identifying the requested level of assurance that authentication
> of the signature certificate subject MUST comply with in order to
> complete signing and certificate issuance. A Signing Service MUST NOT
> issue signature certificates and generate the requested signature
> unless the authentication process used to authenticate the requested
> signer meets one of the requested level of assurance URI:s expressed 
> in this element. 
>
> If this element is absent, the locally configured policy of
> the Signing Service is assumed. This can either mean that the Signing Service
> includes one or more locally configured URI:s in the `saml:RequestedAuthnContext` element
> of the `saml:AuthnRequest` issued to authenticate the user, or that no 
> `saml:RequestedAuthnContext` element is included in the `saml:AuthnRequest`.
> In the latter case the Signature Service puts no requirements on the
> required level of assurance.

> **Note:** If more than one URI is given, the `Version` attribute of the `SignRequestExtension` element MUST be set to "1.4" or higher. Implementations prior to version 1.4 of this specification assume that this element may only contain one URI.


`<RequestedCertAttributes>` \[Optional\]

> Element holding a SAML entity ID of an Attribute Authority that MAY be
> used to obtain an attribute value for the requested attribute. The
> entityID value is specified using the **saml:NameIDType** complex type
> and MUST include a Format attribute with the value
> `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`.

`<OtherProperties>` \[Optional\]

> Other requested properties of the signature certificate.

The following schema fragment defines the **CertRequestPropertiesType**
complex type:

```
<xs:complexType name="CertRequestPropertiesType">
  <xs:sequence>
    <xs:element ref="saml:AuthnContextClassRef" minOccurs="0" maxOccurs="unbounded" />
    <xs:element ref="csig:RequestedCertAttributes" minOccurs="0" />
    <xs:element ref="csig:OtherProperties" minOccurs="0" />
  </xs:sequence>
  <xs:attribute default="PKC" name="CertType">
    <xs:simpleType>
      <xs:restriction base="xs:string">
        <xs:enumeration value="PKC"/>
        <xs:enumeration value="QC"/>
        <xs:enumeration value="QC/SSCD"/>
      </xs:restriction>
    </xs:simpleType>
  </xs:attribute>
</xs:complexType>

<xs:element name="RequestedCertAttributes" type="csig:RequestedAttributesType" />
<xs:element name="OtherProperties" type="csig:AnyType" />
```


<a name="type-requestedattributestype"></a>
##### 3.1.1.1. Type RequestedAttributesType

The **RequestedAttributesType** complex type is used to represent
requests for subject attributes in a signer certificate that is
associated with the signer of the generated signature as a result of the
sign request. This protocol is designed to accommodate the scenario
where the Signing Service generates the signer key and the signer
certificate at the time of signing and where the Signing Service
collects the user's attributes from a SAML assertion. However, this
element can also be used as a requirement for attributes in existing
certificates, where the Signing Service can determine if the existing
signing certificate matches the requirements of the requesting service.

The **RequestedAttributesType** has the following element:

`<RequestedCertAttribute>` \[One or More\]

> Information of type **MappedAttributeType** about a requested
> certificate attribute.

The following schema fragment defines the **RequestedAttributesType**
complex type:

```
<xs:complexType name="RequestedAttributesType">
  <xs:sequence>
    <xs:element name="RequestedCertAttribute" type="csig:MappedAttributeType" 
      maxOccurs="unbounded" minOccurs="1" />
  </xs:sequence>
</xs:complexType>
```

The **MappedAttributeType** complex type has the following elements and
attributes:

`CertAttributeRef` \[Optional\]

> A reference to the certificate attribute or name type where the
> requester wants to store this attribute value. The information in this
> attribute depends on the selected `CertNameType` attribute value. If the
> `CertNameType` is "**rdn**" or "**sda**", then this attribute MUST
> contain a string representation of an object identifier (OID). If the
> `CertNameType` is "**san**" (Subject Alternative Name) and the target
> name is a GeneralName, then this attribute MUST hold a string
> representation of the tag value of the target GeneralName type, e.g.
> "1" for rfc822Name (e-mail) or "2" for dNSName. If the `CertNameType` is
> "**san**" and the target name form is an OtherName, then this
> attribute value MUST include a string representation of the object
> identifier of the target OtherName form.
>
> Representation of an OID as a string in this attribute MUST consist of
> a sequence of integers delimited by a dot. This string MUST not
> contain white space or line breaks. Example: "2.5.4.32".

`CertNameType` \[Optional\]

> An enumeration of the target name form for storing the associated SAML
> attribute value in the certificate. The available values are "rdn" for
> storing the attribute value as an attribute in a Relative
> Distinguished Name in the subject field of the certificate, "san" for
> storing the attribute value in a subject alternative name extension
> and "sda" for storing the attribute value in a subject directory
> attribute extension. The default value for this attribute is "rdn".

`FriendlyName` \[Optional\]

> An optional friendly name of the subject attribute, e.g. "givenName".
> Note that this name does not need to map to any particular naming
> convention and its value MUST NOT be used by the Signing Service for
> attribute type mapping. This name is present for display purposes
> only.

`DefaultValue` \[Optional\]

> An optional default value for the requested attribute. This value MAY
> be used by the Signing Service if no authoritative value for the
> attribute can be obtained when the Signing Service authenticates the
> user. This value MUST NOT be used by the Signing Service unless this
> value is consistent with a defined policy at the Signing Service. A
> typical valid use of this attribute is to hold a default countryName
> attribute value that matches a set of allowed countryName values. By
> accepting the default attribute value provided in this attribute, the
> Signing Service accept the requesting service as an authoritative
> source for this particular requested attribute.

`Required` \[Optional\] (Default `false`)

> If this attribute is set to true, the Signing Service MUST ensure that
> the signing certificate contains a subject attribute of the requested
> type, or else the Signing Service MUST NOT generate the requested
> signature.

`<AttributeAuthority>` \[Zero or More\]

> Element holding an entityID of an Attribute Authority that MAY be
> used to obtain an attribute value for the requested attribute. The
> entityID value is specified using the **saml:NameIDType** complex type
> and MUST include a `Format` attribute with the value
> `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`.

`<SamlAttributeName>` \[Zero or More\]

> Element of type **PreferredSAMLAttributeNameType** complex type
> holding a name of a SAML subject attribute that is allowed to provide
> the content value for the requested certificate attribute.

The following schema fragment defines the **MappedAttributeType**
complex type:

```
<xs:complexType name="MappedAttributeType">
  <xs:sequence>
    <xs:element name="AttributeAuthority" type="saml:NameIDType"
      maxOccurs="unbounded" minOccurs="0" />
    <xs:element name="SamlAttributeName" type="csig:PreferredSAMLAttributeNameType"
      maxOccurs="unbounded" minOccurs="0" />
  </xs:sequence>
  <xs:attribute name="CertAttributeRef" type="xs:string" use="optional" />
  <xs:attribute name="CertNameType" default="rdn" use="optional">
    <xs:simpleType>
      <xs:restriction base="xs:string">
        <xs:enumeration value="rdn"/>
        <xs:enumeration value="san"/>
        <xs:enumeration value="sda"/>
      </xs:restriction>
    </xs:simpleType>
  </xs:attribute>
  <xs:attribute name="FriendlyName" type="xs:string" />
  <xs:attribute name="DefaultValue" type="xs:string" />
  <xs:attribute name="Required" type="xs:boolean" default="false" />
</xs:complexType>
```

The **PreferredSAMLAttributeNameType** complex type holds a string value
of a SAML attribute name. This attribute name SHALL be mapped against
attribute names in `<saml:Attribute>` elements representing the
subject in a SAML assertion that is used to authenticate the signer.

The **PreferredSAMLAttributeNameType** complex type has the following
attribute:

`Order` \[Optional\]

> An integer specifying the order of preference of this SAML attribute.
> If more than one SAML attribute is listed, the SAML attribute with the
> lowest `Order` integer value that is present as a subject attribute in
> the SAML assertion, SHALL be used. SAML attributes with an absent
> `Order` attribute SHALL be treated as having an order value of 0.
> Multiple SAML attributes with an identical `Order` attribute values
> SHALL be treated as having equal priority.

The following schema fragment defines the
**PreferredSAMLAttributeNameType** complex type:

```
<xs:complexType name="PreferredSAMLAttributeNameType">
  <xs:simpleContent>
    <xs:extension base="xs:string">
      <xs:attribute name="Order" type="xs:int" default="0" />
    </xs:extension>
  </xs:simpleContent>
</xs:complexType>
```

<a name="element-signmessage"></a>
#### 3.1.2. Element &lt;SignMessage&gt;

The `<SignMessage>` element holds a message to the signer with
information about what is being signed. The sign message is provided
either in plain text using the `<Message>` child element or as an
encrypted message using the `<EncryptedMessage>` child element. This
element's **SignMessageType** complex type includes the following
attributes and elements:

`MustShow` \[Optional\] (Default `false`)

> When this attribute is set to `true` then the requested signature MUST
> NOT be created unless this message has been displayed and accepted by
> the signer. The default is `false`.

`DisplayEntity` \[Optional\]

> The entityID of the entity responsible for displaying the sign message
> to the signer. When the sign message is encrypted, then this entity is
> also the holder of the private decryption key necessary to decrypt the
> sign message.

`MimeType` \[Optional\] (Default `text`)

> The MIME type defining the message format. This is an enumeration of
> the valid attribute values `text` (plain text), `text/html` (html) or
> `text/markdown` (markdown). This specification does not specify any
> particular restrictions on the provided message but it is RECOMMENDED
> that sign message content is restricted to a limited set of valid tags
> and attributes, and that the display entity performs filtering to
> enforce these restrictions before displaying the message. The means
> through which parties agree on such restrictions are outside the scope
> of this specification, but one valid option to communicate such
> restrictions could be through federation metadata.

`<Message>` \[Choice\]

> The base64 encoded sign message in unencrypted form. The message MUST
> be encoded using UTF-8.

`<EncryptedMessage>` \[Choice\]

> An encrypted `<Message>` element. 

> Either a `<Message>` or an `<EncryptedMessage>` element MUST be present.

The following schema fragment defines the `<SignMessage>` element
and the **SignMessageType** complex type:

```
<xs:complexType name="SignMessageType">
  <xs:choice>
    <xs:element ref="csig:Message" />
    <xs:element ref="csig:EncryptedMessage" />
  </xs:choice>
  <xs:attribute name="MustShow" type="xs:boolean" default="false" />
  <xs:attribute name="DisplayEntity" type="xs:anyURI" />
  <xs:attribute name="MimeType" default="text">
    <xs:simpleType>
      <xs:restriction base="xs:string">
        <xs:enumeration value="text/html" />
        <xs:enumeration value="text" />
        <xs:enumeration value="text/markdown" />
      </xs:restriction>
    </xs:simpleType>
  </xs:attribute>
  <xs:anyAttribute namespace="##other" processContents="lax" />
</xs:complexType>


<xs:element name="Message" type="xs:base64Binary"/>
<xs:element name="EncryptedMessage" type="saml:EncryptedElementType"/>
```

<a name="element-signresponseextension"></a>
### 3.2. Element &lt;SignResponseExtension&gt;

The `<SignResponseExtension>` element is an extension that
allows a requesting service to add essential sign response information
to the sign response. When present, this element MUST be included in the
`<dss:OptionalOutputs>` element in a `<dss:SignResponse>`
element.

This element's **SignResponseExtensionType** complex type includes the
following attributes and elements:

`Version` \[Optional\] (Default `1.1`)

> The version of this specification under which the response message was produced. 
> If absent, the version value
> defaults to "1.1". This attribute provides means for the receiving
> service to determine the expected semantics of the response based on the
> protocol version.

> **Note:** The sender MUST use the same version number as received in the `Version`
> attribute of the `SignRequestExtension` (see [section 3.1](#element-signrequestextension)).

`<ResponseTime>` \[Required\]

> The time when the sign response was created.

`<Request>` \[Optional\]

> A base64 encoded signed `<dss:SignRequest>` element that contains
> the request related to this sign response. This element MUST be
> present if signing was successful.

`<SignerAssertionInfo>` \[Optional\]

> An element of type **SignerAssertionInfoType** holding information
> about how the signer was authenticated by the sign service as well as
> information about subject attribute values present in the SAML
> assertion authenticating the signer, which was incorporated into the
> signer certificate. This element MUST be present if signing was
> successful.

`<SignatureCertificateChain>` \[Optional\]

> An element of type **CertificateChainType** holding the signer
> certificate as well as other certificates that may be used to validate
> the signature. This element MUST be present if signing was successful
> and MUST contain all certificates that are necessary to compile a
> complete and functional signed document. Certificates in
> `<SignatureCertificateChain>` MUST be provided in sequence with
> the signature certificate first followed by any CA certificates that
> can be used to verify the previous certificate in the sequence, ending
> with a self-signed root certificate.

`<OtherResponseInfo>` \[Optional\]

> Optional sign response elements of type **AnyType**.

The following schema fragment defines the `<SignResponseExtension>`
element and the **SignResponseExtensionType** complex type:

```
<xs:element name="SignResponseExtension" type="csig:SignResponseExtensionType" />

<xs:complexType name="SignResponseExtensionType">
  <xs:sequence>
    <xs:element ref="csig:ResponseTime" />
    <xs:element ref="csig:Request" minOccurs="0" />
    <xs:element ref="csig:SignerAssertionInfo" maxOccurs="1" minOccurs="0" />
    <xs:element ref="csig:SignatureCertificateChain" minOccurs="0" />
    <xs:element ref="csig:OtherResponseInfo" minOccurs="0" />
  </xs:sequence>
  <xs:attribute name="Version" type="xs:string" default="1.2" />
</xs:complexType>

<xs:element name="ResponseTime" type="xs:dateTime" />
<xs:element name="Request" type="xs:base64Binary" />
<xs:element name="SignerAssertionInfo" type="csig:SignerAssertionInfoType" />
<xs:element name="SignatureCertificateChain" type="csig:CertificateChainType" />
<xs:element name="OtherResponseInfo" type="csig:AnyType" />
```

<a name="type-signerassertioninfotype"></a>
#### 3.2.1. Type SignerAssertionInfoType

The **SignerAssertionInfoType** complex type has the following elements:

`<ContextInfo>` \[Required\]

> This element of type **ContextInfoType** holds information about SAML
> authentication context related to signer authentication through a SAML
> assertion.

`<saml:AttributeStatement>` \[Required\]

> This element of type **saml:AttributeStatementType** (see
> \[[*SAML2.0*](#saml)\]) holds subject attributes obtained from the
> SAML assertion used to authenticate the signer at the Signing Service.
> For integrity reasons, this element SHOULD only provide information
> about SAML attribute values that maps to subject identity information
> in the signer's certificate.

`<SamlAssertions>` \[Zero or More\]

> Any number of relevant SAML assertions that was relevant for
> authenticating the signer and signer's identity attributes at the
> Signing Service.

The following schema fragment defines the **SignerAssertionInfoType**
complex type:

```
<xs:complexType name="SignerAssertionInfoType">
  <xs:sequence>
    <xs:element ref="csig:ContextInfo" />
    <xs:element ref="saml:AttributeStatement" />
    <xs:element minOccurs="0" ref="csig:SamlAssertions" />
  </xs:sequence>
</xs:complexType>

<xs:element name="ContextInfo" type="csig:ContextInfoType" />
<xs:element name="SamlAssertions" type="csig:SAMLAssertionsType" />
```

<a name="type-contextinfotype"></a>
##### 3.2.1.1. Type ContextInfoType

The **ContextInfoType** complex type has the following elements:

`<IdentityProvider>`\[Required\]

> The entityID of the Identity Provider that authenticated the signer to
> the Signing Service.

`<AuthenticationInstant>` \[Required\]

> The time when the Signing Service authenticated the signer.

`<saml:AuthnContextClassRef>` \[Required\]

> A URI reference to the authentication context class (see
> \[[SAML2.0](#saml)\]).

`<ServiceID>` \[Optional\]

> An arbitrary identifier of the instance of the Signing Service that
> authenticated the signer.

`<AuthType>` \[Optional\]

> An arbitrary identifier of the service used by the Signing Service to
> authenticate the signer (e.g. "shibboleth".)

`<AssertionRef>` \[Optional\]

> A reference to the assertion used to identify the signer. This MAY be
> the ID attribute of a `<saml:Assertion>` element but MAY also be
> any other reference that can be used to locate and identify the
> assertion.

```
<xs:complexType name="ContextInfoType">
  <xs:sequence maxOccurs="1" minOccurs="0">
    <xs:element name="IdentityProvider" type="saml:NameIDType" />
    <xs:element name="AuthenticationInstant" type="xs:dateTime" />
    <xs:element ref="saml:AuthnContextClassRef" />
    <xs:element name="ServiceID" type="xs:string" minOccurs="0" />
    <xs:element name="AuthType" type="xs:string" minOccurs="0" />
    <xs:element name="AssertionRef" type="xs:string" minOccurs="0" />
  </xs:sequence>
</xs:complexType>
```

<a name="type-samlassertionstype"></a>
##### 3.2.1.2. Type SAMLAssertionsType

The **SAMLAssertionsType** is used to store the bytes of an arbitrary
number of SAML assertions (see \[[SAML2.0](#saml)\]). This complex
type has the following elements:

`<Assertion>`\[One or More\]

> One or more SAML assertions represented by the bytes of each
> assertion. Assertions are stored as byte data to ensure that the
> signature on each assertion can be validated. Assertions stored in
> this element MUST retain its original canonical format so that any
> signature on the assertion can be validated.

```
<xs:complexType name="SAMLAssertionsType">
  <xs:sequence>
    <xs:element name="Assertion" type="xs:base64Binary" maxOccurs="unbounded" />
  </xs:sequence>
</xs:complexType>
```

<a name="type-certificatechaintype"></a>
#### 3.2.2. Type CertificateChainType

This complex type can be used to hold a sequence of X.509 certificates.
Certificates MUST be provided in sequence with the end-entity
certificate first in the sequence followed by any CA certificates that
can be used to verify the previous certificate in the sequence, ending
with a self signed root certificate.

The **CertificateChainType** complex type has the following elements:

`<X509Certificate>` \[One or More\]

> An X.509 certificate \[[RFC 5280](#rfc5280)\] that is part of a
> certificate chain that can be used to verify the generated signature.
> The certificate SHALL be represented as a base64Binary of the DER
> encoded certificate.

The following schema fragment defines the **CertificateChainType**
complex type:

```
<xs:complexType name="CertificateChainType">
  <xs:sequence>
    <xs:element name="X509Certificate" type="xs:base64Binary" maxOccurs="unbounded" />
  </xs:sequence>
</xs:complexType>
```

<a name="extensions-to-dssinputdocuments-and-dsssignatureobject"></a>
## 4. Extensions to &lt;dss:InputDocuments&gt; and &lt;dss:SignatureObject&gt; 

This section defines elements that extends the
`<dss:InputDocuments>` element of DSS sign requests and the
`<dss:SignatureObject>` element of DSS sign responses by inclusion
in their respective `<dss:Other>` element.

<a name="element-signtasks"></a>
### 4.1. Element &lt;SignTasks&gt;

The `<SignTasks>` element, when present, MUST appear either in the
`<dss:Other>` element of the `<dss:InputDocuments>` element of a
sign request or in the `<dss:Other>` element of the
`<dss:SignatureObject>` element of a sign response.

This element holds information about sign tasks that are requested in a
sign request and returned in a sign response. If information about a
sign task is provided using this element in a sign request, then the
corresponding signature result data MUST also be provided using this
element in the sign response.

This element's **SignTasksType** complex type includes the following
attributes and elements:

`<SignTaskData>` \[One or More\]

> Input and output data associated with a sign task. A request MAY
> contain several instances of this element. When multiple instances of
> this element are present in the request, this means that the Signing
> Service is requested to generate multiple signatures (one for each
> `<SignTaskData>` element) using the same signing key and signature
> certificate. This allows batch signing of several different documents
> in the same signing instance or creation of multiple signatures on the
> same document such as signing XML content of a PDF document with an
> XML signature, while signing the rest of the document with a PDF
> signature.

The following schema fragment defines the `<SignTasks>` element and
its **SignTasksType** complex type:

```
<xs:element name="SignTasks" type="csig:SignTasksType" />

<xs:complexType name="SignTasksType">
  <xs:sequence>
    <xs:element ref="csig:SignTaskData" maxOccurs="unbounded" />
  </xs:sequence>
</xs:complexType>

<xs:element name="SignTaskData" type="csig:SignTaskDataType" />
```

<a name="element-signtaskdata"></a>
#### 4.1.1. Element &lt;SignTaskData&gt;

When present in a sign request, this element provides input data to a
signature generation process. When present in a sign response, this
element provides the corresponding signature result data. When a request
provides input data using this type of element, then an element of this
type MUST also be used to return the corresponding signature result
data.

This element's **SignTaskDataType** complex type includes the following
attributes and elements:

`SignTaskId` \[Optional\]

> An identifier of the signature task that is represented by this
> element. If the request contains multiple instances of
> `<SignTaskData>` representing separate sign tasks, then each
> instance of the element MUST have a SignatureId attribute value that
> is unique among all sign tasks in the sign request. When this
> attribute is present, the same attribute value MUST be returned in the
> corresponding `<SignTaskData>` element in the response that holds
> corresponding signature result data.

`SigType` \[Required\]

> Enumerated identifier of the type of signature format the
> canonicalized signed information octets in the `<ToBeSignedBytes>`
> element are associated with. This MUST be one of the enumerated values
> "XML", "PDF", "CMS" of "ASiC".

`AdESType` \[Optional\]

> Specifies the type of AdES signature. BES means that the signing
> certificate hash must be covered by the signature. EPES means that the
> signing certificate hash and a signature policy identifier must be
> covered by the signature.

`ProcessingRules` \[Optional\]

> A URI identifying one or more processing rules that the Signing
> Service MUST apply when processing and using the provided signed
> information octets. The Signing Service MUST NOT process and complete
> the signature request if this attribute contains a URI that is not
> recognized by the Signing Service. When this attribute is present in
> the sign response, it represents a statement by the Signing Service
> that the identified processing rule was successfully executed.

`<ToBeSignedBytes>` \[Required\]

> The bytes to be hashed and signed when generating the requested
> signature. For an XML signature this MUST be the canonicalized octets
> of a `<dss:SignedInfo>` element. For a PDF signature this MUST be
> the octets of the DER encoded SignedAttrs value (signed attributes).
> If this data was altered by the signature process, for example as a
> result of changing a signing time attribute in PDF SignedAttrs, or as
> a result of adding a reference to a hash of the signature certificate
> in an XAdES signature, the altered data MUST be returned in the sign
> response using this element.

`<AdESObject>` \[Optional\]

> An element of type **AdESObjectType** complex type holding data to
> support generation of a signature according to any of the ETSI
> Advanced Electronic Signature (AdES) standard formats.

`<Base64Signature>` \[Optional\]

> The output signature value of the signature creation process
> associated with this sign task. This element's optional `Type`
> attribute, if present, SHALL contain a URI indicating the signature
> algorithm that was used to generate the signature value.

`<OtherSignTaskData>` \[Optional\]

> Other input or output data elements associated with the sign task.

The following schema fragment defines the `<SignTaskData>` element
and its **SignTaskDataType** complex type:

```
<xs:element name="SignTaskData" type="csig:SignTaskDataType" />

<xs:complexType name="SignTaskDataType">
  <xs:sequence>
    <xs:element ref="csig:ToBeSignedBytes" />
    <xs:element ref="csig:AdESObject" minOccurs="0" maxOccurs="1" />
    <xs:element ref="csig:Base64Signature" minOccurs="0" />
    <xs:element ref="csig:OtherSignTaskData" minOccurs="0" />
  </xs:sequence>
  <xs:attribute name="SignTaskId" type="xs:string" />
  <xs:attribute name="SigType" use="required">
    <xs:simpleType>
      <xs:restriction base="xs:string">
        <xs:enumeration value="XML" />
        <xs:enumeration value="PDF" />
        <xs:enumeration value="CMS" />
        <xs:enumeration value="ASiC" />
      </xs:restriction>
    </xs:simpleType>
  </xs:attribute>
  <xs:attribute name="AdESType" default="None">
    <xs:simpleType>
      <xs:restriction base="xs:string">
        <xs:enumeration value="None" />
        <xs:enumeration value="BES" />
        <xs:enumeration value="EPES" />
      </xs:restriction>
    </xs:simpleType>
  </xs:attribute>
  <xs:attribute name="ProcessingRules" type="xs:anyURI" use="optional" />
</xs:complexType>

<xs:element name="ToBeSignedBytes" type="xs:base64Binary" />
<xs:element name="AdESObject" type="csig:AdESObjectType" />
<xs:element name="Base64Signature" type="csig:Base64SignatureType" />
<xs:element name="OtherSignTaskData" type="csig:AnyType" />
```

<a name="type-adesobjecttype"></a>
##### 4.1.1.1. Type AdESObjectType

The **AdESObjectType** complex type holds a base64 encoded object that
is referenced from the signature and which content has to be modified as
part of the certificate and signature generation process. Handling of
this data as in the signature generation process MAY be affected by
rules identifyed by the `ProcessingRules`, `SigType` and `AdESType` attributes
of the parent `<SignatureInputObjects>` elements.

This complex type has the following elements:

`<SignatureId>` \[Optional\]

> An optional identifier of the signature. When the requested signature
> is a XAdES signature, this is the value of the Id attribute of the
> `<ds:Signature>` element of the resulting signature, which is used
> to construct the `Target` attribute of the
> `<xades:QualifyingProperties>` element.

`<AdESObjectBytes>` \[Optional\]

> A base64 encoded object that is referenced from the signature and
> which content has to be modified as part of the certificate and
> signature generation process. The type of data in the base64 encoded
> bytes and the rules of handling of this data as in the signature
> generation process is determined through the `ProcessingRules`, `SigType`
> and `AdESType` attributes of the parent `<SignatureInputObjects>`
> elements. When the signature type is XAdES, then this is the bytes of
> the `<ds:Object>` element that holds the
> `<xades:QualifyingProperties>` element of the signature where the
> hash of the signature certificate will be placed.
>
> When this element is present in the request, it forms a base for
> construction of this object in the signature process.

`<OtherAdESData>` \[Optional\]

> Other input data related to the AdES signature generation process.

The following schema fragment defines the **AdESObjectType** complex
type

```
<xs:complexType name="AdESObjectType">
  <xs:sequence>
    <xs:element name="SignatureId" type="xs:string" minOccurs="0" />
    <xs:element name="AdESObjectBytes" type="xs:base64Binary" minOccurs="0" />
    <xs:element name="OtherAdESData" type="csig:AnyType" minOccurs="0" />
  </xs:sequence>
</xs:complexType>
```

<a name="signing-sign-requests-and-responses"></a>
## 5. Signing Sign Requests and Responses

This specification supports a scenario where a requesting service
requests the signer to sign some data and where the same requesting
service receives the signature from the Signing Service. In this
scenario the requesting service acts as the presenter of information to
be signed to the signer. Implementers of this specification MUST sign
requests and responses for signature creation to protect against
spoofing and substitution attacks. If a hash of the document to be
signed is replaced in a sign request, the signer may end up signing
something completely different than what the requesting service
presented to the signer.

When a `<dss:SignRequest>` is signed, the signature of that request
MUST be placed as the last child element in the
`<dss:OptionalInputs>` element. The Signing Service MUST check this
signature and MUST check that the signature covers all data in the
`<dss:SignRequest>` element (except for the signature itself).

When a `<dss:SignResponse>` is signed, the signature of that
response MUST be placed as the last child element in the
`<dss:OptionalOutputs>` element. The Signing Service MUST check this
signature and MUST check that the signature covers all data in the
`<dss:SignResponse>` element (except for the signature itself)

<a name="normative-references"></a>
## 6. Normative References

<a name="csig-xsd"></a>
**\[Csig-XSD\]**
> This specification's DSS Extensions schema Version 1.1, https://docs.swedenconnect.se/schemas/csig/1.1/EidCentralSigDssExt-1.1.xsd, August 2015.

> See also the draft version: https://docs.swedenconnect.se/schemas/csig/1.1/EidCentralSigDssExt-1.1.2-DRAFT.xsd, June 2020.

<a name="dss"></a>
**\[OASIS-DSS\]**
> [Digital Signature Service Core Protocols, Elements, and Bindings Version 1.0, OASIS, 11 April 2007](https://docs.oasis-open.org/dss/v1.0/oasis-dss-core-spec-v1.0-os.html).

<a name="rfc2119"></a>
**\[RFC 2119\]**
> [RFC 2119: Key words for use in RFCs to Indicate Requirement Levels](https://www.ietf.org/rfc/rfc2119.txt).

<a name="rfc3986"></a>
**\[RFC 3986\]** 
> [RFC 3986: Uniform Resource Identifier (URI): Generic Syntax](https://www.ietf.org/rfc/rfc3986.txt).

<a name="rfc5652"></a>
**\[RFC 5652\]** 
> [RFC 5652: Cryptographic Message Syntax (CMS)](https://www.ietf.org/rfc/rfc5652.txt).

<a name="rfc5280"></a>
**\[RFC 5280\]** 
> [RFC 5280: Internet X.509 Public Key Infrastructure Certificate and Certificate Revocation List (CRL) Profile](https://www.ietf.org/rfc/rfc5280.txt).

<a name="saml"></a>
**\[SAML2.0\]**
> [Assertions and Protocols for the OASIS Security Assertion Markup Language (SAML) V2.0](https://docs.oasis-open.org/security/saml/v2.0/).

<a name="schema1"></a>
**\[Schema1\]** 
> [XML Schema Part 1: Structures. W3C Recommendation 28 October 2004](https://www.w3.org/TR/xmlschema-1/).

<a name="schema2"></a>
**\[Schema2\]** 
> [XML Schema Part 2: Datatypes. W3C Recommendation 28 October 2004](https://www.w3.org/TR/xmlschema-2/).

<a name="xades"></a>
**\[XAdES\]** 
> [XAdES digital signatures; Part 1: Building blocks and XAdES baseline signatures](https://www.etsi.org/deliver/etsi_en/319100_319199/31913201/01.01.01_60/en_31913201v010101p.pdf).

<a name="xml"></a>
**\[XML\]**
> [Extensible Markup Language (XML) 1.0 (Fifth Edition). W3C
Recommendation 26 November 2008](https://www.w3.org/TR/REC-xml/).

<a name="xml-ns"></a>
**\[XML-ns\]** 
> [Namespaces in XML. W3C Recommendation, January 1999](https://www.w3.org/TR/1999/REC-xml-names-19990114).

<a name="xmldsig"></a>
**\[XMLDSIG\]**
> [XML-Signature Syntax and Processing. W3C Recommendation, February 2002](https://www.w3.org/TR/2002/REC-xmldsig-core-20020212/).

<a name="changes-between-versions"></a>
## 7. Changes between versions

**Changes between version 1.3 and 1.4:**

- Section 3.1, "Element SignRequestExtension", was updated with the element `AuthnProfile`.

- Section 3.1 and 3.2 was updated to clarify the use of the `Version` attribute in the `SignRequestExtension` and `SignResponseExtension` elements.

- Section 3.1.1, "Type CertRequestPropertiesType", was updated so that more than one `<saml:AuthnContextClassRef>` element can be included. The schema was also updated (to version 1.1.2 but keeping the same namespace identifier). 

**Changes between version 1.2 and 1.3:**

- No functional changes. The document has been re-branded with the Sweden Connect- and DIGG logotypes and the document format has been changed from OASIS-style to the style used by all other specifications within the Swedish eID Framework. Some typos were also fixed.

**Changes between version 1.1 and 1.2:**

- Incorrect versions and references were corrected.

**Changes between version 1.0 and 1.1:**

- Version 1.1 of the XML Schema for DSS extensions was introduced.

<a name="appendix-a.xml-schema"></a>
## Appendix A: XML Schema

This appendix provides the full XML Schema declaration for the DSS
protocol extension defined in this document. In case of differences
between the XML Schema in this appendix and XML Scema fragments in the
sections above, the XML Schema in this appendix is the normative one.

The schema can also be downloaded from https://docs.swedenconnect.se/schemas/csig/1.1/EidCentralSigDssExt-1.1.xsd.

> See also: https://docs.swedenconnect.se/schemas/csig/1.1/EidCentralSigDssExt-1.1.2-DRAFT.xsd.

```
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
    version="1.1.2"
    xmlns:ds="http://www.w3.org/2000/09/xmldsig#"
    targetNamespace="http://id.elegnamnden.se/csig/1.1/dss-ext/ns"
    xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:dss="urn:oasis:names:tc:dss:1.0:core:schema"
    xmlns:csig="http://id.elegnamnden.se/csig/1.1/dss-ext/ns">

  <xs:annotation>
    <xs:documentation>
      Version: 1.1.2
      Schema location URL: https://docs.swedenconnect.se/schemas/csig/1.1/EidCentralSigDssExt-1.1.2-DRAFT.xsd
    </xs:documentation>
  </xs:annotation>

  <xs:import namespace="urn:oasis:names:tc:SAML:2.0:assertion"
      schemaLocation="https://docs.oasis-open.org/security/saml/v2.0/saml-schema-assertion-2.0.xsd"/>

  <xs:element name="SignRequestExtension" type="csig:SignRequestExtensionType">
    <xs:annotation>
      <xs:documentation>
        Extension to an OASIS DSS SignRequest, providing additional 
        information about a sign request. This element extends the 
        dss:OptionalInputs element of a dss:SignRequest.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="SignResponseExtension" type="csig:SignResponseExtensionType">
    <xs:annotation>
      <xs:documentation>
        Extension to an OASIS DSS SignResponse, providing additional information 
        about a sign response. This element extends the dss:OptionalOutput element 
        of a dss:SignResponse.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="SignTasks" type="csig:SignTasksType" />

  <xs:element name="SignTaskData" type="csig:SignTaskDataType" />
    
  <xs:element name="RequestTime" type="xs:dateTime">
    <xs:annotation>
      <xs:documentation>
        Time when the request was created.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="Signer" type="saml:AttributeStatementType">
    <xs:annotation>
      <xs:documentation>
        The identity of the signer expressed as a sequence of SAML attributes 
        using the AttributesType complex type.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="IdentityProvider" type="saml:NameIDType">
    <xs:annotation>
      <xs:documentation>
        The SAML entityID of the Identity Provider that MUST be used to 
        authenticate the signer before signing. The EntitID value is specified 
        using the saml:NameIDType complex type and MUST include a Format 
        attribute with the value urn:oasis:names:tc:SAML:2.0:nameid-format:entity.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="SignRequester" type="saml:NameIDType">
    <xs:annotation>
      <xs:documentation>
        The SAML entityID of the service that sends this request to the signing service. 
        The entityID value is specified using the saml:NameIDType complex type and MUST 
        include a Format attribute with the value 
        urn:oasis:names:tc:SAML:2.0:nameid-format:entity.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="SignService" type="saml:NameIDType">
    <xs:annotation>
      <xs:documentation>
        The SAML entityID of the service to which this Sign Request is sent. 
        The entityID value is specified using the saml:NameIDType complex type 
        and MUST include a Format attribute with the value 
        urn:oasis:names:tc:SAML:2.0:nameid-format:entity.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="RequestedSignatureAlgorithm" type="xs:anyURI">
    <xs:annotation>
      <xs:documentation>
        An identifier of the signature algorithm the requesting service prefers 
        when generating the requested signature.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="CertRequestProperties" type="csig:CertRequestPropertiesType">
    <xs:annotation>
      <xs:documentation>
        The requested properties of the signature certificate being issued by the 
        signature service.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="RequestedCertAttributes" type="csig:RequestedAttributesType">
    <xs:annotation>
      <xs:documentation>
        An optional set of requested attributes that the requesting service prefers 
        or requires in the subject name of the generated signing certificate.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="OtherProperties" type="csig:AnyType" />

  <xs:element name="SignMessage" type="csig:SignMessageType">
    <xs:annotation>
      <xs:documentation>
        Sign message included as a choice of a Base64 encoded string or 
        an encrypted sign message.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="Message" type="xs:base64Binary" />
  
  <xs:element name="EncryptedMessage" type="saml:EncryptedElementType" />

  <xs:element name="OtherRequestInfo" type="csig:AnyType">
    <xs:annotation>
      <xs:documentation>
        Any additional inputs to the request extension.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="ResponseTime" type="xs:dateTime">
    <xs:annotation>
      <xs:documentation>
        The time when the sign response was created.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="Request" type="xs:base64Binary">
    <xs:annotation>
      <xs:documentation>
        An element of type EncodedRequestType with base64Binary base type, holding 
        a representation of a complete and signed dss:SignRequest element that is 
        related to this sign response. This element MUST be present if signing was 
        successful.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="SignerAssertionInfo" type="csig:SignerAssertionInfoType">
    <xs:annotation>
      <xs:documentation>
        An element of type SignerAssertionInfoType holding information about how 
        the signer was authenticated by the sign service as well as information 
        about subject attribute values present in the SAML assertion authenticating 
        the signer, which was incorporated into the signer certificate. This element 
        MUST be present if signing was successful.
      </xs:documentation>
    </xs:annotation>
  </xs:element>
  
  <xs:element name="ContextInfo" type="csig:ContextInfoType" />

  <xs:element name="SamlAssertions" type="csig:SAMLAssertionsType" />

  <xs:element name="SignatureCertificateChain" type="csig:CertificateChainType">
    <xs:annotation>
      <xs:documentation>
        An element of type CertificateChainType holding the signer certificate as 
        well as other certificates that may be used to validate the signature. This 
        element MUST be present if signing was successful and MUST contain all 
        certificate that are necessary to compile a complete and functional signed 
        document.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="OtherResponseInfo" type="csig:AnyType">
    <xs:annotation>
      <xs:documentation>
        Optional sign response elements of type AnyType.
      </xs:documentation>
    </xs:annotation>
  </xs:element>
  
  <xs:element name="ToBeSignedBytes" type="xs:base64Binary">
    <xs:annotation>
      <xs:documentation>
        The octets that are hashed and signed when generating the signture. For 
        PDF and common modes of CMS this is the DER encoded SignedAttributess field. 
        For XML this is the canonicalized SignedInfo octets.
      </xs:documentation>
    </xs:annotation>
  </xs:element>
  
  <xs:element name="AdESObject" type="csig:AdESObjectType">
    <xs:annotation>
      <xs:documentation>
        Information in support of AdES signature creation.
      </xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="Base64Signature" type="csig:Base64SignatureType">
    <xs:annotation>
      <xs:documentation>Result signature bytes</xs:documentation>
    </xs:annotation>
  </xs:element>

  <xs:element name="OtherSignTaskData" type="csig:AnyType" />

  <xs:complexType name="SignRequestExtensionType">
    <xs:sequence>
      <xs:element ref="csig:RequestTime"/>
      <xs:element ref="saml:Conditions">
        <xs:annotation>
          <xs:documentation>
            Conditions that MUST be evaluated when assessing the validity of and/or 
            when using the Sign Request. See Section 2.5 of SAML2.0 for additional 
            information on how to evaluate conditions.

            This element MUST include the attributes NotBefore and NotOnOrAfter and 
            MUST include the element saml:AudienceRestriction which in turn MUST 
            contain one saml:Audience element, specifying the return URL for any 
            resulting Sign Response message.
          </xs:documentation>
        </xs:annotation>
      </xs:element>
      <xs:element ref="csig:Signer" minOccurs="0" />
      <xs:element ref="csig:IdentityProvider" />
      <xs:element name="AuthnProfile" type="xs:string" minOccurs="0">
        <xs:annotation>
          <xs:documentation>
            An opaque string that can be used to inform the Signing Service about 
            specific requirements regarding the user authentication at the given 
            Identity Provider (see above).
            If set, the Version attribute MUST be 1.4 or higher.
          </xs:documentation>
        </xs:annotation>
      </xs:element>      
      <xs:element ref="csig:SignRequester" />
      <xs:element ref="csig:SignService" />
      <xs:element ref="csig:RequestedSignatureAlgorithm" minOccurs="0" />
      <xs:element ref="csig:CertRequestProperties" minOccurs="0" />
      <xs:element ref="csig:SignMessage" minOccurs="0" maxOccurs="1" />
      <xs:element ref="csig:OtherRequestInfo" minOccurs="0" />
    </xs:sequence>
    <xs:attribute name="Version" type="xs:string" use="optional" default="1.1">
      <xs:annotation>
        <xs:documentation>
          The version of the DSS specification. If absent, the version value defaults to "1.1".
        </xs:documentation>
      </xs:annotation>
    </xs:attribute>
  </xs:complexType>
  
  <xs:complexType name="SignResponseExtensionType">
    <xs:sequence>
      <xs:element ref="csig:ResponseTime"/>
      <xs:element ref="csig:Request" minOccurs="0" />
      <xs:element ref="csig:SignerAssertionInfo" minOccurs="0" maxOccurs="1" />
      <xs:element ref="csig:SignatureCertificateChain" minOccurs="0" />
      <xs:element ref="csig:OtherResponseInfo" minOccurs="0" />
    </xs:sequence>
    <xs:attribute name="Version" type="xs:string" default="1.1">
      <xs:annotation>
        <xs:documentation>
          The version of the DSS specification. If absent, the version value defaults to "1.1".
        </xs:documentation>
      </xs:annotation>
    </xs:attribute>
  </xs:complexType>

  <xs:complexType name="CertificateChainType">
    <xs:sequence>
      <xs:element name="X509Certificate" type="xs:base64Binary" maxOccurs="unbounded" />
    </xs:sequence>
  </xs:complexType>

  <xs:complexType name="MappedAttributeType">
    <xs:sequence>
      <xs:element name="AttributeAuthority" type="saml:NameIDType" 
                  minOccurs="0" maxOccurs="unbounded" />
      <xs:element name="SamlAttributeName" type="csig:PreferredSAMLAttributeNameType"
                  minOccurs="0" maxOccurs="unbounded" />
    </xs:sequence>
    <xs:attribute name="CertAttributeRef" type="xs:string" use="optional" />
    <xs:attribute name="CertNameType" default="rdn" use="optional">
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="rdn" />
          <xs:enumeration value="san" />
          <xs:enumeration value="sda" />
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
    <xs:attribute name="FriendlyName" type="xs:string" />
    <xs:attribute name="DefaultValue" type="xs:string" />
    <xs:attribute name="Required" type="xs:boolean" default="false" />
  </xs:complexType>

  <xs:complexType name="RequestedAttributesType">
    <xs:sequence>
      <xs:element name="RequestedCertAttribute" type="csig:MappedAttributeType"
                  minOccurs="1" maxOccurs="unbounded" />
    </xs:sequence>
  </xs:complexType>

  <xs:complexType name="AnyType">
    <xs:sequence>
      <xs:any processContents="lax" minOccurs="0" maxOccurs="unbounded" />
    </xs:sequence>
  </xs:complexType>

  <xs:complexType name="SAMLAssertionsType">
    <xs:sequence>
      <xs:element name="Assertion" type="xs:base64Binary" maxOccurs="unbounded" />
    </xs:sequence>    
  </xs:complexType>

  <xs:complexType name="PreferredSAMLAttributeNameType">
    <xs:simpleContent>
      <xs:extension base="xs:string">
        <xs:attribute name="Order" type="xs:int" default="0" />
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>

  <xs:complexType name="SignTasksType">
    <xs:sequence>
      <xs:element maxOccurs="unbounded" ref="csig:SignTaskData"/>
    </xs:sequence>
  </xs:complexType>
  
  <xs:complexType name="SignTaskDataType">
    <xs:sequence>
      <xs:element ref="csig:ToBeSignedBytes" />
      <xs:element ref="csig:AdESObject" minOccurs="0" maxOccurs="1" />
      <xs:element ref="csig:Base64Signature" minOccurs="0" />
      <xs:element ref="csig:OtherSignTaskData" minOccurs="0" />
    </xs:sequence>
    <xs:attribute name="SignTaskId" type="xs:string">
      <xs:annotation>
        <xs:documentation>
          A distinguishing id of this sign task which is used to distinguish between 
          multiple sign tasks in the same request.
        </xs:documentation>
      </xs:annotation>
    </xs:attribute>
    <xs:attribute name="SigType" use="required">
      <xs:annotation>
        <xs:documentation>
          Enumeration of the type of signature the canonical signed information is
          associated with.
        </xs:documentation>
      </xs:annotation>
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="XML" />
          <xs:enumeration value="PDF" />
          <xs:enumeration value="CMS" />
          <xs:enumeration value="ASiC" />
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
    <xs:attribute name="AdESType" default="None">
      <xs:annotation>
        <xs:documentation>
          Specifies the type of AdES signature. BES means that the signing certificate
          hash must be covered by the signature. EPES means that the signing 
          certificate hash and a signature policy identifier must be covered by 
          the signature.
        </xs:documentation>
      </xs:annotation>
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="None" />
          <xs:enumeration value="BES" />
          <xs:enumeration value="EPES" />
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
    <xs:attribute name="ProcessingRules" type="xs:anyURI" use="optional">
      <xs:annotation>
        <xs:documentation>
          An identifier for processing rules that must be executed by the signature 
          service when processing data in this element.
        </xs:documentation>
      </xs:annotation>
    </xs:attribute>
  </xs:complexType>

  <xs:complexType name="AdESObjectType">
    <xs:sequence>
      <xs:element name="SignatureId" type="xs:string" minOccurs="0" />
      <xs:element name="AdESObjectBytes" type="xs:base64Binary" minOccurs="0" />
      <xs:element name="OtherAdESData" type="csig:AnyType" minOccurs="0" />
    </xs:sequence>
  </xs:complexType>

  <xs:complexType name="CertRequestPropertiesType">
    <xs:sequence>
      <xs:element ref="saml:AuthnContextClassRef" minOccurs="0" maxOccurs="unbounded">
        <xs:annotation>
          <xs:documentation>
            The URI reference(s) to the requested level of assurance with which the 
            certificate subject should be authenticated.
          </xs:documentation>
        </xs:annotation>
      </xs:element>
      <xs:element ref="csig:RequestedCertAttributes" minOccurs="0" />
      <xs:element ref="csig:OtherProperties" minOccurs="0" />
    </xs:sequence>
    <xs:attribute default="PKC" name="CertType">
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="PKC" />
          <xs:enumeration value="QC" />
          <xs:enumeration value="QC/SSCD" />
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
  </xs:complexType>

  <xs:complexType name="SignerAssertionInfoType">
    <xs:sequence>
      <xs:element ref="csig:ContextInfo" />
      <xs:element ref="saml:AttributeStatement" />
      <xs:element ref="csig:SamlAssertions" minOccurs="0" />
    </xs:sequence>
  </xs:complexType>

  <xs:complexType name="ContextInfoType">
    <xs:sequence minOccurs="0" maxOccurs="1">
      <xs:element name="IdentityProvider" type="saml:NameIDType" />
      <xs:element name="AuthenticationInstant" type="xs:dateTime" />
      <xs:element ref="saml:AuthnContextClassRef" />
      <xs:element name="ServiceID" type="xs:string" minOccurs="0" />
      <xs:element name="AuthType" type="xs:string" minOccurs="0" />
      <xs:element name="AssertionRef" type="xs:string" minOccurs="0" />
    </xs:sequence>
  </xs:complexType>
  
  <xs:complexType name="Base64SignatureType">
    <xs:simpleContent>
      <xs:extension base="xs:base64Binary">
        <xs:attribute name="Type" type="xs:anyURI" />
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>

  <xs:complexType name="SignMessageType">
    <xs:choice>
      <xs:element ref="csig:Message" />
      <xs:element ref="csig:EncryptedMessage" />
    </xs:choice>
    <xs:attribute name="MustShow" type="xs:boolean" default="false" />
    <xs:attribute name="DisplayEntity" type="xs:anyURI" />
    <xs:attribute name="MimeType" default="text">
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="text/html" />
          <xs:enumeration value="text" />
          <xs:enumeration value="text/markdown" />
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
    <xs:anyAttribute namespace="##other" processContents="lax" />
  </xs:complexType>

</xs:schema>
```
