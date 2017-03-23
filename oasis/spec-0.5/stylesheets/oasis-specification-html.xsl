<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet
[
  <!ENTITY upper 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'>
  <!ENTITY lower 'abcdefghijklmnopqrstuvwxyz'>
  <!ENTITY oasis-spec 'http://docs.oasis-open.org/templates/DocBook/spec-0.5/'>
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:saxon="http://icl.com/saxon"
                xmlns:lxslt="http://xml.apache.org/xslt"
                xmlns:xalanredirect="org.apache.xalan.xslt.extensions.Redirect"
                xmlns:exsl="http://exslt.org/common"
                extension-element-prefixes="saxon xalanredirect lxslt exsl"
                version="1.0">
<!-- $Id: oasis-specification-html.xsl,v 1.23 2010/06/26 16:26:30 admin Exp $ -->

<!-- This stylesheet is a customization of the DocBook XSL Stylesheets -->
<!-- from http://docs.oasis-open.org/templates/ -->
<!-- See http://sourceforge.net/projects/docbook/ -->
<xsl:import href="../docbook/xsl/html/docbook.xsl"/>
<xsl:include href="titlepage-html.xsl"/>

<!-- ============================================================ -->
<!-- Parameters -->

<!--online configuration-->
<xsl:param name="css.path"
           select="'&oasis-spec;css/'"/>
<xsl:param name="oasis.logo"
           select="'&oasis-spec;OASISLogo.jpg'"/>
<xsl:param name="oasis-base" select="'yes'"/>

<!--common between offline and online-->

<xsl:param name="css.stylesheet">oasis-spec.css</xsl:param>
<!--No longer changing the style based on the stage of development
  <xsl:choose>
    <xsl:when test="/article/@status='Working Draft'">oasis-wd.css</xsl:when>
    <xsl:when test="/article/@status=&quot;Editor's Draft&quot;">oasis-ed.css</xsl:when>
    <xsl:when test="/article/@status='Committee Draft'">oasis-cd.css</xsl:when>
    <xsl:when test="/article/@status='Committee Specification'">oasis-cs.css</xsl:when>
    <xsl:when test="/article/@status='Standard'">oasis-standard.css</xsl:when>
    <xsl:otherwise>
      <xsl:message>
        <xsl:text>Unrecognized status: '</xsl:text>
        <xsl:value-of select="/article/@status"/>
        <xsl:text>'; styling as Working Draft.</xsl:text>
      </xsl:message>
      <xsl:text>oasis-wd.css</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:param>
-->

<xsl:param name="html.stylesheet">
  <xsl:value-of select="$css.path"/>
  <xsl:value-of select="$css.stylesheet"/>
</xsl:param>

<xsl:param name="section.autolabel" select="'1'"/>
<xsl:param name="section.label.includes.component.label" select="1"/>
<xsl:param name="toc.section.depth">3</xsl:param>

<xsl:param name="generate.component.toc" select="'1'"/>

<xsl:param name="method" select="'html'"/>
<xsl:param name="indent" select="'no'"/>
<xsl:param name="encoding" select="'ISO-8859-1'"/>
<xsl:param name="automatic-output-filename" select="'no'"/>

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
    <xsl:text>.html</xsl:text>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$automatic-output-filename!='yes' or
                    not(normalize-space($filename))">
      <xsl:copy-of select="$content"/>      
    </xsl:when>
    <xsl:when test="element-available('exsl:document')">
      <xsl:message>Writing <xsl:value-of select="$filename"/></xsl:message>
      <exsl:document href="{$filename}"
                     method="{$method}"
                     encoding="{$encoding}"
                     indent="{$indent}">
        <xsl:copy-of select="$content"/>
      </exsl:document>
    </xsl:when>
    <xsl:when test="element-available('saxon:output')">
      <xsl:message>Writing <xsl:value-of select="$filename"/></xsl:message>
      <saxon:output href="{$filename}"
                    method="{$method}"
                    encoding="{$encoding}"
                    indent="{$indent}">
        <xsl:copy-of select="$content"/>
      </saxon:output>
    </xsl:when>
    <xsl:when test="element-available('xalanredirect:write')">
      <!-- Xalan uses xalanredirect -->
      <xsl:message>Writing <xsl:value-of select="$filename"/></xsl:message>
      <xalanredirect:write file="{$filename}">
        <xsl:copy-of select="$content"/>
      </xalanredirect:write>
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy-of select="$content"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ============================================================ -->
<!-- HTML META -->

<xsl:template name="user.head.content">
  <xsl:param name="node" select="."/>
  <xsl:if test="$oasis-base='yes'">
    <xsl:for-each select="/*/articleinfo/releaseinfo
                          [starts-with(@role,'OASIS-specification-this')]
                          [contains(.,'.htm')]">
      <base href="{.}"/>
    </xsl:for-each>
  </xsl:if>
  <xsl:apply-templates select="/*/articleinfo/releaseinfo[@role='cvs']"
                       mode="head.meta.content"/>
</xsl:template>

<xsl:template match="releaseinfo" mode="head.meta.content">
  <meta name="cvsinfo">
    <xsl:attribute name="content">
      <xsl:value-of select="substring-before(substring-after(.,'$'),'$')"/>
    </xsl:attribute>
  </meta>
</xsl:template>

<!-- ============================================================ -->
<!-- Titlepage -->

<xsl:template match="pubdate" mode="titlepage.mode">
  <h2>
    <xsl:choose>
      <xsl:when test="/*/@status">
        <xsl:value-of select="/*/@status"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>???Unknown Status???</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </h2>

  <h2>
    <xsl:apply-templates mode="titlepage.mode"/>
  </h2>
</xsl:template>

<xsl:template match="productname" mode="titlepage.mode">
<!--
  <xsl:variable name="pn" select="../productnumber[1]"/>

  <dl>
    <dt><span class="docid-heading">Document identifier:</span></dt>
    <dd>
        <xsl:value-of select="."/>
        <xsl:if test="$pn">
          <xsl:text>-</xsl:text>
          <xsl:value-of select="$pn"/>
        </xsl:if>
        <xsl:if test="../releaseinfo[@role='product']">
          <xsl:text> (</xsl:text>
          <xsl:for-each select="../releaseinfo[@role='product']">
            <xsl:if test="position() &gt; 1">, </xsl:if>
            <xsl:apply-templates select="." mode="product.mode"/>
          </xsl:for-each>
          <xsl:text>)</xsl:text>
        </xsl:if>
    </dd>
  </dl>
-->
</xsl:template>

<xsl:template match="releaseinfo[@role='product']" mode="titlepage.mode" priority="2">
  <!-- suppress -->
</xsl:template>

<xsl:template match="releaseinfo[@role='product']" mode="product.mode" priority="2">
  <xsl:apply-templates mode="titlepage.mode"/>
</xsl:template>

<xsl:template match="releaseinfo[@role='committee']" mode="titlepage.mode" priority="2">
  <dl>
    <dt><span class="loc-heading">Technical Committee:</span></dt>
    <dd>
        <xsl:apply-templates/>
    </dd>
  </dl>
</xsl:template>

<xsl:template match="releaseinfo[@role='oasis-id']" mode="titlepage.mode" priority="2">
  <dl>
    <dt><span class="loc-heading">OASIS identifier:</span></dt>
    <dd>
        <xsl:apply-templates/>
    </dd>
  </dl>
</xsl:template>

<xsl:template match="releaseinfo[starts-with(@role,'OASIS-specification-')]"
              mode="titlepage.mode" priority="2">
  <xsl:if test="not(preceding-sibling::releaseinfo
                                 [starts-with(@role,'OASIS-specification-')])">
    <xsl:variable name="locations" 
                  select="../releaseinfo[starts-with(@role,
                                         'OASIS-specification-')]"/>
    <dl>
      <dt>
        <span class="loc-heading">
          Specification URIs:
        </span>
      </dt>
    </dl>
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
  </xsl:if>
