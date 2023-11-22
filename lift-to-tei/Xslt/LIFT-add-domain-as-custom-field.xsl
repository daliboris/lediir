<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Mar 29, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xsl:template match="trait[@name='semantic-domain-ddp4'][last()]">
  <xsl:copy-of select="." />
  <field type="Domain">
   <form lang="en">
    <text>
     <xsl:apply-templates select="parent::*/trait[@name='semantic-domain-ddp4']" mode="value">
      <xsl:sort select="./@value" />
     </xsl:apply-templates>
    </text>
   </form>
  </field>
  <xsl:apply-templates select="parent::*/trait[@name='semantic-domain-ddp4']" mode="reversal" />
 </xsl:template>
 
 <xsl:template match="trait[@name='semantic-domain-ddp4']" mode="value">
  <xsl:value-of select="@value"/>
  <xsl:if test="position() != last()">; </xsl:if>
 </xsl:template>
 
 <!--
           <reversal type="cs-CZ">
            <form lang="cs-CZ">
               <text>háj</text>
            </form>
         </reversal>
 -->
 <xsl:template match="trait[@name='semantic-domain-ddp4']" mode="reversal">
  <xsl:variable name="domain" select="replace(@value, '([\d\.]+)\s(.*)', '\2 (\1)')"/>
  <reversal type="dm">
   <form lang="dm">
    <text><xsl:value-of select="@value"/></text>
   </form>
  </reversal>
 </xsl:template>

</xsl:stylesheet>