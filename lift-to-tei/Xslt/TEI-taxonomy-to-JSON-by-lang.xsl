<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:fn="http://www.w3.org/2005/xpath-functions" 
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs math xd tei" version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 9, 2022</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <!-- https://stackoverflow.com/questions/45739445/xml-to-json-transformation-in-xslt-3-0 -->
 
 <xsl:mode on-no-match="shallow-skip"/>
 
 <xsl:param name="taxonomy-id-prefix" select="'LeDIIR.taxonomy.'"/>
 <xsl:param name="lang" />
 
 
 <xsl:template match="/">
  
  <xsl:variable name="doc" select="."/>
  
   <xsl:variable name="json">
    <fn:map key="root">
     <fn:map key="dictionary">
      <fn:map key="pos">
       <xsl:apply-templates select="$doc/id(concat($taxonomy-id-prefix, 'grammar'))//tei:category" mode="to-json">
        <xsl:with-param name="lang" select="$lang" />
       </xsl:apply-templates>
      </fn:map>
      <fn:map key="meaningType">
       <xsl:apply-templates select="$doc/id(concat($taxonomy-id-prefix, 'meaningType'))//tei:category" mode="to-json">
        <xsl:with-param name="lang" select="$lang" />
       </xsl:apply-templates>
      </fn:map>
      <fn:map key="textType">
       <xsl:apply-templates select="$doc/id(concat($taxonomy-id-prefix, 'textType'))//tei:category" mode="to-json">
        <xsl:with-param name="lang" select="$lang" />
       </xsl:apply-templates>
      </fn:map>
      <fn:map key="variantType">
       <xsl:apply-templates select="$doc/id(concat($taxonomy-id-prefix, 'variantType'))//tei:category" mode="to-json">
        <xsl:with-param name="lang" select="$lang" />
       </xsl:apply-templates>
      </fn:map>
      <fn:map key="socioCultural">
       <xsl:apply-templates select="$doc/id(concat($taxonomy-id-prefix, 'socioCultural'))//tei:category" mode="to-json">
        <xsl:with-param name="lang" select="$lang" />
       </xsl:apply-templates>
      </fn:map>
      <fn:map key="complexFormType">
       <xsl:apply-templates select="$doc/id(concat($taxonomy-id-prefix, 'complexFormType'))//tei:category" mode="to-json">
        <xsl:with-param name="lang" select="$lang" />
       </xsl:apply-templates>
      </fn:map>
     </fn:map>
    </fn:map>
   </xsl:variable>
  <xsl:value-of select="xml-to-json($json, map { 'indent' : true() })"/> 
 </xsl:template>
 
 <xsl:template match="tei:category" mode="to-json">
   <xsl:param name="lang" as="xs:string" select="'en'" />
    <xsl:apply-templates select="tei:catDesc[@xml:lang = $lang]"  mode="#current" />
 </xsl:template>
 
 <xsl:template match="tei:catDesc"  mode="to-json">
  <xsl:variable name="idno" select="parent::tei:category/tei:catDesc[@xml:lang='en']/tei:idno"/>
  <xsl:variable name="temp" select="if(ends-with($idno, '.')) then substring($idno, 1, string-length($idno) - 1) else $idno"/>
  <xsl:variable name="key" select="translate($temp, ' ', '-')"/>

    <fn:map key="{$key}">
     <fn:string key="abbr"><xsl:value-of select="tei:idno"/></fn:string>
     <fn:string key="expand"><xsl:value-of select="tei:term"/></fn:string>
     <fn:string key="tooltip"><xsl:apply-templates select="tei:gloss" mode="#current"/></fn:string>     
    </fn:map>
   
 </xsl:template>
 
 <xsl:template match="tei:ref" mode="to-json">
  <xsl:value-of select="." />
  <xsl:value-of select="fn:concat('&lt;', @target, '&gt;')"/>
 </xsl:template>
 
 <!--
  "dictionary" : {
  "pos" : {
   "Abbreviation" : "zkratka"
   }
   }

 -->
 
</xsl:stylesheet>