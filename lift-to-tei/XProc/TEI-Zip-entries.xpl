<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:xdp="https://www.daliboris.cz/ns/xproc/drama"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xi = "http://www.w3.org/2001/XInclude"
 xmlns:c="http://www.w3.org/ns/xproc-step"
 version="3.0">

 <p:option name="project-acronym" static="true" />
 <p:option name="source-lang" static="true"/>
 
 <p:option name="dictionary-id" select="concat(upper-case($source-lang), 'CS')" static="true" />
 <p:option name="dictionary-acronym" select="concat($project-acronym, '-', $dictionary-id)" static="true" />
 
 
 <p:output port="result" pipe="report@archive" serialization="map{'indent' : true()}"  />
<!-- <p:output port="result" serialization="map{'indent' : true()}"  />-->
 
 
 <!--
 <p:variable name="filter" select="concat($project-acronym, '-', $dictionary-id, '\.div.*\.xml')" />

 
 <p:directory-list path="../Dictionary/" include-filter="{$filter}" message="{$filter}" />
 -->
 <p:variable name="filter" select="concat($dictionary-id, '.*\.xml')" />
 <p:directory-list path="../Dictionary/entries/{$project-acronym}/{$dictionary-id}/" include-filter="{$filter}" message="Path: ../Dictionary/entries/{$project-acronym}/{$dictionary-id}/; Filter: {$filter}" max-depth="3" />
 <p:store href="../Dictionary/directory-list.xml" serialization="map{'indent' : true()}" />
 <p:xslt name="manifest" >
  <p:with-input port="stylesheet" href="../Xslt/archive-directory-to-manifest.xsl" />
  <p:with-option name="parameters" select="map{
   'root' : concat($project-acronym, '/', $dictionary-id, '/')}" />
 </p:xslt>
 
 <p:store href="../Dictionary/archive-directory-list.xml" serialization="map{'indent' : true()}" />
 <!-- 
 <c:archive>
  <c:entry name="a" href ="" comment="?" method = "?" level = "?" />
 </c:archive>
 -->
 
 <p:variable name="time" select="substring-before(current-dateTime() => string(), '.') => replace(':', '-')" />
 
<!-- <p:group use-when="true()">-->
  <p:archive name="archive" relative-to="../Dictionary/entries/{$project-acronym}">
   <p:with-input port="source">
    <p:empty />
   </p:with-input>
   <p:with-input port="manifest" pipe="@manifest"/>
  </p:archive>
  
  <p:store href="../Dictionary/{$project-acronym}-{$dictionary-id}-{$time}.zip" />
  
 <!--</p:group>-->
 <p:count />

</p:declare-step>
