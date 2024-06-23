<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" 
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xpath-default-namespace="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei" version="3.0">

 <xsl:import href="Dictionary-front.xsl"/>

 <xsl:output method="xml" indent="yes" />
 <xsl:mode on-no-match="shallow-copy"/>

 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Dec 1, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p/>
  </xd:desc>
 </xd:doc>

 <xsl:template match="TEI">
  <xsl:copy>
   <xsl:copy-of select="@*"/>
   <xsl:namespace name="tei" select="'http://www.tei-c.org/ns/1.0'" />
   <xsl:apply-templates select="teiHeader"/>
   <tei:text>
    <tei:body>
     <xsl:call-template name="front-content"/>
    </tei:body>
    <xsl:copy-of select="tei:text/tei:back" />
   </tei:text>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:titleStmt/tei:title">
  <tei:title>Elektronická lexikální databáze indoíránských jazyků</tei:title>
 </xsl:template>
 
 <xsl:template match="tei:titleStmt/tei:author"/>
 
 <xsl:template match="tei:titleStmt/tei:respStmt" />

 <xsl:template match="tei:profileDesc/tei:langUsage" />

</xsl:stylesheet>
