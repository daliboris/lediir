<p:declare-step 
	xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:err="http://www.w3.org/ns/xproc-error"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:ldw="https://www.daliboris.cz/ns/lediir/web"
	xmlns:lds="https://www.daliboris.cz/ns/lediir/settings"
	xmlns:map = "http://www.w3.org/2005/xpath-functions/map"	
	version="3.0" name="lediir-management">

	<p:import href="LeDIIR-management.xpl" />

	<p:input port="source" primary="true" href="local.settings.xml" />
	<p:output port="result" primary="true" serialization="map{'indent' : true()}" />
	<p:option name="dictionary-directory" select="'../../lift-to-tei/Dictionary'" />
	<p:option name="report-directory" select="'../report'" />
	<p:option name="profile" select="'remote'" values="('local', 'remote')" as="xs:string"/>
	<p:option name="steps" select="('metadata')" values="('statistics', 'clean', 'metadata', 'data-selected', 'data-all', 'data-all-in-one', 'all')" as="xs:string*" />
	<p:option name="data-selected" select="('00033', '00042')" as="xs:string*" />
	<p:option name="report-filename" select="concat('upload-data-', $profile, '-report-2024-06-23.xml')" />
	<p:option name="all-in-one-filename" select="'LeDIIR-FACS-2024-06-19T23-14-57.zip'" />
	
	<p:declare-step type="ldw:upload-dictionary-metadata" name="uploading-dictionary-metadata">
		<p:input port="settings" primary="false" />
		<p:output port="result" primary="true" />
		<p:option name="dictionary-directory"  required="true" />
		<p:option name="report-directory" required="true" />
		<p:option name="report-filename" required="true" />
		
		<p:load	href="{$dictionary-directory}/about/LeDIIR-FACS-about.xml" /> 
		<ldw:upload-file parameters="map {'collection' : 'about'}" p:message="Uploading about file">
			<p:with-input port="settings" pipe="settings@uploading-dictionary-metadata" />
		</ldw:upload-file>
		
		<ldw:summarize-upload-result href="{$report-directory}/{$report-filename}">
			<p:with-input port="settings" pipe="settings@uploading-dictionary-metadata" />
		</ldw:summarize-upload-result>
		
		<p:load	href="{$dictionary-directory}/metadata/LeDIIR-FACS-metadata.xml" />
		<ldw:upload-file parameters="map {'collection' : 'metadata'}" p:message="Uploading metadata file">
			<p:with-input port="settings" pipe="settings@uploading-dictionary-metadata" />
		</ldw:upload-file>
		<ldw:summarize-upload-result href="{$report-directory}/{$report-filename}">
			<p:with-input port="settings" pipe="settings@uploading-dictionary-metadata" />
		</ldw:summarize-upload-result>
		
	</p:declare-step>


	<p:group use-when="true()" message="Uploading dictionaries data ({$profile}); steps: {string-join($steps, ', ')}">
		<p:filter select="/lds:settings/lds:data[@profile='{$profile}']" name="target-data">
			<p:with-input port="source" pipe="source@lediir-management" />
		</p:filter>
		<ldw:login />
		
		<p:if test="$steps = ('statistics', 'all')">
			<ldw:get-index-statistics>
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:get-index-statistics>
			<ldw:update-results-report href="{$report-directory}/{$report-filename}" />
		</p:if>
		
		<p:if test="$steps = ('clean', 'all')">
			<ldw:clean-collection>
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:clean-collection>
			<ldw:get-index-statistics name="statistics">
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:get-index-statistics>
		</p:if>
		
		<p:if test="$steps = ('metadata', 'all')">
			<ldw:upload-dictionary-metadata 
				dictionary-directory="{$dictionary-directory}" 
				report-directory="{$report-directory}"
				report-filename="{$report-filename}">
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:upload-dictionary-metadata>
		</p:if>
		
		<p:if test="$steps = ('data-selected', 'all')">
			<p:for-each>
				<p:with-input select="for $i in $data-selected return $i"/>
				<p:variable name="div-id" select="." />
				<ldw:login >
					<p:with-input port="source" pipe="result@target-data" />
				</ldw:login>
				<p:load	href="{$dictionary-directory}/Zip/LeDIIR-FACS-FACS.div.{$div-id}.zip" message="Loading div {$div-id}" /> 
				<ldw:upload-file name="upload">
					<p:with-input port="settings" pipe="result@target-data" />
				</ldw:upload-file>
				
				<ldw:summarize-upload-result href="{$report-directory}/{$report-filename}">
					<p:with-input port="settings" pipe="result@target-data" />
				</ldw:summarize-upload-result>
				
			</p:for-each>
			
			<p:count />
		</p:if>
		
		<p:if test="$steps = ('data-all', 'all')">
			<p:variable name="input-directory" select="concat($dictionary-directory, '/Zip/')" />
			<p:directory-list path="{$input-directory}" include-filter="LeDIIR-FACS-FACS\.div\.\d+\.zip"/>
			<p:for-each>
				<p:with-input select="//c:file"/>
				<p:variable name="filename" select="/*/@name"/>
				
				<ldw:login >
					<p:with-input port="source" pipe="result@target-data" />
				</ldw:login>
				
				<p:load href="{$input-directory}/{$filename}" message="Loading {$filename}"/>
				
				<ldw:upload-file name="upload" p:message="Uploading {$filename}">
					<p:with-input port="settings" pipe="result@target-data" />
				</ldw:upload-file>
				
				<ldw:summarize-upload-result href="{$report-directory}/{$report-filename}">
					<p:with-input port="settings" pipe="result@target-data" />
				</ldw:summarize-upload-result>
				
			</p:for-each>
			<p:count />
		</p:if>
		
		<p:if test="$steps = ('data-all-in-one')">
			<p:variable name="filename" select="$all-in-one-filename" />
			<p:load	href="{$dictionary-directory}/Zip/{$filename}" message="Loading {$filename}"/> 

			<ldw:upload-file p:message="Uploading {$filename}">
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:upload-file>

			<ldw:summarize-upload-result href="{$report-directory}/{$report-filename}">
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:summarize-upload-result>
		
		</p:if>

		<p:if test="$steps = ('statistics', 'all') and $steps != ('statistics')">
			<ldw:get-index-statistics>
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:get-index-statistics>
			<ldw:update-results-report href="{$report-directory}/{$report-filename}" />
		</p:if>
		
		<p:identity message="Finishing">
			<p:with-input port="source">
				<p:inline content-type="text/plain">Upload process finished</p:inline>
			</p:with-input>
		</p:identity>

	</p:group>
	
	<p:group use-when="false()" message="Generating ODD">
		<p:filter select="/lds:settings/lds:web" name="target-web">
			<p:with-input port="source" pipe="source@lediir-management" />
		</p:filter>
		
		<ldw:login />
		
		<ldw:generate-odd parameters="map {'odd' : 'lediir.odd'}">
			<p:with-input port="settings" pipe="result@target-web" />
		</ldw:generate-odd>
	</p:group>
	
	<p:group use-when="false()" message="Uploading collection.xconf (local)">
		<p:filter select="/lds:settings/lds:data-admin" name="target-data-admin">
			<p:with-input port="source" pipe="source@lediir-management" />
		</p:filter>
		<ldw:login />
		<p:load	href="../../../lediir-web-data/data/dictionaries/collection.xconf" />
		<ldw:upload-file parameters=" map {'collection' : '/db/system/config/db/apps/lediir-data/data/dictionaries'}">
			<p:with-input port="settings" pipe="result@target-data-admin" />
		</ldw:upload-file>
	</p:group>

	<p:group use-when="false()" message="Uploading dictionaries data (local)">
		<p:filter select="/lds:settings/lds:data[@profile='local']" name="target-data">
			<p:with-input port="source" pipe="source@lediir-management" />
		</p:filter>
		<ldw:login />
		
		<p:group use-when="false()" message="Cleaning dictionary collection">
			<ldw:clean-collection>
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:clean-collection>
			<ldw:get-index-statistics name="statistics">
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:get-index-statistics>
		</p:group>
		
		<p:group use-when="true()" message="Uploading metadata">
			
			<ldw:upload-dictionary-metadata 
				dictionary-directory="{$dictionary-directory}" 
				report-directory="{$report-directory}"
				report-filename="{$report-filename}">
				<p:with-input port="settings" pipe="result@target-data" />
			</ldw:upload-dictionary-metadata>
		
		</p:group>
		
		<p:group use-when="false()" message="Upload all directories (locally)">
			<p:variable name="input-directory" select="concat({$dictionary-directory}, '/Zip/'" />
			<p:directory-list path="{$input-directory}" include-filter="LeDIIR-FACS-FACS\.div\.\d+\.zip"/>
			<p:for-each>
				<p:with-input select="//c:file"/>
				<p:variable name="filename" select="/*/@name"/>
				
				<ldw:login >
					<p:with-input port="source" pipe="result@target-data" />
				</ldw:login>
				
				<p:load href="{$input-directory}/{$filename}" message="Loading {$filename}"/>
				
				<ldw:upload-file name="upload" message="Uploading {$filename}">
					<p:with-input port="settings" pipe="result@target-data" />
				</ldw:upload-file>
				
				<ldw:summarize-upload-result href="{$report-directory}/{$report-filename}">
					<p:with-input port="settings" pipe="result@target-data" />
				</ldw:summarize-upload-result>
				
			</p:for-each>
			<p:count />
		</p:group>
		
		<p:group use-when="false()" message="Upload selected directories">
			<!-- ('00033', '00042', '00061', '00097', '00070') -->
			<p:variable name="data-selected" select="('00033', '00042')" />
			<p:for-each>
				<p:with-input select="for $i in $data-selected return $i"/>
				<p:variable name="div-id" select="." />
				<ldw:login >
					<p:with-input port="source" pipe="result@target-data" />
				</ldw:login>
				<p:load	href="{$dictionary-directory}/Zip/LeDIIR-FACS-FACS.div.{$div-id}.zip" message="Loading div {$div-id}" /> 
				<ldw:upload-file name="upload">
					<p:with-input port="settings" pipe="result@target-data" />
				</ldw:upload-file>
				
				<ldw:summarize-upload-result href="{$report-directory}/{$report-filename}">
					<p:with-input port="settings" pipe="result@target-data" />
				</ldw:summarize-upload-result>
				
			</p:for-each>
			
			<p:count />
			
		</p:group>

	</p:group>
 
	<p:group use-when="false()" message="Uploading dictionaries data (remote)">
		<p:filter select="/lds:settings/lds:data[@profile='remote']" name="target-data-remote">
			<p:with-input port="source" pipe="source@lediir-management" />
		</p:filter>
		<ldw:login />
		
		<p:group use-when="false()" message="Get index statistics">
			<ldw:get-index-statistics>
				<p:with-input port="source" pipe="result@target-data-remote" >
				</p:with-input>
				<p:with-input port="settings" pipe="result@target-data-remote" />
			</ldw:get-index-statistics>
		</p:group>
		
		<p:group use-when="true()" message="Uploading dictionary metadata">
			
			<ldw:upload-dictionary-metadata 
				dictionary-directory="{$dictionary-directory}" 
				report-directory="{$report-directory}"
				report-filename="{$report-filename}">
				<p:with-input port="settings" pipe="result@target-data-remote" />
			</ldw:upload-dictionary-metadata>
			
			<!--<p:load	href="{$dictionary-directory}/LeDIIR-FACS-about.xml" /> 
			<ldw:upload-file parameters="map {'collection' : 'about'}">
				<p:with-input port="settings" pipe="result@target-data-remote" />
			</ldw:upload-file>
			
			<ldw:summarize-upload-result href="{$report-directory}/{$report-filename}">
				<p:with-input port="settings" pipe="result@target-data-remote" />
			</ldw:summarize-upload-result>
			
			<p:load	href="{$dictionary-directory}/metadata/LeDIIR-FACS-metadata.xml" />
			<ldw:upload-file parameters="map {'collection' : 'metadata'}">
				<p:with-input port="settings" pipe="result@target-data-remote" />
			</ldw:upload-file>-->
			
		</p:group>
		
		<p:group use-when="false()" message="Upload selected directories">
			<p:variable name="data-selected" select="('00033', '00042')" />
			<p:for-each>
				<p:with-input select="for $i in $data-selected return $i"/>
				<p:variable name="div-id" select="." />
				<ldw:login >
					<p:with-input port="source" pipe="result@target-data-remote" />
				</ldw:login>
				<p:load	href="{$dictionary-directory}/Zip/LeDIIR-FACS-FACS.div.{$div-id}.zip" message="Loading div {$div-id}" /> 
				<ldw:upload-file name="upload">
					<p:with-input port="settings" pipe="result@target-data-remote" />
				</ldw:upload-file>
				
				<ldw:summarize-upload-result href="{$report-directory}/{$report-filename}">
					<p:with-input port="settings" pipe="result@target-data-remote" />
				</ldw:summarize-upload-result>
				
			</p:for-each>
			
			<p:count />
			
		</p:group>
		
		<p:group use-when="false()" message="Upload whole dictionary">
			<p:load	href="{$dictionary-directory}/Zip/LeDIIR-FACS-2024-06-16T19-43-32.zip" /> 
			<ldw:upload-file>
				<p:with-input port="settings" pipe="result@target-data-remote" />
			</ldw:upload-file>
			<ldw:summarize-upload-result name="result" />
			<ldw:login>
				<p:with-input port="source" pipe="result@target-data-remote" />
			</ldw:login>
			<ldw:get-index-statistics name="statistics">
				<p:with-input port="settings" pipe="result@target-data-remote" />
			</ldw:get-index-statistics>
			<p:insert match="/*" position="last-child">
				<p:with-input port="source" select="/" pipe="result@result" />
				<p:with-input port="insertion" select="/*" pipe="result@statistics" />
			</p:insert>
			<ldw:update-results-report href="{$report-directory}/{$report-filename}" />
		</p:group>
		
	</p:group>
 

 
</p:declare-step>
