<p>
<img align="left" src="img/sweden-connect.png"></img>
<img align="right" src="img/digg_centered.png"></img>
</p>
<p>
<img align="center" src="img/transparent.png"></img>
</p>

# DSS Extension for Federated Central Signing Services

### Version 1.6 - 2026-08-17 - Draft

Registration number: **2019-314**

---

<p class="copyright-statement">
Copyright &copy; <a href="https://www.digg.se">The Swedish Agency for Digital Government (Digg)</a>, 2015-2026. All Rights Reserved.
</p>

## Table of Contents

1. [**Introduction**](#introduction)

    1.1. [Terminology](#terminology)

    1.1.1. [Keywords](#keywords)

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

    3.2.1.2. [Type AssertionsType](#type-assertionstype)

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

This specification defines elements that extend the `<dss:SignRequest>` and `<dss:SignResponse>` elements of \[[OASIS-DSS](#dss)\].

One element `<SignRequestExtension>` is defined for extending signature requests and one element `<SignResponseExtension>` is defined for extending signature responses. The `<SignTasks>` element extends the `<dss:InputDocuments>` element of signature requests and `<dss:SignatureObject>` element of signature responses.

These extensions to the DSS protocols provide essential protocol elements in a scenario where:

- The user's signature is requested by a service with which the user has an active session and where this service has authenticated the user using a SAML assertion or an OpenID Connect ID Token.

- The Service Provider holds the data to be signed.

- The Central Signature Service is requested to authenticate the user with the same SAML Identity Provider or OpenID Connect Provider that was used to authenticate the user to the Service Provider.

This particular use case is relevant when a user logs in to a service using a federated identity, where the user at some point is required to sign some data such as a tax declaration or payment transaction. The user is forwarded to the Signature Service together with a Sign Request from the Service Provider, specifying the information to be signed together with the conditions for signing. After completed signing, the user is returned to the Service Provider together with a Sign Response from which the Service Provider can assemble a complete signed document, signed by the user.

This scenario requires more information in both Sign Requests and Sign Responses than the original DSS core standard provides, and it also requires the capability to let the service provider sign the Sign Request.

<a name="terminology"></a>
### 1.1. Terminology

<a name="keywords"></a>
#### 1.1.1.  Keywords

The keywords MUST, MUST NOT, REQUIRED, SHALL, SHALL NOT, SHOULD, SHOULD NOT, RECOMMENDED, MAY, and OPTIONAL are to be interpreted as described in \[[RFC 2119](#rfc2119)\].

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behavior that affect the interoperability and security of implementations.

When these words are not capitalized, they are meant in their natural-language sense.

<a name="structure"></a>
#### 1.1.2. Structure

This specification uses the following typographical conventions in text: `<ThisSpecifictionElements>`, `<ns:ForeignElement>`, Attribute, **Datatype**, OtherCode.

Listings of DSS schemas appear like this.

<a name="definitions"></a>
#### 1.1.3. Definitions

**Signer**

> The user that signs data at the Signature Service.

**Identity Provider**

> A service that is assigned to authenticate the Signer, typically a SAML Identity Provider or OpenID Provider.

**Signature Service**

> A service that receives Sign Requests and responds with Sign Responses according to this specification.

**Service Provider**

> A service that has identified the Signer through the user's Identity Provider and requests that the Signer signs data using the Signature Service.

<a name="schema-organization-and-namespaces"></a>
### 1.2. Schema Organization and Namespaces

The structures described in this specification are contained in the XML schema for this protocol \[[Csig-XSD](#csig-xsd)\]. All schema listings in the current document are excerpts from the complete XML schema. 

This schema is associated with the following XML namespace:

`http://id.elegnamnden.se/csig/1.1/dss-ext/ns`

Compliance with this specification requires support of the latest version of the \[[Csig-XSD](#csig-xsd)\] schema which is 1.1.4.

If a future, non backwards compatible, version of this specification is needed, it will use a
different namespace.

Conventional XML namespace prefixes are used in the schema:

- The prefix `csig`: stands for this specification's XML schema namespace \[[Csig-XSD](#csig-xsd)\].

- The prefix `dss`: stands for the DSS core namespace \[[OASIS-DSS](#dss)\].

- The prefix `ds`: stands for the W3C XML Signature namespace \[[XMLDSIG](#xmldsig)\].

- The prefix `xs`: stands for the W3C XML Schema namespace \[[Schema1](#schema1)\].

- The prefix `saml`: stands for the OASIS SAML Schema namespace \[[SAML2.0](#saml)\].

- The prefix `xades`: stands for the ETSI XAdES Schema namespace \[[XAdES](#xades)\].

Applications MAY use different namespace prefixes, and MAY use whatever namespace defaulting/scoping conventions they desire, as long as they are compliant with the Namespaces in XML specification \[[XML-ns](#xml-ns)\].

The following schema fragment defines the XML namespaces and other header information for this specification's core XML schema:

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

The following sections define how to use and interpret common data types that appear throughout the specification.

<a name="string-values"></a>
#### 1.3.1. String values

All string values have the type **xs:string**, which is built in to the W3C XML Schema Datatypes specification \[[Schema2](#schema2)\]. Unless otherwise noted in this specification or particular profiles, all strings in this specification MUST consist of at least one non-whitespace character (whitespace is defined in the XML Recommendation \[[XML](#xml)\] Section 2.3).

Unless otherwise noted in this specification, all elements that have the XML Schema **xs:string** type, or a type derived from that, MUST be compared using an exact binary comparison. In particular, implementations MUST NOT depend on case-insensitive string comparisons, normalization or trimming of whitespace, or conversion of locale-specific formats such as numbers or currency. This requirement is intended to conform to the W3C working group note "Requirements for String
Identity, Matching, and String Indexing" \[[W3C-CHAR](https://www.w3.org/TR/charreq/)\].

<a name="uri-values"></a>
#### 1.3.2. URI Values

All SAML URI reference values have the type **xs:anyURI**, which is built in to the W3C XML Schema Datatypes specification \[[Schema2](#schema2)\].

Unless otherwise indicated in this specification, all URI reference values used within defined elements or attributes MUST consist of at least one non-whitespace character, and are REQUIRED to be absolute \[[RFC 3986](#rfc3986)\].

Note that this specification makes use of URI references as identifiers, such as status codes, format types, attribute and system entity names, etc. In such cases, it is essential that the values be both unique and consistent, such that the same URI is never used at different times to
represent different underlying information.

<a name="time-values"></a>
#### 1.3.3. Time Values

All time values have the type **xs:dateTime**, which is built in to the W3C XML Schema Datatypes specification \[[Schema2](#schema2)\], and MUST be expressed in UTC form, with no time zone component.

Implementations SHOULD NOT rely on time resolution finer than milliseconds. Implementations MUST NOT generate time instants that specify leap seconds.

<a name="mime-types-for-dsstransformeddata"></a>
#### 1.3.4. MIME Types for &lt;dss:TransformedData&gt;

The following MIME type is defined for transformed data included in a `<dss:Base64Data>` element within a `<dss:TransformedData>` element in a `<dss:SignRequest>`.

**application/cms-signed-attributes**

> This MIME type identifies that the data contained in the `<dss:Base64Data>` element, is a DER encoded CMS signed attributes structure \[[RFC 5652](#rfc5652)\]. This data is useful when signing a PDF document in cases where the whole PDF document is not included in the request. The signature on a PDF document is generated by signing the hash of a CMS signed attributes structure representing the PDF document to be signed. These signed attributes include data that a Signature Service may want to check before signing, such as the claimed signing time.

<a name="common-protocol-structures"></a>
## 2. Common Protocol Structures

The following sections describe XML structures and types that are used in multiple places.

<a name="type-anytype"></a>
### 2.1. Type AnyType

The **AnyType** complex type allows arbitrary XML element content within an element of this type (see section 3.2.1 Element Content \[[XML](#xml)\]).

```
<xs:complexType name="AnyType">
  <xs:sequence>
    <xs:any processContents="lax" minOccurs="0" maxOccurs="unbounded" />
  </xs:sequence>
</xs:complexType>
```

<a name="federated-signing-dss-extensions"></a>
## 3. Federated Signing DSS Extensions

This section defines elements that extend the `<dss:SignRequest>` and `<dss:SignResponse>` elements of the DSS Signing Protocol.

<a name="element-signrequestextension"></a>
### 3.1. Element &lt;SignRequestExtension&gt;

The `<SignRequestExtension>` element allows a requesting service to add essential request information to a DSS Sign Request. When present, this element MUST be included in the `<dss:OptionalInputs>` element of a DSS Sign Request. This element's **SignRequestExtensionType** complex type includes the following attributes and elements:

`Version` \[Optional\] (Default `1.1`)

> The version of this specification supported by the sender. If absent, the version value defaults to "1.1". 
>
> This attribute provides means for the receiving service (i.e., the Signature Service) to determine the expected semantics of the request based on the protocol version. 
>
> The receiving service MUST use the same version in the resulting response, see [section 3.2](#element-signresponseextension). If the receiving service does not support the requested version, the service MUST refuse to process the request and respond with an error message where `<dss:ResultMajor>` is set to `urn:oasis:names:tc:dss:1.0:resultmajor:RequesterError` and `<dss:ResultMinor>` is set to `urn:oasis:names:tc:dss:1.0:resultminor:NotSupported`.

`<RequestTime>` \[Required\]

> The time when this request was created.

`<saml:Conditions>` \[Required\]

> This element MUST include the element `<saml:AudienceRestriction>` which in turn MUST contain one `<saml:Audience>` element, specifying the return URL for the resulting Sign Response message.

`<Signer>`, `<SamlAuthenticationAttributes>`, `<OidcAuthenticationAttributes>`, or `<OtherAuthenticationAttributes>` \[Optional\]

> The identity of the Signer expressed as a choice between:

> - `Signer`/`SamlAuthenticationAttributes` - a SAML attribute statement holding a sequence of SAML attributes.
> - `OidcAuthenticationAttributes` - a set of OpenID Connect claims.
> - `OtherAuthenticationAttributes` - an open type that can hold other attribute representations.
>
> If this element is present, the Signature Service MUST verify that the authenticated identity of the Signer is consistent with the attributes in this element.
>
> **Note**: `Signer` is the only valid choice for versions prior to 1.6 of this specification. If any other element is used, the `Version` attribute of the `SignRequestExtension` element MUST be set to "1.6" or higher. Implementations prior to version 1.6 do not support these elements.
>
> For versions 1.6 or higher, `SamlAuthenticationAttributes` is preferred over `Signer` for representing SAML-authenticated Signers.

`<IdentityProvider>` \[Required\]

> The identifier for the Identity Provider that MUST be used to authenticate the Signer before signing.
>
> This identifier may be an entityID of a SAML Identity Provider, an Issuer URI of an OpenID Connect Provider, or possibly another type of service.
>
> The `AuthnProfile` element (see below) MAY be used to indicate the type of Identity Provider (should it not be known from the deployment's context).
>
> The value is specified using the **saml:NameIDType** complex type. If the element represents a SAML Identity Provider, it MUST include a `Format` attribute with the value `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`. If the element represents any other type of identity provider (such as an OpenID Connect Provider), the `Format` attribute SHOULD be omitted.

`<AuthnProfile>` \[Optional\]

> An opaque string that can be used to inform the Signature Service about specific requirements regarding the user authentication at the given Identity Provider (see above). This specification does not define any possible values or semantics for the element.

> **Note:** If this element is set, the `Version` attribute of the `SignRequestExtension` element MUST be set to "1.4" or higher. Implementations prior to version 1.4 of this specification do not support the element.

`<SignRequester>` \[Required\]

> The identifier for the service that sends this request to the Signature Service. Typically, this is a SAML entityID or an OpenID Connect identifier.
>
> The value is specified using the **saml:NameIDType** complex type. If the element represents a SAML entity, it MUST include a `Format` attribute with the value `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`. Otherwise, the `Format` attribute SHOULD be omitted.


`<SignService>` \[Required\]

> The identifier for the service to which this Sign Request is sent, i.e., the Signature Service. This is typically a SAML entityID or an OpenID Connect client identifier.

> The value is specified using the **saml:NameIDType** complex type. If the element represents a SAML entity, it MUST include a `Format` attribute with the value `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`. Otherwise, the `Format` attribute SHOULD be omitted.

`<RequestedSignatureAlgorithm>` \[Optional\]

> An identifier of the signature algorithm the requesting service prefers when generating the requested signature.

`<SignMessage>` \[Optional\]

> Optional sign message with information to the Signer about the requested signature.

`<CertRequestProperties>` \[Optional\]

> An optional set of requested properties of the signature certificate that is generated as part of the signature process.

`<OtherRequestInfo>` \[Optional\]

> Any additional inputs to the request extension.

The following schema fragment defines the `<SignRequestExtension>` element and its **SignRequestExtensionType** complex type:

```
<xs:complexType name="SignRequestExtensionType">
  <xs:sequence>
    <xs:element ref="csig:RequestTime"/>
    <xs:element ref="saml:Conditions"/>
    <xs:choice minOccurs="0">
      <xs:element name="Signer" type="saml:AttributeStatementType"/>
      <xs:element ref="csig:SamlAuthenticationAttributes"/>
      <xs:element ref="csig:OidcAuthenticationAttributes"/>
      <xs:element ref="csig:OtherAuthenticationAttributes"/>
    </xs:choice>
    <xs:element ref="csig:IdentityProvider"/>
    <xs:element ref="csig:AuthnProfile" minOccurs="0"/>
    <xs:element ref="csig:SignRequester"/>
    <xs:element ref="csig:SignService"/>
    <xs:element ref="csig:RequestedSignatureAlgorithm" minOccurs="0"/>
    <xs:element ref="csig:CertRequestProperties" minOccurs="0"/>
    <xs:element ref="csig:SignMessage" minOccurs="0" maxOccurs="1"/>
    <xs:element ref="csig:OtherRequestInfo" minOccurs="0"/>
  </xs:sequence>
  <xs:attribute name="Version" type="xs:string" use="optional" default="1.1"/>
</xs:complexType>
```

<a name="type-certrequestpropertiestype"></a>
#### 3.1.1. Type CertRequestPropertiesType

The **CertRequestPropertiesType** complex type is used to specify requested properties of the signature certificate that is associated with the generated signature.

The **CertRequestPropertiesType** complex type has the following attributes and elements:

`CertType` \[Default "PKC"\]

> An enumeration of certificate types where "PKC" is the default. The supported values are "PKC", "QC", and "QC/SSCD". "QC" means that the certificate is requested to be a Qualified Certificate according to legal definitions in national law governing the issuer. "QC/SSCD" means a Qualified Certificate where the private key is declared to be residing within a Secure Signature Creation Device according to national law. "PKC" (Public Key Certificate) means a certificate that is not a Qualified Certificate.

`<saml:AuthnContextClassRef>` \[Zero or More\]

> Identifier(s) (URIs) identifying the requested authentication context class reference (level of assurance) that authentication of the signature certificate subject MUST comply with in order to complete signing and certificate issuance.
>
> A Signature Service MUST NOT issue signature certificates or generate the requested signature unless the authentication process used to authenticate the requested Signer meets one of the requested values expressed in this element. 
>
> If this element is absent, the locally configured policy of the Signature Service is assumed. This can either mean that the Signature Service includes one or more locally configured identifiers in the authentication request issued to authenticate the user, or that an authentication request with no requirements for requested authentication context class reference is used.
>
> **Note:** If more than one identifier is given, the `Version` attribute of the `SignRequestExtension` element MUST be set to "1.4" or higher. Implementations prior to version 1.4 of this specification assume that this element may only contain one identifier.


`<RequestedCertAttributes>` \[Optional\]

> An optional set of requested attributes that the requesting service prefers or requires to be present in the generated signing certificate.
> 
> The element provides mappings between identity attributes from the user identity token and certificate entries.

`<OtherProperties>` \[Optional\]

> Other requested properties of the signature certificate.

The following schema fragment defines the **CertRequestPropertiesType** complex type:

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

The **RequestedAttributesType** complex type is used to represent requests for subject attributes in a signer certificate that is associated with the Signer of the generated signature as a result of the Sign Request. 

This protocol is designed to accommodate the scenario where the Signature Service generates the signer key and the signer certificate at the time of signing and where it collects the user's attributes from an identity token (SAML assertion or OpenID Connect ID Token). 

> This element can also be used as a requirement for attributes in existing certificates, where the Signature Service can determine if the existing signing certificate matches the requirements of the requesting service.

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

`CertAttributeRef` \[Required\]

> A reference to the certificate attribute or name type where the requester wants to store this attribute value. The information in this attribute depends on the selected `CertNameType` attribute value.
>
>
> If the `CertNameType` is `rdn` or `sda`, then this attribute MUST contain a string representation of an object identifier (OID). If the `CertNameType` is `san` (Subject Alternative Name) and the target name is a GeneralName, then this attribute MUST hold a string representation of the tag value of the target GeneralName type, e.g. "1" for rfc822Name (e-mail) or "2" for dNSName. If the `CertNameType` is `san` and the target name form is an OtherName, then this attribute value MUST include a string representation of the object identifier of the target OtherName form.
>
>
> Representation of an OID as a string in this attribute MUST consist of a sequence of integers delimited by a dot. This string MUST NOT contain white space or line breaks. Example: "2.5.4.32".


`CertNameType` \[Optional\] (Default "rdn")

> An enumeration of the target name form for storing the associated attribute value in the certificate. The available values are:
> - `rdn` – for storing the attribute value as an attribute in a Relative Distinguished Name in the subject field of the certificate,
> - `san` – for storing the attribute value in a Subject Alternative Name extension, and
> - `sda` – for storing the attribute value in a Subject Directory Attribute extension.
>
> The default value for this attribute is `rdn`.

`FriendlyName` \[Optional\]

> An optional friendly name of the subject attribute, e.g. "givenName".
>
> Note that this name does not need to map to any particular naming convention and its value MUST NOT be used by the Signature Service for attribute type mapping. This name is present for display purposes only.

`DefaultValue` \[Optional\]

> An optional default value for the requested attribute. This value MAY be used by the Signature Service if no authoritative value for the attribute can be obtained when the Signature Service authenticates the user. The value MUST NOT be used by the Signature Service unless this value is consistent with a defined policy at the Signature Service. 
>
> A typical valid use of this attribute is to hold a default country name attribute value that matches a set of allowed country name values. By accepting the default attribute value provided in this attribute, the Signature Service accepts the requesting service as an authoritative source for this particular requested attribute.

`Required` \[Optional\] (Default `false`)

> If this attribute is set to true, the Signature Service MUST ensure that either an authoritative value for the attribute can be obtained from the user authentication, or that an acceptable default value exists, or else the Signature Service MUST NOT generate the requested certificate.

`<AttributeAuthority>` \[Zero or More\]

> Element holding an identity of an attribute provider that MAY be used to obtain an attribute value for the requested attribute. 
>
> If this authority is a SAML Attribute Authority, the value MUST be the entityID of the Attribute Authority and MUST include a `Format` attribute with the value `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`. For other types of attribute providers the `Format` attribute SHOULD NOT be present.

`<AttributeName>` \[Zero or More\]

> Element of type **PreferredAttributeNameType** complex type holding a name of a subject attribute/claim that is allowed to provide the content value for the requested certificate attribute.
>
>
> For versions prior to 1.6 of this specification, the `SamlAttributeName` element (see below) is used. For backwards-compatibility reasons, a Signature Service supporting version 1.6 and later of this specification MUST also accept the `SamlAttributeName` element. 
>
>
> If the `AttributeName` choice is set, the `Version` attribute of the `SignRequestExtension` element MUST be set to "1.6" or higher. 


The following schema fragment defines the **MappedAttributeType**
complex type:

```
  <xs:complexType name="MappedAttributeType">
    <xs:sequence>
      <xs:element name="AttributeAuthority" type="saml:NameIDType"
                  minOccurs="0" maxOccurs="unbounded"/>
      <xs:choice>
        <xs:element name="SamlAttributeName" type="csig:PreferredSAMLAttributeNameType"
                    minOccurs="0" maxOccurs="unbounded"/>
        <xs:element name="AttributeName" type="csig:PreferredAttributeNameType"
                    minOccurs="0" maxOccurs="unbounded"/>
      </xs:choice>
    </xs:sequence>
    <xs:attribute name="CertAttributeRef" type="xs:string" use="required"/>
    <xs:attribute name="CertNameType" default="rdn">
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="rdn"/>
          <xs:enumeration value="san"/>
          <xs:enumeration value="sda"/>
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
    <xs:attribute name="FriendlyName" type="xs:string"/>
    <xs:attribute name="DefaultValue" type="xs:string"/>
    <xs:attribute name="Required" type="xs:boolean" default="false"/>
  </xs:complexType>
```

The **PreferredAttributeNameType** complex type holds a string value of an attribute/claim name. This attribute/claim name SHALL be mapped against attribute/claim names in an authentication token (SAML Assertion or OpenID Connect ID Token) that is used to authenticate the Signer.

The **PreferredAttributeNameType** complex type has the following attributes:

`Order` \[Optional\] (Default 0)

> An integer specifying the order of preference regarding this attribute. If more than one attribute is listed, the attribute that is present in the authentication token (e.g., a SAML assertion or an OIDC ID Token) and has the lowest Order value SHALL be used.
>
> Attributes with an absent Order attribute SHALL be treated as having an Order value of 0. Multiple attributes with identical Order values SHALL be treated as having equal priority.

`AuthnProtocol` \[Optional\] (Default "saml")

> Tells which type of attribute is represented: "saml", "oidc", or a custom value.
>
> This attribute MAY be used when a Signature Service supports multiple authentication protocols.

The following schema fragment defines the **PreferredAttributeNameType** complex type:

```
<xs:complexType name="PreferredAttributeNameType">
  <xs:simpleContent>
    <xs:extension base="xs:string">
      <xs:attribute name="Order" type="xs:int" default="0"/>
      <xs:attribute name="AuthnProtocol" type="csig:AuthnProtocolType" default="saml"/>
    </xs:extension>
  </xs:simpleContent>
</xs:complexType>

<xs:simpleType name="AuthnProtocolType">
  <xs:union>
    <xs:simpleType>
      <xs:restriction base="xs:string">
        <xs:enumeration value="saml"/>
        <xs:enumeration value="oidc"/>
      </xs:restriction>
    </xs:simpleType>
    <xs:simpleType>
      <xs:restriction base="xs:string"/>
    </xs:simpleType>
  </xs:union>
</xs:simpleType>
```

<a name="element-signmessage"></a>
#### 3.1.2. Element &lt;SignMessage&gt;

The `<SignMessage>` element holds a message, to be displayed to the Signer, with information about what is being signed.

The Sign Message is provided either in plain text using the `<Message>` child element or as an encrypted message using the `<EncryptedMessage>` child element. This element's **SignMessageType** complex type includes the following attributes and elements:

`MustShow` \[Optional\] (Default `false`)

> When this attribute is set to `true`, the requested signature MUST NOT be created unless this message has been displayed and accepted by the Signer. The default is `false`.

`DisplayEntity` \[Optional\]

> The identifier of the entity responsible for displaying the Sign Message to the Signer. When the Sign Message is encrypted, this entity is also the holder of the private decryption key necessary to decrypt the Sign Message.

`MimeType` \[Optional\] (Default `text`)

> The MIME type defining the message format. This is an enumeration of the valid attribute values `text` (plain text), `text/html` (html) or `text/markdown` (markdown).
>
> This specification does not specify any particular restrictions on the provided message, but it is RECOMMENDED that Sign Message content is restricted to a limited set of valid tags and attributes, and that the display entity performs filtering to enforce these restrictions before displaying the message. The means through which parties agree on such restrictions are outside the scope of this specification, but one valid option to communicate such restrictions could be through federation metadata.

`<Message>` \[Choice\]

> The Base64-encoded Sign Message in unencrypted form. The message MUST be UTF-8 encoded prior to Base64 encoding.

`<EncryptedMessage>` \[Choice\]

> An encrypted `<Message>` element. 

> Either a `<Message>` or an `<EncryptedMessage>` element MUST be present.

The following schema fragment defines the `<SignMessage>` element and the **SignMessageType** complex type:

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

The `<SignResponseExtension>` element is an extension that allows a Signature Service to add essential information to the Sign Response. When present, this element MUST be included in the `<dss:OptionalOutputs>` element in a `<dss:SignResponse>` element.

This element's **SignResponseExtensionType** complex type includes the following attributes and elements:

`Version` \[Optional\] (Default `1.1`)

> The version of this specification under which the response message was produced. This attribute provides means for the receiving service to determine the expected semantics of the response based on the protocol version.
>
> If absent, the version value defaults to "1.1". 
>
> **Note:** The sender (Signature Service) MUST use the same version number as received in the `Version` attribute of the `SignRequestExtension` (see [section 3.1](#element-signrequestextension)).

`<ResponseTime>` \[Required\]

> The time when the Sign Response was created.

`<Request>` \[Optional\]

> A Base64-encoded signed `<dss:SignRequest>` element that contains the request related to this Sign Response. This element MAY be present if signing was successful.

`<SignerAssertionInfo>` \[Optional\]

> An element of type **SignerAssertionInfoType** holding information about how the Signer was authenticated by the Signature Service, as well as the subject attribute values from the token authenticating the Signer that were incorporated into the signer certificate.
>
> This element MUST be present if signing was successful.

`<SignatureCertificateChain>` \[Optional\]

> An element of type **CertificateChainType** holding the signer certificate as well as other certificates that may be used to validate the signature. This element MUST be present if signing was successful and MUST contain all certificates that are necessary to compile a complete and functional signed document.
>
> The certificates MUST be provided in sequence, with the signer certificate first, followed by any CA certificates that can be used to verify the previous certificate in the sequence, ending with a root CA certificate.

`<OtherResponseInfo>` \[Optional\]

> Optional Sign Response elements of type **AnyType**.

The following schema fragment defines the `<SignResponseExtension>` element and the **SignResponseExtensionType** complex type:

```
<xs:element name="SignResponseExtension" type="csig:SignResponseExtensionType" />

<xs:complexType name="SignResponseExtensionType">
  <xs:sequence>
    <xs:element ref="csig:ResponseTime"/>
    <xs:element ref="csig:Request" minOccurs="0"/>
    <xs:element ref="csig:SignerAssertionInfo" minOccurs="0"/>
    <xs:element ref="csig:SignatureCertificateChain" minOccurs="0"/>
    <xs:element ref="csig:OtherResponseInfo" minOccurs="0"/>
  </xs:sequence>
  <xs:attribute name="Version" type="xs:string" default="1.1"/>
</xs:complexType>

<xs:element name="ResponseTime" type="xs:dateTime"/>
<xs:element name="Request" type="xs:base64Binary"/>
<xs:element name="SignerAssertionInfo" type="csig:SignerAssertionInfoType"/>
<xs:element name="SignatureCertificateChain" type="csig:CertificateChainType"/>
<xs:element name="OtherResponseInfo" type="csig:AnyType"/>
```

<a name="type-signerassertioninfotype"></a>
#### 3.2.1. Type SignerAssertionInfoType

The **SignerAssertionInfoType** complex type has the following elements and attributes:

`AuthnProtocol` \[Optional\] (Default "saml")

> The authentication protocol used to authenticate the Signer. For backwards compatibility, the default is "saml". If any other authentication protocol was used, this attribute MUST be explicitly set (for versions 1.6 or higher).

`<ContextInfo>` \[Required\]

> This element of type **ContextInfoType** holds information about the authentication context related to Signer authentication through an authentication token (SAML assertion or OpenID Connect ID Token). The contents of this element MUST correspond to the `AuthnProtocol` attribute.

`<saml:AttributeStatement>`, `<csig:OidcAuthenticationAttributes>` or `<csig:OtherAuthenticationAttributes>` \[Required\]

> Contains subject attributes obtained from the authentication of the Signer. Depending on the authentication protocol used to authenticate the Signer (see `AuthnProtocol` above), `<saml:AttributeStatement>` is used to represent SAML attributes from a SAML authentication, `<csig:OidcAuthenticationAttributes>` is used to represent OpenID Connect claims from an OpenID Connect authentication, and if an other authentication protocol was used, `<csig:OtherAuthenticationAttributes>` is set.
>
> For integrity reasons, it is RECOMMENDED that this element only provides information about attribute values that maps to subject identity information in the Signer's certificate.

`<Assertions>` or `<SamlAssertions>` \[Optional\]

> Any number of relevant assertions that were used for authenticating the Signer and the Signer's identity attributes at the Signature Service.
>
> Deployments according to version 1.6 and higher of this specification SHOULD use the Assertions choice that supports any type of assertion (depending on the authentication protocol). The `SamlAssertions` choice is for backwards compatibility (versions prior to 1.6) and supports only SAML assertions.

The following schema fragment defines the **SignerAssertionInfoType**
complex type:

```
<xs:complexType name="SignerAssertionInfoType">
  <xs:sequence>
    <xs:element ref="csig:ContextInfo"/>
    <xs:choice>
      <xs:element ref="saml:AttributeStatement"/>
      <xs:element ref="csig:OidcAuthenticationAttributes"/>
      <xs:element ref="csig:OtherAuthenticationAttributes"/>
    </xs:choice>    
    <xs:choice minOccurs="0">
      <xs:element name="Assertions" type="csig:AssertionsType"/>
      <xs:element ref="csig:SamlAssertions"/>
    </xs:choice>
  </xs:sequence>
  <xs:attribute name="AuthnProtocol" type="csig:AuthnProtocolType" default="saml"/>
</xs:complexType>

<xs:element name="ContextInfo" type="csig:ContextInfoType"/>
```

<a name="type-contextinfotype"></a>
##### 3.2.1.1. Type ContextInfoType

The **ContextInfoType** complex type has the following elements:

`<IdentityProvider>`\[Required\]

> The identifier of the Identity Provider that authenticated the Signer to the Signature Service.
>
> If the element represents a SAML Identity Provider, it MUST include a `Format` attribute with the value `urn:oasis:names:tc:SAML:2.0:nameid-format:entity`. If the element represents any other type of identity provider (such as an OpenID Connect Provider), the `Format` attribute SHOULD be omitted.

`<AuthenticationInstant>` \[Required\]

> The time when the Signature Service authenticated the Signer.

`<saml:AuthnContextClassRef>` \[Required\]

> A URI reference to the authentication context class under which the authentication was made.

> **Note:** This type is used also for OpenID Connect.

`<ServiceID>` \[Optional\]

> An arbitrary identifier of the instance of the Signature Service that authenticated the Signer.

`<AuthType>` \[Optional\]

> An arbitrary identifier of the service used by the Signature Service to authenticate the Signer.
>
> The content of the element is not specified by this specification.

`<AssertionRef>` \[Optional\]

> A reference to the assertion/token used to identify the Signer. Depending on the authentication protocol used, this reference MAY be the ID attribute of a SAML assertion or a `jti` claim of an OpenID Connect ID Token, but it MAY also be any other reference that can be used to locate and identify the authentication assertion/token.

```
<xs:complexType name="ContextInfoType">
  <xs:sequence minOccurs="0">
    <xs:element name="IdentityProvider" type="saml:NameIDType"/>
    <xs:element name="AuthenticationInstant" type="xs:dateTime"/>
    <xs:element ref="saml:AuthnContextClassRef"/>
    <xs:element name="ServiceID" type="xs:string" minOccurs="0"/>
    <xs:element name="AuthType" type="xs:string" minOccurs="0"/>
    <xs:element name="AssertionRef" type="xs:string" minOccurs="0"/>
  </xs:sequence>
</xs:complexType>
```

<a name="type-assertionstype"></a>
##### 3.2.1.2. Type AssertionsType

The **AssertionsType** holds a collection of assertions or tokens that were used to authenticate the Signer. Each entry is one of: 

- a SAML assertion (SamlAssertion), 
- an OpenID Connect ID Token (OidcIdToken),
- an OpenID Connect UserInfo response (OidcUserInfoResponse),
- or any other assertion or token represented by an element from a foreign namespace.

Assertions/tokens stored in this element MUST retain their original canonical format so that any signature on the assertion can be validated.

```
<xs:complexType name="AssertionsType">
  <xs:choice maxOccurs="unbounded">
    <xs:element name="SamlAssertion" type="xs:base64Binary"/>
    <xs:element name="OidcIdToken" type="csig:EncodedJwtType"/>
    <xs:element name="OidcUserInfoResponse" type="csig:EncodedJwtType"/>
    <xs:any namespace="##other" processContents="lax"/>
  </xs:choice>
</xs:complexType>

<xs:simpleType name="EncodedJwtType">
  <xs:restriction base="xs:string"/>
</xs:simpleType>
```

<a name="type-certificatechaintype"></a>
#### 3.2.2. Type CertificateChainType

This complex type can be used to hold a sequence of X.509 certificates. Certificates MUST be provided in sequence, with the end-entity certificate first, followed by any CA certificates that can be used to verify the previous certificate in the sequence, ending with a self-signed root certificate.

The **CertificateChainType** complex type has the following elements:

`<X509Certificate>` \[One or More\]

> An X.509 certificate \[[RFC 5280](#rfc5280)\] that is part of a certificate chain that can be used to verify the generated signature. The certificate SHALL be represented as a base64Binary of the DER-encoded certificate.

The following schema fragment defines the **CertificateChainType**
complex type:

```
<xs:complexType name="CertificateChainType">
  <xs:sequence>
    <xs:element name="X509Certificate" type="xs:base64Binary" maxOccurs="unbounded"/>
  </xs:sequence>
</xs:complexType>
```

<a name="extensions-to-dssinputdocuments-and-dsssignatureobject"></a>
## 4. Extensions to &lt;dss:InputDocuments&gt; and &lt;dss:SignatureObject&gt; 

This section defines elements that extend the
`<dss:InputDocuments>` element of DSS Sign Requests and the
`<dss:SignatureObject>` element of DSS Sign Responses by inclusion
in their respective `<dss:Other>` element.

<a name="element-signtasks"></a>
### 4.1. Element &lt;SignTasks&gt;

The `<SignTasks>` element, when present, MUST appear either in the
`<dss:Other>` element of the `<dss:InputDocuments>` element of a
Sign Request or in the `<dss:Other>` element of the
`<dss:SignatureObject>` element of a Sign Response.

This element holds information about sign tasks that are requested in a
Sign Request and returned in a Sign Response. If information about a
sign task is provided using this element in a Sign Request, the
corresponding signature result data MUST also be provided using this
element in the Sign Response.

This element's **SignTasksType** complex type includes the following elements:

`<SignTaskData>` \[One or More\]

> Input and output data associated with a sign task. A request MAY
> contain several instances of this element. When multiple instances of
> this element are present in the request, this means that the Signature
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
<xs:element name="SignTasks" type="csig:SignTasksType"/>

<xs:complexType name="SignTasksType">
  <xs:sequence>
    <xs:element ref="csig:SignTaskData" maxOccurs="unbounded"/>
  </xs:sequence>
</xs:complexType>

<xs:element name="SignTaskData" type="csig:SignTaskDataType"/>
```

<a name="element-signtaskdata"></a>
#### 4.1.1. Element &lt;SignTaskData&gt;

When present in a Sign Request, this element provides input data to a
signature generation process. When present in a Sign Response, this
element provides the corresponding signature result data. When a request
provides input data using this type of element, an element of this
type MUST also be used to return the corresponding signature result
data.

This element's **SignTaskDataType** complex type includes the following
attributes and elements:

`SignTaskId` \[Optional\]

> An identifier of the signature task that is represented by this
> element. If the request contains multiple instances of
> `<SignTaskData>` representing separate sign tasks, each
> instance of the element MUST have a `SignTaskId` attribute value that
> is unique among all sign tasks in the Sign Request. When this
> attribute is present, the same attribute value MUST be returned in the
> corresponding `<SignTaskData>` element in the response that holds
> corresponding signature result data.

`SigType` \[Required\]

> Enumerated identifier of the type of signature format the
> canonicalized signed information octets in the `<ToBeSignedBytes>`
> element are associated with. This MUST be one of the enumerated values
> "XML", "PDF", "CMS" or "ASiC".

`AdESType` \[Optional\]

> Specifies the type of AdES signature. "BES" means that the signing
> certificate hash must be covered by the signature. "EPES" means that the
> signing certificate hash and a signature policy identifier must be
> covered by the signature.

`ProcessingRules` \[Optional\]

> A URI identifying one or more processing rules that the Signature
> Service MUST apply when processing and using the provided signed
> information octets. The Signature Service MUST NOT process and complete
> the signature request if this attribute contains a URI that is not
> recognized by the Signature Service. When this attribute is present in
> the Sign Response, it represents a statement by the Signature Service
> that the identified processing rule was successfully executed.

`<ToBeSignedBytes>` \[Required\]

> The bytes to be hashed and signed when generating the requested
> signature. For an XML signature this MUST be the canonicalized octets
> of a `<dss:SignedInfo>` element. For a PDF signature this MUST be
> the octets of the DER-encoded SignedAttrs value (signed attributes).
> In some cases the signature process alters this data, for example by
> changing a signing time attribute in PDF SignedAttrs, or by adding a
> reference to a hash of the signature certificate in an XAdES signature.
> If this data was altered, the altered data MUST be returned in the sign
> response using this element.

`<AdESObject>` \[Optional\]

> An element of the **AdESObjectType** type holding data to
> support generation of a signature according to any of the ETSI
> Advanced Electronic Signature (AdES) standard formats.

`<Base64Signature>` \[Optional\]

> The output signature value of the signature creation process
> associated with this sign task. This element's optional `Type`
> attribute, if present, SHALL contain a URI indicating the signature
> algorithm that was used to generate the signature value.

`<OtherSignTaskData>` \[Optional\]

> Provides extensibility for input or output data elements associated with the sign task.

The following schema fragment defines the `<SignTaskData>` element
and its **SignTaskDataType** complex type:

```
<xs:element name="SignTaskData" type="csig:SignTaskDataType"/>

<xs:complexType name="SignTaskDataType">
  <xs:sequence>
    <xs:element ref="csig:ToBeSignedBytes"/>
    <xs:element ref="csig:AdESObject" minOccurs="0"/>
    <xs:element ref="csig:Base64Signature" minOccurs="0"/>
    <xs:element ref="csig:OtherSignTaskData" minOccurs="0"/>
  </xs:sequence>
  <xs:attribute name="SignTaskId" type="xs:string"/>
  <xs:attribute name="SigType" use="required">
    <xs:simpleType>
      <xs:restriction base="xs:string">
        <xs:enumeration value="XML"/>
        <xs:enumeration value="PDF"/>
        <xs:enumeration value="CMS"/>
        <xs:enumeration value="ASiC"/>
      </xs:restriction>
    </xs:simpleType>
  </xs:attribute>
  <xs:attribute name="AdESType" default="None">
    <xs:simpleType>
      <xs:restriction base="xs:string">
        <xs:enumeration value="None"/>
        <xs:enumeration value="BES"/>
        <xs:enumeration value="EPES"/>
      </xs:restriction>
    </xs:simpleType>
  </xs:attribute>
  <xs:attribute name="ProcessingRules" type="xs:anyURI"/>
</xs:complexType>

<xs:element name="ToBeSignedBytes" type="xs:base64Binary"/>
<xs:element name="AdESObject" type="csig:AdESObjectType"/>
<xs:element name="Base64Signature" type="csig:Base64SignatureType"/>
<xs:element name="OtherSignTaskData" type="csig:AnyType"/>
```

<a name="type-adesobjecttype"></a>
##### 4.1.1.1. Type AdESObjectType

The **AdESObjectType** complex type holds a Base64-encoded object that
is referenced from the signature and whose content has to be modified as
part of the certificate and signature generation process. Handling of
this data in the signature generation process MAY be affected by
rules identified by the `ProcessingRules`, `SigType` and `AdESType` attributes
of the parent `<SignatureInputObjects>` element.

This complex type has the following elements:

`<SignatureId>` \[Optional\]

> An optional identifier of the signature. When the requested signature
> is an XAdES signature, this is the value of the Id attribute of the
> `<ds:Signature>` element of the resulting signature, which is used
> to construct the `Target` attribute of the
> `<xades:QualifyingProperties>` element.

`<AdESObjectBytes>` \[Optional\]

> A Base64-encoded object that is referenced from the signature and
> whose content has to be modified as part of the certificate and
> signature generation process. The type of data in the Base64-encoded
> bytes and the rules for handling this data in the signature
> generation process are determined through the `ProcessingRules`, `SigType`
> and `AdESType` attributes of the parent `<SignatureInputObjects>`
> element. When the signature type is XAdES, these are the bytes of
> the `<ds:Object>` element that holds the
> `<xades:QualifyingProperties>` element of the signature where the
> hash of the signature certificate will be placed.
>
> When this element is present in the request, it forms a base for
> construction of this object in the signature process.

`<OtherAdESData>` \[Optional\]

> An extension point for additional input data related to the AdES signature
> generation process.

The following schema fragment defines the **AdESObjectType** complex
type

```
<xs:complexType name="AdESObjectType">
  <xs:sequence>
    <xs:element name="SignatureId" type="xs:string" minOccurs="0"/>
    <xs:element name="AdESObjectBytes" type="xs:base64Binary" minOccurs="0"/>
    <xs:element name="OtherAdESData" type="csig:AnyType" minOccurs="0"/>
  </xs:sequence>
</xs:complexType>
```

<a name="signing-sign-requests-and-responses"></a>
## 5. Signing Sign Requests and Responses

This specification supports a scenario where a requesting service
requests the Signer to sign some data and where the same requesting
service receives the signature from the Signature Service. In this
scenario the requesting service acts as the presenter of information to
be signed to the Signer. Implementers of this specification MUST sign
requests and responses for signature creation to protect against
spoofing and substitution attacks. If a hash of the document to be
signed is replaced in a Sign Request, the Signer may end up signing
something completely different from what the requesting service
presented to the Signer.

When a `<dss:SignRequest>` is signed, the signature of that request
MUST be placed as the last child element in the
`<dss:OptionalInputs>` element. The service that receives the request,
i.e. the Signature Service, MUST check this signature and MUST check
that the signature covers all data in the `<dss:SignRequest>` element
(except for the signature itself).

When a `<dss:SignResponse>` is signed, the signature of that
response MUST be placed as the last child element in the
`<dss:OptionalOutputs>` element. The service that initiated the
signature process, i.e. the requesting service, MUST check this
signature and MUST check that the signature covers all data in the
`<dss:SignResponse>` element (except for the signature itself).

<a name="normative-references"></a>
## 6. Normative References

<a name="csig-xsd"></a>
**\[Csig-XSD\]**
> This specification's DSS Extensions schema Version 1.1.4, https://docs.swedenconnect.se/schemas/csig/1.1/EidCentralSigDssExt-1.1.4.xsd, August 2026.

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

**Changes between version 1.5 and 1.6:**

- OpenID Connect was introduced as an alternative to SAML for "authentication for signature". This affects many parts of the underlying schema. The updated \[[Csig-XSD](#csig-xsd)\] schema 1.1.4 is backwards compatible with the prior version of the schema at the message encoding level.

- The `CertAttributeRef` attribute of the **MappedAttributeType** was incorrectly marked as optional. This has been fixed. See Section 3.1.1.1.

**Changes between version 1.4 and 1.5:**

- The \[[Csig-XSD](#csig-xsd)\] schema was updated to version 1.1.3.

- In section 3.1, "Element SignRequestExtension", the requirements for `NotBefore` and `NotOnOrAfter` to be present under the `<saml:Conditions>` element was removed. The reason for this is that it will always be the SignService itself that determines whether a message has expired or not.

- Links in the appendix pointed to a draft version of the schema. This was fixed.

**Changes between version 1.3 and 1.4:**

- In section 3.2, "Element SignResponseExtension", the requirement for the `Request` element was changed so that it is optional to include even if the signature was successful.

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
protocol extension defined in this document. If there are differences
between the XML Schema in this appendix and XML Schema fragments in the
sections above, the XML Schema in this appendix is the normative one.

The schema can also be downloaded from https://docs.swedenconnect.se/schemas/csig/1.1/EidCentralSigDssExt-1.1.4.xsd. The downloaded version includes extensive
documentation.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
           version="1.1.4"
           targetNamespace="http://id.elegnamnden.se/csig/1.1/dss-ext/ns"
           xmlns:saml="urn:oasis:names:tc:SAML:2.0:assertion"
           xmlns:dss="urn:oasis:names:tc:dss:1.0:core:schema"
           xmlns:csig="http://id.elegnamnden.se/csig/1.1/dss-ext/ns">

  <xs:annotation>
    <xs:documentation>
      Version: 1.1.4
      Schema location URL: https://docs.swedenconnect.se/schemas/csig/1.1/EidCentralSigDssExt-1.1.4.xsd
    </xs:documentation>
  </xs:annotation>

  <xs:import namespace="urn:oasis:names:tc:SAML:2.0:assertion"
             schemaLocation="https://docs.oasis-open.org/security/saml/v2.0/saml-schema-assertion-2.0.xsd"/>

  <xs:element name="SignTasks" type="csig:SignTasksType"/>

  <xs:complexType name="SignTasksType">
    <xs:sequence>
      <xs:element maxOccurs="unbounded" ref="csig:SignTaskData"/>
    </xs:sequence>
  </xs:complexType>

  <xs:element name="SignTaskData" type="csig:SignTaskDataType"/>

  <xs:complexType name="SignTaskDataType">
    <xs:sequence>
      <xs:element ref="csig:ToBeSignedBytes"/>
      <xs:element ref="csig:AdESObject" minOccurs="0"/>
      <xs:element ref="csig:Base64Signature" minOccurs="0"/>
      <xs:element ref="csig:OtherSignTaskData" minOccurs="0"/>
    </xs:sequence>
    <xs:attribute name="SignTaskId" type="xs:string"/>
    <xs:attribute name="SigType" use="required">
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="XML"/>
          <xs:enumeration value="PDF"/>
          <xs:enumeration value="CMS"/>
          <xs:enumeration value="ASiC"/>
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
    <xs:attribute name="AdESType" default="None">
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="None"/>
          <xs:enumeration value="BES"/>
          <xs:enumeration value="EPES"/>
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
    <xs:attribute name="ProcessingRules" type="xs:anyURI"/>
  </xs:complexType>

  <xs:element name="OtherSignTaskData" type="csig:AnyType"/>

  <xs:element name="ToBeSignedBytes" type="xs:base64Binary"/>

  <xs:element name="AdESObject" type="csig:AdESObjectType"/>

  <xs:complexType name="AdESObjectType">
    <xs:sequence>
      <xs:element name="SignatureId" type="xs:string" minOccurs="0"/>
      <xs:element name="AdESObjectBytes" type="xs:base64Binary" minOccurs="0"/>
      <xs:element name="OtherAdESData" type="csig:AnyType" minOccurs="0"/>
    </xs:sequence>
  </xs:complexType>

  <xs:element name="Base64Signature" type="csig:Base64SignatureType"/>

  <xs:complexType name="Base64SignatureType">
    <xs:simpleContent>
      <xs:extension base="xs:base64Binary">
        <xs:attribute name="Type" type="xs:anyURI"/>
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>

  <xs:element name="SignRequestExtension" type="csig:SignRequestExtensionType"/>

  <xs:complexType name="SignRequestExtensionType">
    <xs:sequence>
      <xs:element ref="csig:RequestTime"/>
      <xs:element ref="saml:Conditions"/>
      <xs:choice minOccurs="0">
        <xs:element name="Signer" type="saml:AttributeStatementType"/>
        <xs:element ref="csig:SamlAuthenticationAttributes"/>
        <xs:element ref="csig:OidcAuthenticationAttributes"/>
        <xs:element ref="csig:OtherAuthenticationAttributes"/>
      </xs:choice>
      <xs:element ref="csig:IdentityProvider"/>
      <xs:element ref="csig:AuthnProfile" minOccurs="0"/>
      <xs:element ref="csig:SignRequester"/>
      <xs:element ref="csig:SignService"/>
      <xs:element ref="csig:RequestedSignatureAlgorithm" minOccurs="0"/>
      <xs:element ref="csig:CertRequestProperties" minOccurs="0"/>
      <xs:element ref="csig:SignMessage" minOccurs="0" maxOccurs="1"/>
      <xs:element ref="csig:OtherRequestInfo" minOccurs="0"/>
    </xs:sequence>
    <xs:attribute name="Version" type="xs:string" default="1.1"/>
  </xs:complexType>

  <xs:element name="RequestTime" type="xs:dateTime"/>

  <xs:element name="SamlAuthenticationAttributes" type="saml:AttributeStatementType"/>

  <xs:element name="OidcAuthenticationAttributes" type="csig:OidcClaimsType"/>

  <xs:element name="OtherAuthenticationAttributes">
    <xs:complexType>
      <xs:sequence>
        <xs:any namespace="##any" processContents="lax"/>
      </xs:sequence>
    </xs:complexType>
  </xs:element>

  <xs:element name="IdentityProvider" type="saml:NameIDType"/>

  <xs:element name="AuthnProfile" type="xs:string"/>

  <xs:element name="SignRequester" type="saml:NameIDType"/>

  <xs:element name="SignService" type="saml:NameIDType"/>

  <xs:element name="RequestedSignatureAlgorithm" type="xs:anyURI"/>

  <xs:element name="CertRequestProperties" type="csig:CertRequestPropertiesType"/>

  <xs:complexType name="CertRequestPropertiesType">
    <xs:sequence>
      <xs:element ref="saml:AuthnContextClassRef" minOccurs="0" maxOccurs="unbounded"/>
      <xs:element ref="csig:RequestedCertAttributes" minOccurs="0"/>
      <xs:element ref="csig:OtherProperties" minOccurs="0"/>
    </xs:sequence>
    <xs:attribute name="CertType" default="PKC">
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="PKC"/>
          <xs:enumeration value="QC"/>
          <xs:enumeration value="QC/SSCD"/>
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
  </xs:complexType>

  <xs:element name="OtherProperties" type="csig:AnyType"/>

  <xs:element name="RequestedCertAttributes" type="csig:RequestedAttributesType"/>

  <xs:complexType name="RequestedAttributesType">
    <xs:sequence>
      <xs:element name="RequestedCertAttribute" type="csig:MappedAttributeType"
                  minOccurs="1" maxOccurs="unbounded"/>
    </xs:sequence>
  </xs:complexType>

  <xs:complexType name="MappedAttributeType">
    <xs:sequence>
      <xs:element name="AttributeAuthority" type="saml:NameIDType" minOccurs="0" maxOccurs="unbounded"/>
      <xs:choice>
        <xs:element name="SamlAttributeName" type="csig:PreferredSAMLAttributeNameType"
                    minOccurs="0" maxOccurs="unbounded"/>
        <xs:element name="AttributeName" type="csig:PreferredAttributeNameType"
                    minOccurs="0" maxOccurs="unbounded"/>
      </xs:choice>
    </xs:sequence>
    <xs:attribute name="CertAttributeRef" type="xs:string" use="required"/>
    <xs:attribute name="CertNameType" default="rdn">
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="rdn"/>
          <xs:enumeration value="san"/>
          <xs:enumeration value="sda"/>
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
    <xs:attribute name="FriendlyName" type="xs:string"/>
    <xs:attribute name="DefaultValue" type="xs:string"/>
    <xs:attribute name="Required" type="xs:boolean" default="false"/>
  </xs:complexType>

  <xs:complexType name="PreferredSAMLAttributeNameType">
    <xs:simpleContent>
      <xs:extension base="xs:string">
        <xs:attribute name="Order" type="xs:int" default="0"/>
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>

  <xs:complexType name="PreferredAttributeNameType">
    <xs:simpleContent>
      <xs:extension base="xs:string">
        <xs:attribute name="Order" type="xs:int" default="0"/>
        <xs:attribute name="AuthnProtocol" type="csig:AuthnProtocolType" default="saml"/>
      </xs:extension>
    </xs:simpleContent>
  </xs:complexType>

  <xs:element name="SignMessage" type="csig:SignMessageType"/>

  <xs:complexType name="SignMessageType">
    <xs:choice>
      <xs:element ref="csig:Message"/>
      <xs:element ref="csig:EncryptedMessage"/>
    </xs:choice>
    <xs:attribute name="MustShow" type="xs:boolean" default="false"/>
    <xs:attribute name="DisplayEntity" type="xs:anyURI"/>
    <xs:attribute name="MimeType" default="text">
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="text/html"/>
          <xs:enumeration value="text"/>
          <xs:enumeration value="text/markdown"/>
        </xs:restriction>
      </xs:simpleType>
    </xs:attribute>
    <xs:anyAttribute namespace="##other" processContents="lax"/>
  </xs:complexType>

  <xs:element name="Message" type="xs:base64Binary"/>
  <xs:element name="EncryptedMessage" type="saml:EncryptedElementType"/>

  <xs:element name="OtherRequestInfo" type="csig:AnyType"/>

  <xs:element name="SignResponseExtension" type="csig:SignResponseExtensionType"/>

  <xs:complexType name="SignResponseExtensionType">
    <xs:sequence>
      <xs:element ref="csig:ResponseTime"/>
      <xs:element ref="csig:Request" minOccurs="0"/>
      <xs:element ref="csig:SignerAssertionInfo" minOccurs="0"/>
      <xs:element ref="csig:SignatureCertificateChain" minOccurs="0"/>
      <xs:element ref="csig:OtherResponseInfo" minOccurs="0"/>
    </xs:sequence>
    <xs:attribute name="Version" type="xs:string" default="1.1"/>
  </xs:complexType>

  <xs:element name="ResponseTime" type="xs:dateTime"/>
  <xs:element name="Request" type="xs:base64Binary"/>

  <xs:element name="SignerAssertionInfo" type="csig:SignerAssertionInfoType"/>

  <xs:complexType name="SignerAssertionInfoType">
    <xs:sequence>
      <xs:element ref="csig:ContextInfo"/>
      <xs:choice>
        <xs:element ref="saml:AttributeStatement"/>
        <xs:element ref="csig:OidcAuthenticationAttributes"/>
        <xs:element ref="csig:OtherAuthenticationAttributes"/>
      </xs:choice>
      <xs:choice minOccurs="0">
        <xs:element name="Assertions" type="csig:AssertionsType"/>
        <xs:element ref="csig:SamlAssertions"/>
      </xs:choice>
    </xs:sequence>
    <xs:attribute name="AuthnProtocol" type="csig:AuthnProtocolType" default="saml"/>
  </xs:complexType>

  <xs:element name="ContextInfo" type="csig:ContextInfoType"/>

  <xs:complexType name="ContextInfoType">
    <xs:sequence minOccurs="0">
      <xs:element name="IdentityProvider" type="saml:NameIDType"/>
      <xs:element name="AuthenticationInstant" type="xs:dateTime"/>
      <xs:element ref="saml:AuthnContextClassRef"/>
      <xs:element name="ServiceID" type="xs:string" minOccurs="0"/>
      <xs:element name="AuthType" type="xs:string" minOccurs="0"/>
      <xs:element name="AssertionRef" type="xs:string" minOccurs="0"/>
    </xs:sequence>
  </xs:complexType>

  <xs:element name="SignatureCertificateChain" type="csig:CertificateChainType"/>

  <xs:complexType name="CertificateChainType">
    <xs:sequence>
      <xs:element name="X509Certificate" type="xs:base64Binary" maxOccurs="unbounded"/>
    </xs:sequence>
  </xs:complexType>

  <xs:element name="SamlAssertions" type="csig:SAMLAssertionsType"/>

  <xs:complexType name="SAMLAssertionsType">
    <xs:sequence>
      <xs:element name="Assertion" type="xs:base64Binary" maxOccurs="unbounded"/>
    </xs:sequence>
  </xs:complexType>

  <xs:complexType name="AssertionsType">
    <xs:choice maxOccurs="unbounded">
      <xs:element name="SamlAssertion" type="xs:base64Binary"/>
      <xs:element name="OidcIdToken" type="csig:EncodedJwtType"/>
      <xs:element name="OidcUserInfoResponse" type="csig:EncodedJwtType"/>
      <xs:any namespace="##other" processContents="lax"/>
    </xs:choice>
  </xs:complexType>

  <xs:element name="OtherResponseInfo" type="csig:AnyType"/>

  <xs:complexType name="AnyType">
    <xs:sequence>
      <xs:any processContents="lax" minOccurs="0" maxOccurs="unbounded"/>
    </xs:sequence>
  </xs:complexType>

  <xs:simpleType name="AuthnProtocolType">
    <xs:union>
      <xs:simpleType>
        <xs:restriction base="xs:string">
          <xs:enumeration value="saml"/>
          <xs:enumeration value="oidc"/>
        </xs:restriction>
      </xs:simpleType>
      <xs:simpleType>
        <xs:restriction base="xs:string"/>
      </xs:simpleType>
    </xs:union>
  </xs:simpleType>

  <xs:simpleType name="EncodedJwtType">
    <xs:restriction base="xs:string"/>
  </xs:simpleType>

  <xs:complexType name="OidcClaimsType">
    <xs:sequence>
      <xs:element name="Claim" type="csig:OidcClaimType" maxOccurs="unbounded"/>
    </xs:sequence>
  </xs:complexType>

  <xs:complexType name="OidcClaimType">
    <xs:sequence>
      <xs:choice>
        <xs:element name="StringValue" type="xs:string"/>
        <xs:element name="IntValue" type="xs:integer"/>
        <xs:element name="DecimalValue" type="xs:decimal"/>
        <xs:element name="BooleanValue" type="xs:boolean"/>
        <xs:element name="JsonObjectValue" type="xs:base64Binary"/>
        <xs:element name="JsonArrayValue" type="xs:base64Binary"/>
        <xs:element name="NullValue">
          <xs:complexType/>
        </xs:element>
      </xs:choice>
    </xs:sequence>
    <xs:attribute name="Name" type="xs:string" use="required"/>
  </xs:complexType>

</xs:schema>
```