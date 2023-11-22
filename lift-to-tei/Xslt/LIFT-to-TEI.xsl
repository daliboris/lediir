<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" 
 xmlns:lediir="https://daliboris.cz/ns/lediir/xslt/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0"
 exclude-result-prefixes="xs xd lediir" version="3.0">
 <xsl:import href="Dictionary-header.xsl"/>
 <!--<xsl:import href="Dictionary-front.xsl"/>-->
 <xsl:import href="LeDIIR-text-functions.xsl"/>
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Oct 6, 2020</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p/>
  </xd:desc>
 </xd:doc>

 <xsl:param name="lift-ranges-file" />
 <xsl:param name="dict-id" select="'FACS'"/>
 <xsl:variable name="taxonomy-id" select="'LeDIIR.taxonomy'"/>

 <xsl:output method="xml" indent="yes"/>
 <xsl:strip-space elements="*"/>
 <xsl:key name="entry-reference" match="entry" use="@id"/>
 <xsl:key name="sense-reference" match="sense" use="@id"/>
 <xsl:key name="relation-reference" match="relation" use="@ref" />
 <xsl:key name="variant-relation-reference" match="relation[trait[@name='variant-type']]" use="@ref" />
 <!--<xsl:key name="pos-reference" match="doc($lift-ranges-file)//range[@id=('grammatical-info')]/range-element" use="normalize-unicode(@id, 'NFC')" />-->
 <xsl:key name="pos-reference" match="doc($lift-ranges-file)//range[@id=('grammatical-info')]/range-element" use="concat('#',normalize-unicode(@id, 'NFC'))" />
 <xsl:key name="sense-type-reference" match="doc($lift-ranges-file)//range[@id=('sense-type')]/range-element" use="concat('#',normalize-unicode(@id, 'NFC'))" />
 <xsl:key name="usage-type-reference" match="doc($lift-ranges-file)//range[@id=('usage-type')]/range-element" use="concat('#',normalize-unicode(@id, 'NFC'))" />
 <xsl:key name="variant-type-reference" match="doc($lift-ranges-file)//range[@id=('variant-type')]/range-element" use="concat('#',normalize-unicode(@id, 'NFC'))" />
 


 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="/">
  <tei:TEI type="lex-0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xml:id="{$dict-id}" xml:lang="cs">
   <xsl:call-template name="dictionary-header">
    <xsl:with-param name="dict-id" select="$dict-id" />
   </xsl:call-template>
   <tei:text>
    <!--<xsl:call-template name="front" />-->
    <tei:body xml:lang="fa">
     <xsl:apply-templates select="lift/entry"/>
    </tei:body>
    <tei:back>
     <tei:div xml:id="bibliography">
      <tei:head>Bibliografie</tei:head>
      <!--<tei:listBibl>
       <xsl:apply-templates select="doc($lift-ranges-file)//range[@id='Bibliography']/range-element[*]/description[form[@lang='cs-CZ']]/form[@lang='cs-CZ']" mode="bibliography" >
        <xsl:sort select="../../range-element/@id" />
       </xsl:apply-templates> 
      </tei:listBibl>-->
      <tei:listBibl>
       <xsl:for-each select="doc($lift-ranges-file)//range[@id='Bibliography']/range-element[*]">
        <xsl:sort select="@id" lang="cs-CZ" />
        <xsl:apply-templates select="description[form[@lang='cs-CZ']]/form[@lang='cs-CZ']" mode="bibliography" />
       </xsl:for-each>
       
      </tei:listBibl>
     </tei:div>
    </tei:back>
   </tei:text>
  </tei:TEI>
 </xsl:template>

 <!-- &#x200c = ZERO WIDTH NON-JOINER -->
 <!-- &#x02c8; = MODIFIER LETTER VERTICAL LINE -->
 <!-- n="en.{translate(@id, ' &#x200c;&#x02c8;&#x5f;&#xa0;&#x200e;&#x61b;&#x61f;&#x60c;&#x21;&#x200d;&#x202c;', '_') -->
 <!-- sortKey="{translate(substring-before(@id, '_'), ' ', '_')}"  -->
 
 <xd:doc>
  <xd:desc> ZERO WIDTH NON-JOINER; ZERO WIDTH JOINER </xd:desc>
 </xd:doc>
 <xsl:template match="entry">
  <tei:entry xml:lang="{lexical-unit[1]/form[1]/@lang}" type="mainEntry" xml:id="{$dict-id}.{@guid}" sortKey="{lediir:get-sort-key-for-entry(.)}">
   <xsl:attribute name="xml:lang" select="lexical-unit[1]/form[1]/@lang"/>
   <xsl:apply-templates select="citation" mode="form"/>
   <xsl:if test="not(citation)">
    <xsl:apply-templates select="lexical-unit" mode="form"/>
   </xsl:if>
   <xsl:variable name="related-entries" select="key('variant-relation-reference', @id)"/>
  <xsl:if test="$related-entries">
   <xsl:apply-templates select="$related-entries/parent::entry/citation" mode="referred" />
  </xsl:if>


   <!--<xsl:apply-templates select="variant" mode="form"/>-->

   <xsl:apply-templates/>
   <xsl:call-template name="group-related-items"/>
  </tei:entry>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="sense">
  <xsl:variable name="entry-id" select="lediir:get-entry-id(parent::entry/@id)"/>
  <xsl:variable name="sense-id" select="lediir:get-sense-id(@id)"/>
  <!--<xsl:variable name="sense-id" select="lediir:get-entry-id(parent::entry/@id)"/>-->
  <xsl:variable name="sense-item" select="count(preceding-sibling::sense) + 1"/>
  <xsl:variable name="sense-xml-id" select="concat($dict-id, '.', $entry-id, '.sense.', $sense-item)"/>
  <xsl:variable name="referenced-sense" select="key('relation-reference', @id)"/>
  <tei:sense xml:id="{$sense-xml-id}"> <!-- {$dict-id}.{$sense-id}.sense.{$sense-item} -->
   <xsl:if test="count(parent::entry/sense) gt 1">
    <xsl:attribute name="n">
     <xsl:number count="sense" from="entry" format="1."/>
    </xsl:attribute>
   </xsl:if>
   <xsl:apply-templates select="grammatical-info"/>
   <xsl:apply-templates select="note[@type = 'grammar']"/>
   <xsl:apply-templates select="trait[@name = 'sense-type']"/>
   <xsl:apply-templates select="trait[@name = 'usage-type']"/>
   <xsl:apply-templates select="definition"/>
   <xsl:call-template name="group-related-items-spec">
    <xsl:with-param name="type" select="('Synonyms')"/>
   </xsl:call-template>

   <xsl:apply-templates select="* except (note[@type = 'grammar'], trait[@name = 'sense-type'], trait[@name = 'usage-type'], relation[@type = 'Synonyms'], trait[@name = 'semantic-domain-ddp4'], definition, reversal, grammatical-info)"/>
   <xsl:call-template name="group-related-items">
    <xsl:with-param name="excluded-types" select="('Synonyms')"/>
   </xsl:call-template>
   <xsl:apply-templates select="trait[@name = 'semantic-domain-ddp4']"/>
   <xsl:if test="reversal">
    <tei:xr type="related" subtype="Reversals">
     <xsl:call-template name="create-relation-label">
      <xsl:with-param name="relation-type" select="'Reversals'"/>
     </xsl:call-template>
     <xsl:apply-templates select="reversal" mode="reversal">
      <xsl:sort select="./@type" /> <!-- i.e. en, cs-CZ, fa -->
     </xsl:apply-templates>
    </tei:xr>
   </xsl:if>
   <xsl:if test="$referenced-sense">
    <xsl:for-each-group select="$referenced-sense" group-by="@type">
     <tei:xr type="{lediir:get-relation-type-value(current-grouping-key())}" subtype="{current-grouping-key()}">
      <xsl:call-template name="create-relation-label">
       <xsl:with-param name="relation-type" select="current-grouping-key()"/>
      </xsl:call-template>
      <xsl:apply-templates select="current-group()" mode="grouping-for-sense"/>
     </tei:xr>
    </xsl:for-each-group>
   </xsl:if>
  </tei:sense>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
  <xd:param name="type"/>
 </xd:doc>
 <xsl:template name="group-related-items-spec">
  <xsl:param name="type" as="xs:string*"/>
  <xsl:for-each-group select="relation[@type = $type]" group-by="@type">
   <tei:xr type="{lediir:get-relation-type-value(current-grouping-key())}">
    <xsl:call-template name="create-relation-label">
     <xsl:with-param name="relation-type" select="current-grouping-key()"/>
    </xsl:call-template>
    <xsl:apply-templates select="current-group()" mode="grouping"/>
   </tei:xr>
  </xsl:for-each-group>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
  <xd:param name="excluded-types"/>
 </xd:doc>
 <xsl:template name="group-related-items">
  <xsl:param name="excluded-types" as="xs:string*"/>
  <xsl:for-each-group select="relation[@type][not(@type = $excluded-types)]" group-by="@type">
   <xsl:variable name="relation-type" select="lediir:get-relation-type-value(lediir:create-relation-type(current-grouping-key()))"/>
   <tei:xr type="{$relation-type}">
    <xsl:call-template name="create-relation-label">
     <xsl:with-param name="relation-type" select="current-grouping-key()"/>
    </xsl:call-template>
    <xsl:apply-templates select="current-group()" mode="grouping"/>
   </tei:xr>
  </xsl:for-each-group>
 </xsl:template>


 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
  <xd:param name="relation-type"/>
 </xd:doc>
 <xsl:template name="create-relation-label">
  <xsl:param name="relation-type" as="xs:string"/>
  <xsl:choose>
   <xsl:when test="$relation-type = 'Antonym'">
    <tei:lbl type="cross-rerefence" subtype="antonyms" xml:lang="cs-CZ">Antonyma:</tei:lbl>
   </xsl:when>
   <xsl:when test="$relation-type = 'Compare'">
    <tei:lbl type="cross-rerefence" subtype="related" xml:lang="cs-CZ">Srovnej:</tei:lbl>
   </xsl:when>
   <xsl:when test="$relation-type = 'Specific'">
    <tei:lbl type="cross-rerefence" subtype="specific"/>
   </xsl:when>
   <xsl:when test="$relation-type = 'Synonyms'">
    <tei:lbl type="cross-rerefence" subtype="synonyms" xml:lang="cs-CZ">Synonyma:</tei:lbl>
   </xsl:when>
   <xsl:when test="normalize-space($relation-type) = 'rodový protějšek'">
    <tei:lbl type="cross-rerefence" subtype="voice-counterparts" xml:lang="cs-CZ">Rodové protějšky:</tei:lbl>
   </xsl:when>
   <xsl:when test="normalize-space($relation-type) = 'Reversals'">
    <tei:lbl type="cross-rerefence" subtype="reversals" xml:lang="cs-CZ">Zpětné odkazy:</tei:lbl>
   </xsl:when>
   <xsl:when test="$relation-type = '_component-lexeme'">
    <tei:lbl type="cross-rerefence" subtype="complex-forms"/>
    <!--<tei:lbl type="cross-rerefence" subtype="complex-forms">Komplexní formy:</tei:lbl>-->
    <!-- jde odkaz na komponenty u koplexní formy -->
   </xsl:when>
  </xsl:choose>
 </xsl:template>


 <xd:doc>
  <xd:desc>
   <xd:p/>
  </xd:desc>
 </xd:doc>
 <xsl:template match="lexical-unit" mode="form">
  <tei:form type="lexical-unit">
   <tei:orth>
    <xsl:apply-templates />
   </tei:orth>
  </tei:form>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="pronunciation" mode="form">
  <tei:pron xml:lang="{form[1]/@lang}" notation="czech">
   <xsl:apply-templates/>
  </tei:pron>
 </xsl:template>
 
 <xsl:template name="lemma-variant">
  <xsl:param name="reffered-entry" as="element(entry)"/>
  
 </xsl:template>
 
 <!--
  V rámci jedné heslové stati odkazy na dva různé lexémy
  TODO: entry/@guid=849b4484-6dcd-4f00-b4d3-6501aebdc764
 -->
 <xsl:template match="citation" mode="referred">
  <xsl:variable name="trait-name" select="'variant-type'"/>
  <xsl:variable name="entry-id" select="lediir:get-entry-id(./parent::entry/@id)"/>
  <xsl:variable name="type" select="./parent::entry/relation/trait[@name=$trait-name]/normalize-unicode(@value, 'NFC')"/>
  
  <xsl:variable name="type-lbl" select="translate(normalize-space($type[1]), ' ', '-')"/>
  
  <xsl:variable name="items" select="doc($lift-ranges-file)//range[@id=($trait-name, 'grammatical-info')]/range-element"/>
  <xsl:variable name="value" select="normalize-unicode($type[1], 'NFC')"/>
  <xsl:variable name="item" select="$items[normalize-unicode(@id, 'NFC') = $value][1]"/>
  
  <xsl:variable name="range-element" select="key('variant-type-reference',  concat('#',$value))"/>
  
  <xsl:variable name="lbl" select="($item/abbrev/form[@lang = 'en'],$type)[1] => normalize-space() => translate(' ', '-')"/>
  <xsl:variable name="element-id" select="concat($taxonomy-id, '.', lediir:get-id-from-label($lbl))"/>
  
  
  <tei:form type="variant" subtype="{$lbl}" ana="{concat('#', $element-id)}" corresp="{concat('#', $dict-id, '.', $entry-id)}">
   <xsl:apply-templates mode="form"/>
   <!-- 
   <xsl:apply-templates select="./following-sibling::variant" mode="form"/>
   <xsl:apply-templates select="./parent::entry/pronunciation" mode="form"/>
    -->
  </tei:form>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="citation" mode="form">
  <tei:form type="lemma">
   <xsl:apply-templates mode="#current"/>
   <xsl:apply-templates select="following-sibling::variant" mode="#current"/>
   <xsl:apply-templates select="parent::entry/pronunciation" mode="#current"/>
  </tei:form>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="citation/form[@lang = 'fa']" mode="form">
  <tei:orth xml:lang="{@lang}">
   <xsl:apply-templates/>
  </tei:orth>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="citation/form[@lang = 'tg']" mode="form">
  <tei:orth xml:lang="{@lang}">
   <xsl:apply-templates/>
  </tei:orth>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="citation/form[@lang = 'cs-CZ']" mode="form">
  <tei:pron xml:lang="{@lang}">
   <xsl:apply-templates/>
  </tei:pron>
 </xsl:template>

 

 <xd:doc>
  <xd:desc> &lt;xsl:template match="citation" mode="form"&gt;
   &lt;tei:form type="lemma"&gt;
   &lt;xsl:apply-templates select="form[@lang = 'fa']" mode="#current" /&gt;
   &lt;xsl:apply-templates select="form[@lang != 'fa']" mode="#current" /&gt;
   &lt;/tei:form&gt;
   &lt;/xsl:template&gt;</xd:desc>
 </xd:doc>
 <xsl:template match="variant" mode="form">
  <tei:form type="variant" subtype="{trait/@value}">
   <xsl:apply-templates select="form[@lang = 'fa']" mode="#current"/>
  </tei:form>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="variant/form[@lang = 'fa']" mode="form">
  <tei:orth xml:lang="{@lang}">
   <xsl:apply-templates/>
  </tei:orth>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="lexical-unit | pronunciation | citation | variant"/>


 <xd:doc>
  <xd:desc>
   &lt;range-element id="příslovce" guid="46e4fe08-ffa0-4c8b-bf98-2c56f38904d9"&gt;
   &lt;label&gt;
   &lt;form lang="cs-CZ"&gt;&lt;text&gt;příslovce&lt;/text&gt;&lt;/form&gt;
   &lt;form lang="en"&gt;&lt;text&gt;Adverb&lt;/text&gt;&lt;/form&gt;
   &lt;form lang="fa"&gt;&lt;text&gt;قید&lt;/text&gt;&lt;/form&gt;
   &lt;/label&gt;
   &lt;abbrev&gt;
   &lt;form lang="cs-CZ"&gt;&lt;text&gt;přísl.&lt;/text&gt;&lt;/form&gt;
   &lt;form lang="en"&gt;&lt;text&gt;adv&lt;/text&gt;&lt;/form&gt;
   &lt;form lang="fa"&gt;&lt;text&gt;قید&lt;/text&gt;&lt;/form&gt;
   &lt;/abbrev&gt;
   &lt;description&gt;
   &lt;form lang="cs-CZ"&gt;&lt;text&gt;Adverbium (příslovce). Autosémantikum pojmenovávající „příznaky příznaků“, tj. okolnosti. (&lt;span href="https://www.czechency.org/slovnik/ADVERBIUM" class="Hyperlink"&gt;Karlík, P., Biskup, J. (2017)&lt;/span&gt;).  V perštině mohou být adverbia tvořena nejen pomocí přípon, ale mezi adverbia řadíme i adverbializované skupiny tvořené pomocí předložek, příslovečné spřežky (&lt;span href="https://www.czechency.org/slovnik/ADVERBIALIZACE" class="Hyperlink"&gt;Karlík, P. (2017)&lt;/span&gt;). O tomto typu adverbií v perštině viz n. &lt;span href="https://www.jahanshiri.ir/fa/en/adverb-formation" class="Hyperlink"&gt;Jahangiri, A. (2004-2022).&lt;/span&gt;&lt;/text&gt;&lt;/form&gt;
   &lt;form lang="en"&gt;&lt;text&gt;An adverb, narrowly defined, is a part of speech whose members modify verbs for such categories as time, manner, place, or direction. An adverb, broadly defined, is a part of speech whose members modify any constituent class of words other than nouns, such as verbs, adjectives, adverbs, phrases, clauses, or sentences. Under this definition, the possible type of modification depends on the class of the constituent being modified.&lt;/text&gt;&lt;/form&gt;
   &lt;/description&gt;
   &lt;trait name="catalog-source-id" value="Adverb"/&gt;
   &lt;/range-element&gt;
  </xd:desc>
 </xd:doc>
 <xsl:template match="grammatical-info">
  <xsl:variable name="trait-name" select="name(.)"/>
  <xsl:variable name="items" select="doc($lift-ranges-file)//range[@id=($trait-name)]/range-element"/>
  <xsl:variable name="value" select="normalize-unicode(@value, 'NFC')"/>
  <xsl:variable name="item" select="$items[normalize-unicode(@id, 'NFC') = $value][1]"/>
  
  <xsl:variable name="range-element" select="key('pos-reference',  concat('#',$value))"/>

  <xsl:variable name="lbl" select="$item/abbrev/form[@lang = 'en']"/>
  <xsl:variable name="element-id" select="concat($taxonomy-id, '.', $lbl (:, if(ends-with($lbl, '.')) then '' else '.' :))"/> <!-- , if(ends-with($lbl, '.')) then '' else '.', @guid -->
  <tei:gramGrp>
   <tei:gram type="pos" xml:lang="en">
    <!-- TODO @expanded -->
    <!--<xsl:value-of select="@value"/>-->
    <xsl:attribute name="expand" select="$item/label/form[@lang = 'en']" />
    <xsl:attribute name="ana" select="concat('#', $element-id)"></xsl:attribute>
    <xsl:value-of select="$lbl"/>
   </tei:gram>
  </tei:gramGrp>
 </xsl:template>

 <!--    <xsl:template match="gloss">
        <tei:gloss>
            <xsl:apply-templates />
        </tei:gloss>
    </xsl:template>-->


 <xd:doc>
  <xd:desc>
   <xd:p>Viz <xd:a href="https://dariah-eric.github.io/lexicalresources/pages/TEILex0/TEILex0.html#index.xml-body.1_div.8_div.2">TEI Lex-0</xd:a> 8.2. Types of usage</xd:p>
   <xd:pre>
    <usg type="meaningType"/>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="sense/trait[@name = 'sense-type']">
  <xsl:variable name="trait-name" select="@name"/>
  <xsl:variable name="items" select="doc($lift-ranges-file)//range[@id=($trait-name)]/range-element"/>
  <xsl:variable name="value" select="normalize-unicode(@value, 'NFC')"/>
  <xsl:variable name="item" select="$items[normalize-unicode(@id, 'NFC') = $value][1]"/>
  
  <xsl:variable name="range-element" select="key('sense-type-reference',  concat('#',$value))"/>
  
  <xsl:variable name="lbl" select="$item/abbrev/form[@lang = 'en']"/>
  <xsl:variable name="element-id" select="concat($taxonomy-id, '.', $lbl)"/> <!-- , if(ends-with($lbl, '.')) then '' else '.', $item/@guid) , if(ends-with($lbl, '.')) then '' else '.', @guid -->
  
  
  <xsl:variable name="meaning-type" select="lediir:get-sense-type-label(@value)"/>
   <!-- https://dariah-eric.github.io/lexicalresources/pages/TEILex0/spec.html#TEI.usg -->
   <tei:usg type="meaningType" value="{@value}">
    <xsl:attribute name="expand" select="$item/label/form[@lang = 'en']" />
    <xsl:attribute name="ana" select="concat('#', $element-id)"></xsl:attribute>
    <xsl:value-of select="$lbl"/>
    <!--<xsl:value-of select="@value"/>
