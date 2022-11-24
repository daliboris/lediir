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

    <xsl:output method="xml" omit-xml-declaration="no" />
    <xsl:mode on-no-match="shallow-copy" />

    <xsl:template match="span[@class = 'Hyperlink']">
        <xsl:copy>
            <xsl:copy-of select="@*" />
            <xsl:attribute name="href">
                <xsl:value-of select="replace(@href, '&#xD;|&#xA;', '')" />
            </xsl:attribute>
            <xsl:apply-templates />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="field[@type = 'Frekvency']/form/text">
        <xsl:copy>
            <xsl:copy-of select="@*" />
         <xsl:value-of select="normalize-space(replace(., '&#x200c;', ''))"/>
        </xsl:copy>
    </xsl:template>
 
 <xsl:template match="entry/citation/form/text | entry/lexical-unit/form/text">
   <xsl:copy>
    <xsl:copy-of select="@*" />
    <xsl:value-of select="normalize-space(replace(., '&#x200f;', ''))"/>
   </xsl:copy>
  </xsl:template>
 
 </xsl:stylesheet>
