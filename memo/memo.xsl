<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/memo">
    <html>
      <head>
        <title><xsl:value-of select="title" /></title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karla"/>
        <link rel="stylesheet" href="/style.css" />

        <meta name="description" content="{description}" />
        <meta property="og:description" content="{description}" />
        <meta property="og:title" content="{title}" />
        <meta property="og:url" content="https://emilyshepherd.me/memo/{@url}" />
        <meta property="og:image" content="{img}" />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:site" content="@EmilyLShepherd" />
        <meta name="twitter:title" content="{title}" />
        <meta name="twitter:description" content="{description}" />
        <meta name="twitter:image" content="{img}" />
      </head>

      <body>
        <nav></nav>
        <span id="sectionTitle"><xsl:value-of select="title" /></span>
        
        <main>
          <section id="general_top">
            <div class="inner">
              <img src="{img}" height="300" />
              <header style="margin-top: 20px;">
                <h1><xsl:value-of select="title" /></h1>
                <p><xsl:apply-templates select="date" /></p>
              </header>
            </div>

            <xsl:for-each select="content/section">
              <section>
                <xsl:if test="@title">
                  <h2><xsl:value-of select="@title" /></h2>
                </xsl:if>

                <xsl:apply-templates />
              </section>
            </xsl:for-each>
          </section>
        </main>

        <section>
          <h2>References</h2>

          <table width="100%" cellborder="0" cellpadding="5">
            <xsl:for-each select="references/reference">
              <xsl:apply-templates select="." />
            </xsl:for-each>
          </table>
        </section>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="date">
    <xsl:value-of select="@day" />-<xsl:value-of select="@month" />-<xsl:value-of select="@year" />
  </xsl:template>

  <xsl:template match="ref">
    <sup>[<a href="#{@to}"><xsl:value-of select="@to" /></a>]</sup>
  </xsl:template>

  <xsl:template match="em">
    <em><xsl:apply-templates select="node()" /></em>
  </xsl:template>

  <xsl:template match="ul">
    <ul><xsl:apply-templates select="node()" /></ul>
  </xsl:template>

  <xsl:template match="li">
    <li><xsl:apply-templates select="node()" /></li>
  </xsl:template>

  <xsl:template match="p">
    <p><xsl:apply-templates select="node()" /></p>
  </xsl:template>

  <xsl:template match="reference">
    <tr id="{@id}">
      <td>[<xsl:value-of select="@id" />]</td>
      <td>
        <xsl:value-of select="author" />,
        "<xsl:value-of select="title" />",

        <xsl:if test="date">
          <xsl:apply-templates select="date" />,
        </xsl:if>

        &lt;<a href="{normalize-space(url)}"><xsl:value-of select="normalize-space(url)" /></a>&gt;
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>
