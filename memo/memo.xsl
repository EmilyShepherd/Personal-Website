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
        <meta property="og:image" content="{img[@rel='social']}" />
        <meta name="twitter:card" content="summary_large_image" />
        <meta name="twitter:site" content="@EmilyLShepherd" />
        <meta name="twitter:title" content="{title}" />
        <meta name="twitter:description" content="{description}" />
        <meta name="twitter:image" content="{img[@rel='social']}" />
      </head>

      <body>
        <nav></nav>
        <span id="sectionTitle"><xsl:value-of select="title" /></span>
        
        <main>
          <section class="general_top">
            <div class="inner">
              <img src="{img[@rel='header']}" height="300" />
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

        <section class="band" id="references">
          <h2>References</h2>

          <xsl:for-each select="references/reference">
            <xsl:sort select="@id" />
            <xsl:apply-templates select="." />
          </xsl:for-each>
        </section>

        <xsl:if test="foot">
          <section class="general_top">
            <h1>Appendices</h1>
            <xsl:for-each select="foot/*">
              <section>
                <h2><xsl:value-of select="@title" /></h2>
                <xsl:apply-templates />
              </section>
            </xsl:for-each>
          </section>
        </xsl:if>

        <footer>
          <small>
            <a href="https://github.com/EmilyShepherd/Personal-Website/commits/master/memo/icann.xml">
              <xsl:text>Document History</xsl:text>
            </a>
            <br /><br />
            Alternative Formats:
            <br />
            <a href="https://emilyshepherd.me/memo/{@url}.txt">
              <xsl:text>TXT</xsl:text>
            </a>
            |
            <a href="https://emilyshepherd.me/memo/{@url}.xml">
              <xsl:text>XML</xsl:text>
            </a>
          </small>
        </footer>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="date">
    <xsl:value-of select="@day" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="@month" />
    <xsl:text> </xsl:text>
    <xsl:value-of select="@year" />
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

  <xsl:template match="fig">
    <pre><xsl:value-of select="replace(., '(^|\n) +', '&#xa;')" /></pre>
  </xsl:template>

  <xsl:template match="reference">
    <div>
      <h3 id="{@id}"><xsl:value-of select="@id" /></h3>
      <span>
        <xsl:value-of select="normalize-space(author)" />,
        "<xsl:value-of select="normalize-space(title)" />",

        <xsl:if test="date">
          <xsl:apply-templates select="date" />,
        </xsl:if>

        <xsl:text>&lt;</xsl:text>
        <a href="{normalize-space(url)}"><xsl:value-of select="normalize-space(url)" /></a>
        <xsl:text>&gt;</xsl:text>
      </span>
    </div>
  </xsl:template>
</xsl:stylesheet>
