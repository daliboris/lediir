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
      <xd:p><xd:b>Created on:</xd:b> Nov 21, 2023</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p>Odstraní heslové stati, které nemají význam a zároveň se na ně neodkazuje.</xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:key name="related-entry" match="tei:entry" use="concat('#', @corresp)" />
  <xsl:key name="related-entry" match="tei:entry" use="concat('#', @ana)" />
  
  <xsl:template match="tei:entry[not(tei:sense)][not(@copyOf)]">
    <xsl:if test="key('related-entry', @xml:id)">
      <xsl:copy-of select="." />
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>