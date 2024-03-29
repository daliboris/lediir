<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  exclude-result-prefixes="xs math xd"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Oct 11, 2023</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:template match="form[let $l := @lang return following-sibling::form[@lang=$l]]">
    <xsl:variable name="lang" select="@lang"/>
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <text>
        <xsl:apply-templates select="text" mode="content" />
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="following-sibling::form[@lang = $lang]/text" mode="content" />        
      </text>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="form[let $l := @lang return preceding-sibling::form[@lang=$l]]" />
  
  <xsl:template match="form/text" mode="content">
    <xsl:apply-templates />
  </xsl:template>
  
</xsl:stylesheet>