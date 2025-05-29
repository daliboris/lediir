<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="3.0">
	
	<p:option name="root-directory" static="true"/>
	<p:option name="file-name" static="true"/>
	<p:option name="flex-file-path" static="true"/>
	
	<p:input port="source" primary="true">
		<p:document href="{$flex-file-path}" content-type="text/xml"/>
	</p:input>
	<p:output port="result" sequence="true"/>
	
	<p:store href="../{$root-directory}/data/pes-ces-flex.fwdata" serialization="map{'indent' : false()}" message="Storing original data to ../{$root-directory}/data/pes-ces-flex.fwdata"/>
	
	<p:xslt>
		<p:with-input port="stylesheet" href="../Xslt/FWDATA-Fix-xml.xsl"/>
	</p:xslt>
	
	<p:store href="../{$root-directory}/data/pes-ces-flex-clean.fwdata" serialization="map{'indent' : false()}" message="Storing text to ../{$root-directory}/data/pes-ces-flex-clean.fwdata"/>
	
	<p:file-copy href="../{$root-directory}/data/pes-ces-flex-clean.fwdata" target="{$flex-file-path}" message="Storing text to original path {$flex-file-path}"/>
	<!--<p:store href="{$flex-file-path}" serialization="map{'indent' : false()}" message="Storing text to original path {$flex-file-path}" />-->
	<!--<p:sink message="Done."/>-->
</p:declare-step>