</xsl:template>

<xsl:template name="spec-uri-group">
  <xsl:param name="header"/>
  <xsl:param name="uris"/>
  <dl>
    <dt>
      <span class="loc-heading">
        <xsl:copy-of select="$header"/>
      </span>
    </dt>
    <dd>
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
                <a href="{.}">
                  <xsl:value-of select="."/>
                </a>
                <xsl:if test="contains(@role,'-authoritative')">
                  (Authoritative)
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
            <br/>
          </xsl:for-each>
        </xsl:otherwise>
      </xsl:choose>
    </dd>
  </dl>
</xsl:template>

<xsl:template match="authorgroup" mode="titlepage.mode">
  <xsl:variable name="chairs"  select="othercredit"/>
  <xsl:variable name="editors" select="editor"/>
  <xsl:variable name="authors" select="author"/>

  <xsl:if test="$chairs">
    <dl>
      <dt>
        <span class="contrib-heading">
          <xsl:text>Chair</xsl:text>
          <xsl:if test="count($chairs) &gt; 1">s</xsl:if>
          <xsl:text>:</xsl:text>
        </span>
      </dt>
      <dd>
          <xsl:apply-templates select="$chairs" mode="titlepage.mode"/>
      </dd>
    </dl>
  </xsl:if>
  <xsl:if test="$editors">
    <dl>
      <dt>
        <span class="editor-heading">
          <xsl:text>Editor</xsl:text>
          <xsl:if test="count($editors) &gt; 1">s</xsl:if>
          <xsl:text>:</xsl:text>
        </span>
      </dt>
      <dd>
          <xsl:apply-templates select="$editors" mode="titlepage.mode"/>
      </dd>
    </dl>
  </xsl:if>

  <xsl:if test="$authors">
    <dl>
      <dt>
        <span class="author-heading">
          <xsl:text>Author</xsl:text>
          <xsl:if test="count($authors) &gt; 1">s</xsl:if>
          <xsl:text>:</xsl:text>
        </span>
      </dt>
      <dd>
          <xsl:apply-templates select="$authors" mode="titlepage.mode"/>
      </dd>
    </dl>
  </xsl:if>

