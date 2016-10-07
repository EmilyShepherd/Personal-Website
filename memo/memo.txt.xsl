<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text" />
  <xsl:strip-space elements="*" />

  <xsl:template match="memo">
    <xsl:call-template name="underline">
      <xsl:with-param name="str" select="title" />
      <xsl:with-param name="chr" select="'='" />
    </xsl:call-template>
    
    <xsl:value-of select="concat(date/@day, ' ', date/@month, ' ', date/@year, ' ')" />

    <xsl:text>&#xa;&#xa;</xsl:text>

    <xsl:apply-templates select="content/*" />
  </xsl:template>

  <xsl:template match="section">
    <xsl:text>&#xa;&#xa;</xsl:text>
    <xsl:if test="@title">
      <xsl:call-template name="underline">
        <xsl:with-param name="str" select="@title" />
        <xsl:with-param name="chr" select="'-'" />
      </xsl:call-template>
    </xsl:if>
    
    <xsl:apply-templates />
  </xsl:template>

  <xsl:template name="wrapText">
    <xsl:param name="text" />
    <xsl:param name="len" select="72" />

    <xsl:value-of select="replace(
        concat(normalize-space($text), ' '),
        concat('(.{0,', $len, '}) '),
        '$1&#xa;')" />
    <xsl:text>&#xa;</xsl:text>
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
  </xsl:template>

  <xsl:template match="li">
    <xsl:text>  + </xsl:text> 
    <xsl:call-template name="wrapText">
      <xsl:with-param name="text">
        <xsl:apply-templates />
      </xsl:with-param>
      <xsl:with-param name="len" select="64" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="em">
    _<xsl:apply-templates />_
  </xsl:template>

</xsl:stylesheet>
