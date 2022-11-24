<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" 
 exclude-result-prefixes="xs xd" version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 7, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
            <xd:p />
        </xd:desc>
    </xd:doc>
 
 
 <xsl:key name="entry-reference" match="entry" use="@id"/>
 <xsl:key name="sense-reference" match="sense" use="@id"/>
 

    <xsl:output method="xml" omit-xml-declaration="no" />
    <xsl:mode on-no-match="shallow-copy" />
 
 <xsl:template match="grammatical-info[@value='subst']">
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="value" select="'substantivum'" />
   <xsl:apply-templates />
  </xsl:copy>
 </xsl:template>
 
 <!-- Chyba: odkaz, který nikam nevede -->
 <xsl:template match="relation[@ref='']" />
 
 <!-- Chyba: odkaz, který nikam nevede; mohl vzniknou odstraněním heslové stati nebo významu obsahujícími chyby. -->
 <xsl:template match="relation[@ref!='']">
  <xsl:variable name="target" select="key('sense-reference', @ref) | key('entry-reference', @ref)"/>
  <xsl:if test="exists($target)">
   <xsl:copy-of select="." />
  </xsl:if>
 </xsl:template>
 
 
 </xsl:stylesheet>
