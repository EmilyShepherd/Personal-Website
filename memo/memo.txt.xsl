<?xml version="1.1" encoding="UTF-8"?>
<!DOCTYPE stylesheet [
<!ENTITY sp "<xsl:text> </xsl:text>">
<!ENTITY nl "<xsl:text>&#xa;</xsl:text>">
<!ENTITY ob "<xsl:text>[</xsl:text>">
<!ENTITY cb "<xsl:text>]</xsl:text>">
<!ENTITY comma "<xsl:text>, </xsl:text>">
<!ENTITY qut '<xsl:text>"</xsl:text>'>
]>
<xsl:stylesheet version="2.0" 
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:memo="https://emilyshepherd.me/memo"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
  <xsl:output method="text" />
  <xsl:strip-space elements="*" />

  <!-- VARIABLES -->

  <xsl:param name="PAGE_SIZE">54</xsl:param>
  <xsl:param name="FILE_NAME" />

  <xsl:variable name="header">
    <xsl:value-of select="memo:padToCenter(/memo/title)" />
  </xsl:variable>

  <xsl:variable name="header2">
    <xsl:text>&#12;</xsl:text>&nl;
    <xsl:call-template name="padToRight">
      <xsl:with-param name="str">
        <xsl:value-of select="/memo/date/@month" />
        &sp;
        <xsl:value-of select="/memo/date/@year" />
      </xsl:with-param>
      <xsl:with-param name="left" select="$header" />
    </xsl:call-template>
    &nl;&nl;
  </xsl:variable>

  <xsl:variable name="date">
    <xsl:apply-templates select="/memo/date" />
  </xsl:variable>

  <!-- / VARIABLES -->

  <!-- MAIN -->

  <xsl:template match="/">
    <xsl:variable name="text"><xsl:apply-templates /></xsl:variable>

    &nl;&nl;&nl;

    <xsl:value-of
      select="memo:page(tokenize($text, '&#xa;'), $PAGE_SIZE, 1, '')" />
  </xsl:template>

  <!-- / MAIN -->

  <!-- MEMO -->

  <xsl:template match="memo">
    <xsl:value-of select="memo:padToRight('E. Shepherd')" />
    <xsl:value-of select="memo:padToRight($date)" />
    &nl;
    &nl;
    <xsl:value-of select="$header" />&nl;
    &nl;
    &nl;
    <xsl:text>Table of Contents</xsl:text>&nl;

    <xsl:for-each select="1 to count(//section) + 3">
      <xsl:text>&#xa; ,</xsl:text>
    </xsl:for-each>

    &nl;&nl;
    <xsl:apply-templates select="content/*" />&nl;

    <xsl:text>References</xsl:text>&nl;

    <xsl:for-each select="references/*"><xsl:sort select="@id"/>
      &nl;
      <xsl:call-template name="hangingItem">
        <xsl:with-param name="label">
          &ob;<xsl:value-of select="@id" />&cb;
        </xsl:with-param>
        <xsl:with-param name="text">
          <xsl:value-of select="normalize-space(author)" />&comma;

          &qut;<xsl:value-of select="normalize-space(title)" />&qut;
          &comma;

          <xsl:if test="date">
            <xsl:apply-templates select="date" />&comma;
          </xsl:if>

          <xsl:text>&lt;</xsl:text>
          <xsl:value-of select="normalize-space(url)" />
          <xsl:text>&gt;</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>

    &nl;&nl;

    <xsl:if test="foot">
      <xsl:apply-templates select="foot/*">
        <xsl:with-param name="prefix">Appendix&sp;</xsl:with-param>
      </xsl:apply-templates>
    </xsl:if>

    <xsl:text>Document History</xsl:text>&nl;
    &nl;
    <xsl:call-template name="wrapText">
      <xsl:with-param name="text">
        <xsl:text>&lt;https://github.com/EmilyShepherd/</xsl:text>
        <xsl:text>Personal-Website/commits/master/memo/</xsl:text>
        <xsl:value-of select="$FILE_NAME" />
        <xsl:text>.xml&gt;</xsl:text>
      </xsl:with-param>
    </xsl:call-template>

    &nl;&nl;

    <xsl:text>Alternative Formats</xsl:text>&nl;
    <xsl:value-of select="memo:format('HTML', $FILE_NAME, '')" />
    <xsl:value-of select="memo:format('XML', $FILE_NAME, '.xml')" />
  </xsl:template>

  <!-- / MEMO -->
  
  <!-- NODES -->

  <xsl:template match="section/*[not(self::fig or self::ul or self::section)]">
    <xsl:call-template name="wrapText">
      <xsl:with-param name="text">
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
    &nl;
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
    &nl;
  </xsl:template>

  <xsl:template match="fig">
    <xsl:for-each select="tokenize(replace(., '^ *\n',''), '&#xa;')">
      <xsl:choose>
        <xsl:when test=".">
          <xsl:call-template name="wrapText">
            <xsl:with-param name="text" select="." />
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>&nl;</xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
    &nl;
  </xsl:template>

  <xsl:template match="section">
    <xsl:param name="prefix" />

    <xsl:variable name="newPrefix">
      <xsl:value-of select="$prefix" />
      <xsl:value-of select="index-of(../section, .)" />
      <xsl:text>.</xsl:text>
    </xsl:variable>

    &nl;
    <xsl:value-of select="$newPrefix" />&sp;&sp;

    <xsl:choose>
      <xsl:when test="@title">
        <xsl:value-of select="@title" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>Introduction</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:if test="not(*[1] = section)">&nl;</xsl:if>

    &nl;
    <xsl:apply-templates>
      <xsl:with-param name="prefix" select="$newPrefix" />
    </xsl:apply-templates>
  </xsl:template>

  <xsl:template match="date">
    <xsl:value-of select="concat(@day, ' ', @month, ' ', @year)" />
  </xsl:template>

  <xsl:template match="em">_<xsl:apply-templates />_</xsl:template>
  <xsl:template match="ref">[<xsl:value-of select="@to" />]</xsl:template>

  <!-- / NODES -->

  <!-- TEXT PROCESSING -->

  <xsl:function name="memo:pad">
    <xsl:param name="count" />
    <xsl:value-of select="memo:pad($count, ' ')" />
  </xsl:function>
  <xsl:function name="memo:pad">
    <xsl:param name="count" />
    <xsl:param name="chr" />
    <xsl:for-each select="1 to $count">
      <xsl:value-of select="$chr" />
    </xsl:for-each>
  </xsl:function>

  <xsl:function name="memo:padToCenter">
    <xsl:param name="str" />
    <xsl:value-of select="memo:padToCenter($str, 0)" />
  </xsl:function>
  <xsl:function name="memo:padToCenter">
    <xsl:param name="str" />
    <xsl:param name="left" />
    <xsl:variable name="pad" select="36 - string-length($str) div 2" />
    <xsl:value-of select="memo:pad(xs:integer(floor($pad) - $left))" />
    <xsl:value-of select="$str" />
  </xsl:function>

  <xsl:template name="padToRight">
    <xsl:param name="str" />
    <xsl:param name="left" />
    <xsl:value-of select="$left" />
    <xsl:value-of select="memo:padToRight($str, string-length($left))" />
  </xsl:template>
  <xsl:function name="memo:padToRight">
    <xsl:param name="str" />
    <xsl:value-of select="memo:padToRight($str, 0)" />
  </xsl:function>
  <xsl:function name="memo:padToRight">
    <xsl:param name="str" />
    <xsl:param name="left" />
    <xsl:value-of select="memo:pad(72 - string-length($str) - $left)" />
    <xsl:value-of select="$str" />
    &nl;
  </xsl:function>

  <xsl:function name="memo:format">
    <xsl:param name="label" />
    <xsl:param name="url" />
    <xsl:param name="ext" />

    &nl;
    <xsl:call-template name="hangingItem">
      <xsl:with-param name="label" select="$label" />
      <xsl:with-param name="text">
        <xsl:text>&lt;https://emilyshepherd.me/memo/</xsl:text>
        <xsl:value-of select="$url" />
        <xsl:value-of select="$ext" />
        <xsl:text>&gt;</xsl:text>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:function>

  <xsl:template name="hangingItem">
    <xsl:param name="label" />
    <xsl:param name="text" />
    
    &sp;&sp;&sp;
    <xsl:value-of select="$label" />

    <xsl:choose>
      <xsl:when test="string-length($label) &gt; 9">
        &nl;
        &sp;&sp;&sp;&sp;&sp;&sp;&sp;&sp;&sp;&sp;&sp;&sp;
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="memo:pad(9 - string-length($label))" />
      </xsl:otherwise>
    </xsl:choose>

    <xsl:call-template name="wrapText">
      <xsl:with-param name="len" select="58" />
      <xsl:with-param name="indent" select="'              '" />
      <xsl:with-param name="startIndent" select="'  '" />
      <xsl:with-param name="text" select="$text" />
    </xsl:call-template>
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

    &nl;
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
          &nl;
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
          &sp;
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

  <!-- / TEXT PROCESSING -->

  <!-- PAGINATION -->

  <xsl:template name="outputLines">
    <xsl:param name="lines" />
    <xsl:param name="number" />
    <xsl:param name="output" />

    <xsl:choose>
      <xsl:when test="$lines[1] = ''">
        <xsl:call-template name="outputLines">
          <xsl:with-param name="lines" select="subsequence($lines, 2)" />
          <xsl:with-param name="number" select="$number" />
          <xsl:with-param name="output" select="$output" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of
          select="memo:page($lines, $PAGE_SIZE, $number, $output)" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:function name="memo:page">
    <xsl:param name="lines" />
    <xsl:param name="left" />
    <xsl:param name="number" />
    <xsl:param name="output" />

    <xsl:variable name="outputTop">
      <xsl:call-template name="addLine">
        <xsl:with-param name="output" select="$output" />
        <xsl:with-param name="line" select="$lines[1]" />
        <xsl:with-param name="number" select="$number" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="$left &gt; 1">
        <xsl:value-of select="memo:page(
          subsequence($lines, 2), $left - 1, $number, $outputTop)" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="_paginate">
          <xsl:with-param name="text" select="subsequence($lines, 2)" />
          <xsl:with-param name="number" select="$number" />
          <xsl:with-param name="output" select="$outputTop" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:function>

  <xsl:template name="_advancePage">
    <xsl:param name="text" />
    <xsl:param name="number" />
    <xsl:param name="output" />
    
    <xsl:variable name="outputTop">
      <xsl:value-of select="$output" />
      &nl;&nl;
      <xsl:call-template name="padToRight">
        <xsl:with-param name="str">
          <xsl:text>[Page </xsl:text>
          <xsl:value-of select="$number" />
          <xsl:text>]</xsl:text>
        </xsl:with-param>
        <xsl:with-param name="left">
          <xsl:text>Shepherd</xsl:text>
          <xsl:value-of select="memo:padToCenter('Memo', 8)" />
        </xsl:with-param>
      </xsl:call-template>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="count($text) &lt;= 1">
        <xsl:value-of select="$outputTop" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="outputLines">
          <xsl:with-param name="lines" select="$text" />
          <xsl:with-param name="number" select="$number + 1" />
          <xsl:with-param name="output">
            <xsl:value-of select="$outputTop" />
            <xsl:value-of select="$header2" />
          </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="_paginate">
    <xsl:param name="text" />
    <xsl:param name="number" />
    <xsl:param name="output" />

    <xsl:choose>
      <xsl:when test="(matches($text[1], '^[^ ]') and $text[4]) or matches($text[2], '^[^ ]') or matches($text[3], '^[^ ]')">
        <xsl:call-template name="_advancePage">
          <xsl:with-param name="text" select="$text" />
          <xsl:with-param name="number" select="$number" />
          <xsl:with-param name="output">
            <xsl:value-of select="$output" />
            &nl;&nl;&nl;
          </xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="outputTop">
          <xsl:call-template name="addLine">
            <xsl:with-param name="number" select="$number" />
            <xsl:with-param name="output" select="$output" />
            <xsl:with-param name="line" select="$text[1]" />
          </xsl:call-template>
          <xsl:value-of select="$text[2]" />
          &nl;
        </xsl:variable>

        <xsl:choose>
          <xsl:when test="not($text[4]) or ($text[2] and $text[5])">
            <xsl:call-template name="_advancePage">
              <xsl:with-param name="text" select="subsequence($text, 4)" />
              <xsl:with-param name="number" select="$number" />
              <xsl:with-param name="output">
                <xsl:value-of select="$outputTop" />
                <xsl:value-of select="$text[3]" />
                &nl;
              </xsl:with-param>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="_advancePage">
              <xsl:with-param name="text" select="subsequence($text, 3)" />
              <xsl:with-param name="number" select="$number" />
              <xsl:with-param name="output">
                <xsl:value-of select="$outputTop" />
                &nl;
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="addLine">
    <xsl:param name="line" />
    <xsl:param name="output" />
    <xsl:param name="number" />

    <xsl:choose>
      <xsl:when test="not(starts-with($line, 'Table')) and matches($line, '^[^ ]')">
        <xsl:variable name="level" select="
          count(tokenize(substring-before($line,' '),'\.'))" />
        <xsl:variable name="padding" as="xs:integer">
          <xsl:choose>
            <xsl:when test="$level &lt;= 2">
              <xsl:value-of select="3" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$level + $level - 1" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="substring-before($output, ' ,')" />
        <xsl:value-of select="memo:pad($padding)" />

        <xsl:value-of select="$line" />&sp;

        <xsl:value-of select="memo:pad(69 - $padding - string-length($line) - string-length(string($number)), '.')" />

        &sp;&sp;
        <xsl:value-of select="$number" />
        <xsl:value-of select="substring-after($output, ' ,')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$output" />
      </xsl:otherwise>
    </xsl:choose>

    <xsl:value-of select="$line" />
    &nl;
  </xsl:template>

  <!-- / PAGINATION -->

</xsl:stylesheet>
