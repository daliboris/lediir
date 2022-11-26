<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:dlb="https://www.daliboris.cz/ns/xproc/"
	version="3.0"
	name="resources">
 
 <p:option name="source-lang" static="true"/>
 
 <p:documentation>Slučuje nově vygenerované zdrojové soubory (překlady) s těmi, které existují ve zdrojových kódech webové aplikace.</p:documentation>
 
 <p:input port="source" primary="true">
  <p:documentation>Prázdný vstup, který slouží k tomu, aby se spustila iterace.</p:documentation>
  <p:inline><root /></p:inline>
 </p:input>
 <p:output port="result" serialization="map{'indent' : true()}" sequence="true" />
 
 <p:declare-step name="merging" type="dlb:merging-resources">
  <p:input port="source" primary="true" sequence="true" />
  <p:output port="result" serialization="map{'method': 'json', 'indent' : true()}" />
  <p:option name="language" />
  
  <p:json-merge duplicates="use-last" message="JSON merge for {$language}">
   <p:with-input>
    <p:document href="../../web-app/resources/i18n/app/{$language}.json" />
    <p:document href="../Dictionary/resources/i18n/app/{$language}.json" />
   </p:with-input>
  </p:json-merge>
  <p:store href="../../web-app/resources/i18n/app/{$language}.json" message="storing {$language}.json in resources/i18n/app"  />
 </p:declare-step>
 
 <p:for-each name="languages">
  <p:with-input select="('cs', 'en', 'fa')"/>
  <p:variable name="language" select="." />
  <dlb:merging-resources p:message="Merging: {$language}">
   <p:with-option name="language" select="$language" />
  </dlb:merging-resources>
 </p:for-each>

 <p:identity>
  <p:with-input pipe="source@resources" />
 </p:identity>

</p:declare-step>
