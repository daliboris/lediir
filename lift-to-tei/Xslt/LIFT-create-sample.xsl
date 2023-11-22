<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 6, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
            <xd:p>Extrakce několika heslových statí pro ukázku.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output indent="yes" />
    <xsl:strip-space elements="*"/>
    <xsl:param name="ratio" select="50" />
    
    <xsl:key name="related-entry" match="entry" use="@id" />
    <xsl:key name="subentry" match="entry" use="relation/@ref" />
    
<!--    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>-->
    
    
    <xd:doc>
        <xd:desc>
            <xd:p>Pouze každý 25. doklad bude exportován.</xd:p>
        </xd:desc>
    </xd:doc>
 <xsl:template match="entry[position() mod $ratio != 0]" />
 
<!-- <xsl:template match="entry[.//trait[@name='status']/normalize-space(@value)=('Confirmed', 'Proved Czech', 'Verified by reverse translation')][position() mod $ratio = 0]" priority="2">
  <xsl:copy-of select="." />
 </xsl:template>-->
 
 <!-- synonyma -->
 <xsl:template  match="entry[pronunciation[form/text = 'ebtedájí']]
  | entry[pronunciation[form/text = 'anfás']]
  | entry[pronunciation[form/text = ('otágh-e jek-nafare', 'otágh-e tak-tachte')]]
  | entry[pronunciation[form/text = ('entehá', 'páján')]]" priority="3">
  <xsl:copy-of select="." />
     <xsl:call-template name="copy-related-entries"/>
 </xsl:template>
 
 <!-- různé typy varianty -->
 <xsl:template match="entry[pronunciation[form/text = ('ebtekár (pl ebtekárát)', 'ebtekárát')]]
  | entry[pronunciation[form/text = ('esbát kardan', 'esbát namúdan')]]
  | entry[pronunciation[form/text = ('ámúchte (pl ámúchtegán)', 'ámúchtegán')]]" priority="3">
  <xsl:copy-of select="." />
     <xsl:call-template name="copy-related-entries"/>
 </xsl:template>
    
    <!-- illustration -->
    <xsl:template match="entry[pronunciation[form/text = ('áb-ambár')]]" priority="3">
        <xsl:copy-of select="." />
        <xsl:call-template name="copy-related-entries"/>
    </xsl:template>
    
    <xsl:template match="entry[pronunciation[form/text = ('abad')]]" priority="3">
        <xsl:copy-of select="." />
        <xsl:call-template name="copy-related-entries"/>
    </xsl:template>
    
    <xsl:template match="entry[sense/definition[contains(., 'elixír života')]]" priority="3">
        <xsl:copy-of select="." />
        <xsl:call-template name="copy-related-entries"/>
    </xsl:template>
    
    <xsl:template match="entry[sense/reversal[contains(., 'město')]]" priority="3">
        <xsl:copy-of select="." />
        <xsl:call-template name="copy-related-entries"/>
    </xsl:template>
    
    <xsl:template name="copy-related-entries">
        <xsl:for-each select="key('subentry', @id)">
            <xsl:copy-of select="."/>
        </xsl:for-each>
        <xsl:for-each select="relation">
            <xsl:copy-of select="key('related-entry', ./@ref)"/>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>