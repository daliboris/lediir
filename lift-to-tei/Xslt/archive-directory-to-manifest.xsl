<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 xmlns:c="http://www.w3.org/ns/xproc-step"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 11, 2023</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output indent="yes" method="xml" />
 
 <xsl:param name="root" select="''" />
 
 <!--
 <c:archive>
  <c:entry name="a" href ="" comment="?" method = "?" level = "?" />
 </c:archive>
 -->
 
 <xsl:template match="/c:directory">
  <xsl:variable name="path" select="@xml:base"/>
  <xsl:variable name="dir-name" select="@name"/>
  <c:archive xmlns:c="http://www.w3.org/ns/xproc-step">
   <xsl:for-each select="c:directory">
    <xsl:apply-templates select="." mode="process-directory">
     <xsl:with-param name="parent-base" select="$path" />
    </xsl:apply-templates>
   </xsl:for-each>
   <xsl:for-each select="c:file">
    <c:entry name="{concat($root, $dir-name, '/', @name)}" href="{concat($path, @name)}" />
   </xsl:for-each>
  </c:archive>
 </xsl:template>
 
 <xsl:template match="c:directory" mode="process-directory">
  <xsl:param name="parent-base" />
  <xsl:variable name="base" select="@xml:base"/>
  <xsl:variable name="full-base" select="concat($parent-base, $base)"/>
  <xsl:for-each select="c:directory">
   <xsl:apply-templates select="." mode="process-directory">
    <xsl:with-param name="parent-base" select="@xml:base" />
   </xsl:apply-templates>
  </xsl:for-each>
  <xsl:for-each select="c:file">
   <c:entry name="{concat($root, $base, @name)}" href="{concat($full-base, @name)}" />
  </xsl:for-each>
 </xsl:template>
 
</xsl:stylesheet>