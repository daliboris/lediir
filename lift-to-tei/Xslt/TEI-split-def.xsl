<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:tei="http://www.tei-c.org/ns/1.0"  
  xmlns:ldf="https://www.daliboris.cz/ns/lediir/xslt"
  xmlns:ed = "httpd://www.daliboris.cz/ns/edition-functions"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="xs math xd tei ed ldf"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Apr 20, 2024</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:import href="edition-functions-expand.xsl"/>
  
  <xsl:output method="xml" indent="yes" />
  <xsl:mode on-no-match="shallow-copy" />
  
  <xsl:template match="tei:def/text()">
    <xsl:analyze-string select="." regex=";">
      <xsl:matching-substring>
        <metamark function="equivalentDelimiter"><xsl:value-of select="."/></metamark>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <seg type="equivalent">
          <xsl:call-template name="separate-def-glosses">
            <xsl:with-param name="text" select="normalize-space(.)" />
          </xsl:call-template>
        </seg>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>
  
  <xsl:template name="separate-def-glosses">
    <xsl:param name="text" as="xs:string" />
    <xsl:analyze-string select="$text" regex="\(([^()]+)\)">
      <xsl:matching-substring>
        <gloss><xsl:value-of select="."/></gloss>
      </xsl:matching-substring>
      <xsl:non-matching-substring>
        <xsl:value-of select="."/>
      </xsl:non-matching-substring>
    </xsl:analyze-string>
  </xsl:template>
  
  <xsl:function name="ldf:expand-short-form">
    <xsl:param name="text" as="xs:string" />
    <xsl:param name="previous" as="xs:string" />
    
    <xsl:variable name="segments" select="analyze-string($text, '\(([^()]+)\)')"/>
    
  </xsl:function>
  
</xsl:stylesheet>