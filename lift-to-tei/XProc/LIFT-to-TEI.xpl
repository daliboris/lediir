<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:dlb="https://www.daliboris.cz/ns/xproc/"
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 version="3.0">
 
 <p:documentation>Procedura pro konverzi formátu LIFT do formátu TEI Lex-0 a vygenerování
  pomocných souborů (např. zdrojových souborů s překladem pro webovou aplikaci).</p:documentation>
 
 <p:import href="LIFT-ranges-Processing.xpl" />
 <p:import href="LIFT-Processing.xpl" />
 
 <p:option name="root-directory" static="true"/>
 <p:option name="file-name" static="true"/>
 <p:option name="create-sample" as="xs:boolean" static="true"/>
 <p:option name="source-lang" static="true"/>
 <p:option name="project-acronym" select="'LeDIIR'" static="true" />
 
 <p:option name="testing" static="true"  />


 <p:input port="source" primary="true">
  <p:document href="../{$root-directory}/{$file-name}.lift" content-type="text/xml"/>
 </p:input>


 <dlb:clean-raw-data>
  <p:with-option name="root-directory" select="$root-directory" />
  <p:with-option name="file-name" select="$file-name" />
  <p:with-option name="create-sample" select="$create-sample" />
  <p:with-option name="testing" select="$testing" />
 </dlb:clean-raw-data>

 <p:store href="../{$root-directory}/temp/raw-data-cleaned.xml" use-when="$testing"/>
 

 <dlb:convert-to-tei name="converting-to-tei">
  <p:with-option name="source-lang" select="$source-lang" />
  <p:with-option name="root-directory" select="$root-directory" />
  <p:with-option name="file-name" select="$file-name" />
  <p:with-option name="testing" select="$testing" />
 </dlb:convert-to-tei>

 <p:load href="../{$root-directory}/{$file-name}.lift-ranges" content-type="text/xml"/>
  
 <dlb:semantic-domains-to-tei-taxonomy  name="taxonomy-tei"/>
 
 <p:store href="../{$root-directory}/TEI-taxonomy.xml" use-when="$testing"/>

 <!--
 <p:xslt name="generating-taxonomy-html" message="generating-taxonomy-html">
  <p:with-input port="stylesheet" href="../Xslt/TEI-taxonomy-to-HTML.xsl"/>
 </p:xslt>

 <p:store href="../Html/{$file-name}-taxonomy.html" serialization="map{'indent' : true(), 'method' : 'xhtml', 'omit-xml-declaration' : true() }"/>

 <p:xslt name="generating-pos-taxonomy-translation" message="generating-pos-taxonomy-translation">
  <p:with-input port="source" pipe="@taxonomy-tei"/>
  <p:with-input port="stylesheet" href="../Xslt/TEI-taxonomy-to-JSON.xsl"/>
 </p:xslt>
-->
 
 <p:for-each name="languages">
  <p:with-input select="('cs-CZ', 'en', 'fa')" />
  <p:variable name="lang" select="." />
  <p:variable name="lang-store" select="if(contains($lang, '-')) then substring-before($lang, '-') else $lang" />
  <dlb:taxonomy-translation p:message="Taxonomy translation for {$lang} language">
   <p:with-input port="source" pipe="@taxonomy-tei"/>
   <p:with-option name="lang" select="$lang"/>
  </dlb:taxonomy-translation>
  <p:store href="../{$root-directory}/resources/i18n/app/{$lang-store}.json" message="Storing ../{$root-directory}/resources/i18n/app/{$lang-store}.json"/>
 </p:for-each>


 <p:insert match="/tei:TEI/tei:teiHeader[1]/tei:encodingDesc[1]" position="last-child" name="taxonomy-insertion" message="inserting taxonomy">
  <p:with-input port="source" pipe="@converting-to-tei"/>
  <p:with-input port="insertion" pipe="@taxonomy-tei" select="/tei:TEI/tei:teiHeader[1]/tei:encodingDesc[1]/tei:classDecl[1]"/>
 </p:insert>
 
 <p:store href="../{$root-directory}/{$project-acronym}-{upper-case($source-lang)}CS-labels-before.xml" message="Storing ../{$root-directory}/{$project-acronym}-{upper-case($source-lang)}CS-labels-before.xml" use-when="$testing"/>
 
 <p:xslt name="adding-labels-to-lemma-variants" message="adding-labels-to-lemma-variants">
  <p:with-input port="stylesheet" href="../Xslt/TEI-add-labels-to-variants.xsl"/>
 </p:xslt>
 
 
 <p:xslt name="cleaning-namespace-prefixes" message="cleaning-namespace-prefixes">
  <p:with-input port="stylesheet" href="../Xslt/Clean-namespace-prefixes.xsl"/>
 </p:xslt>

 <p:store href="../{$root-directory}/{$project-acronym}-{upper-case($source-lang)}CS.xml" message="Storing ../{$root-directory}/{$project-acronym}-{upper-case($source-lang)}CS.xml"/>


 <p:store href="../Dictionary/{$project-acronym}-{upper-case($source-lang)}CS.xml" message="Storing ../Dictionary/{$project-acronym}-{upper-case($source-lang)}CS.xml"/>


 
<!-- <p:xslt name="generating-html" message="generating-html">
  <p:with-input port="stylesheet" href="../Xslt/TEI-to-HTML.xsl"/>
 </p:xslt>

 <p:store href="../Html/{$file-name}.html" serialization="map{'indent' : true(), 'method' : 'xhtml', 'omit-xml-declaration' : true() }"/>

-->
 <p:xslt name="generating-about" message="generating-about">
  <p:with-input port="source" pipe="@taxonomy-insertion"/>
  <p:with-input port="stylesheet" href="../Xslt/TEI-to-about.xsl"/>
 </p:xslt>

 <p:xslt name="cleaning-namespace-prefixes-about" message="cleaning-namespace-prefixes">
  <p:with-input port="stylesheet" href="../Xslt/Clean-namespace-prefixes.xsl"/>
 </p:xslt>

 <p:add-attribute attribute-name="xml:id" attribute-value="{$project-acronym}"/>

 <p:store href="../{$root-directory}/{$project-acronym}-{upper-case($source-lang)}CS-about.xml" message="Storing ../{$root-directory}/{$project-acronym}-{upper-case($source-lang)}CS-about.xml"/>
 <p:store href="../Dictionary/{$project-acronym}-{upper-case($source-lang)}CS-about.xml" message="Storing ../Dictionary/{$project-acronym}-{upper-case($source-lang)}CS-about.xml"/>
 
</p:declare-step>
