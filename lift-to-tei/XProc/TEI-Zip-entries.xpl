<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xdp="https://www.daliboris.cz/ns/xproc/drama"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xi = "http://www.w3.org/2001/XInclude"
 xmlns:c="http://www.w3.org/ns/xproc-step"
 xmlns:xld="https://eldi.soc.cas.cz/ns/xproc"
 version="3.0">

 <p:option name="testing" static="true" />
 
 <p:option name="project-acronym" static="true" />
 <p:option name="source-lang" static="true"/>
 
 <p:option name="dictionary-id" select="concat(upper-case($source-lang), 'CS')" static="true" />
 <p:option name="dictionary-acronym" select="concat($project-acronym, '-', $dictionary-id)" static="true" />
 
 
 <p:output port="result" primary="true" serialization="map{'indent' : true()}"  sequence="true" />
<!-- <p:output port="result" serialization="map{'indent' : true()}"  />-->
 
 
 <!--
 <p:variable name="filter" select="concat($project-acronym, '-', $dictionary-id, '\.div.*\.xml')" />

 
 <p:directory-list path="../Dictionary/" include-filter="{$filter}" message="{$filter}" />
 -->
 
 <p:declare-step type="xld:zip-directory">
  <p:option name="input-path" as="xs:string" />
  <p:option name="filter" as="xs:string" />
  <p:option name="output-path" as="xs:string" />
  
  <p:output port="result" pipe="report@archive" primary="true" serialization="map{'indent' : true()}"  />
  
  <p:directory-list path="{$input-path}/" include-filter="{$filter}" message="Path: {$input-path}/; Filter: {$filter}" max-depth="1" />
  
  <p:variable name="root-directory" select="/c:directory/@name" />

  <p:store href="../temp/zip-directory-{$root-directory}.xml" use-when="$testing"/>
  

  <p:xslt name="manifest" >
   <p:with-input port="stylesheet" href="../Xslt/archive-directory-to-manifest.xsl" />
   <p:with-option name="parameters" select="map{
    'root' : concat($project-acronym, '/', $dictionary-id, '/')}" />
  </p:xslt>
  
  <p:store href="../temp/zip-directory-{$root-directory}-manifest.xml" use-when="$testing"/>
  
  <p:archive name="archive" relative-to="../Dictionary/entries/{$project-acronym}">
   <p:with-input port="source">
    <p:empty />
   </p:with-input>
   <p:with-input port="manifest" pipe="@manifest"/>
  </p:archive>
  
  <p:store href="{$output-path}/{$project-acronym}-{$dictionary-id}-{$root-directory}.zip" />
  
  
 </p:declare-step>
 
 <p:declare-step type="xld:zip-directories">
  <p:option name="input-path" as="xs:string" />
  <p:option name="filter" as="xs:string" />
  <p:option name="output-path" as="xs:string" />
  
  <p:output port="result" primary="true" serialization="map{'indent' : true()}" sequence="true"  />
  
  <p:directory-list path="{$input-path}/" message="Path: {$input-path}/; Filter: {$filter}" max-depth="1" />
  
  <p:store href="../temp/zip-directories.xml" use-when="$testing"/>
  
  <p:for-each>
   <p:with-input select="/c:directory//c:directory"/>
   <p:variable name="dir-name" select="/c:directory/@name" />
   <xld:zip-directory filter="{$filter}" input-path="{$input-path}/{$dir-name}" output-path="{$output-path}" />
  </p:for-each>
  
  <!--<p:count />-->
  
 </p:declare-step>
 
 <p:declare-step type="xld:zip-full-content">
  <p:option name="output-path" as="xs:string" />
  
  <p:output port="result" pipe="report@archive" serialization="map{'indent' : true()}"  />
  
  <p:variable name="filter" select="concat($dictionary-id, '.*\.xml')" />
  <p:directory-list path="../Dictionary/entries/{$project-acronym}/{$dictionary-id}/" include-filter="{$filter}" message="Path: ../Dictionary/entries/{$project-acronym}/{$dictionary-id}/; Filter: {$filter}" max-depth="3" />
  
  <p:store href="../temp/zip-full-content.xml" serialization="map{'indent' : true()}" use-when="$testing" />
  
  <p:xslt name="manifest" >
   <p:with-input port="stylesheet" href="../Xslt/archive-directory-to-manifest.xsl" />
   <p:with-option name="parameters" select="map{
    'root' : concat($project-acronym, '/', $dictionary-id, '/')}" />
  </p:xslt>
  
  <p:store href="../temp/zip-full-content-manifest.xml" serialization="map{'indent' : true()}" use-when="$testing" />
  
  <p:variable name="time" select="substring-before(current-dateTime() => string(), '.') => replace(':', '-')" />

  <p:archive name="archive" relative-to="../Dictionary/entries/{$project-acronym}">
   <p:with-input port="source">
    <p:empty />
   </p:with-input>
   <p:with-input port="manifest" pipe="@manifest"/>
  </p:archive>
  
  <p:store href="{$output-path}/{$project-acronym}-{$dictionary-id}-{$time}.zip" />
  
  <p:count />
  
 </p:declare-step>
 
 <xld:zip-full-content output-path="../Dictionary/Zip" />
 <xld:zip-directories input-path="../Dictionary/entries/{$project-acronym}/{$dictionary-id}" filter=".*\.xml" output-path="../Dictionary/Zip"/>
 
</p:declare-step>
