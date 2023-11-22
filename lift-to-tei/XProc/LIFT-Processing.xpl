<p:library xmlns:p="http://www.w3.org/ns/xproc"
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:dlb="https://www.daliboris.cz/ns/xproc/"
 xmlns:c="http://www.w3.org/ns/xproc-step" 
 xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 version="3.0">
 
 <p:declare-step type="dlb:clean-raw-data" version="3.0" name="clean-raw-data">
  <p:documentation>Cleans unwanted data from LIFT document.</p:documentation>
  
  <p:output port="result" serialization="map{'indent' : false()}" primary="true">
   <p:documentation>LIFT document with cleaned data.</p:documentation>
  </p:output>

  <p:input port="source" primary="true">
   <p:documentation>Source document, ie. file with .lift extension.</p:documentation>
  </p:input>
  
  <p:option name="root-directory" as="xs:string" />
  <p:option name="file-name" as="xs:string" />
  <p:option name="create-sample" as="xs:boolean" />
  <p:option name="testing" as="xs:boolean" />
  
  <p:if test="$create-sample">
   <p:xslt message="creating-sample">
    <p:with-input port="stylesheet" href="../Xslt/LIFT-create-sample.xsl"/>
   </p:xslt>
  </p:if>
  
  <p:if test="$testing and $create-sample">
   <p:store href="../{$root-directory}/{$file-name}-sample.xml" message="saving ../{$root-directory}/{$file-name}-sample.xml" />
  </p:if>
  
  <p:xslt message="removing-elements">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-remove-elements.xsl"/>
  </p:xslt>
  
  <p:xslt message="cleaning-typos">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-clean-typos.xsl"/>
  </p:xslt>

  <p:xslt message="fixing-errors">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-fix-errors.xsl"/>
  </p:xslt>
  
  
  <p:xslt name="removing-empty-examples" message="removing-empty-examples">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-remove-empty-elements.xsl"/>
  </p:xslt>
  
  <p:if test="$testing">
   <p:store href="../{$root-directory}/{$file-name}-unsorted.xml" message="saving ../{$root-directory}/{$file-name}-unsorted.xml" />
  </p:if>
  
  <p:xslt name="sorting-entries" message="sorting-entries">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-sort-entries.xsl"/>
  </p:xslt>
  
  <p:if test="$testing">
  <p:store href="../{$root-directory}/{$file-name}.xml" message="Saving ../{$root-directory}/{$file-name}.xml" />
  </p:if>

 </p:declare-step>
 
 <p:declare-step type="dlb:convert-to-tei" version="3.0" name="convert-to-tei">
  <p:documentation>Converts data from LIFT format into TEI format used in TEI Publsher.</p:documentation>
 
  <p:option name="source-lang" as="xs:string" />
  <p:option name="root-directory" as="xs:string" />
  <p:option name="file-name" as="xs:string" />
  <p:option name="testing" as="xs:boolean" />
  
  <p:output port="result" serialization="map{'indent' : false()}" primary="true">
   <p:documentation>TEI document.</p:documentation>
  </p:output>
  
  <p:input port="source" primary="true">
   <p:documentation>Source document, ie. LIFT document.</p:documentation>
  </p:input>
  
  <p:variable name="base-directory" select="base-uri()"/>
  
   
  <p:xslt name="creating-tei" message="creating-tei">
   <p:with-input port="stylesheet" href="../Xslt/LIFT-to-TEI.xsl"/>
   <p:with-option name="parameters" select="map{
    'lift-ranges-file' : concat($base-directory, '-ranges'), 
    'dict-id' : concat(upper-case($source-lang), 'CS')
    }"/>
  </p:xslt>
  
  <p:if test="$testing">
   <p:store href="../{$root-directory}/{$file-name}-TEI-Step-01.xml" message="Storing ../{$root-directory}/{$file-name}-TEI-Step-01.xml" />   
  </p:if>
  
  <p:xslt name="moving-usg-socioCultural" message="moving-usg-socioCultural">
   <p:with-input port="stylesheet" href="../Xslt/TEI-moving-usg-socioCultural.xsl"/>
  </p:xslt>
  
  <p:if test="$testing">
   <p:store href="../{$root-directory}/{$file-name}-TEI-Step-01-usg.xml" message="Storing ../{$root-directory}/{$file-name}-TEI-Step-01-usg.xml" />   
  </p:if>
  
  
  <p:xslt name="processing-complex-forms" message="processing-complex-forms">
   <p:with-input port="stylesheet" href="../Xslt/TEI-complex-forms-processing.xsl"/>
  </p:xslt>
  
  <p:xslt>
   <p:with-input port="stylesheet" href="../Xslt/TEI-remove-duplicate-xml-ids.xsl"/>
  </p:xslt>
  
  <p:xslt message="removing not approved entries">
   <p:with-input port="stylesheet" href="../Xslt/TEI-remove-not-approved-entries.xsl"/>
  </p:xslt>
  
  <p:xslt name="generating-lemma-variants" message="generating-lemma-variants">
   <p:with-input port="stylesheet" href="../Xslt/TEI-create-lemma-variants.xsl"/>
  </p:xslt>
  
  
  <p:xslt name="cleaning-namespace-prefixes" message="cleaning-namespace-prefixes">
   <p:with-input port="stylesheet" href="../Xslt/Clean-namespace-prefixes.xsl"/>
  </p:xslt>
  
  <p:store href="../{$root-directory}/{$file-name}-TEI.xml" message="Storing ../{$root-directory}/{$file-name}-TEI.xml"/>
  
  <p:xslt name="grouping-entries-by-letter" message="grouping-entries-by-letter">
   <p:with-input port="stylesheet" href="../Xslt/TEI-group-entries-by-letter.xsl"/>
  </p:xslt>
  
  <p:xslt name="cleaning-entries-1" message="cleaning-entries 1st time">
   <p:with-input port="stylesheet" href="../Xslt/TEI-cleanning-entries.xsl"/>
  </p:xslt>
  
  <p:xslt name="cleaning-entries" message="cleaning-entries 2nd time">
   <p:with-input port="stylesheet" href="../Xslt/TEI-cleanning-entries.xsl"/>
  </p:xslt>

 </p:declare-step>
 
</p:library>
