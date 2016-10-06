<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text" />
  <xsl:strip-space elements="*" />

  <xsl:template match="/">
    <xsl:value-of select="concat('# ', memo/title)" />
    <xsl:text>&#xa;</xsl:text>
    
            <xsl:value-of select="
                concat(
                    memo/date/@day, ' ',
                    memo/date/@month, ' ',
                    memo/date/@year, ' '
                    )" />

    <xsl:apply-templates select="/memo/content/node()" />
  </xsl:template>

  <xsl:template match="h2">
    <xsl:value-of select="concat('## ', .)" />
    <xsl:text>&#xa;&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="p">
    <xsl:value-of select="replace(concat(normalize-space(.), ' '), '(.{0,72}) ', '$1&#xa;')" />
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>
</xsl:stylesheet>
