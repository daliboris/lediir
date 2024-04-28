<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:math="http://www.w3.org/2005/xpath-functions/math"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
  xmlns:fn="http://www.w3.org/2005/xpath-functions"
  xmlns:efx = "httpd://www.daliboris.cz/ns/xslt/edition-functions"
  xmlns:ed = "httpd://www.daliboris.cz/ns/edition-functions"
  xmlns:tei="http://www.tei-c.org/ns/1.0"  
  exclude-result-prefixes="xs math xd tei efx fn"
  version="3.0">
  <xd:doc scope="stylesheet">
    <xd:desc>
      <xd:p><xd:b>Created on:</xd:b> Apr 21, 2024</xd:p>
      <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
      <xd:p></xd:p>
    </xd:desc>
  </xd:doc>
  
  <xsl:variable name="parentheses-regex" select="'\(([^(\s)]+)\)'"/>
  <xsl:variable name="parentheses-with-sapce-regex" select="'\(([^()]+\s[^()]+)\)'"/>
  
    
  <xsl:function name="efx:get-variants" as="xs:string*">
    <xsl:param name="analysis" as="element(fn:analyze-string-result)" />
    <xsl:variable name="first-match" select="$analysis/fn:match[1]"/>
    
    <xsl:sequence select="(
      normalize-space(
      string-join(($first-match/preceding-sibling::*, $first-match/fn:group, $first-match/following-sibling::*), '')
      ),
      normalize-space(
      string-join(($analysis/* except $first-match), '')
      )
      )"/>
  </xsl:function>
  
  <xsl:function name="efx:expand" as="element(ed:expansions)">
     <xsl:param name="text" as="xs:string" />
    <xsl:variable name="analysis" select="analyze-string($text, $parentheses-regex)"/>
    <xsl:variable name="with-sapce-analysis" select="analyze-string($text, $parentheses-with-sapce-regex)"/>
    
    <xsl:variable name="result">
      <xsl:choose>
        <xsl:when test="count($with-sapce-analysis/*) ge 2">
          <xsl:variable name="texts" select="efx:get-variants($with-sapce-analysis)"/>
          <xsl:value-of select="for $item in $texts return efx:expand($item)"/>
        </xsl:when>
        <xsl:when test="count($analysis/*) = 1">
          <ed:expansion><xsl:value-of select="($analysis/*/fn:group | $analysis/fn:non-match) => normalize-space()"/></ed:expansion>
        </xsl:when>
        <xsl:when test="count($analysis/fn:match) = 1">
          <ed:expansion>
            <xsl:value-of select="(string-join(
              ($analysis/*/fn:group | $analysis/fn:non-match), '')
              )  => normalize-space()"/>
          </ed:expansion>
          <ed:expansion>
            <xsl:value-of select="(string-join(($analysis/fn:non-match), ''))  => normalize-space()"/>
            </ed:expansion>
        </xsl:when>
        <xsl:when test="count($analysis/*) = 2">
          <ed:expansion>
            <xsl:value-of select="(string-join(($analysis/*/fn:group | $analysis/fn:non-match), ''))  => normalize-space()"/>
           </ed:expansion>
          <ed:expansion><xsl:value-of select="$analysis/fn:non-match/normalize-space()"/></ed:expansion>
          )
        </xsl:when>
        <xsl:otherwise>
          <xsl:variable name="texts" select="efx:get-variants($analysis)"/>
          <xsl:value-of select="for $item in $texts return efx:expand($item)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <ed:expansions source="{$text}"><xsl:sequence select="$result"/></ed:expansions>
    
  </xsl:function>
  
</xsl:stylesheet>