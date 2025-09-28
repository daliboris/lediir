<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jan 17, 2025</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:param name="target-level" as="xs:string?" required="yes" />
 
 
 <xsl:template match="entry[field[@type='Frequency'][form/text = ('◧□□', '□□□')]]" /> <!-- entries with frequeny R and X -->
 <xsl:template match="entry[field[@type='Frequency'][form/text = ('■◧□', '■□□')]]"> <!-- entries with frequeny D, E -->
  <xsl:choose>
   <xsl:when test="$target-level = 'Basic'" />
   <xsl:when test="$target-level = 'Medium'" />
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template> 
 <xsl:template match="entry[field[@type='Frequency'][form/text = ('■■□')]]" > <!-- entries with frequeny C -->
  <xsl:choose>
   <xsl:when test="$target-level = 'Basic'" />
   <xsl:otherwise>
    <xsl:copy-of select="." />
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template> 
 <xsl:template match="entry[not(field[@type='Frequency'])]" />
</xsl:stylesheet>