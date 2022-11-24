<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 9, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:key name="categories" match="tei:category" use="@xml:id" />
 
 <xsl:template match="tei:category">
  <xsl:variable name="categories" select="key('categories', @xml:id)"/>
  <xsl:choose>
   <xsl:when test="count($categories) = 1">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:apply-templates />
    </xsl:copy>
   </xsl:when>
   <xsl:when test="$categories[1] = .">
    <xsl:copy>
     <xsl:copy-of select="@*" />
     <xsl:apply-templates />
    </xsl:copy>
   </xsl:when>
   <xsl:otherwise>
    <xsl:comment> <xsl:value-of select="@xml:id"/> skipped </xsl:comment>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
<xsl:template match="node() | @*">
 <xsl:copy>
  <xsl:apply-templates select="node() | @*"/>
 </xsl:copy>
</xsl:template>
 
 
</xsl:stylesheet>