-->   </tei:usg>
 </xsl:template>
 
 <xsl:template match="sense/trait[@name = 'usage-type']">
  <xsl:variable name="trait-name" select="@name"/>
  <xsl:variable name="key" select="concat($trait-name, '-reference')"/>
  <xsl:variable name="items" select="doc($lift-ranges-file)//range[@id=($trait-name)]/range-element"/>
  <xsl:variable name="value" select="normalize-unicode(@value, 'NFC')"/>
  <xsl:variable name="item" select="$items[normalize-unicode(@id, 'NFC') = $value][1]"/>
  
  <xsl:variable name="range-element" select="key($key,  concat('#',$value))"/>
  
  <xsl:variable name="lbl" select="head(($item/abbrev/form[@lang = 'en'], $value))"/>
  <xsl:variable name="element-id" select="concat($taxonomy-id, '.', lediir:get-id-from-label($lbl))"/> <!-- , if(ends-with($lbl, '.')) then '' else '.', $item/@guid) , if(ends-with($lbl, '.')) then '' else '.', @guid -->
  
  <!-- https://dariah-eric.github.io/lexicalresources/pages/TEILex0/spec.html#TEI.usg -->
  <tei:usg type="textType" value="{@value}">
   <xsl:attribute name="expand" select="$item/label/form[@lang = 'en']" />
   <xsl:attribute name="ana" select="concat('#', $element-id)" />
   <xsl:value-of select="$lbl"/>
  </tei:usg>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="example[translation[*]]">
  <tei:cit type="example">
   <xsl:apply-templates select="form[@lang = 'fa']"/>
   <xsl:apply-templates select="form[@lang = 'cs-CZ']"/>
   <xsl:apply-templates select="* except form"/>
  </tei:cit>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="example/form[@lang = 'fa']">
  <tei:quote xml:lang="{@lang}">
   <xsl:apply-templates/>
  </tei:quote>
 </xsl:template>

 <xd:doc>
  <xd:desc>
   <xd:p>Výslovnost dokladu. Ve slovníku by se tento prvek neměl objevit. Nejspíš půjde o zbytečnou šablonu.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="example/form[@lang = 'cs-CZ']">
  <tei:pron xml:lang="{@lang}">
   <xsl:apply-templates/>
  </tei:pron>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="example/translation/form">
  <tei:cit type="translation" xml:lang="{@lang}">
   <tei:quote>
    <xsl:apply-templates/>
   </tei:quote>
  </tei:cit>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="definition/form">
  <tei:def xml:lang="{@lang}">
   <xsl:apply-templates/>
  </tei:def>
 </xsl:template>


 <xd:doc>
  <xd:desc>
   <xd:p>Nejspíš se používá pro interní poznámky. Nemělo by se do slovníku vůbec dostat.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="note[@type = 'anthropology']">
  <!--  <tei:usg type="anthropology">
   <xsl:apply-templates/>
  </tei:usg> -->
 </xsl:template>

 
 <xd:doc>
  <xd:desc> Původně:  nebudeme na webu využívat, místo toho bude grafické znázornění rozdílů ve frekvenci </xd:desc>
 </xd:doc>
 <xsl:template match="note[@type = 'sociolinguistics']">
  <tei:usg type="socioCultural">
   <xsl:apply-templates />
  </tei:usg> 
 </xsl:template>


 
 <xd:doc>
  <xd:desc> Také nejde na web a je to zřejmě jen omylem zapsané. </xd:desc>
 </xd:doc>
 <xsl:template match="note[@type = 'semantics']">
  <!--  <tei:usg type="domain">
   <xsl:apply-templates />
  </tei:usg>-->
 </xsl:template>

 <!-- TODO -->
 <!-- <xsl:template match="note[@type = 'bibliography']">
  <tei:note>
   <xsl:apply-templates/>
  </tei:note>
 </xsl:template>
