<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY upper 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'>
  <!ENTITY lower 'abcdefghijklmnopqrstuvwxyz'>
  <!ENTITY logo  SYSTEM '../OASISLogo.jpg' NDATA dummy>
  <!NOTATION dummy SYSTEM "">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="saxon xalanredirect lxslt exsl"
                version="1.0">
<!-- $Id: oasis-specification-fo-a4.xsl,v 1.28 2010/07/08 12:26:21 admin Exp $ -->

<!-- This stylesheet is a customization of the DocBook XSL Stylesheets -->
<!-- from http://www.oasis-open.org/spectools/stylesheets/oasis-docbook-fo.xsl
     to include additional formatting for programlisting, and parameter
     settings for international paper size (for an international standards
     organization) and body indentation (new with DocBook stylesheets);
     note also that directory locations have been parameterized; a number of
     changes were made to conform to revised OASIS presentation reqts -->
<!-- See http://sourceforge.net/projects/docbook/ -->
<xsl:import href="../docbook/xsl/fo/docbook.xsl"/>
<xsl:import href="titlepage-fo.xsl"/>

<!-- ============================================================ -->
<!-- Parameters -->

<xsl:param name="section.autolabel" select="'1'"/>
<xsl:param name="section.label.includes.component.label" select="1"/>
<xsl:param name="title.margin.left" select="'0pt'"/>
<xsl:param name="paper.type" select="'A4'"/>
<xsl:param name="body.start.indent" select="'0pt'"/>
<xsl:param name="linenumbering.extension" select="'1'"/>
<xsl:param name="body.font.family" select="'Arial,Helvetica,sans-serif'"/>
<xsl:param name="body.fontset" select="'Arial,Helvetica,sans-serif'"/>
<xsl:param name="title.fontset" select="'Arial,Helvetica,sans-serif'"/>
<xsl:param name="toc.section.depth">3</xsl:param>
<xsl:param name="variablelist.as.blocks">1</xsl:param>
<xsl:param name="footer.rule">0</xsl:param>
<xsl:param name="ulink.hyphenate">&#x200b;</xsl:param>

<xsl:param name="shade.verbatim" select="'1'"/>
<xsl:attribute-set name="shade.verbatim.style">
  <xsl:attribute name="background-color">#E7DEEF</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="xref.properties">
  <xsl:attribute name="color">blue</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="informal.object.properties">
  <xsl:attribute name="border-before-style">solid</xsl:attribute>
  <xsl:attribute name="border-before-width">1pt</xsl:attribute>
  <xsl:attribute name="border-after-style">solid</xsl:attribute>
  <xsl:attribute name="border-after-width">1pt</xsl:attribute>
</xsl:attribute-set>

<xsl:param name="generate.component.toc" select="'1'"/>

<xsl:param name="oasis.logo">
  <xsl:for-each select="document('')">
    <xsl:value-of select="unparsed-entity-uri('logo')"/>
  </xsl:for-each>
</xsl:param>

<xsl:param name="method" select="'xml'"/>
<xsl:param name="indent" select="'no'"/>
<xsl:param name="encoding" select="'utf-8'"/>

<xsl:param name="automatic-output-filename" select="'no'"/>

<xsl:attribute-set name="section.title.properties">
  <xsl:attribute name="color">#66116D</xsl:attribute>
  <xsl:attribute name="text-align">start</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="component.title.properties">
  <xsl:attribute name="color">#66116D</xsl:attribute>
  <xsl:attribute name="text-align">start</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="root.properties">
  <xsl:attribute name="id">entire_publication</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="table.of.contents.titlepage.recto.style">
  <xsl:attribute name="break-before">page</xsl:attribute>
  <xsl:attribute name="color">#66116D</xsl:attribute>
  <xsl:attribute name="border-before-width">1pt</xsl:attribute>
  <xsl:attribute name="border-before-style">solid</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="article.appendix.title.properties">
  <xsl:attribute name="break-before">page</xsl:attribute>
  <xsl:attribute name="border-before-width">1pt</xsl:attribute>
  <xsl:attribute name="border-before-style">solid</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="section.level1.properties">
  <xsl:attribute name="break-before">page</xsl:attribute>
  <xsl:attribute name="border-before-width">1pt</xsl:attribute>
  <xsl:attribute name="border-before-style">solid</xsl:attribute>
