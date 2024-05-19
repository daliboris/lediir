<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:tei = "http://www.tei-c.org/ns/1.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" version="3.0">

 <p:documentation>Procedura, která vygeneruje grafické soubory pro frekvenční údaje o výskytu heslovného slova, a to na základě dat v aktuální verzi slovníku.</p:documentation>

 <p:option name="source-lang" static="true"/>

	<p:output port="result" serialization="map{'indent' : true()}">
	 <p:documentation>Výstupní informace o počtu vytvořených grafických souborů SVG.</p:documentation>
	</p:output>
	
 <p:input port="source" primary="true" href="../Dictionary/LeDIIR-{upper-case($source-lang)}CS.xml">
  <p:documentation>Vstupní dokument, který obsahuje slovníková data ve formátu TEI Lex-0.</p:documentation>
 </p:input>
 
 <p:xquery>
  <p:with-input port="query" href="../XQuery/TEI-frequencies-statistics.xquery"/>
 </p:xquery>

  
 <p:store href="../temp/frequencies.xml" serialization="map{'indent' : true()}"/>
 
 <p:xslt>
  <p:with-input port="stylesheet" href="../Xslt/Frequency-statistics.xsl" />
 </p:xslt>
 
 <p:store href="../temp/FA-CS-frekvence.html" serialization="map{'indent' : true()}"/>

 <p:count />

</p:declare-step>
