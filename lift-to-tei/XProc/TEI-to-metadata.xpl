<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" version="3.0">
  
  
	<p:option name="root-directory" static="true"/>
	<p:option name="file-name" static="true"/>
	<p:option name="project-acronym" static="true" />
	<p:option name="source-lang" static="true"/>
	
	<p:option name="dictionary-id" select="concat(upper-case($source-lang), 'CS')" static="true" />
	<p:option name="dictionary-acronym" select="concat($project-acronym, '-', $dictionary-id)" static="true" />
   
  <p:input port="source" primary="true">
  	<p:document href="../Dictionary/{$dictionary-acronym}.xml" />
  </p:input>
   
	<p:output port="result" serialization="map{'indent' : true()}" />
	
	<p:xslt>
		<p:with-input port="stylesheet" href="../Xslt/tei-to-metadata.xsl" />
	</p:xslt>
	
	
	<p:store href="../Dictionary/metadata/{$dictionary-acronym}-metadata.xml" serialization="map{'indent' : true()}" message="Storing text to ..../Dictionary/metadata/{$dictionary-acronym}-metadata.xml" />
	

</p:declare-step>