</xsl:template>

<xsl:template match="releaseinfo[@role='subject-keywords']" mode="titlepage.mode" priority="2">
  <dl>
    <dt><span class="loc-heading">Subject / Keywords:</span></dt>
    <dd>
        <xsl:apply-templates/>
    </dd>
  </dl>
</xsl:template>

<xsl:template match="releaseinfo[@role='topic']" mode="titlepage.mode" priority="2">
  <dl>
    <dt><span class="loc-heading">OASIS Conceptual Model Topic Area:</span></dt>
    <dd>
        <xsl:apply-templates/>
    </dd>
  </dl>
</xsl:template>

<xsl:template match="ulink" mode="revision-links">
  <xsl:if test="position() = 1"> (</xsl:if>
  <xsl:if test="position() &gt; 1">, </xsl:if>
  <a href="{@url}"><xsl:value-of select="@role"/></a>
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
  <xsl:if test="position()&lt;last()"><br/></xsl:if>
</xsl:template>

<xsl:template match="email" mode="titlepage.mode">
  <xsl:text>&#160;&lt;</xsl:text>
  <a href="mailto:{.}">
    <xsl:apply-templates/>
  </a>
  <xsl:text>></xsl:text>
</xsl:template>

<xsl:template match="abstract" mode="titlepage.mode">
  <dl>
    <dt>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <span class="abstract-heading">
        <xsl:apply-templates select="." mode="object.title.markup"/>
        <xsl:text>:</xsl:text>
      </span>
    </dt>
    <dd>
      <xsl:apply-templates mode="titlepage.mode"/>
    </dd>
  </dl>
</xsl:template>

<xsl:template match="legalnotice[title]" mode="titlepage.mode">
  <dl>
    <dt>
      <a>
        <xsl:attribute name="name">
          <xsl:call-template name="object.id"/>
        </xsl:attribute>
      </a>
      <span class="status-heading">
        <xsl:apply-templates select="." mode="object.title.markup"/>
        <xsl:text>:</xsl:text>
      </span>
    </dt>
    <dd>
      <xsl:apply-templates mode="titlepage.mode"/>
    </dd>
  </dl>
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
  <hr/>
  <h2>
    <xsl:apply-templates/>
  </h2>
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
  <xsl:if test="$generate.component.toc != 0">
    <xsl:variable name="nodes" select="section|sect1"/>
    <xsl:variable name="apps" select="bibliography|glossary|appendix"/>

    <xsl:if test="$nodes">
      <div class="toc">
        <h2>
          <xsl:call-template name="gentext">
            <xsl:with-param name="key">TableofContents</xsl:with-param>
          </xsl:call-template>
        </h2>

        <xsl:if test="$nodes">
          <xsl:element name="{$toc.list.type}">
            <xsl:apply-templates select="$nodes" mode="toc"/>
          </xsl:element>
        </xsl:if>

        <xsl:if test="$apps">
          <h3>Appendixes</h3>

          <xsl:element name="{$toc.list.type}">
            <xsl:apply-templates select="$apps" mode="toc"/>
          </xsl:element>
        </xsl:if>
      </div>
      <hr/>
    </xsl:if>
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
  <b>
    <xsl:apply-templates/>
  </b>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="para/revhistory">
  <xsl:variable name="numcols">
    <xsl:choose>
      <xsl:when test="//authorinitials">3</xsl:when>
      <xsl:otherwise>2</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <div class="{name(.)}">
    <table border="1" width="100%" summary="Revision history">
      <xsl:apply-templates mode="titlepage.mode">
        <xsl:with-param name="numcols" select="$numcols"/>
      </xsl:apply-templates>
    </table>
  </div>
</xsl:template>

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

<xsl:template match="table[starts-with(@role,'font-size-')]//td/node() |
                     table[starts-with(@role,'font-size-')]//entry/node()">
  <span style="font-size:{substring-after(ancestor::table[@role][1]/@role,
                                          'font-size-')}">
    <xsl:apply-imports/>
  </span>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="processing-instruction('lb')">
  <br/>
</xsl:template>

<!-- ============================================================ -->

</xsl:stylesheet>
