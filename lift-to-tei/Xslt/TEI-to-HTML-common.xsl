<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" 
 xmlns:lediir="https://daliboris.cz/ns/lediir/xslt/1.0"
 exclude-result-prefixes="xs tei xd lediir" version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 9, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
            <xd:p />
        </xd:desc>
    </xd:doc>

    <xsl:template name="svg-styles">
        <style>
            .frequency-bar-1 {
                fill: #537614;
            }
            .frequency-bar-2 {
                fill: #789E35;
            }
            .frequency-bar-3 {
                fill: #A2C563;
            }
            .frequency-bar-4 {
                fill: #137177;
            }
            .frequency-text {
                font-family: Arial, sans-serif;
                font-size: 0.5em;
                font-weight: bold;
            }</style>
    </xsl:template>

 <xsl:template name="abbr-pos-to-text">
  <xsl:param name="abbr" as="xs:string" />
  <xsl:choose>
   <xsl:when test="$abbr = 'Abbreviation'"><xsl:text>zkratka</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Adjective'"><xsl:text>přídavné jméno</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Adverb'"><xsl:text>příslovce</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Connective'"><xsl:text>konektor</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Interjection'"><xsl:text>částice</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Noun'"><xsl:text>podstatné jméno</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Noun, plural'"><xsl:text>podstatné jméno, množné číslo</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Numeral'"><xsl:text>číslovka</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Particle'">částice<xsl:text></xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Prefix'">předpona<xsl:text></xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Preposition'"><xsl:text>předložka</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Pronoun'">zájmeno<xsl:text></xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Verb'"><xsl:text>sloveso</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Verb - passive'"><xsl:text>sloveso, pasivní tvar</xsl:text></xsl:when>
   <xsl:otherwise><xsl:value-of select="$abbr"/></xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:template name="abbr-pos-to-abbreviation">
  <xsl:param name="abbr" as="xs:string" />
  <xsl:choose>
   <xsl:when test="$abbr = 'Abbreviation'"><xsl:text>zkr.</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Adjective'"><xsl:text>příd. jm.</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Adverb'"><xsl:text>přísl.</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Connective'"><xsl:text>konektor</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Interjection'"><xsl:text>část.</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Noun'"><xsl:text>podst. jm.</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Noun, plural'"><xsl:text>podst. jm., mn. č.</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Numeral'"><xsl:text>čísl.</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Particle'">část.<xsl:text></xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Prefix'">předp.<xsl:text></xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Preposition'"><xsl:text>předl.</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Pronoun'">zájm.<xsl:text></xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Verb'"><xsl:text>slov.</xsl:text></xsl:when>
   <xsl:when test="$abbr = 'Verb - passive'"><xsl:text>slov., pas. tvar</xsl:text></xsl:when>
   <xsl:otherwise><xsl:value-of select="$abbr"/></xsl:otherwise>
  </xsl:choose>
 </xsl:template>
 
 <xsl:function name="lediir:get-text-direction">
  <xsl:param name="lang" as="xs:string" />
  <xsl:choose>
   <xsl:when test="$lang = ('cs-CZ', 'en')">
    <xsl:text>ltr</xsl:text>
   </xsl:when>
   <xsl:when test="$lang = ('fa')">
    <xsl:text>rtl</xsl:text>
   </xsl:when>
  </xsl:choose>
 </xsl:function>
 
 <xsl:template name="add-dir-attribute">
  <xsl:param name="lang" as="xs:string" />
  <xsl:variable name="direction" select="lediir:get-text-direction($lang)"/>
  <xsl:if test="$direction != ''">
   <xsl:attribute name="dir" select="$direction" />
  </xsl:if>
 </xsl:template>
</xsl:stylesheet>