-->


 <!-- <xsl:template match="note[@type = 'discourse']">
  <tei:usg>
   <xsl:apply-templates/>
  </tei:usg>
 </xsl:template>-->



 
 <xd:doc>
  <xd:desc> TODO </xd:desc>
 </xd:doc>
 <xsl:template match="note[@type = 'source']">
  <tei:note>
   <xsl:apply-templates/>
  </tei:note>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="note">
  <tei:note>
   <xsl:apply-templates/>
  </tei:note>
 </xsl:template>

 <xd:doc>
  <xd:desc>
   <xd:p>Viz <xd:a href="https://dariah-eric.github.io/lexicalresources/pages/TEILex0/TEILex0.html#collocates">TEI Lex-0</xd:a></xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="note[@type = 'grammar']">
  <tei:gramGrp>
   <tei:gram type="collocate">
    <xsl:apply-templates/>
   </tei:gram>
  </tei:gramGrp>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="note[@type = 'grammar']/form[@lang = 'fa']">
  <xsl:attribute name="lang" select="@lang" namespace="http://www.w3.org/XML/1998/namespace"/>
  <xsl:apply-templates/>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="reversal"/>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="reversal" mode="reversal">
<!--  <tei:xr type="reversal">-->
   <xsl:apply-templates/>
  <!--</tei:xr>-->
  <xsl:if test="position() != last()">
   <tei:pc>, </tei:pc>
  </xsl:if>
 </xsl:template>

 <xd:doc>
  <xd:desc>
   <xd:pre>
    <reversal type="en">
      <form lang="en">
         <text>Falsify</text>
      </form>
      <main>
         <form lang="en">
            <text>manipulate</text>
         </form>
      </main>
    </reversal>
   </xd:pre>
  </xd:desc>
 </xd:doc>
 <xsl:template match="reversal[main]" mode="reversal" priority="2">
  <tei:ref xml:lang="{form[1]/@lang}" type="reversal">
   <xsl:apply-templates select="main/form/text"/>
   <xsl:text>: </xsl:text>
   <xsl:apply-templates select="form/text"/>
  </tei:ref>
  <xsl:if test="position() != last()">
   <tei:pc>, </tei:pc>
  </xsl:if>
 </xsl:template>
 

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="lexical-unit/form/text[not(*)]">
  <xsl:value-of select="normalize-space()"/>
 </xsl:template>
 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="variant/form/text[not(*)]">
  <xsl:value-of select="normalize-space()"/>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="reversal/form">
  <tei:ref xml:lang="{@lang}" type="reversal">
   <xsl:apply-templates/>
  </tei:ref>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="definition/form/text | note/form/text">
  <xsl:apply-templates/>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="field/form/text">
  <xsl:apply-templates/>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="citation/form/text">
  <xsl:value-of select="normalize-space()"/>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="field[@type = 'Frekvency']">
  <tei:usg type="frequency">
   <xsl:attribute name="value">
    <xsl:value-of select="translate(normalize-space(.), ' ', '-')"/>
   </xsl:attribute>
   <xsl:apply-templates/>
  </tei:usg>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Co s tímto polem? Objevuje se zatím pouze jednou, navíc je jeho obsah duplicitní.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="field[@type = 'literal-meaning']" />
 

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="field[@type = 'import-residue']"/>


 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="etymology[*]">
  <tei:etym>
   <tei:cit type="etymon">
    <xsl:apply-templates/>
   </tei:cit>
  </tei:etym>
 </xsl:template>

 
 <xd:doc>
  <xd:desc>
   &lt;xr type="related" xml:lang="fa"&gt;&lt;ref type="etymon"&gt;جد&lt;/ref&gt;&lt;/xr&gt;
  </xd:desc>
 </xd:doc>
 <xsl:template match="etymology/form">
