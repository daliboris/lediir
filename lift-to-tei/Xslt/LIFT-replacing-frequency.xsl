<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:map="http://www.w3.org/2005/xpath-functions/map"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs math xd"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Oct 6, 2023</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:variable name="values" select="map {
    'TA' : '■■■', 'TB' : '■■◧', 'TC' : '■■□' , 'TD' : '■◧□', 'TE' : '■□□', 'TR' : '◧□□' , 'TX' : '□□□' ,
    'MA' : '■■■', 'MB' : '■■◧', 'MC' : '■■□' , 'MD' : '■◧□', 'ME' : '■□□', 'MR' : '◧□□' , 'MX' : '□□□'   
    }"/>
  
  <xsl:template match="field[@type='Frekvency']" />
  
  <xsl:template match="field[@type='Frekvency'][tokenize(.)[substring(., 1, 1) = ('T', 'M')]]" priority="2">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="type" select="'Frequency'" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="field[@type='Frekvency']/form">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="lang" select="'fq'" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="field[@type='Frekvency']/form/text">
    <xsl:variable name="items" select="tokenize(.)[substring(., 1, 1) = ('T', 'M')]"/>
    <xsl:copy>
      <xsl:value-of select="for $item in $items return if (map:contains($values, $item)) then map:get($values, $item) else ()"/>  
    </xsl:copy>
    
  </xsl:template>
  
</xsl:stylesheet>