<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:math="http://www.w3.org/2005/xpath-functions/math" 
 xmlns:map="http://www.w3.org/2005/xpath-functions/map"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xml="http://www.w3.org/XML/1998/namespace"
 exclude-result-prefixes="xs math xd tei map" version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Sep 10, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p/>
  </xd:desc>
 </xd:doc>
 <xsl:output method="xml" indent="yes"/>
 <xsl:mode on-no-match="shallow-copy"/>
 <xsl:variable name="taxonomy-id" select="'LeDIIR.taxonomy'"/>
 <xsl:variable name="taxonomy-category" select="'.complexFormType.'"/>
 <xsl:variable name="sort" as="map(xs:string, xs:integer)">
  <xsl:map>
   <xsl:map-entry key="'kolokace'" select="1" />
   <xsl:map-entry key="'analytický-predikát'" select="2" />
   <xsl:map-entry key="'kompozitum'" select="3" />
   <xsl:map-entry key="'arabské-kompozitum'" select="4" />
   <xsl:map-entry key="'derivace'" select="5" />
   <xsl:map-entry key="'idiom'" select="6" />
   <xsl:map-entry key="'rčení-a-přísloví'" select="7" />
   <xsl:map-entry key="'nespecifikovaný-komplexní-tvar'" select="8" />
  </xsl:map>
 </xsl:variable>
 <xsl:key name="complex-entry" match="tei:xr[@type = 'related'][tei:lbl[@subtype = 'complex-forms']]/tei:ref" use="@target" />
 <xsl:key name="related-sense" match="tei:xr[@type = 'related'][tei:lbl[@subtype = 'complex-forms']]/tei:ref" use="@target" />

 <xsl:template match="tei:entry">
  <xsl:variable name="entry-id" select="@xml:id"/>
  <xsl:copy>
   <xsl:copy-of select="@*"/>
   <xsl:apply-templates/>
   <xsl:variable name="complex-entry" select="key('complex-entry', concat('#', $entry-id))"/>
   <xsl:if test="$complex-entry">
    <xsl:for-each select="$complex-entry">
     <xsl:sort select="map:get($sort, ./@subtype)"/>
     <xsl:sort select="let $entry := ./ancestor::tei:entry return let $frequency := $entry/tei:usg[@type='frequency']/@value/tokenize(., '-')[1] ! substring(., 2) return if(empty($frequency) or $frequency = '') then concat('Z-', $entry/@sortKey) else concat($frequency, '-', $entry/@sortKey)"/>
     <xsl:variable name="ref" select="."/>
     <xsl:variable name="entry" select="$ref/ancestor::tei:entry"/>
<!--     <xsl:variable name="frequency-letter" select="$entry/tei:usg[@type='frequency']/@value/tokenize(., '-')[1] ! substring(., 2)"/>
     <xsl:variable name="frequency" select="if(empty($frequency-letter) or $frequency-letter = '') then 'Z-' else $frequency-letter || '-'"/>-->
     <xsl:variable name="xml-id" select="concat($entry/@xml:id, '.CF.', $ref/@subtype, '.', $entry-id, if($entry/@xml:id='FACS.6043db8e-cc64-4e9f-bfb3-c7a94f6f3544') then concat('.', position()) else '')"/>
     <tei:entry type="complexForm" ana="{concat('#', $taxonomy-id, $taxonomy-category, $ref/@subtype)}" copyOf="{concat('#', $entry/@xml:id )}" xml:id="{$xml-id}">
      <xsl:copy-of select="$entry/@xml:lang"/>
      <xsl:copy-of select="$entry/@sortKey" />
<!--      <xsl:attribute name="sortKey" select="concat($frequency, $entry/@sortKey)" />-->
      <xsl:copy-of select="$entry/tei:form[@type = 'lemma'][1]"/>
      <xsl:copy-of select="$entry/tei:usg[@type='frequency']"/>
      <xsl:apply-templates select="$entry/tei:sense[1]" mode="complex-entry" >
       <xsl:with-param name="entry-xml-id" select="$xml-id"></xsl:with-param>
      </xsl:apply-templates>
      <!--<xsl:copy-of select="$entry/tei:sense[1]/tei:def/self::* | preceding-sibling::*"/>-->
     </tei:entry>
    </xsl:for-each>
     
   </xsl:if>
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:sense" mode="complex-entry">
  <xsl:param name="entry-xml-id" as="xs:string" />
  <xsl:copy>
   <xsl:copy-of select="@*" />
   <xsl:attribute name="id" namespace="http://www.w3.org/XML/1998/namespace" select="concat($entry-xml-id, '.', @xml:id)" />
   <xsl:attribute name="copyOf" select="concat('#', @xml:id)" />
   <xsl:apply-templates select="tei:def[1]/preceding-sibling::* | tei:def[1]" />
  </xsl:copy>
 </xsl:template>
 
 <xsl:template match="tei:sense">
  <xsl:variable name="sense-id" select="@xml:id"/>
  <xsl:variable name="complex-entry" select="key('related-sense', $sense-id)"/>

  <xsl:copy>
     <xsl:copy-of select="@*"/>
     <xsl:apply-templates/>
     
     <xsl:if test="$complex-entry">
      <xsl:for-each select="$complex-entry">
       <xsl:sort select="map:get($sort, ./@subtype)"/>
       <xsl:variable name="ref" select="."/>
       <xsl:variable name="entry" select="$ref/ancestor::tei:entry"/>
       <tei:entry type="complexForm" ana="{concat('#', $taxonomy-id, $taxonomy-category, substring-after($ref/@subtype, '#'))}" copyOf="{concat('#', $entry/@xml:id )}" xml:id="{concat($entry/@xml:id, '.CF.', $sense-id)}">
        <xsl:copy-of select="$entry/@xml:lang"/>
        <xsl:copy-of select="$entry/@sortKey"/>
        <xsl:copy-of select="$entry/tei:form[@type = 'lemma'][1]"/>
       </tei:entry>
      </xsl:for-each>
     </xsl:if>

    </xsl:copy>
 </xsl:template>
 
 <!--<xsl:for-each-group select="*" group-by="$complex-entry/@subtype">
     <xsl:sort select="map:get($sort, current-grouping-key())"/>
     <tei:lbl type="cross-rerefence" subtype="{current-grouping-key()}" xml:lang="cs-CZ"><xsl:value-of select="current-grouping-key()"/></tei:lbl>
     <xsl:for-each select="current-group()">
      <xsl:variable name="ref" select="."/>
      <xsl:variable name="entry" select="$ref/ancestor::tei:entry"/>
      <tei:entry type="complexForm" subtype="{current-grouping-key()}" copyOf="{concat('#', $entry/@xml:id )}" xml:id="{concat($entry/@xml:id, '.CF.', $entry-id)}">
       <xsl:copy-of select="$entry/@xml:lang"/>
       <xsl:copy-of select="$entry/@sortKey"/>
       <xsl:copy-of select="$entry/tei:form[@type = 'lemma'][1]"/>
      </tei:entry>      
     </xsl:for-each>
    </xsl:for-each-group>-->

</xsl:stylesheet>