<!--  <tei:mentioned xml:lang="{@lang}">-->
  
  <tei:form>
   <tei:orth xml:lang="{@lang}">
    <xsl:apply-templates/>
   </tei:orth>
  </tei:form>
  <!--<tei:xr type="related" xml:lang="{@lang}">
   <tei:ref type="etymon">
   <xsl:apply-templates/>
   </tei:ref>
  </tei:xr>-->
  <!--</tei:mentioned>-->
 </xsl:template>
 
 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="etymology/field[@type='languagenotes'] | etymology/gloss">
  <tei:lang><xsl:apply-templates /></tei:lang>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="etymology/trait[@name = 'languages']">
  <tei:lang>
   <xsl:value-of select="@value"/>
  </tei:lang>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="tei:form" mode="grouping">
  <xsl:apply-templates/>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="relation"/>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="relation[@ref and @ref != '']" mode="grouping">
  
  <xsl:variable name="reference">
   <xsl:call-template name="get-reference-details">
    <xsl:with-param name="ref" select="@ref" />
   </xsl:call-template>   
  </xsl:variable>
  
  <tei:ref type="{$reference/reference/@type}" target="{$reference/reference/@tei-ref}">
   <xsl:variable name="entry" select="key('entry-reference', $reference/reference/@entry-id)"/>
   <xsl:call-template name="process-lexical-unit-or-citation-for-reference">
    <xsl:with-param name="entry" select="$entry" />
   </xsl:call-template>
  </tei:ref>
  
  
