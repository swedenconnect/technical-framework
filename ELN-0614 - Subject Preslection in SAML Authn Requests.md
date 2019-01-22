<img src="img/sweden-connect.png"></img>

# Subject Preslection in SAML Authn Requests 

### Version 1.1 - 2018-08-03 - *Draft version*

*ELN-0614-v0.1*

---

## Table of Contents


## 1. Introduction

Authentication of users sometimes require a specific user to be authenticated, in particular in the case when the user authenticates to a signature service to sign a document in a context where the signer already has been authenticated.

Some Identity Providers, such an Identity Provider acting as proxy to BankID (See: [[ELN-0612](#eln-0612)]), requires the user to enter personal identifying data such as the national person identifier (personnummer) in order to initiate the authentication process with a particular user's credentials. This process can be avoided when the service provider already knows which user that will be authenticated if the service provider has the means to communicate this information to the Identity Provider.

This specification defines an element that may be included in the `<Extensions>` element of a SAML AuthnRequest where the requesting service provider can specify matching criteria that may be used by the IdP to preselect the particular user that should be authenticated.


### 1.1. Requirement key words

The key words **MUST**, **MUST** **NOT**, **REQUIRED**, **SHALL**,
**SHALL** **NOT**, **SHOULD**, **SHOULD** **NOT**, **RECOMMENDED**,
**MAY**, and **OPTIONAL** are to be interpreted as described in
\[[RFC2119](#rfc2119)\].

These keywords are capitalized when used to unambiguously specify requirements over protocol features and behavior that affect the interoperability and security of implementations. When these words are not capitalized, they are meant in their natural-language sense.

### 1.2. XML name space references

The prefix **asp:** stands for the Authenticated Subject Preselection XML Schema namespace `http://id.swedenconnect.se/authn/1.0/subject-preselect/ns` (https://elegnamnden.github.io/schemas/...). 

The prefix **saml2:** stands for the OASIS SAML 2 Assertion Schema namespace `urn:oasis:names:tc:SAML:2.0:assertion`.

### 1.3. Structure

This specification uses the following typographical conventions in text:
`<LocalElement>`, `<ns:ForeignElement>`, `Attribute`, **Datatype**,
`OtherCode`.

## 2. Data elements

### 2.1. Subject Preselect Criteria

The Subject Preselect  Criteria is provided in a `<SubjectPreselectCriteria>` element. The element has the following elements and attributes:

`<MatchingPolicy>` \[One or more]

> Specifies one alternative matching policy to identify an acceptable preselected subject. If more than one MatchingPolicy element is present, they provide alternative policies that may represent different acceptable subject identities.

`<OtherMatchingCriteria>` \[Optional\]

> This element is an extension element that may contain any element that provides other matching criteria in accordance with local conventions or future specifications.

The following schema fragment defines the `<SubjectPreselectCriteria>` element:

    <xs:element name="SubjectPreselectCriteria" type="asp:SubjectPreselectCriteriaType"/>

    <xs:complexType name="SubjectPreselectCriteriaType">
        <xs:sequence>
            <xs:element name="MatchingPolicy" type="asp:MatchingPolicyType" maxOccurs="unbounded"/>
            <xs:element minOccurs="0" name="OtherMatchingCriteria" type="asp:AnyType"/>
        </xs:sequence>
    </xs:complexType>



### 2.1. MatchingPolicy

The matching policy `<MatchingPolicy>` element contains one or more `<MatchValue>` elements. 

The `<MatchValue>` element contains a string value to be matched against the preselected subject. This element has the following attributes which determines the meaning of the match value:

`Name` \[Required\]

> The identifying name of the type of identifier value expressed in the MatchValue element. This is analogous to the `Name` attribute of a SAML `<saml2:Attribute>` element.

`NameFormat` \[Default `urn:oasis:names:tc:SAML:2.0:attrname-format:uri`\]

> Attribute specifying the format of the Name attribute. This attribute is analogous to the `NameFormat` attribute of a SAML `<saml2:Attribute>` element.

`MustValidate` \[Default `true`\]

> When set to `true`, this indicates that the value of the specified type of this element MUST match the preselected subject and that the Identity Provider MUST verify this value in the authentication process. A value of `false` means that the Identity Provider does not have to verify this value and may rely entirely on other present match criteria to identify the preselected subject.

`##any` \[Optional\]

> Extension point for any attribute in accordance with local conventions and future specifications.

The following schema fragment defines the `<MatchingPolicyType>` complex type:

    <xs:complexType name="MatchingPolicyType">
        <xs:sequence>
            <xs:element maxOccurs="unbounded" name="MatchValue" type="asp:MatchValueType"/>
        </xs:sequence>
    </xs:complexType>
    <xs:complexType name="MatchValueType">
        <xs:simpleContent>
            <xs:extension base="xs:string">
                <xs:attribute name="MustValidate" type="xs:boolean" default="true"/>
                <xs:attribute name="NameFormat" type="xs:anyURI"
                    default="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"/>
                <xs:attribute name="Name" type="xs:string" use="required"/>
                <xs:anyAttribute namespace="##any"/>
            </xs:extension>
        </xs:simpleContent>
    </xs:complexType>
    <xs:complexType name="AnyType">
        <xs:sequence>
            <xs:any maxOccurs="unbounded" minOccurs="0" processContents="lax"/>
        </xs:sequence>
    </xs:complexType>



## 3. Examples

    <asp:SubjectPreselectCriteria xmlns:asp="http://id.swedenconnect.se/authn/1.0/subject-preselect/ns">
        <asp:MatchingPolicy>
            <asp:MatchValue Name="urn:oid:1.2.752.29.4.13">197309069289</asp:MatchValue>
        </asp:MatchingPolicy>
    </asp:SubjectPreselectCriteria>

> *Example of a SubjectPreselectCriteria specifying a Swedish person identifier (Personnummer) as match value*

    <asp:SubjectPreselectCriteria xmlns:asp="http://id.swedenconnect.se/authn/1.0/subject-preselect/ns">
        <asp:MatchingPolicy>
            <asp:MatchValue Name="urn:oid:1.2.752.29.4.13">197309069289</asp:MatchValue>
        </asp:MatchingPolicy>
        <asp:MatchingPolicy>
            <asp:MatchValue Name="urn:oid:1.2.752.201.3.4">XE:197309069289</asp:MatchValue>
            <asp:MatchValue Name="urn:oid:1.3.6.1.5.5.7.9.1" MustValidate="false">1973-09-06</asp:MatchValue>
        </asp:MatchingPolicy>
    </asp:SubjectPreselectCriteria>

> *Example of a SubjectPreselectCriteria specifying two alternative matching policies. Policy 1 specifying a Swedish person identifier (Personnummer) as match value and Policy 2 specifying a ProvidionalID and optional birth date as match values*

Attributes in the examples above are specified in [[ELN-0604](eln-0604)].

## 4. Schemas
The following XML schema defines the `http://id.swedenconnect.se/authn/1.0/subject-preselect/ns` name space:

    <?xml version="1.0" encoding="UTF-8"?>
    <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified"
        targetNamespace="http://id.swedenconnect.se/authn/1.0/subject-preselect/ns"
        xmlns:asp="http://id.swedenconnect.se/authn/1.0/subject-preselect/ns">
    
        <xs:annotation>
            <xs:documentation>
                Schema location URL: https://elegnamnden.github.io/schemas/csig/1.1/EidCsigSAP-1.1.xsd
            </xs:documentation>
        </xs:annotation>
    
        <xs:element name="SubjectPreselectCriteria" type="asp:SubjectPreselectCriteriaType"/>
    
        <xs:complexType name="SubjectPreselectCriteriaType">
            <xs:sequence>
                <xs:element name="MatchingPolicy" type="asp:MatchingPolicyType" maxOccurs="unbounded"/>
                <xs:element minOccurs="0" name="OtherMatchingCriteria" type="asp:AnyType"/>
            </xs:sequence>
        </xs:complexType>
        <xs:complexType name="MatchingPolicyType">
            <xs:sequence>
                <xs:element maxOccurs="unbounded" name="MatchValue" type="asp:MatchValueType"/>
            </xs:sequence>
        </xs:complexType>
        <xs:complexType name="MatchValueType">
            <xs:simpleContent>
                <xs:extension base="xs:string">
                    <xs:attribute name="MustValidate" type="xs:boolean" default="true"/>
                    <xs:attribute name="NameFormat" type="xs:anyURI"
                        default="urn:oasis:names:tc:SAML:2.0:attrname-format:uri"/>
                    <xs:attribute name="Name" type="xs:string" use="required"/>
                    <xs:anyAttribute namespace="##any"/>
                </xs:extension>
            </xs:simpleContent>
        </xs:complexType>
        <xs:complexType name="AnyType">
            <xs:sequence>
                <xs:any maxOccurs="unbounded" minOccurs="0" processContents="lax"/>
            </xs:sequence>
        </xs:complexType>
    </xs:schema>

## 5. Normative References

<a name="rfc2119"></a>**[RFC2119]**

> [Bradner, S., Key words for use in RFCs to Indicate Requirement
> Levels, March 1997](http://www.ietf.org/rfc/rfc2119.txt).

<a name="rfc7519"></a>**[RFC7519]**

> [Jones, M., Bradley, J., and N. Sakimura, "JSON Web Token (JWT)", RFC 7519, DOI 10.17487/RFC7519, May 2015](http://www.rfc-editor.org/info/rfc7519).

<a name="eln-0604"></a>**[ELN-0604]**

> [Attribute Specification for the Swedish eID Framework](http://docs.swedenconnect.se/technical-framework/latest/ELN-0604_-_Attribute_Specification_for_the_Swedish_eID_Framework.html).

<a name="eln-0612"></a>**[ELN-0612]**

> [Implementation Profile for BankID Identity Providers within the Swedish eID Framework](http://docs.swedenconnect.se/technical-framework/latest/ELN-0612_-_BankID_Profile_for_the_Swedish_eID_Framework.html).

## 6. Changes between versions

This is the first version of this draft.
