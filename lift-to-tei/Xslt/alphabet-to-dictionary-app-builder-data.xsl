<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Nov 17, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p>Pomocná šablona, která generuje data o abecedě a jejím řazení,
    kterou vužívá konfigurační soubor pro Dictionary App Builder.</xd:p>
   <xd:p>Šablona pracuje se datovým souborem XML sestaveným pro tento projekt..</xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output indent="yes" method="xml" />
 <xsl:template match="/">
  <data>
   <xsl:apply-templates select="alphabet/letters" />
   <xsl:apply-templates select="alphabet/letters" mode="icu-sorting" />
  </data>
 </xsl:template>
 
 <xsl:template match="letters">
  <alphabet>
   <xsl:apply-templates select="letter" />
  </alphabet>
 </xsl:template>
 
 <xsl:template match="letter">
  <xsl:apply-templates  select="concat(@text, ' ')"/>
 </xsl:template>
 
 <xsl:template match="letters" mode="icu-sorting">
  <sorting type="ICU">
   <xsl:value-of select="'&#10;'"/>
   <xsl:apply-templates select="letter[variant]" mode="icu-sorting" />
  </sorting>
 </xsl:template>
 
 <xsl:template match="letter[variant]" mode="icu-sorting">
  <xsl:value-of select="concat('&amp;', @text, ' &lt; ', string-join(variant/@text, ' &lt; '), '&#10;')"/>
 </xsl:template>
</xsl:stylesheet>