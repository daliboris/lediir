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
	
	<p:variable name="time" select="substring-before(current-dateTime() => string(), '.') => replace(':', '-')" />
	
	<p:store href="../Dictionary/metadata/{$dictionary-acronym}-metadata.xml" serialization="map{'indent' : true()}" message="Storing text to ..../Dictionary/metadata/{$dictionary-acronym}-metadata.xml" />



	<p:variable name="filter" select="concat($dictionary-acronym, '.*\.xml')" />
	<p:directory-list path="../Dictionary/metadata/" include-filter="{$filter}" message="Path: ../Dictionary/metadata/; Filter: {$filter}" max-depth="3" />
	
	<p:xslt name="manifest" >
		<p:with-input port="stylesheet" href="../Xslt/archive-directory-to-manifest.xsl" />
		<p:with-option name="parameters" select="map{
			'root' : concat('metadata', '/')}" />
	</p:xslt>
	
	<p:archive name="archive" relative-to="../Dictionary/metadata">
		<p:with-input port="source">
			<p:empty />
		</p:with-input>
		<p:with-input port="manifest" pipe="@manifest"/>
	</p:archive>
	
	<p:store href="../Dictionary/{$dictionary-acronym}-metadata.zip" />
	<p:file-copy href="../Dictionary/{$dictionary-acronym}-metadata.zip" target="../Dictionary/{$dictionary-acronym}-metadata-{$time}.zip" />
	

</p:declare-step>
