<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	version="3.0">

 <p:documentation>
  Přejmenuje odkazy v souboru LIFT, které jsou v atributu @href elementu range a které odkazují na umístění souboru s příponou .lift-ranges. 
  Využije se v případě, že data pocházejí z jiného počítače, nebo se přesunula do jiné složky.
 </p:documentation>

 <p:option name="root-directory" static="true"  />
 <p:option name="file-name" static="true" />
 
	<p:output port="result" serialization="map{'indent' : true()}" sequence="true" />
	
 <p:directory-list path="../{$root-directory}/" detailed="true" max-depth="1" include-filter="^.*\.lift.*$" />
 
 <p:filter select="c:directory/c:file" />
 

 <p:for-each>
  <p:with-input select="." />
  <p:variable name="name" select="c:file/@name" />
  <p:variable name="base-directory" select="base-uri(c:file/@name)"/>
  <p:variable name="new-name" select="concat($file-name, '.', substring-after($name, '.'))" />
  <p:file-move href="{p:urify(concat('./', $name), $base-directory)}" target="../{$root-directory}/{$new-name}" message="{$base-directory}: {$root-directory}/{$name} >> {$root-directory}/{$new-name}" />
 </p:for-each>
 
 <p:wrap-sequence wrapper="files" />
 
 <p:filter select="files/c:result[ends-with(.,'.lift')]" />

 <p:variable name="file-path" select="data(c:result/.)" />

 <p:load href="{c:result/.}" content-type="application/xml" />
 
 <p:add-attribute match="/lift/header/ranges/range" attribute-name="href" attribute-value="{concat(substring-before($file-path, '.lift'), '.lift-ranges')}" />
 
 <p:store href="{$file-path}" />
 
 <p:identity>
  <p:with-input select="$file-path" />
 </p:identity>
 
</p:declare-step>
