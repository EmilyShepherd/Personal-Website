<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text" />
  <xsl:strip-space elements="*" />

  <xsl:template match="memo">
    <xsl:call-template name="underline">
      <xsl:with-param name="str" select="title" />
      <xsl:with-param name="chr" select="'='" />
    </xsl:call-template>
    
    <xsl:apply-templates select="date" />

    <xsl:text>&#xa;&#xa;</xsl:text>

    <xsl:apply-templates select="content/*" />

    <xsl:text>&#xa;</xsl:text>

    <xsl:call-template name="underline">
      <xsl:with-param name="str">References</xsl:with-param>
      <xsl:with-param name="chr" select="'-'" />
    </xsl:call-template>

    <xsl:for-each select="references/reference">
      <xsl:text>[</xsl:text>
      <xsl:value-of select="@id" />
      <xsl:text>]</xsl:text>

      <xsl:if test="string-length(@id) &gt; 7">
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>         </xsl:text>
      </xsl:if>
      <xsl:if test="string-length(@id) &lt; 8">
        <xsl:for-each select="string-length(@id) to 6">
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:if>

      <xsl:call-template name="indent">
        <xsl:with-param name="str">
          <xsl:call-template name="wrapText">
            <xsl:with-param name="len" select="61" />
            <xsl:with-param name="text">
              <xsl:value-of select="normalize-space(author)" />

              <xsl:text>, "</xsl:text>

              <xsl:value-of select="normalize-space(title)" />

              <xsl:text>", </xsl:text>

              <xsl:if test="date">
                <xsl:apply-templates select="date" />
                <xsl:text>, </xsl:text>
              </xsl:if>

              <xsl:if test="string-length(normalize-space(url)) &lt; 60">
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="normalize-space(url)" />
                <xsl:text>&gt;</xsl:text>
              </xsl:if>
            </xsl:with-param>
          </xsl:call-template>
          <xsl:if test="string-length(normalize-space(url)) &gt; 59">
            <xsl:text>  &lt;</xsl:text>
            <xsl:value-of select="normalize-space(url)" />
            <xsl:text>&gt;&#xa;</xsl:text>
          </xsl:if>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="section">
    <xsl:text>&#xa;</xsl:text>
    <xsl:if test="@title">
      <xsl:call-template name="underline">
        <xsl:with-param name="str" select="@title" />
        <xsl:with-param name="chr" select="'-'" />
      </xsl:call-template>
    </xsl:if>
    
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template name="indent">
    <xsl:param name="str" />

    <xsl:value-of select="replace($str, '(.&#xa;)', '$1         ')" />
  </xsl:template>

  <xsl:template name="wrapText">
    <xsl:param name="text" />
    <xsl:param name="len" select="70" />

    <xsl:value-of select="replace(
        concat(normalize-space($text), ' '),
        concat('(.{0,', $len, '}) '),
        '  $1&#xa;')" />
  </xsl:template>

  <xsl:template name="underline">
    <xsl:param name="str" />
    <xsl:param name="chr" />

    <xsl:value-of select="$str" />
    <xsl:text>&#xa;</xsl:text>

    <xsl:for-each select="1 to string-length($str)">
      <xsl:value-of select="$chr"/>
    </xsl:for-each>

    <xsl:text>&#xa;&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="p">
    <xsl:call-template name="wrapText">
      <xsl:with-param name="text">
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="ul">
    <xsl:apply-templates />
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="li">
    <xsl:text>    + </xsl:text> 
    <xsl:call-template name="wrapText">
      <xsl:with-param name="text">
        <xsl:apply-templates />
      </xsl:with-param>
      <xsl:with-param name="len" select="62" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="em">
    _<xsl:apply-templates />_
  </xsl:template>

  <xsl:template match="date">
    <xsl:value-of select="concat(@day, ' ', @month, ' ', @year)" />
  </xsl:template>

  <xsl:template match="ref">
    <xsl:text>[</xsl:text>
    <xsl:value-of select="@to" />
    <xsl:text>]</xsl:text>
  </xsl:template>
</xsl:stylesheet>
