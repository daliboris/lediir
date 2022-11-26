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
  <p:with-input port="query" href="../XQuery/TEI-frequencies-for-xslt-to-svg.xquery"/>
 </p:xquery>

 <p:for-each>
  <p:with-input select="tei:usg"/>
  <p:variable name="value" select="translate(normalize-space(.), ' ', '-')" />
  <p:xslt message="Frekvence pro {$value}">
   <p:with-input port="stylesheet" href="../Xslt/TEI-to-Frequency.xsl" />
   <p:with-option name="parameters" select="map{
    'frequency-step-width' : '1.5', 
    'frequency-box-width' : '60'
    }"/>
  </p:xslt>
  
  <p:store href="../Dictionary/resources/images/frequency/{$value}.svg" />
  
 </p:for-each>

 <p:count />

</p:declare-step>
