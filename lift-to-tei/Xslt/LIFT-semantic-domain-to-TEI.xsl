<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs math xd tei" version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Sep 7, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p/>
  </xd:desc>
 </xd:doc>

 <xsl:output method="xml" indent="yes" omit-xml-declaration="no"/>

 <xsl:mode on-no-match="shallow-skip"/>

 <xsl:key name="child-category" match="range[@id=('semantic-domain-ddp4', 'grammatical-info', 'sense-type', 'sociolinguistics')]/range-element" use="@parent"/>

 <xsl:variable name="taxonomy-id" select="'LeDIIR.taxonomy'"/>

 <xsl:template match="/">
  <tei:TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0">
   <tei:teiHeader>
    <tei:fileDesc>
     <tei:titleStmt>
      <tei:title/>
     </tei:titleStmt>
     <tei:publicationStmt>
      <tei:p/>
     </tei:publicationStmt>
     <tei:sourceDesc>
      <tei:bibl/>
     </tei:sourceDesc>
    </tei:fileDesc>
    <tei:encodingDesc>
     <tei:projectDesc>
      <tei:p>Data vznikla v rámci projektu podpořeného TA ČR.</tei:p>
     </tei:projectDesc>
     <tei:classDecl>
      <xsl:apply-templates select="/lift-ranges/range[@id = 'semantic-domain-ddp4']"/>
      <xsl:apply-templates select="/lift-ranges/range[@id = 'grammatical-info']"/>
      <xsl:apply-templates select="/lift-ranges/range[@id = 'sense-type']"/>
      <xsl:apply-templates select="/lift-ranges/range[@id = 'usage-type']"/>
      <xsl:apply-templates select="/lift-ranges/range[@id = 'variant-type']"/>
      <xsl:apply-templates select="/lift-ranges/range[@id = 'sociolinguistics']"/>
      <xsl:call-template name="sociolinguistics" />
      <xsl:call-template name="complexFormType" />
     </tei:classDecl>
    </tei:encodingDesc>
   </tei:teiHeader>
   <tei:text>
    <tei:body>
     <tei:div/>
    </tei:body>
   </tei:text>
  </tei:TEI>
 </xsl:template>

 <xsl:template match="range[@id = 'semantic-domain-ddp4']">
  <tei:taxonomy xml:id="{$taxonomy-id}">
   <tei:bibl>Taxonomie Lexikální databáze indoevropských jazyků.</tei:bibl>
   <xsl:apply-templates select="range-element[not(@parent)][label and abbrev]"/>
  </tei:taxonomy>
 </xsl:template>

 <xsl:template match="range-element[label and abbrev]">
  <xsl:variable name="lbl" select="translate(normalize-space(abbrev/form[@lang = 'en']), ' ', '-')"/>
  <!--<xsl:variable name="category-id" select="concat($taxonomy-id, '.', $lbl, if(ends-with($lbl, '.')) then '' else '.', @guid)"/>--> <!-- , if(ends-with($lbl, '.')) then '' else '.', @guid -->
  <xsl:variable name="category-id" select="concat($taxonomy-id, '.', if(ends-with($lbl, '.')) then substring($lbl, 1, string-length($lbl) - 1) else $lbl)"/>
  <tei:category xml:id="{$category-id}" n="{@guid}">
   <tei:catDesc xml:lang="en">
    <tei:idno>
     <xsl:apply-templates select="abbrev/form[@lang = 'en']"/>
    </tei:idno>
    <xsl:text> </xsl:text>
    <tei:term>
     <xsl:apply-templates select="label/form[@lang = 'en']"/>
    </tei:term>
    <tei:gloss><xsl:apply-templates select="description/form[@lang = 'en']" /></tei:gloss>
   </tei:catDesc>
   <xsl:if test="abbrev/form[@lang = 'cs-CZ']">
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>
      <xsl:apply-templates select="abbrev/form[@lang = 'cs-CZ']"/>
     </tei:idno>
     <xsl:text> </xsl:text>
     <tei:term>
      <xsl:apply-templates select="label/form[@lang = 'cs-CZ']"/>
     </tei:term>
     <tei:gloss><xsl:apply-templates select="description/form[@lang = 'cs-CZ']" /></tei:gloss>
    </tei:catDesc>
   </xsl:if>
   <xsl:if test="abbrev/form[@lang = 'fa']">
   <tei:catDesc xml:lang="fa">
    <tei:idno>
     <xsl:apply-templates select="abbrev/form[@lang = 'fa']"/>
    </tei:idno>
    <xsl:text> </xsl:text>
    <tei:term>
     <xsl:apply-templates select="label/form[@lang = 'fa']"/>
    </tei:term>
    <tei:gloss><xsl:apply-templates select="description/form[@lang = 'fa']" /></tei:gloss>
   </tei:catDesc>
   </xsl:if>
   <xsl:if test="key('child-category', @id)[label and abbrev]">
    <xsl:apply-templates select="key('child-category', @id)[label and abbrev]"/>
   </xsl:if>
  </tei:category>
 </xsl:template>


 <xsl:template match="form/text/text()">
  <xsl:value-of select="."/>
 </xsl:template>
 
 <xsl:template match="span[@href and @class = 'Hyperlink']">
  <tei:ref target="{@href}" type="external">
   <xsl:apply-templates/>
  </tei:ref>
 </xsl:template>
 
 <xsl:template match="span[@href and @class = 'Hyperlink']/text()">
  <xsl:value-of select="."/>
 </xsl:template>
 

 <xsl:template match="range[@id = 'grammatical-info']">
  <tei:taxonomy xml:id="{$taxonomy-id}.grammar">
   <tei:bibl>Slovní druhy (Lexikální databáze indoevropských jazyků).</tei:bibl>
   <xsl:apply-templates select="range-element[not(@parent)][label and abbrev]"/>
  </tei:taxonomy>
 </xsl:template>

 <xsl:template match="range[@id = 'sense-type']">
  <tei:taxonomy xml:id="{$taxonomy-id}.meaningType">
   <tei:bibl>Stylové poznámky (Lexikální databáze indoevropských jazyků).</tei:bibl>
   <xsl:apply-templates select="range-element[not(@parent)][label and abbrev]"/>
  </tei:taxonomy>
 </xsl:template>
 
 <xsl:template match="range[@id = 'usage-type']">
  <tei:taxonomy xml:id="{$taxonomy-id}.textType">
   <tei:bibl>Stylistické kvalifikátory (Lexikální databáze indoevropských jazyků).</tei:bibl>
   <xsl:apply-templates select="range-element[label and abbrev]"/>
  </tei:taxonomy>
 </xsl:template>
 
 <xsl:template match="range[@id = 'variant-type']">
  <tei:taxonomy xml:id="{$taxonomy-id}.variantType">
   <tei:bibl>Varianty lexémů (Lexikální databáze indoevropských jazyků).</tei:bibl>
   <xsl:apply-templates select="range-element[label and abbrev]"/>
  </tei:taxonomy>
 </xsl:template>

 <xsl:template name="sociolinguistics"><!-- match="range[@id = 'sociolinguistics']" -->
  <tei:taxonomy xml:id="{$taxonomy-id}.socioCultural">
   <tei:bibl>Stylové poznámky (Lexikální databáze indoevropských jazyků).</tei:bibl>
   <!-- jde o typ poznámky k významu s libovolnou hodnotou, nejde o seznam hodnot -->
   <!--<xsl:apply-templates select="range-element[not(@parent)][label and abbrev]"/>-->
   <tei:category xml:id="{$taxonomy-id}.socioCultural.form"
    n="696ff9d2-d28e-40ee-8ae0-449682180f20">
    <tei:catDesc xml:lang="en">
     <tei:idno>form</tei:idno>
     <tei:term>formal</tei:term>
     <tei:gloss/>
    </tei:catDesc>
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>kniž.</tei:idno>
     <tei:term>knižní, knižně</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
   <tei:category xml:id="{$taxonomy-id}.socioCultural.coll"
    n="b11457ab-226b-43b3-8c81-dae9f6dc75dd">
    <tei:catDesc xml:lang="en">
     <tei:idno>hov.</tei:idno>
     <tei:term>hovorový, hovorově</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
  </tei:taxonomy>
 </xsl:template>

 <xsl:template name="complexFormType">
  <tei:taxonomy xml:id="{$taxonomy-id}.complexFormType">
   <tei:bibl>Komplexní formy (Lexikální databáze indoevropských jazyků).</tei:bibl>
   <!-- jde o typ poznámky k významu s libovolnou hodnotou, nejde o seznam hodnot -->
   <tei:category xml:id="{$taxonomy-id}.complexFormType.analytický-predikát">
    <tei:catDesc xml:lang="en">
     <tei:idno>analytický predikát</tei:idno>
     <tei:term>analytický predikát</tei:term>
     <tei:gloss/>
    </tei:catDesc>
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>analytický predikát</tei:idno>
     <tei:term>analytický predikát</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
   <tei:category xml:id="{$taxonomy-id}.complexFormType.arabské-kompozitum">
    <tei:catDesc xml:lang="en">
     <tei:idno>arabské kompozitum</tei:idno>
     <tei:term>arabské kompozitum</tei:term>
     <tei:gloss/>
    </tei:catDesc>
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>arabské kompozitumt</tei:idno>
     <tei:term>arabské kompozitum</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
   <tei:category xml:id="{$taxonomy-id}.complexFormType.derivace">
    <tei:catDesc xml:lang="en">
     <tei:idno>derivace</tei:idno>
     <tei:term>derivace</tei:term>
     <tei:gloss/>
    </tei:catDesc>
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>derivace</tei:idno>
     <tei:term>derivace</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
   <tei:category xml:id="{$taxonomy-id}.complexFormType.idiom">
    <tei:catDesc xml:lang="en">
     <tei:idno>idiom</tei:idno>
     <tei:term>idiom</tei:term>
     <tei:gloss/>
    </tei:catDesc>
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>idiom</tei:idno>
     <tei:term>idiom</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
   <tei:category xml:id="{$taxonomy-id}.complexFormType.kolokace">
    <tei:catDesc xml:lang="en">
     <tei:idno>kolokace</tei:idno>
     <tei:term>kolokace</tei:term>
     <tei:gloss/>
    </tei:catDesc>
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>kolokace</tei:idno>
     <tei:term>kolokace</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
   <tei:category xml:id="{$taxonomy-id}.complexFormType.kompozitum">
    <tei:catDesc xml:lang="en">
     <tei:idno>kompozitum</tei:idno>
     <tei:term>kompozitum</tei:term>
     <tei:gloss/>
    </tei:catDesc>
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>kompozitum</tei:idno>
     <tei:term>kompozitum</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
   <tei:category xml:id="{$taxonomy-id}.complexFormType.nespecifikovaný-komplexní-tvar">
    <tei:catDesc xml:lang="en">
     <tei:idno>nespecifikovaný komplexní tvar</tei:idno>
     <tei:term>nespecifikovaný komplexní tvar</tei:term>
     <tei:gloss/>
    </tei:catDesc>
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>nespecifikovaný komplexní tvar</tei:idno>
     <tei:term>nespecifikovaný komplexní tvar</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
   <tei:category xml:id="{$taxonomy-id}.complexFormType.rčení-a-přísloví">
    <tei:catDesc xml:lang="en">
     <tei:idno>rčení a přísloví</tei:idno>
     <tei:term>rčení a přísloví</tei:term>
     <tei:gloss/>
    </tei:catDesc>
    <tei:catDesc xml:lang="cs-CZ">
     <tei:idno>rčení a přísloví</tei:idno>
     <tei:term>rčení a přísloví</tei:term>
     <tei:gloss/>
    </tei:catDesc>
   </tei:category>
  </tei:taxonomy>
 </xsl:template>

</xsl:stylesheet>
