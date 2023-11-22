<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
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
  
  <xsl:key name="variant" match="entry" use="relation[trait[@name='variant-type']]/@ref" />
  
  <xsl:template match="entry/pronunciation">
    <xsl:variable name="id" select="../@id"/>
    <xsl:copy-of select="." />
    <xsl:variable name="variant" select="key('variant', $id)"/>
    <xsl:for-each select="$variant">
      <xsl:variable name="var" select="."/>
      <xsl:variable name="type" select="./relation[@ref = $id]/trait[@name='variant-type']/@value"/>
      <relation type="varianta" ref="{$var/@id}" />
      <field type="varianta-typ">
        <form lang="cs-CZ"><text><xsl:value-of select="$type"/></text></form>
      </field>
    </xsl:for-each>
<!--
    <xsl:if test="$variant">
      <xsl:copy-of select="$variant/citation"/>
    </xsl:if>
-->
  </xsl:template>
  
</xsl:stylesheet>