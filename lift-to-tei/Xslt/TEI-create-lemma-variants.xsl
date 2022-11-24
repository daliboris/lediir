<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs math xd tei"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Jan 21, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p>Generuje variantní podoby heslového slova, které obsahuje prázdnou mezeru.</xd:p>
   <xd:p>Vygenerované podoby se využijí při indexování a prohledávání.</xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:form/tei:orth[@xml:lang='fa'][contains(., '&#x200c;')]">
  <xsl:copy-of select="." />
  <tei:orth type="generated" subtype="space" xml:lang="fa"><xsl:value-of select="replace(., '&#x200c;', '')"/></tei:orth>
  <tei:orth type="generated" subtype="space" xml:lang="fa"><xsl:value-of select="replace(., '&#x200c;', ' ')"/></tei:orth>
 </xsl:template>
 
</xsl:stylesheet>