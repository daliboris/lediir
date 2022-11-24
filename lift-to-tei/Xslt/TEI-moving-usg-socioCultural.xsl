<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
 xmlns:map="http://www.w3.org/2005/xpath-functions/map"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei map" version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Oct 20, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="tei:sense[tei:def][tei:usg[@type='socioCultural']]" priority="2">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:copy-of select="tei:def[1]/preceding-sibling::*" />
   <xsl:copy-of select="tei:usg[@type='socioCultural']" />
   <xsl:copy-of select="tei:def[1]" />
   <xsl:copy-of select="tei:def[1]/following-sibling::* except tei:usg[@type='socioCultural']" />
  </xsl:copy>
 </xsl:template>
 
</xsl:stylesheet>