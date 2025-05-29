<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Feb 20, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:param name="replacement" select="'_'" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="entry/lexical-unit" priority="2" />
 
  <xsl:template match="entry/citation/form/text[contains(normalize-space(), ' ')]">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:value-of select="replace(., ' ', $replacement)"/>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="example/form[@lang='fa']/text" use-when="false()">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:value-of select="replace(., ' ', $replacement)"/>
  </xsl:copy>
 </xsl:template>
 
 
</xsl:stylesheet>