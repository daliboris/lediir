<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema" 
	xmlns:dlb="https://www.daliboris.cz/ns/xproc/"
	version="3.0">

 <p:documentation>
   Slouží k úpravě dokumentu LIFT pro generování mobilní aplikace.
   Vyčistí vstupní soubor od známých chyb a odkazů na nezpracovaná hesla.
   Převede sémantické kategorie na uživatelské pole, aby je bylo možné zobrazit.
 </p:documentation>

 <p:import href="LIFT-Processing.xpl" />
 
 <p:option name="root-directory" static="true"/>
 <p:option name="file-name" static="true"/>
 <p:option name="create-sample" as="xs:boolean" static="true"/>
 <p:option name="source-lang" static="true"/>
 
 <p:option name="testing" select="true()" static="false"  />
 	
 <p:input port="source" primary="true">
  <p:document href="../{$root-directory}/{$file-name}.lift" content-type="text/xml" />
	</p:input>

	<!--<p:output port="result" serialization="map{'indent' : true()}" />-->
	 
	 
 <dlb:clean-raw-data>
  <p:with-option name="root-directory" select="$root-directory" />
  <p:with-option name="file-name" select="$file-name" />
  <p:with-option name="create-sample" select="$create-sample" />
  <p:with-option name="testing" select="$testing" />
 </dlb:clean-raw-data>
 

 <p:xslt name="adding-domain-as-custom-field" message="adding-domain-as-custom-field">
  <p:with-input port="stylesheet" href="../Xslt/LIFT-ad-domain-as-custom-field.xsl" />
 </p:xslt>
 
 <p:store href="../{$root-directory}/{$file-name}-mobile.lift" serialization="map{'indent' : true()}" message="Saving ../{$root-directory}/{$file-name}-mobile.lift"/>
 <p:store href="../Dictionary/LeDIIR-{upper-case($source-lang)}CS-mobile.lift" serialization="map{'indent' : true()}" message="Saving ../Dictionary/LeDIIR-{upper-case($source-lang)}CS-mobile.lift"/>
 
</p:declare-step>
