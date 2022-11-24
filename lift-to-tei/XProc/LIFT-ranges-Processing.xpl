<p:library xmlns:p="http://www.w3.org/ns/xproc"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:dlb="https://www.daliboris.cz/ns/xproc/"
 xmlns:tei="http://www.tei-c.org/ns/1.0" 
 xmlns:c="http://www.w3.org/ns/xproc-step" 
 xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="3.0">
 
 <p:declare-step type="dlb:semantic-domains-to-tei-taxonomy" version="3.0" name="domains-to-taxonomy">
  <p:documentation>Converts semantinc domains from LIFT document to TEI format.</p:documentation>
  
  <p:output port="result" serialization="map{'indent' : false()}" primary="true">
   <p:documentation>TEI document with taxonomy element and nested category elements.</p:documentation>
  </p:output>

  <p:input port="source" primary="true">
   <p:documentation>Source document, ie. file with .lift-ranges extension.</p:documentation>
  </p:input>
  

  <p:xslt name="lift-to-taxonomy" message="lift-to-taxonomy">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-semantic-domain-to-TEI.xsl"/>
  </p:xslt>
  
  <p:xslt name="taxonomy-remove-duplicates" message="taxonomy-remove-duplicates">
   <p:with-input port="stylesheet" href="../Xslt/TEI-taxonomy-remove-duplicates.xsl"/>
  </p:xslt>
  
  <p:xslt name="taxonomy-cleaning-namespace-prefixes" message="taxonomy-cleaning-namespace-prefixes">
   <p:with-input port="stylesheet" href="../Xslt/Clean-namespace-prefixes.xsl"/>
  </p:xslt>
    
 </p:declare-step>
 
 <p:declare-step type="dlb:taxonomy-translation" version="3.0" name="taxonomy-translation">
  <p:documentation>Converts taxonomy in TEI format to JSON format used for translation in TEI Publsher.</p:documentation>
  
  <p:output port="result" serialization="map{'indent' : false()}" primary="true">
   <p:documentation>JSON document with &lt;taxonomy&gt; element used for translation in TEI Publsher.</p:documentation>
  </p:output>
  
  <p:input port="source" primary="true">
   <p:documentation>Source document, ie. TEI document with &lt;taxonomy&gt; element.</p:documentation>
  </p:input>
  
  <p:option name="lang" as="xs:string" />
  
  <p:xslt name="generating-taxonomy-translation" message="generating-taxonomy-translation for {$lang} language">
   <p:with-input port="stylesheet" href="../Xslt/TEI-taxonomy-to-JSON-by-lang.xsl"/>
   <p:with-option name="parameters" select="map {
    'taxonomy-id-prefix' : 'LeDIIR.taxonomy.', 
    'lang' : $lang
    }"/>
  </p:xslt>
  
  
 </p:declare-step>
 
</p:library>