</xsl:attribute-set>
<xsl:attribute-set name="appendix.title.augmented.properties">
  <xsl:attribute name="space-before.minimum">12pt</xsl:attribute>
  <xsl:attribute name="space-before.maximum">12pt</xsl:attribute>
  <xsl:attribute name="space-before.optimum">12pt</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="article/appendix">
  <fo:block break-after="page"/><!--this appears to get around an XEP bug-->
  <xsl:apply-imports/>
</xsl:template>

<xsl:template match="article/appendix" mode="object.title.markup">
  <fo:block xsl:use-attribute-sets="appendix.title.augmented.properties">
    <xsl:apply-imports/>
  </fo:block>
</xsl:template>

<!-- ============================================================ -->
<!-- The document -->
<xsl:template match="/">
  <xsl:variable name="content">
    <xsl:apply-imports/>
  </xsl:variable>

  <xsl:variable name="filename">
    <xsl:value-of select="/article/articleinfo/productname[1]"/>
    <xsl:if test="/article/articleinfo/productnumber">
      <xsl:text>-</xsl:text>
      <xsl:value-of select="/article/articleinfo/productnumber[1]"/>
    </xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$automatic-output-filename!='yes' or
                    not(normalize-space($filename))">
      <xsl:copy-of select="$content"/>      
    </xsl:when>
    <xsl:when test="element-available('exsl:document')">
      <xsl:message>Writing <xsl:value-of select="$filename"/>.fo</xsl:message>
      <exsl:document href="{$filename}.fo"
                     method="{$method}"
                     encoding="{$encoding}"
                     indent="{$indent}">
        <xsl:copy-of select="$content"/>
      </exsl:document>
    </xsl:when>
    <xsl:when test="element-available('saxon:output')">
      <xsl:message>Writing <xsl:value-of select="$filename"/>.fo</xsl:message>
      <saxon:output href="{$filename}.fo"
                    method="{$method}"
                    encoding="{$encoding}"
                    indent="{$indent}">
        <xsl:copy-of select="$content"/>
      </saxon:output>
    </xsl:when>
    <xsl:when test="element-available('xalanredirect:write')">
      <!-- Xalan uses xalanredirect -->
      <xsl:message>Writing <xsl:value-of select="$filename"/>.fo</xsl:message>
      <xalanredirect:write file="{$filename}.fo">
        <xsl:copy-of select="$content"/>
      </xalanredirect:write>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy-of select="$content"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->
<!-- Titlepage -->

<xsl:attribute-set name="oasis-metadata-title"
                   use-attribute-sets="component.title.properties">
  <xsl:attribute name="space-before">8pt</xsl:attribute>
  <xsl:attribute name="font-family">
    <xsl:value-of select="$title.font.family"/>
  </xsl:attribute>
  <xsl:attribute name="font-weight">bold</xsl:attribute>
  <xsl:attribute name="font-size">14pt</xsl:attribute>
</xsl:attribute-set>

<xsl:template match="pubdate" mode="titlepage.mode">
  <fo:block keep-with-next="always"
            font-size="18pt"
            space-before="10pt"
            space-after="8pt"
            font-weight="bold"
            font-family="{$title.font.family}"
            xsl:use-attribute-sets="component.title.properties">
    <xsl:choose>
      <xsl:when test="/*/@status">
        <xsl:value-of select="/*/@status"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>???Unknown Status???</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
  <fo:block keep-with-next="always"
            font-size="18pt"
            space-before="10pt"
            space-after="8pt"
            font-weight="bold"
            font-family="{$title.font.family}"
            xsl:use-attribute-sets="component.title.properties">
    <xsl:apply-templates mode="titlepage.mode"/>
  </fo:block>
</xsl:template>

<xsl:template match="productname" mode="titlepage.mode">
<!--
  <xsl:variable name="pn" select="../productnumber[1]"/>

  <fo:block>
    <fo:block xsl:use-attribute-sets="oasis-metadata-title">Document identifier:</fo:block>
    <fo:block margin-left="2em">
      <xsl:value-of select="."/>
      <xsl:if test="$pn">
        <xsl:text>-</xsl:text>
        <xsl:value-of select="$pn"/>
      </xsl:if>
    </fo:block>
  </fo:block>
-->
</xsl:template>

