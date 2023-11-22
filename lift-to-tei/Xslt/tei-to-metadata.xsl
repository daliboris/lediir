<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:xml="http://www.w3.org/XML/1998/namespace"
  exclude-result-prefixes="xs math xd"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Nov 16, 2023</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:template match="tei:TEI">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="id" select="concat(@xml:id, '-metadata')" namespace="http://www.w3.org/XML/1998/namespace"/>
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="tei:encodingDesc" />
  <xsl:template match="tei:profileDesc" />
  <xsl:template match="tei:body">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="n" select="count(tei:div/tei:entry)" />
      <xsl:apply-templates />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="tei:div[tei:entry]">
    <xsl:copy>
      <xsl:copy-of select="@*" />
      <xsl:attribute name="subtype" select="@n" />
      <xsl:attribute name="n" select="count(tei:entry)" />
      <xsl:copy-of select="tei:head" />
    </xsl:copy>
   
  </xsl:template>
  
  <xsl:template match="tei:front" />
  <xsl:template match="tei:entry" />
  <xsl:template match="tei:back" />
  
</xsl:stylesheet>