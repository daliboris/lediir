<p:library  xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:xs="http://www.w3.org/2001/XMLSchema" 
 xmlns:err="http://www.w3.org/ns/xproc-error"
 xmlns:c="http://www.w3.org/ns/xproc-step"
 xmlns:ldw="https://www.daliboris.cz/ns/lediir/web"
 xmlns:lds="https://www.daliboris.cz/ns/lediir/settings"
 xmlns:map = "http://www.w3.org/2005/xpath-functions/map"	
 xmlns:html="http://www.w3.org/1999/xhtml"
 version="3.0">
 
 <p:documentation>
  <html:section></html:section>
 </p:documentation>
 
 <p:declare-step type="ldw:build-url" visibility="private">
  <p:input port="source" primary="true" />
  <p:option name="step-name" as="xs:string" required="true" />
  <p:option name="parameters" as="map(xs:string, xs:string)?" required="false" />
  
  <p:output port="result" primary="true" />
  
  <p:variable name="step" select="/*/lds:step[@name=$step-name]" />
  
  <p:variable name="settings-parameters" select="map:merge( for $par in $step/lds:parameter[@place='url'] return map {$par/@name/data() : $par/@value/data()})" />
  <p:variable name="final-parameters" select="if(empty($settings-parameters))
   then $parameters 
   else 
   if(empty($parameters)) 
   then $settings-parameters
   else map:merge(($parameters, $settings-parameters))" /> 
  <!-- 
				odpovídá specifikaci map:merge; 
				konečné hodnoty (v případě duplicitního klíče) se berou z první mapy 
				(viz https://www.w3.org/TR/xpath-functions-31/#func-map-merge: Default: use-first)
				Tvrzení z XQuery Second Edition není pravdivé: 
				If there are any duplicate keys among them, the value for that key is taken from $deptnames2 because it is specified last. 
		-->
  
  <p:variable name="base-url" select="/*/@url" />
  <p:variable name="url" select="concat($base-url, $step/@url)" />
  
  <p:identity message="step-name: {$step-name}; URL: {$url}; parameters: {empty($parameters)}; settings-parameters: {empty($settings-parameters)}; final-parameters: {empty($final-parameters)}" use-when="false()" />
  
  <p:variable name="final-url" select="if(empty($final-parameters)) 
   then $url 
   else
   fold-left(map:keys($final-parameters), $url, function($input, $key) {
   replace($input, concat('\[\[', $key, '\]\]'), $final-parameters?($key))
   })
   " />
  
  <!-- message="ldw:build-url; parameters : {if(empty($parameters)) then () else map:for-each($parameters, function($k, $v) {$k || '=' || $v })} URL: {$url}; step-name: {$step-name}; final: {$final-url}" -->
  <p:identity>
   <p:with-input port="source">
    <p:inline content-type="text/plain">{$final-url}</p:inline>
   </p:with-input>
  </p:identity>
  
 </p:declare-step>
 
 <p:declare-step type="ldw:login">
  <p:input port="source" primary="true">
   <p:documentation>Element typu lds:*, který obsahsuje podřízený prvek lds:login s přihlašovacími údaji</p:documentation>
  </p:input>
  <p:output port="report" primary="false" pipe="report@request" />
  <p:output port="result" primary="true" pipe="result@request" />
  
  <p:variable name="login" select="/*/lds:login" />
  <p:variable name="url" select="concat(/*/@url, $login/@url)" />
  <p:variable name="credentials" select="concat('user=',
   $login/lds:username,
   '&amp;',
   'password=',
   $login/lds:password)"></p:variable>
  
  <p:http-request href="{$url}" method="POST" 
   headers="map { 'content-type' : 'application/x-www-form-urlencoded' }"
   name="request">
   <p:with-input port="source">
    <p:inline content-type="plain/text">{$credentials}</p:inline>
   </p:with-input>
  </p:http-request>
 </p:declare-step>
 
 <p:declare-step type="ldw:generate-odd" name="generating-odd">
  
  <p:input port="source" primary="true"  />
  <p:input port="settings" primary="false" />
  <p:option name="parameters" as="map(xs:string, xs:string)?" required="false" />
  
  <p:output port="report" primary="false" pipe="report@request" />
  <p:output port="result" primary="true" pipe="result@request" />
  
  <ldw:build-url step-name="generate-odd" name="building-url" parameters="$parameters">
   <p:with-input port="source" pipe="settings@generating-odd" />
  </ldw:build-url>
  
  <p:variable name="url" select="/" pipe="result@building-url" />
  <p:http-request href="{$url}" method="POST" name="request" />
 </p:declare-step>
 
 <p:declare-step type="ldw:clean-collection" name="cleaning-collection">
  <p:input port="source" primary="true"  />
  <p:input port="settings" primary="false" />
  <p:option name="parameters" as="map(xs:string, xs:string)?" required="false" />
  
  <p:output port="report" primary="false" pipe="report@request" />
  <p:output port="result" primary="true" pipe="result@request" />
  
  <ldw:build-url step-name="clean" name="building-url" parameters="$parameters">
   <p:with-input port="source" pipe="settings@cleaning-collection" />
  </ldw:build-url>
  
  <p:variable name="url" select="/" pipe="result@building-url" />
  
  <p:http-request href="{$url}" 
   method="DELETE" 
   name="request" >
  </p:http-request>
  
 </p:declare-step>
 
 <p:declare-step type="ldw:upload-file" name="uploading-file">
  <p:input port="source" primary="true"  />
  <p:input port="settings" primary="false" />
  <p:option name="parameters" as="map(xs:string, xs:string)?" required="false" />
  
  <p:output port="report" primary="false" pipe="report@request" />
  <p:output port="result" primary="true" pipe="result@request" />
  
  <p:variable name="filename" select="tokenize(base-uri(/), '/')[last()]" />
  <p:variable name="content-description" select="concat('form-data; name=&#34;file&#34;; filename=&#34;', $filename, '&#34;')" />
  <p:set-properties properties="map {
   'Q{http://www.w3.org/ns/xproc-http}file' : $filename,
   'Q{http://www.w3.org/ns/xproc-http}Content-Disposition' : $content-description }"
   merge="true" name="source-for-body"/>
  
  <ldw:build-url step-name="upload" name="building-url" parameters="$parameters">
   <p:with-input port="source" pipe="settings@uploading-file" />
  </ldw:build-url>
  
  <p:variable name="url" select="/" pipe="result@building-url" />
  
  <p:http-request href="{$url}" 
   headers="map { 'content-type' : 'multipart/form-data' }"
   method="POST" 
   name="request" assert=".?status-code lt 500" >
   <p:with-input port="source" pipe="result@source-for-body" />
  </p:http-request>
  
 </p:declare-step>
 
 <p:declare-step type="ldw:get-index-statistics" name="getting-index-statistics">
  <!--<p:input port="source" primary="true"  />-->
  <p:input port="settings" primary="false" />
  <p:option name="parameters" as="map(xs:string, xs:string)?" required="false" />
  
  <!--		<p:output port="report" primary="false" pipe="report@request" />-->
  <p:output port="result" primary="true" pipe="result@request" />
  
  <ldw:build-url step-name="report" name="building-url" parameters="$parameters">
   <p:with-input port="source" pipe="settings@getting-index-statistics" />
  </ldw:build-url>
  
  <p:variable name="url" select="/" pipe="result@building-url" />
  <p:try>
   <p:http-request href="{$url}" method="GET" />
   <p:catch code="err:XC0126">
    <p:identity>
     <p:with-input port="source">
      <p:inline><statistics failed="true"  /></p:inline>
     </p:with-input>
    </p:identity>
   </p:catch>
  </p:try>
  
  <p:identity name="request" />
  
 </p:declare-step>
 
 <p:declare-step type="ldw:summarize-upload-result" name="summarizing-upload-result">
  <p:input port="source" primary="true" />
  <p:input port="settings" primary="false" />
  <p:output port="result" primary="true" />
  <p:option name="href" as="xs:string" required="true" />
  
  <p:delete match="entries/entry" name="summary" />
  
  <ldw:login>
   <p:with-input port="source" pipe="settings@summarizing-upload-result" />
  </ldw:login>
  
  <ldw:get-index-statistics name="statistics">
   <!--<p:with-input port="source" pipe="result@summary" />-->
   <p:with-input port="settings" pipe="settings@summarizing-upload-result" />
  </ldw:get-index-statistics>
  
  <p:insert match="/*" position="last-child">
   <p:with-input port="source" select="/" pipe="result@summary" />
   <p:with-input port="insertion" select="/*" pipe="result@statistics" />
  </p:insert>
  
  <ldw:update-results-report href="{$href}" />	
  
 </p:declare-step>
 
 <p:declare-step type="ldw:update-results-report" name="updating-results-report">
  <p:input port="source" primary="true" />
  <p:option name="href" as="xs:string" required="true" />
  <p:output port="result" primary="true" />
  
  <p:try use-when="true()">
   <p:load href="{$href}" />
   <p:catch code="err:XD0011">
    <p:identity>
     <p:with-input port="source">
      <p:inline><results /></p:inline>
     </p:with-input>
    </p:identity>
   </p:catch>
  </p:try>
  
  
  <p:insert match="/*" position="last-child">
   <p:with-input port="insertion" select="/*" pipe="source@updating-results-report" />
  </p:insert>
  
  <p:store href="{$href}" />
  
 </p:declare-step>
 
 
</p:library>