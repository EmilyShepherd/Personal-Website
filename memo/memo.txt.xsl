<?xml version="1.1" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text" />
  <xsl:strip-space elements="*" />

  <xsl:variable name="header">
    <xsl:call-template name="pad">
      <xsl:with-param
          name="number"
          select="floor((72 - string-length(/memo/title)) div 2)" />
    </xsl:call-template>

    <xsl:value-of select="/memo/title" />
  </xsl:variable>

  <xsl:variable name="header2">
    <xsl:variable name="date">
      <xsl:value-of select="/memo/date/@month" />
      <xsl:text> </xsl:text>
      <xsl:value-of select="/memo/date/@year" />
    </xsl:variable>

    <xsl:value-of select="$header" />

    <xsl:for-each
        select="string-length($header) to (71 - string-length($date))">
      <xsl:text> </xsl:text>
    </xsl:for-each>

    <xsl:value-of select="$date" />
  </xsl:variable>

  <xsl:variable name="date">
    <xsl:apply-templates select="/memo/date" />
  </xsl:variable>

  <xsl:template match="/">
    <xsl:call-template name="paginate">
      <xsl:with-param name="text">
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="memo">
    <xsl:call-template name="pad">
      <xsl:with-param name="number">61</xsl:with-param>
    </xsl:call-template>

    <xsl:text>E. Shepherd&#xa;</xsl:text>

    <xsl:call-template name="pad">
      <xsl:with-param name="number" select="72 - string-length($date)" />
    </xsl:call-template>

    <xsl:value-of select="$date" />

    <xsl:text>&#xa;&#xa;&#xa;</xsl:text>

    <xsl:value-of select="$header" />

    <xsl:text>&#xa;&#xa;</xsl:text>

    <xsl:apply-templates select="content/*" />

    <xsl:text>&#xa;</xsl:text>

    <xsl:call-template name="underline">
      <xsl:with-param name="str">References</xsl:with-param>
      <xsl:with-param name="chr" select="'-'" />
    </xsl:call-template>

    <xsl:for-each select="references/reference">
      <xsl:sort select="@id" />
      <xsl:text>   [</xsl:text>
      <xsl:value-of select="@id" />
      <xsl:text>]</xsl:text>

      <xsl:if test="string-length(@id) &gt; 7">
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>            </xsl:text>
      </xsl:if>
      <xsl:if test="string-length(@id) &lt; 8">
        <xsl:for-each select="string-length(@id) to 6">
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </xsl:if>

      <xsl:call-template name="wrapText">
        <xsl:with-param name="len" select="58" />
        <xsl:with-param name="indent" select="'              '" />
        <xsl:with-param name="startIndent" select="'  '" />
        <xsl:with-param name="text">
          <xsl:value-of select="normalize-space(author)" />

          <xsl:text>, "</xsl:text>

          <xsl:value-of select="normalize-space(title)" />

          <xsl:text>", </xsl:text>

          <xsl:if test="date">
            <xsl:apply-templates select="date" />
            <xsl:text>, </xsl:text>
          </xsl:if>

          <xsl:text>&lt;</xsl:text>
          <xsl:value-of select="normalize-space(url)" />
          <xsl:text>&gt;</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>

    <xsl:text>&#xa;</xsl:text>

    <xsl:text>Document History&#xa;</xsl:text>
    <xsl:text>----------------&#xa;&#xa;</xsl:text>

    <xsl:call-template name="wrapText">
      <xsl:with-param name="text">
        <xsl:text>&lt;https://github.com/EmilyShepherd/</xsl:text>
        <xsl:text>Personal-Website/commits/master/memo/</xsl:text>
        <xsl:value-of select="@url" />
        <xsl:text>.xml&gt;</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:text>&#xa;&#xa;</xsl:text>

    <xsl:text>Alternative Formats&#xa;</xsl:text>
    <xsl:text>-------------------&#xa;&#xa;</xsl:text>

    <xsl:text>   HTML     </xsl:text>
    <xsl:call-template name="wrapText">
      <xsl:with-param name="startIndent" select="''" />
      <xsl:with-param name="indent" select="'         '" />
      <xsl:with-param name="text">
        <xsl:text>&lt;https://emilyshepherd.me/memo/</xsl:text>
        <xsl:value-of select="@url" />
        <xsl:text>&gt;</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    <xsl:text>&#xa;</xsl:text>

    <xsl:text>   XML      </xsl:text>
    <xsl:call-template name="wrapText">
      <xsl:with-param name="startIndent" select="''" />
      <xsl:with-param name="indent" select="'         '" />
      <xsl:with-param name="text">
        <xsl:text>&lt;https://emilyshepherd.me/memo/</xsl:text>
        <xsl:value-of select="@url" />
        <xsl:text>.xml&gt;</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
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

  <xsl:template name="paginate">
    <xsl:param name="text" />

    <xsl:text>&#xa;&#xa;&#xa;&#xa;&#xa;&#xa;</xsl:text>
    <xsl:call-template name="outputLines">
      <xsl:with-param name="lines" select="tokenize($text, '&#xa;')" />
      <xsl:with-param name="number" select="1" />
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="outputLines">
    <xsl:param name="lines" />
    <xsl:param name="number" />

    <xsl:choose>
      <xsl:when test="$lines[1] = ''">
        <xsl:call-template name="outputLines">
          <xsl:with-param name="lines" select="subsequence($lines, 2)" />
          <xsl:with-param name="number" select="$number" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="_outputLines">
          <xsl:with-param name="lines" select="$lines" />
          <xsl:with-param name="number" select="$number" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="_outputLines">
    <xsl:param name="lines" />
    <xsl:param name="left" select="45" />
    <xsl:param name="number" />

    <xsl:value-of select="$lines[1]" />
    <xsl:text>&#xa;</xsl:text>

    <xsl:choose>
      <xsl:when test="$left &gt; 1">
        <xsl:call-template name="_outputLines">
          <xsl:with-param name="lines" select="subsequence($lines, 2)" />
          <xsl:with-param name="left" select="$left - 1" />
          <xsl:with-param name="number" select="$number" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="_paginate">
          <xsl:with-param name="text" select="subsequence($lines, 2)" />
          <xsl:with-param name="number" select="$number" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="_advancePage">
    <xsl:param name="text" />
    <xsl:param name="number" />

    <xsl:text>&#xa;&#xa;</xsl:text>
    
    <xsl:variable name="page">
      <xsl:text>[Page </xsl:text>
      <xsl:value-of select="$number" />
      <xsl:text>]</xsl:text>
    </xsl:variable>

    <xsl:text>Shepherd                          Memo</xsl:text>

    <xsl:call-template name="pad">
      <xsl:with-param name="number" select="34 - string-length($page)"/>
    </xsl:call-template>

    <xsl:value-of select="$page" />
    <xsl:text>&#xa;</xsl:text>
    
    <xsl:if test="not(empty($text))">
      <xsl:text>&#12;&#xa;</xsl:text>
      <xsl:value-of select="$header2" />
      <xsl:text>&#xa;&#xa;&#xa;</xsl:text>

      <xsl:call-template name="outputLines">
        <xsl:with-param name="lines" select="$text" />
        <xsl:with-param name="number" select="$number + 1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="_paginate">
    <xsl:param name="text" />
    <xsl:param name="number" />

    <xsl:choose>
      <xsl:when test="starts-with($text[2], '-') and not($text[5] = '')">
        <xsl:call-template name="_advancePage">
          <xsl:with-param name="text" select="$text" />
          <xsl:with-param name="number" select="$number" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text[1]" />
        <xsl:text>&#xa;</xsl:text>
        <xsl:value-of select="$text[2]" />
        <xsl:text>&#xa;</xsl:text>

        <xsl:choose>
          <xsl:when test="$text[3] = '' and $text[5] = ''">
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="$text[4]" />
            <xsl:text>&#xa;</xsl:text>

            <xsl:call-template name="_advancePage">
              <xsl:with-param name="text" select="subsequence($text, 5)" />
              <xsl:with-param name="number" select="$number" />
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$text[3] = ''">
            <xsl:text>&#xa;&#xa;</xsl:text>

            <xsl:call-template name="_advancePage">
              <xsl:with-param name="text" select="subsequence($text, 3)" />
              <xsl:with-param name="number" select="$number" />
            </xsl:call-template>
          </xsl:when>
          <xsl:when test="$text[6] = '' and not($text[5] = '')">
            <xsl:value-of select="$text[1]" />
            <xsl:text>&#xa;&#xa;</xsl:text>
            <xsl:call-template name="_advancePage">
              <xsl:with-param name="text" select="subsequence($text, 4)" />
              <xsl:with-param name="number" select="$number" />
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="$text[3]" />
            <xsl:text>&#xa;</xsl:text>
            <xsl:value-of select="$text[4]" />
            <xsl:text>&#xa;</xsl:text>

            <xsl:call-template name="_advancePage">
              <xsl:with-param name="text" select="subsequence($text, 5)" />
              <xsl:with-param name="number" select="$number" />
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="wrapText">
    <xsl:param name="text" />
    <xsl:param name="len" select="69" />
    <xsl:param name="indent" select="'   '" />
    <xsl:param name="startIndent" select="'   '" />

    <xsl:variable name="str" select="tokenize(normalize-space($text), ' ')" />

    <xsl:value-of select="$startIndent" />

    <xsl:call-template name="_wrapText">
      <xsl:with-param name="word" select="$str[1]" />
      <xsl:with-param name="rest" select="subsequence($str, 2)" />
      <xsl:with-param name="len" select="$len" />
      <xsl:with-param name="start" select="true()" />
      <xsl:with-param name="indent" select="$indent" />
    </xsl:call-template>

    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template name="_wrapText">
    <xsl:param name="word" />
    <xsl:param name="rest" />
    <xsl:param name="len" />
    <xsl:param name="left" select="$len" />
    <xsl:param name="start" select="false()" />
    <xsl:param name="indent" />

    <xsl:variable name="strlen" select="string-length($word)" />

    <xsl:if test="string-length($word) != 0">
      <xsl:if test="$start = false()">
        <xsl:if test="$left = $len">
          <xsl:text>&#xa;</xsl:text>
          <xsl:value-of select="$indent" />
        </xsl:if>
      </xsl:if>

      <xsl:choose>
        <xsl:when test="$strlen = $left">
          <xsl:value-of select="$word" />
          <xsl:call-template name="_wrapText">
            <xsl:with-param name="word" select="$rest[1]" />
            <xsl:with-param name="rest" select="subsequence($rest, 2)" />
            <xsl:with-param name="len" select="$len" />
            <xsl:with-param name="indent" select="$indent" />
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$strlen &lt; $left">
          <xsl:value-of select="$word" />
          <xsl:text> </xsl:text>
          <xsl:call-template name="_wrapText">
            <xsl:with-param name="word" select="$rest[1]" />
            <xsl:with-param name="rest" select="subsequence($rest, 2)" />
            <xsl:with-param name="len" select="$len" />
            <xsl:with-param name="left" select="$left - $strlen - 1" />
            <xsl:with-param name="indent" select="$indent" />
          </xsl:call-template>
        </xsl:when>
        <xsl:when test="$strlen &gt; $len">
          <xsl:value-of select="substring($word, 1, $left)" />
          <xsl:call-template name="_wrapText">
            <xsl:with-param name="word" select="substring($word, $left + 1)" />
            <xsl:with-param name="rest" select="$rest" />
            <xsl:with-param name="len" select="$len" />
            <xsl:with-param name="indent" select="$indent" />
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="_wrapText">
            <xsl:with-param name="word" select="$word" />
            <xsl:with-param name="rest" select="$rest" />
            <xsl:with-param name="len" select="$len" />
            <xsl:with-param name="indent" select="$indent" />
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
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

  <xsl:template name="pad">
    <xsl:param name="number" />

    <xsl:if test="$number &gt; 0">
      <xsl:text> </xsl:text>
      <xsl:call-template name="pad">
        <xsl:with-param name="number" select="$number - 1" />
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template match="p">
    <xsl:call-template name="wrapText">
      <xsl:with-param name="text">
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text>&#xa;</xsl:text>
  </xsl:template>

  <xsl:template match="li">
    <xsl:text>   o  </xsl:text> 
    <xsl:call-template name="wrapText">
      <xsl:with-param name="startIndent" />
      <xsl:with-param name="indent" select="'      '" />
      <xsl:with-param name="text">
        <xsl:apply-templates />
      </xsl:with-param>
      <xsl:with-param name="len" select="66" />
    </xsl:call-template>
    <xsl:text>&#xa;</xsl:text>
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
