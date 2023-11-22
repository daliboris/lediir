<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:xi="http://www.w3.org/2001/XInclude/ADD"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:dlb="https://www.daliboris.cz/ns/xproc/"
	version="3.0"
	name="tei-to-divs"
	>
   
  
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
	
	<p:declare-step type="dlb:prepare-tei-header" name="preparing-tei-header">
		<p:input port="source" primary="true" />
		<p:output port="result" serialization="map{'indent' : true()}" />
		
		<p:replace match="tei:body">
			<p:with-input port="replacement">
				<tei:body><tei:p /></tei:body>
			</p:with-input>
		</p:replace>
		
		<p:viewport match="tei:teiHeader">
			<p:add-attribute attribute-name="xml:id" attribute-value="{$dictionary-acronym}-teiHeader" />
		</p:viewport>
		
		<p:viewport match="tei:teiHeader/*">
			<p:variable name="element-name" select="/name(*)" />
			<p:add-attribute attribute-name="xml:id" attribute-value="{$dictionary-id}-{$element-name}" />
		</p:viewport>
		
	</p:declare-step>
	
	<p:declare-step type="dlb:prepare-tei-document" name="preparing-tei-document">
		<p:input port="source" primary="true" />
		<p:input port="teiHeader" />
		<p:output port="result" />
		
		
		<p:variable name="letter" select="/*/tei:head[@type='letter']/data()" />
		<p:variable name="id" select="/*/@xml:id" />
		<p:wrap wrapper="tei:body" match="/" />
		<p:wrap wrapper="tei:text" match="/" />
		<p:wrap wrapper="tei:TEI" match="/" />
		<p:add-attribute attribute-name="type" attribute-value="lex-0" />
		<p:add-attribute attribute-name="xml:id" attribute-value="{$dictionary-id}" />
		<p:add-attribute attribute-name="xml:lang" attribute-value="cs" />
		
		<p:insert position="first-child">
			<p:with-input port="insertion" pipe="teiHeader@preparing-tei-document" />
		</p:insert>
		
		<p:delete match="tei:teiHeader/tei:encodingDesc" />
		
		<p:viewport match="tei:teiHeader/*[not(self::tei:fileDesc)]" use-when="false()">
			<p:variable name="id" select="/*/@xml:id" />
			<p:replace match="/*">
				<p:with-input port="replacement">
					<xi:include href="{$dictionary-acronym}-teiHeader.xml" xpointer="{$id}" />
				</p:with-input>
			</p:replace>
		</p:viewport>
		
		<p:add-attribute match="tei:titleStmt/tei:title" attribute-name="type" attribute-value="main" />
		
		<p:insert match="tei:titleStmt/tei:title" position="after">
			<p:with-input port="insertion" expand-text="true">
				<tei:title type="sub">Písmeno {$letter}</tei:title>
			</p:with-input>
		</p:insert>
		
	</p:declare-step>
	
	
	<!--<p:variable name="teiHeader" select="/tei:TEI/tei:teiHeader" />-->
	
	<p:group use-when="false()">
		<dlb:prepare-tei-header name="teiHeader" />
		<p:store href="../Dictionary/{$dictionary-acronym}-teiHeader.xml" />
		
		<p:viewport match="tei:body/tei:div[@type='letter']">
			<p:with-input pipe="source@tei-to-divs" />
			<p:variable name="id" select="/*/@xml:id" />
			<dlb:prepare-tei-document>
				<p:with-input port="teiHeader" select="/tei:TEI/tei:teiHeader" pipe="result@teiHeader" />
			</dlb:prepare-tei-document>
			
			<p:namespace-rename from="http://www.w3.org/2001/XInclude/ADD" to="http://www.w3.org/2001/XInclude" />
			
			<p:store href="../Dictionary/chapters/{$project-acronym}-{$id}.xml" serialization="map{'indent' : false()}"  message="Storing ../Dictionary/chapters/{$project-acronym}-{$id}.xml"/>
		</p:viewport>
	</p:group>
	
	<p:group use-when="true()">
		<dlb:prepare-tei-header name="teiHeader" />
		<p:viewport match="tei:body/tei:div[@type='letter']">
			<p:with-input pipe="source@tei-to-divs" />
			
			<p:variable name="letter-id" select="/*/@xml:id" />
			<p:variable name="n" select="/*/@n" />
			<p:variable name="head" select="/*/tei:head" />
			<p:viewport match="tei:entry" message="Processing ../Dictionary/entries/{$project-acronym}/{$dictionary-id}/{$letter-id}">
				<p:variable name="xml-id" select="/*/@xml:id" />
				<p:variable name="id" select="concat(format-number(p:iteration-position(), '000000'), '-', $xml-id)" />
								
				<p:wrap wrapper="tei:div" match="/" />
				<p:add-attribute attribute-name="n" attribute-value="{$n}" />
				<p:add-attribute attribute-name="xml:id" attribute-value="{$letter-id}" />
				<p:add-attribute attribute-name="type" attribute-value="letter" />
				<p:insert match="tei:div" position="first-child">
					<p:with-input port="insertion">
						<p:inline>{$head}</p:inline>
					</p:with-input>
				</p:insert>
				
				<dlb:prepare-tei-document>
					<p:with-input port="teiHeader" select="/tei:TEI/tei:teiHeader" pipe="result@teiHeader" />
				</dlb:prepare-tei-document>
				
				
				
				<p:store href="../Dictionary/entries/{$project-acronym}/{$dictionary-id}/{$letter-id}/{$id}.xml" serialization="map{'indent' : false()}" />
			</p:viewport>
		</p:viewport>
	</p:group>
	
	<p:viewport match="tei:div/tei:entry" use-when="false()">
		<p:variable name="id" select="/*/@xml:id" />
		<p:store href="../Dictionary/entries/{$project-acronym}/{$dictionary-id}/{$id}.xml" serialization="map{'indent' : false()}"  message="Storing ../Dictionary/entries/{$project-acronym}/{$dictionary-id}/{$id}.xml"/>
	</p:viewport>
	
	
	<p:count />

</p:declare-step>