<xsl:template match="releaseinfo[@role='committee']" mode="titlepage.mode" priority="2">
    <fo:block>
      <fo:block xsl:use-attribute-sets="oasis-metadata-title">
        Technical Committee:
      </fo:block>
      <fo:block margin-left="2em">
        <xsl:apply-templates/>
      </fo:block>
    </fo:block>
</xsl:template>

<!--intercept these links because the URL must not be exposed-->
<xsl:template match="articleinfo//ulink">
    <fo:basic-link external-destination='url("{@url}")'
                   color="blue">
        <xsl:apply-templates/>
    </fo:basic-link>
</xsl:template>

<xsl:template match="releaseinfo[@role='oasis-id']" mode="titlepage.mode" priority="2">
    <fo:block>
      <fo:block xsl:use-attribute-sets="oasis-metadata-title">
        OASIS Identifier:
      </fo:block>
      <fo:block margin-left="2em">
        <xsl:apply-templates/>
      </fo:block>
    </fo:block>
</xsl:template>

<xsl:template match="releaseinfo[@role='product']" mode="titlepage.mode" priority="2">
  <!-- suppress -->
</xsl:template>

<xsl:template match="releaseinfo[starts-with(@role,'OASIS-specification-')]"
              mode="titlepage.mode" priority="2">
  <xsl:if test="not(preceding-sibling::releaseinfo
                                 [starts-with(@role,'OASIS-specification-')])">
    <xsl:variable name="locations" 
                  select="../releaseinfo[starts-with(@role,
                                         'OASIS-specification-')]"/>
    <fo:block>
      <fo:block xsl:use-attribute-sets="oasis-metadata-title">
        Specification URIs:
      </fo:block>
      <xsl:call-template name="spec-uri-group">
        <xsl:with-param name="header">This Version:</xsl:with-param>
        <xsl:with-param name="uris" 
           select="$locations[starts-with(@role,'OASIS-specification-this')]"/>
      </xsl:call-template>
      <xsl:call-template name="spec-uri-group">
        <xsl:with-param name="header">Previous Version:</xsl:with-param>
        <xsl:with-param name="uris" 
       select="$locations[starts-with(@role,'OASIS-specification-previous')]"/>
      </xsl:call-template>
      <xsl:call-template name="spec-uri-group">
        <xsl:with-param name="header">Latest Version:</xsl:with-param>
        <xsl:with-param name="uris" 
         select="$locations[starts-with(@role,'OASIS-specification-latest')]"/>
      </xsl:call-template>
    </fo:block>
  </xsl:if>
</xsl:template>

<xsl:template name="spec-uri-group">
  <xsl:param name="header"/>
  <xsl:param name="uris"/>
  <fo:block>
    <fo:block xsl:use-attribute-sets="oasis-metadata-title">
      <xsl:copy-of select="$header"/>
    </fo:block>
  </fo:block>
  <fo:block margin-left="2em">
    <xsl:choose>
      <xsl:when test="not($uris)">
        N/A
      </xsl:when>
      <xsl:otherwise>
        <xsl:for-each select="$uris">
          <xsl:choose>
            <xsl:when test="contains(@role,'-draft')">
              <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
              <fo:basic-link external-destination='url("{.}")'
                             color="blue">
                <xsl:value-of select="."/>
              </fo:basic-link>
              <xsl:if test="contains(@role,'-authoritative')">
                (Authoritative)
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
          <fo:block/>
        </xsl:for-each>
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>

<xsl:template match="authorgroup" mode="titlepage.mode">
  <xsl:variable name="editors" select="editor"/>
  <xsl:variable name="authors" select="author"/>
  <xsl:variable name="chair" select="othercredit"/>

  <xsl:if test="$chair">
    <fo:block>
      <fo:block xsl:use-attribute-sets="oasis-metadata-title">
        <xsl:text>Chair</xsl:text>
        <xsl:if test="count($chair) &gt; 1">s</xsl:if>
        <xsl:text>:</xsl:text>
      </fo:block>
      <fo:block margin-left="2em">
        <xsl:apply-templates select="$chair" mode="titlepage.mode"/>
      </fo:block>
    </fo:block>
  </xsl:if>

  <xsl:if test="$editors">
    <fo:block>
      <fo:block xsl:use-attribute-sets="oasis-metadata-title">
        <xsl:text>Editor</xsl:text>
        <xsl:if test="count($editors) &gt; 1">s</xsl:if>
        <xsl:text>:</xsl:text>
      </fo:block>
      <fo:block margin-left="2em">
        <xsl:apply-templates select="$editors" mode="titlepage.mode"/>
      </fo:block>
    </fo:block>
  </xsl:if>

  <xsl:if test="$authors">
    <fo:block>
      <fo:block xsl:use-attribute-sets="oasis-metadata-title">
        <xsl:text>Author</xsl:text>
        <xsl:if test="count($authors) &gt; 1">s</xsl:if>
        <xsl:text>:</xsl:text>
      </fo:block>
      <fo:block margin-left="2em">
        <xsl:apply-templates select="$authors" mode="titlepage.mode"/>
      </fo:block>
    </fo:block>
  </xsl:if>

