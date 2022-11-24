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
   <xd:p><xd:b>Created on:</xd:b> Nov 4, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:form[@type='variant'][@subtype][@ana]">
  <tei:lbl xml:lang="en" type="variant">
   <xsl:copy-of select="@ana" />
   <xsl:value-of select="id(substring-after(@ana, '#'))//tei:catDesc[@xml:lang='en']/tei:idno/data()"/>
  </tei:lbl>
  <xsl:copy-of select="." />
 </xsl:template>
</xsl:stylesheet>