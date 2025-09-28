<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step version="3.0" 
 xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:dlb="https://www.daliboris.cz/ns/xproc/"
 xmlns:map="http://www.w3.org/2005/xpath-functions/map"
 >

 <p:documentation>
   Slouží k úpravě dokumentu LIFT pro generování mobilní aplikace.
   Vyčistí vstupní soubor od známých chyb a odkazů na nezpracovaná hesla.
   Převede sémantické kategorie na uživatelské pole, aby je bylo možné zobrazit.
 </p:documentation>

 <p:import href="LIFT-Processing.xpl"/>
 
 <p:option name="root-directory" static="true"/>
 <p:option name="file-name" static="true"/>
 <p:option name="create-sample" as="xs:boolean" static="true"/>
 <p:option name="test-version" as="xs:string?" select="()" values="('underscore', 'nonbreak', 'sample', 'pronunciation')" />
 
 <p:option name="target-level" as="xs:string*" select="('Basic', 'Medium', 'Large')" values="('Basic', 'Medium', 'Large')" />
 <p:option name="replace-pronunciation" as="xs:boolean" select="true()" />
 
 <p:option name="whitespace-replacements" as="map(*)" select="map { 
  'undescore' : map {'replacement' : '_' },
  'nonbreak' : map {'replacement' : '&#xa0;' },
  'sample' :  map {'replacement' : ' ' },
  'pronunciation' :  map {'replacement' : ' ' }
  }" static="true"/>
 <p:option name="source-lang" static="true"/>
 
 <p:option name="testing" select="false()" static="true"/>
 	
 <p:input port="source" primary="true">
  <p:document href="../{$root-directory}/{$file-name}.lift" content-type="text/xml"/>
	</p:input>

	<!--<p:output port="result" serialization="map{'indent' : true()}" />-->
 
 <p:declare-step type="dlb:get-lift-ranges">
  <p:input port="source"/>
  <p:output port="result"/>
  
  <p:variable name="ranges" select="/lift/header/ranges/range[@id='reversal-type']/@href => replace('file://', 'file:///')"/>
  
  <p:load href="{$ranges}" content-type="text/xml" message="Loading {$ranges}"/>
  
 </p:declare-step>
	 
  <p:declare-step type="dlb:add-reversal-for-domain">
	  <p:input port="source"/>
   <p:output port="result"/>
   
   <dlb:get-lift-ranges name="ranges" />
   <p:variable name="ranges-url" select="base-uri()" />
   
   <p:if test="not(exists((/lift-ranges/range[@id='reversal-type']/range-element[@id='dm'])))">
    <p:insert match="/lift-ranges/range[@id='reversal-type']" position="last-child" message="Inserting range-element">
     <p:with-input port="insertion">
      <range-element id="dm">
       <label>
        <form lang="cs-CZ"><text>Domény</text></form>
        <form lang="en"><text>Domains</text></form>
        <form lang="dm"><text>Domains</text></form>
       </label>
      </range-element>
     </p:with-input>
    </p:insert>
    
    <p:store href="{$ranges-url}" message="Storing {$ranges-url}"/>
   </p:if>
   
	 </p:declare-step>
 
 <p:declare-step type="dlb:replace-grammatical-info" name="replacing-grammatical-info">
  <p:input port="source"/>
  <p:output port="result"/>
  
  <dlb:get-lift-ranges />
  
  <!--<p:filter select="/lift-ranges/range[@id='grammatical-info']/range-element" />-->
  
  <p:xquery>
   <p:with-input port="query" href="../XQuery/LIFT-get-grammatical-info-abbreviations.xquery" />
  </p:xquery>
  
  <p:variable name="abbreviations" select="." />
  
  <p:viewport match="grammatical-info" message="viewport: {map:size($abbreviations)}" >
   <p:with-input pipe="source@replacing-grammatical-info" />
   <p:variable name="val" select="/*/@value/data()" />
   <p:if test="map:contains($abbreviations, $val)">
    <p:add-attribute attribute-name="value" attribute-value="{map:get($abbreviations, $val)}" /> 
   </p:if>
  </p:viewport>
    
 </p:declare-step>
	 
 <dlb:clean-raw-data>
  <p:with-option name="root-directory" select="$root-directory"/>
  <p:with-option name="file-name" select="$file-name"/>
  <p:with-option name="create-sample" select="$create-sample"/>
  <p:with-option name="testing" select="$testing"/>
 </dlb:clean-raw-data>

 <!-- heslové statě bez významu a odkazu na jiná hesla -->
 <p:delete match="entry[not(sense)][not(relation)]" message="removing entries with no sense and relation"/>
 
 <p:delete match="reversal[@type='en']" message="removing English reversals" />
 <p:delete match="gloss[@lang='en']" message="removing English glosses" />
 <p:delete match="definition/form[@lang='en']" message="removing English definitions" />
 
 <p:xslt name="removing-allomorphs" message="removing-allomorphs">
  <p:with-input port="stylesheet" href="../Xslt/LIFT-removing-allomorphs.xsl"/>
 </p:xslt>
 
 <p:if test="$test-version">
  <p:xslt name="multiword-expressions-modify" message="multiword-expressions-modify">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-multiword-expressions-modify.xsl" />
   <p:with-option name="parameters" select="$whitespace-replacements($test-version)" />
  </p:xslt>
 </p:if>
 
 
 <p:xslt name="copying-variants" message="copying-variants">
  <p:with-input port="stylesheet" href="../Xslt/LIFT-copying-variants.xsl"/>
 </p:xslt>

 <p:xslt name="replacing-frequency" message="replacing-frequency">
  <p:with-input port="stylesheet" href="../Xslt/LIFT-replacing-frequency.xsl"/>
 </p:xslt>
 
 <p:identity name="full-content" />
 
 <p:store href="../{$root-directory}/{$file-name}-replacing-frequency.lift"
   serialization="map{'indent' : true()}" 
   message="Saving ../{$root-directory}/{$file-name}-replacing-frequency.lift"
   use-when="$testing"
  />
 
 <p:for-each>
  <p:with-input select="$target-level"/>
  <p:variable name="target" select="." />
  
  <p:xslt name="removing-low-frequency" message="removing-low-frequency">
   <p:with-input port="source" pipe="result@full-content" />
   <p:with-input port="stylesheet" href="../Xslt/LIFT-removing-low-frequency.xsl" />
   <p:with-option name="parameters" select="map {'target-level' : $target }" />
  </p:xslt>
  
  <p:xslt name="moving-en-example-to-translation" message="moving-en-example-to-translation">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-move-en-example-to-translation.xsl"/>
  </p:xslt>
  
  <p:xslt name="moving-grammar-note-to-definition" message="moving-grammar-note-to-definition">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-moving-grammar-note-to-definition.xsl"/>
  </p:xslt>
  
  <p:xslt name="merging-grammar-note-in-definition" message="merging-grammar-note-in-definition">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-merging-grammar-note-in-definition.xsl"/>
  </p:xslt>
  
  <p:xslt name="moving-domain-after-definition" message="moving-domain-after-definition">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-moving-domain-after-definition.xsl"/>
  </p:xslt>
  
  <p:xslt name="adding-domain-as-custom-field" message="adding-domain-as-custom-field">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-add-domain-as-custom-field.xsl"/>
  </p:xslt>
  
  <p:xslt name="adding-domain-as-gloss" message="adding-domain-as-gloss">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-add-domain-as-gloss.xsl"/>
  </p:xslt>
  
  <p:xslt name="removing-domain-field" message="removing-domain-field">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-remove-domain-field.xsl"/>
  </p:xslt>
  
  <p:if test="$replace-pronunciation">
   <p:xslt name="adding-pronunciation-as-custom-field" message="adding-pronunciation-as-custom-field">
    <p:with-input port="stylesheet" href="../Xslt/LIFT-add-pronunciation-as-custom-field.xsl"/>
   </p:xslt>  
  </p:if>
  
  <p:xslt name="clean-media-filenames" message="clean-media-filenames">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-clean-media-filenames.xsl"/>
  </p:xslt>
  
  <dlb:replace-grammatical-info />
  
  <p:store href="../{$root-directory}/{$file-name}-mobile_{$target}.lift" serialization="map{'indent' : true()}" message="Saving ../{$root-directory}/{$file-name}-mobile_{$target}.lift"/>
  <p:store href="../Dictionary/LeDIIR-{upper-case($source-lang)}CS-mobile_{$target}.lift" serialization="map{'indent' : true()}" message="Saving ../Dictionary/LeDIIR-{upper-case($source-lang)}CS-mobile_{$target}.lift"/>
  <p:file-copy href="../Dictionary/LeDIIR-{upper-case($source-lang)}CS-mobile_{$target}.lift"
   target="../../../lediir-mobile-app/dictionaries/{upper-case($source-lang)}CS/{upper-case($source-lang)}CS_data/lexicon/LeDIIR-{upper-case($source-lang)}CS-mobile_{$target}.lift"
   overwrite="true"
   message="Copying to ../../../lediir-mobile-app/dictionaries/{upper-case($source-lang)}CS/{upper-case($source-lang)}CS_data/lexicon/LeDIIR-{upper-case($source-lang)}CS-mobile_{$target}.lift" />
  
  
 </p:for-each>
 

 <!--<dlb:add-reversal-for-domain/>-->
 <!-- TODO: change copyright data a version of data in FACS_data/about/about.txt -->
 
</p:declare-step>