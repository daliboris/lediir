<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 16, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:entry/tei:entry">
  <xsl:if test="not(preceding-sibling::tei:entry) or @ana != preceding-sibling::tei:entry[1]/@ana">
   <lbl type="{@type}"  subtype="{substring-after(@ana, '#')}" />
  </xsl:if>
  <xsl:copy-of select="." />
 </xsl:template>
 
 <xsl:template match="tei:entry[tei:entry[@copyOf]]" use-when="false()">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:for-each-group select="*" group-adjacent="if(self::tei:entry) then substring-after(./@ana, '#') else ''">
    <xsl:choose>
     <xsl:when test="current-grouping-key() = ''">
      <xsl:copy-of select="current-group()" />
     </xsl:when>
     <xsl:otherwise>
      <lbl type="{current-group()[1]/@type}"  subtype="{current-grouping-key()}" />
     </xsl:otherwise>
    </xsl:choose>
   </xsl:for-each-group>
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>