</xsl:template>

<xsl:template match="ulink" mode="revision-links">
  <xsl:if test="position() = 1"> (</xsl:if>
  <xsl:if test="position() &gt; 1">, </xsl:if>
  <xsl:value-of select="@role"/>
  <xsl:if test="position() = last()">)</xsl:if>
</xsl:template>

<xsl:template match="editor|author|othercredit" mode="titlepage.mode">
  <xsl:call-template name="person.name"/>
  <xsl:if test="contrib">
    <xsl:text> (</xsl:text>
    <xsl:apply-templates select="contrib" mode="titlepage.mode"/>
    <xsl:text>)</xsl:text>
  </xsl:if>
  <xsl:if test="affiliation/orgname">
    <xsl:text>, </xsl:text>
    <xsl:apply-templates select="affiliation/orgname" mode="titlepage.mode"/>
  </xsl:if>
  <xsl:apply-templates select="affiliation/address/email"
                       mode="titlepage.mode"/>
  <xsl:if test="position()&lt;last()"><fo:block/></xsl:if>
</xsl:template>

<xsl:template match="email" mode="titlepage.mode">
  <xsl:text>&#160;&lt;</xsl:text>
  <fo:basic-link external-destination='url("mailto:{.}")'
                 color="blue">
    <xsl:apply-templates/>
  </fo:basic-link>
  <xsl:text>></xsl:text>
</xsl:template>

<xsl:template match="abstract" mode="titlepage.mode">
  <fo:block>
    <fo:block xsl:use-attribute-sets="oasis-metadata-title">
      <xsl:apply-templates select="." mode="object.title.markup"/>
      <xsl:text>:</xsl:text>
    </fo:block>
    <fo:block margin-left="2em">
      <xsl:apply-templates mode="titlepage.mode"/>
    </fo:block>
  </fo:block>
</xsl:template>

<xsl:template match="articleinfo/abstract/para[1]">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="legalnotice[title]" mode="titlepage.mode">
  <fo:block>
    <fo:block xsl:use-attribute-sets="oasis-metadata-title">
      <xsl:apply-templates select="." mode="object.title.markup"/>
      <xsl:text>:</xsl:text>
    </fo:block>
    <fo:block margin-left="2em">
      <xsl:apply-templates mode="titlepage.mode"/>
    </fo:block>
  </fo:block>
</xsl:template>

<xsl:template match="legalnotice/title" mode="titlepage.mode">
  <!-- nop -->
</xsl:template>

<xsl:template match="legalnotice[@role='notices']" mode="titlepage.mode"
              priority="1">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="legalnotice[@role='notices']/title" mode="titlepage.mode"
              priority="1">
  <fo:block xsl:use-attribute-sets="table.of.contents.titlepage.recto.style" 
            space-before.minimum="1em" space-before.optimum="1.5em" 
            space-before.maximum="2em" space-after="0.5em" 
            margin-left="{$title.margin.left}" 
            start-indent="0pt" font-size="17.28pt" 
            font-weight="bold" font-family="{$title.fontset}">
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="articleinfo/legalnotice/para[1]">
  <fo:block>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="copyright" mode="titlepage.mode">
  <fo:block space-before="1em">
    <xsl:apply-imports/>
  </fo:block>
</xsl:template>

<xsl:template match="releaseinfo" mode="titlepage.mode">
  <xsl:comment>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
    <xsl:text> </xsl:text>
  </xsl:comment>
</xsl:template>

