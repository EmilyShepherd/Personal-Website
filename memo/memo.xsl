<?xml version="1.0" encoding="UTF-8"?>
<html xsl:version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <head>
    <title><xsl:value-of select="memo/title" /></title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karla"/>
    <link rel="stylesheet" href="/style.css" />
  </head>

  <body>
    <nav></nav>
    <span id="sectionTitle"><xsl:value-of select="memo/title" /></span>
    
    <main>
      <section id="general_top">
        <div class="inner">
          <header>
            <h1><xsl:value-of select="memo/title" /></h1>
            <p><xsl:value-of select="
                concat(
                    memo/date/@day, ' ',
                    memo/date/@month, ' ',
                    memo/date/@year, ' '
                )"/></p>
          </header>
        </div>

        <xsl:copy-of select="/memo/content/node()" />
      </section>
    </main>
  </body>
</html>
