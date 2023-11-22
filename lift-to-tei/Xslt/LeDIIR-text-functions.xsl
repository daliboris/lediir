<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" 
 xmlns:lediir="https://daliboris.cz/ns/lediir/xslt/1.0" 
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 exclude-result-prefixes="xs xd lediir" version="3.0">
 
 <xsl:function name="lediir:get-entry-id" as="xs:string">
  <xsl:param name="ref" as="xs:string" />
  <xsl:variable name="id" select="substring-after($ref, '_')" />
  <xsl:value-of select="$id" />
 </xsl:function>
 
 <xsl:function name="lediir:get-sense-id" as="xs:string">
  <xsl:param name="ref" as="xs:string" />
  <xsl:variable name="id" select="if(contains($ref, '_')) then substring-after($ref, '_') else $ref" />
  <xsl:value-of select="$id" />
 </xsl:function>
 
 <xsl:function name="lediir:get-sense-type-label" as="xs:string">
  <xsl:param name="sense-type" as="xs:string" />
  <xsl:choose>
   <xsl:when test="$sense-type = 'figurative'">
    <xsl:text>fig.</xsl:text>
   </xsl:when>
   <xsl:when test="$sense-type = 'literal'">
    <xsl:text>kniž.</xsl:text>
   </xsl:when>
   <xsl:otherwise>
    <xsl:text></xsl:text>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:function>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Z předaného textu odstraní počáteční a koncové mezery, vnitřní mezery nahradí pomlčkou, koncovou textu odstraní.</xd:p>
   <xd:p>Pro <xd:i>ab.a</xd:i> vrátí <xd:i>ab.a</xd:i>, pro <xd:i>ab.a.</xd:i> vrátí <xd:i>ab.a</xd:i>.</xd:p>
  </xd:desc>
  <xd:param name="lbl">
   <xd:p>Text, který se upraví, aby mohl sloužit jako identifikátor, tj. součást atributu <xd:b>@xml:id</xd:b>.</xd:p>
  </xd:param>
 </xd:doc>
 <xsl:function name="lediir:get-id-from-label" as="xs:string">
  <xsl:param name="lbl" as="xs:string" />
  <xsl:variable name="id" select="translate(normalize-space($lbl), ' ', '-')" />
  <xsl:value-of select="if(ends-with($id, '.')) then substring($id, 1, string-length($id) - 1) else $id" />
 </xsl:function>

 <xsl:function name="lediir:get-sort-key-for-entry" as="xs:string">
  <xsl:param name="entry" as="element(entry)" />
  <xsl:variable name="sort-key">
   <xsl:choose>
    <xsl:when test="$entry[not(citation)]">
     <xsl:value-of select="lediir:get-sort-key($entry/lexical-unit)"/>
    </xsl:when>
    <xsl:when test="$entry[normalize-space(lexical-unit) = normalize-space(citation)]">
     <xsl:value-of select="lediir:get-sort-key($entry/lexical-unit)"/>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="normalize-space(concat(lediir:get-sort-key($entry/lexical-unit), '-', lediir:get-sort-key($entry/citation)))"/>
    </xsl:otherwise>
   </xsl:choose>   
  </xsl:variable>
  <xsl:value-of select="lediir:convert-sort-key-to-sortable($sort-key)"/>
 </xsl:function>

 <xsl:function name="lediir:get-sort-key" as="xs:string">
  <xsl:param name="headword" as="xs:string" />
  
  <!-- 
   Diakritická znaménka:
   &#x64f; = Arabic Damma
   &#x64e; = Arabic Fatha
   &#x650; = Arabic Kasra
   &#x651; = Arabic Shadda
   &#x652; = Arabic Sukun
   &#x0640; = Arabic Tatweel

   Mezery a řídicí znaky:
   &#x200d; = Zero Width Joiner; nespíš taky ignorovat
   &#x200c; = Zero Width Non-Joiner; půlmezera => zcela ignorovat
   &#x200e; = Left-to-Right Mark (LRM) => zcela ignorovat
  -->
  <xsl:value-of select="$headword 
    => normalize-space() 
    => translate('', '&#x64f;&#x64e;&#x650;&#x651;&#x652;&#x0640;')
    => translate( '&#x200c;&#x200d;&#x200e;', '') 
    => translate( '&#xfeff;', '!') 
    => translate( ' &#xa0;', '!') 
    => translate('ي', 'ی')
    => translate('ى', 'ی') 
    => translate('ئ', 'ی') 
    => replace('ـي', 'ی') 
    => translate('آإأ', 'ا')
    => translate('ك', 'ک')
    => translate('ؤ', 'و') 
    => translate('ۀ', 'ه') 
    => translate('ة', 'ه') 
    " />
 </xsl:function>
 
 <xsl:function name="lediir:convert-sort-key-to-sortable" as="xs:string">
  <xsl:param name="sort-key" as="xs:string" />
  <xsl:value-of select="$sort-key 
   => translate('ا', 'A')
  => translate('ب', 'B')
  => translate('پ', 'C')
  => translate('ت', 'D')
  => translate('ث', 'E')
  => translate('ج', 'F')
  => translate('چ', 'G')
  => translate('ح', 'H')
  => translate('خ', 'I')
  => translate('د', 'J')
  => translate('ذ', 'K')
  => translate('ر', 'L')
  => translate('ز', 'M')
  => translate('ژ', 'N')
  => translate('س', 'O')
  => translate('ش', 'P')
  => translate('ص', 'Q')
  => translate('ض', 'R')
  => translate('ط', 'S')
  => translate('ظ', 'T')
  => translate('ع', 'U')
  => translate('غ', 'V')
  => translate('ف', 'W')
  => translate('ق', 'X')
  => translate('ک', 'Y')
  => translate('گ', 'Z')
  => translate('ل', 'a')
  => translate('م', 'b')
  => translate('ن', 'c')
  => translate('و', 'd')
  => translate('ه', 'e')
  => translate('ی', 'f')
  " />
 </xsl:function>
 
 <xsl:function name="lediir:convert-sortable-to-sort-key" as="xs:string">
  <xsl:param name="sort-key" as="xs:string" />
  <xsl:value-of select="	$sort-key
   => translate('A', 'ا')
   => translate('B', 'ب')
   => translate('C', 'پ')
   => translate('D', 'ت')
   => translate('E', 'ث')
   => translate('F', 'ج')
   => translate('G', 'چ')
   => translate('H', 'ح')
   => translate('I', 'خ')
   => translate('J', 'د')
   => translate('K', 'ذ')
   => translate('L', 'ر')
   => translate('M', 'ز')
   => translate('N', 'ژ')
   => translate('O', 'س')
   => translate('P', 'ش')
   => translate('Q', 'ص')
   => translate('R', 'ض')
   => translate('S', 'ط')
   => translate('T', 'ظ')
   => translate('U', 'ع')
   => translate('V', 'غ')
   => translate('W', 'ف')
   => translate('X', 'ق')
   => translate('Y', 'ک')
   => translate('Z', 'گ')
   => translate('a', 'ل')
   => translate('b', 'م')
   => translate('c', 'ن')
   => translate('d', 'و')
   => translate('e', 'ه')
   => translate('f', 'ی')
   => translate('!', ' ')
   "/>
 </xsl:function>
 
 <xsl:function name="lediir:create-relation-type" as="xs:string">
  <xsl:param name="type" as="xs:string" />
  <xsl:value-of select="translate(normalize-space($type), ' ', '_')"/>
 </xsl:function>
 
 <xsl:function name="lediir:get-relation-type-value">
  <xsl:param name="relation-type" as="xs:string"/>
  
  <xsl:variable name="relations">
   <relation name="Antonym" type="antonymy" label-type="cross-rerefence" label-subtype="antonyms" label="Antonyma:" />
   <relation name="antonymum" type="antonymy" label-type="cross-rerefence" label-subtype="antonyms" label="Antonyma:" />
   <relation name="Compare" type="related" label-type="cross-rerefence" label-subtype="related" label="Srovnej:" />
   <relation name="srovnej" type="related" label-type="cross-rerefence" label-subtype="related" label="Srovnej:" />
   <relation name="obecný" type="related" label-type="cross-rerefence" label-subtype="related" label="Srovnej:" />
   <relation name="ref" type="related" label-type="cross-rerefence" label-subtype="related" label="Srovnej:" />
   <relation name="Specific" type="related" label-type="cross-rerefence" label-subtype="specific" />
   <relation name="specifický" type="related" label-type="cross-rerefence" label-subtype="specific" />
   <relation name="Synonyms" type="synonymy" label-type="cross-rerefence" label-subtype="synonyms" label="Synonyma:" />
   <relation name="synonyma" type="synonymy" label-type="cross-rerefence" label-subtype="synonyms" label="Synonyma:" />
   <relation name="rodový_protějšek" type="related" label-type="cross-rerefence" label-subtype="voice-counterparts" label="Rodové protějšky:" />
   <relation name="Reversals" type="related" label-type="cross-rerefence" label-subtype="reversals" label="Zpětné odkazy:" />
   <relation name="_component-lexeme" type="related" label-type="cross-rerefence" label-subtype="complex-forms" label="Komplexní formy:" /> 
  </xsl:variable>
  
  <xsl:variable name="relation" select="$relations/relation[@name=normalize-space($relation-type)]"/>
  <xsl:choose>
   <xsl:when test="$relation">
    <xsl:value-of select="$relation/@type"/>
   </xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="normalize-space($relation-type)"/>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:function>

</xsl:stylesheet>