<!--  <xsl:variable name="entry-id" select="lediir:get-entry-id(@ref)"/>
  <tei:ref target="#FACS.{$entry-id}" type="entry">
   <xsl:apply-templates select="key('entry-reference', @ref)/citation[1]/form" mode="#current"/>
  </tei:ref>
-->
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="trait[@name = 'semantic-domain-ddp4']">
  <xsl:variable name="lbl" select="substring-before(@value, ' ')"/>
  <xsl:variable name="category-id" select="concat($taxonomy-id, '.', $lbl)"/>
  <tei:usg type="domain" ana="#{$category-id}">
   <tei:idno>
    <xsl:value-of select="substring-before(@value, ' ')"/>
   </tei:idno>
   <xsl:text> </xsl:text>
   <tei:term>
    <xsl:value-of select="substring-after(@value, ' ')"/>
   </tei:term>
  </tei:usg>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="span[@href and @class = 'Hyperlink']">
  <tei:ref target="{@href}" type="external">
   <xsl:apply-templates/>
  </tei:ref>
 </xsl:template>

 <xd:doc>
  <xd:desc>
   <xd:p>Synonyma pro konkrétní význam.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="sense/relation[@type = 'Synonyms'][@ref and @ref != '']" mode="grouping" priority="3">
  <xsl:variable name="sense" select="key('sense-reference', @ref)"/>
  <xsl:variable name="sense-id" select="lediir:get-entry-id(@ref)"/>
  <xsl:variable name="sense-item" select="count(preceding-sibling::sense) + 1"/>
  <xsl:variable name="entry" select="$sense/parent::entry"/>
  <tei:ref type="sense" target="#{$dict-id}.{$sense-id}.sense.{$sense-item}">
   <!--<xsl:apply-templates select="$entry/lexical-unit[1]/form" mode="#current" />-->
   <xsl:apply-templates select="$entry/citation[1]/form[@lang = 'fa']" mode="#current"/>
   <xsl:if test="count($entry/sense) gt 1">
    <tei:lbl type="sense-number">
     <xsl:value-of select="$sense-item"/>
    </tei:lbl>
   </xsl:if>
  </tei:ref>
 </xsl:template>

 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="relation[@type = '_component-lexeme'][@ref and @ref != '']" mode="grouping" priority="3">
  <xsl:variable name="entry-id" select="lediir:get-entry-id(@ref)"/>
  <xsl:variable name="entry-ref" select="@ref"/>
  
  <xsl:for-each select="trait[@name = 'complex-form-type']">
   
   <xsl:variable name="complex-form" select="."/>
   <xsl:variable name="lbl" select="translate(normalize-space($complex-form/@value), ' ', '-')"/>
   
   <xsl:variable name="item" select="key('variant-type-reference',concat('#', $complex-form/@value))"/>
   
   <tei:ref type="entry" target="#{$dict-id}.{$entry-id}">
    <xsl:attribute name="subtype">
     <xsl:value-of select="$lbl"/>
    </xsl:attribute>
    <xsl:attribute name="ana">
     <xsl:value-of select="concat('#', $taxonomy-id, '.complexFormType.', translate($complex-form/@value, ' ', '-'))"/>
    </xsl:attribute>
    <xsl:variable name="entry" select="key('entry-reference', $entry-ref)"/>
    <xsl:apply-templates select="key('entry-reference', $entry-ref)/lexical-unit[1]/form" mode="#current"/>
   </tei:ref>
  </xsl:for-each>
 </xsl:template>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Jedná se o odkaz na význam. Aktuální kontext je odkazující element <xd:b>relation</xd:b> v rámci odkazovaného hesla.</xd:p>
   <xd:p>Informace o odkazovaném hesle se musejí dostat na místo, kde se na něj odkazuje.</xd:p>
   <xd:p>Je potřeba vytvořit odkaz na heslo, v němž se element <xd:b>relation</xd:b> nachází.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="relation[@type = '_component-lexeme'][@ref and @ref != '']" mode="grouping-for-sense" priority="3">
  <xsl:variable name="reference">
   <xsl:call-template name="get-reference-details">
    <xsl:with-param name="ref" select="parent::entry/@id" />
   </xsl:call-template>
  </xsl:variable>

  <xsl:for-each select="trait[@name = 'complex-form-type']">

   <xsl:variable name="complex-form" select="."/>
   <xsl:variable name="lbl" select="translate(normalize-space($complex-form/@value), ' ', '-')"/>

   <tei:ref type="{$reference/reference/@type}" target="{$reference/reference/@tei-ref}">
    <xsl:attribute name="subtype">
     <xsl:value-of select="$lbl"/>
     <!--<xsl:value-of select="concat('#', translate($complex-form/@value, ' ', '-'))"/>-->
    </xsl:attribute>
    <xsl:attribute name="ana">
     <xsl:value-of select="concat('#', $taxonomy-id, '.complexFormType.', translate($complex-form/@value, ' ', '-'))"/>
    </xsl:attribute>
    <xsl:variable name="entry" select="key('entry-reference', $reference/reference/@entry-id)"/>
    <xsl:call-template name="process-lexical-unit-or-citation-for-reference">
     <xsl:with-param name="entry" select="$entry" />
    </xsl:call-template>
   </tei:ref>
  </xsl:for-each>
 </xsl:template>
 
 <xd:doc>
  <xd:desc><xd:p></xd:p></xd:desc>
 </xd:doc>
 <xsl:template match="form[@lang='cs-CZ']" mode="bibliography">
  <xsl:variable name="root" select="parent::description/parent::range-element" />
  <xsl:variable name="id" select="$root/@id" />
  <tei:bibl xml:id="{$dict-id}.bibl.{$root/@guid}" n="{$root/@guid}">
   <tei:idno><xsl:value-of select="normalize-space($id)"/></tei:idno>
   <xsl:apply-templates select="node()" />
  </tei:bibl>
 </xsl:template>

 <xsl:template name="process-lexical-unit-or-citation-for-reference">
  <xsl:param name="entry" as="element(entry)" />
  <xsl:apply-templates select="$entry/citation[1]" mode="#current"/>
  <xsl:if test="not($entry/citation)">
   <xsl:apply-templates select="$entry/lexical-unit[1]" mode="#current"/>
  </xsl:if>
 </xsl:template>


 <xsl:template name="get-reference-details" as="element(reference)">
  <xsl:param name="ref" as="attribute()" />
  <xsl:variable name="target-type" select="lediir:target-type($ref)"/>
  
  <reference type="{$target-type}" source-ref="{$ref}">
   <xsl:choose>
    <xsl:when test="$target-type = 'entry'">
     <xsl:variable name="entry-clean-id" select="lediir:get-entry-id($ref)"/>
     <xsl:variable name="tei-entry-id" select="concat($dict-id, '.', $entry-clean-id)"/>

     <xsl:attribute name="tei-ref" select="concat('#', $tei-entry-id)" />
     
     <xsl:attribute name="entry-id" select="$ref" />
     <xsl:attribute name="tei-entry-ref" select="concat('#', $tei-entry-id)" />

    </xsl:when>
    <xsl:when test="$target-type = 'sense'">
     <xsl:variable name="sense" select="key('sense-reference', $ref)"/>
     <xsl:variable name="entry" select="$sense/parent::entry"/>
     <xsl:variable name="entry-clean-id" select="lediir:get-entry-id($entry/@id)"/>
     <xsl:variable name="tei-entry-id" select="concat($dict-id, '.', $entry-clean-id)"/>
     <xsl:variable name="sense-number" select="count($sense/preceding-sibling::sense) + 1"/>
     <xsl:variable name="tei-sense-id" select="concat($tei-entry-id, '.sense.', $sense-number)"/>

     <xsl:attribute name="tei-ref" select="concat('#', $tei-sense-id)" />
     
     <xsl:attribute name="entry-id" select="$entry/@id" />
     <xsl:attribute name="tei-entry-id" select="$tei-entry-id" />
     <xsl:attribute name="tei-entry-ref" select="concat('#', $tei-entry-id)" />
     
     <xsl:attribute name="sense-id" select="$ref" />
     <xsl:attribute name="tei-sense-id" select="$tei-sense-id" />
     <xsl:attribute name="tei-sense-ref" select="concat('#', $tei-sense-id)" />
     
    </xsl:when>
   </xsl:choose>
   
  </reference>
  
 </xsl:template>
 
 <xsl:template match="illustration">
  <tei:note>
   <tei:figure>
   <xsl:apply-templates />
   <tei:graphic url="{@href}" />
  </tei:figure>
  </tei:note>
 </xsl:template>
 
 <xsl:template match="illustration/label">
  <tei:head>
   <xsl:apply-templates />
  </tei:head>
 </xsl:template>

 <xsl:function name="lediir:target-type" as="xs:string">
  <xsl:param name="ref" as="attribute()" />
  <xsl:choose>
   <xsl:when test="contains($ref, '_')">
    <xsl:value-of select="'entry'"/>
   </xsl:when>
   <xsl:when test="matches($ref, '^([0-9A-Fa-f]{8}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{12})$')">
    <xsl:value-of select="'sense'"/>
   </xsl:when>
   <xsl:otherwise><xsl:value-of select="'unknown'"/></xsl:otherwise>
  </xsl:choose>
 </xsl:function>
</xsl:stylesheet>