<xsl:template match="jobtitle|shortaffil|orgname|contrib"
              mode="titlepage.mode">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="phrase[@role='keyword']//text()">
  <xsl:value-of select="translate(.,'&lower;','&upper;')"/>
</xsl:template>

<!-- ============================================================ -->
<!-- Component TOC -->

<xsl:template name="component.toc">
  <xsl:param name="toc-context" select="."/>

  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:variable name="cid">
    <xsl:call-template name="object.id">
      <xsl:with-param name="object" select="$toc-context"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="nodes" select="section|sect1"/>
  <xsl:variable name="apps" select="bibliography|glossary|appendix"/>

  <xsl:if test="$nodes">
    <fo:block id="toc...{$id}"
              xsl:use-attribute-sets="toc.margin.properties">
      <xsl:call-template name="table.of.contents.titlepage"/>
      <xsl:apply-templates select="$nodes" mode="toc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:apply-templates>
    </fo:block>
  </xsl:if>

  <xsl:if test="$apps">
    <fo:block id="toc...a{$id}"
              xsl:use-attribute-sets="toc.margin.properties">

      <fo:block space-after="1em"
                margin-left="{$title.margin.left}"
                font-size="12pt"
                font-weight="bold"
                font-family="{$title.font.family}">
        <fo:inline>Appendix</fo:inline>
        <xsl:if test="count($apps) &gt; 1">es</xsl:if>
      </fo:block>

      <xsl:apply-templates select="$apps" mode="toc">
        <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:apply-templates>
    </fo:block>
  </xsl:if>
</xsl:template>

<xsl:template match="appendix" mode="object.title.template">
  <xsl:text>Appendix </xsl:text>
  <xsl:apply-imports/>
</xsl:template>

<!-- ================================================================= -->

<!-- support role='non-normative' -->
<xsl:template match="preface|chapter|appendix" mode="title.markup">
  <xsl:param name="allow-anchors" select="'0'"/>
  <xsl:variable name="title" select="(docinfo/title
                                      |prefaceinfo/title
                                      |chapterinfo/title
                                      |appendixinfo/title
                                      |title)[1]"/>
  <xsl:apply-templates select="$title" mode="title.markup">
    <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
  </xsl:apply-templates>
  <xsl:if test="@role='non-normative'">
    <xsl:text> (Non-Normative)</xsl:text>
  </xsl:if>
</xsl:template>

<!-- support role='non-normative' -->
<xsl:template match="section
                     |sect1|sect2|sect3|sect4|sect5
                     |refsect1|refsect2|refsect3
                     |simplesect"
              mode="title.markup">
  <xsl:param name="allow-anchors" select="'0'"/>
  <xsl:variable name="title" select="(sectioninfo/title
                                      |sect1info/title
                                      |sect2info/title
                                      |sect3info/title
                                      |sect4info/title
                                      |sect5info/title
                                      |refsect1info/title
                                      |refsect2info/title
                                      |refsect3info/title
                                      |title)[1]"/>

  <xsl:apply-templates select="$title" mode="title.markup">
    <xsl:with-param name="allow-anchors" select="$allow-anchors"/>
  </xsl:apply-templates>
  <xsl:if test="@role='non-normative'">
    <xsl:text> (Non-Normative)</xsl:text>
  </xsl:if>
</xsl:template>

<!-- ============================================================ -->
<!-- Formatting changes for OASIS look&amp;feel -->

<xsl:template match="quote">
  <xsl:variable name="depth">
    <xsl:call-template name="dot.count">
      <xsl:with-param name="string">
        <xsl:number level="multiple"/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="$depth mod 2 = 0">
      <xsl:text>"</xsl:text>
      <xsl:call-template name="inline.charseq"/>
      <xsl:text>"</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>'</xsl:text>
      <xsl:call-template name="inline.charseq"/>
      <xsl:text>'</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="filename">
  <fo:inline font-weight="bold">
    <xsl:apply-templates/>
  </fo:inline>
</xsl:template>

<xsl:template match="programlisting">
  <fo:wrapper white-space-treatment="preserve">
    <xsl:apply-imports/>
  </fo:wrapper>
</xsl:template>

<xsl:template match="appendixx">
  <fo:block break-before="page"
            border-before-style="solid" border-before-width="1pt"/>
  <xsl:apply-imports/>
</xsl:template>

<!--remove these interim features
<xsl:param name="section-automatic-page-break" select="'no'"/>
<xsl:param name="appendix-automatic-page-break" select="'no'"/>
<xsl:template match="section//section | appendix//section">
  <xsl:apply-imports/>
</xsl:template>
<xsl:template match="section">
  <xsl:if test="$section-automatic-page-break='yes'">
    <fo:block break-before="page"/>
  </xsl:if>
  <xsl:apply-imports/>
</xsl:template>
<xsl:template match="appendix">
  <xsl:if test="$appendix-automatic-page-break='yes'">
    <fo:block break-before="page"/>
  </xsl:if>
  <xsl:apply-imports/>
</xsl:template>
-->

<xsl:template match="section[bibliography]/para">
  <!--suppress the paragraphs in the references, per OASIS layout-->
  <xsl:if test="normalize-space(.)">
    <xsl:message>
      <xsl:text>Warning: non-empty bibliographic paragraphs are </xsl:text>
      <xsl:text>ignored in order to meet OASIS layout requirements.</xsl:text>
    </xsl:message>
  </xsl:if>
</xsl:template>

<xsl:template match="bibliography">
  <xsl:apply-templates select="bibliomixed"/>
  <xsl:if test="*[not(self::bibliomixed)][normalize-space()]">
    <xsl:message>
    <xsl:text>Warning: non-empty non-bibliomixed children of </xsl:text>
    <xsl:text>bibliography elements are </xsl:text>
    <xsl:text>ignored in order to meet OASIS layout requirements.</xsl:text>
    </xsl:message>
  </xsl:if>
</xsl:template>

<xsl:template match="table">
  <!--this needs to relax the "always" constraint used by DocBook-->
  <fo:block keep-together.within-column="1">
    <xsl:apply-imports/>
  </fo:block>
</xsl:template>

<xsl:template match="table[starts-with(@role,'font-size-')]//td/node() |
                     table[starts-with(@role,'font-size-')]//entry/node()">
  <fo:wrapper font-size="{substring-after(ancestor::table[@role][1]/@role,
                                          'font-size-')}">
    <xsl:apply-imports/>
  </fo:wrapper>
</xsl:template>

<!-- ============================================================ -->

<xsl:param name="header.rule" select="'0'"/>
<xsl:param name="region.before.extent" select="'0pt'"/>

<xsl:template name="header.content">
  <!--last minute change to remove all header content-->
</xsl:template>
<xsl:template name="header.footer.width">
  <xsl:param name="location"/>
  <xsl:param name="position"/>
  <xsl:choose>
    <xsl:when test="$location='header'">
      <xsl:choose>
        <xsl:when test="$position=2">1</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
        <xsl:when test="$position=2">0</xsl:when>
        <xsl:otherwise>1</xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:attribute-set name="footer.content.properties">
  <xsl:attribute name="font-size">80%</xsl:attribute>
</xsl:attribute-set>

<xsl:template name="footer.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

  <xsl:choose>
    <xsl:when test="$position='center'">
      <!--do nothing-->
    </xsl:when>
    <xsl:when test="$position='left'">
      <fo:block>
        <xsl:value-of select="/*/articleinfo/productname"/>
      </fo:block>
      <fo:block>
        Copyright &#xa9; OASIS&#xae;
        <xsl:value-of select="/*/articleinfo/copyright/year"/>. 
        All Rights Reserved.
      </fo:block>
    </xsl:when>
    <xsl:when test="$position='right'">
      <fo:block>
        <xsl:value-of select="/*/articleinfo/pubdate"/>
      </fo:block>
      <fo:block>
        Page <fo:page-number/> of
        <fo:page-number-citation-last ref-id="entire_publication"/>
      </fo:block>
    </xsl:when>
  </xsl:choose>  
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="para/revhistory">
  <fo:table table-layout="fixed" border="solid 1pt">
    <fo:table-column column-number="1" column-width="33%"/>
    <fo:table-column column-number="2" column-width="33%"/>
    <fo:table-column column-number="3" column-width="33%"/>
    <fo:table-body>
      <xsl:apply-templates mode="titlepage.mode"/>
    </fo:table-body>
  </fo:table>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="processing-instruction('lb')">
  <fo:block/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="processing-instruction('pb')">
  <fo:block break-after="page"/>
</xsl:template>

<!-- ============================================================ -->

</xsl:stylesheet>
