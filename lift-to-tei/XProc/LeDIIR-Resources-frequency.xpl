<p:declare-step xmlns:p="http://www.w3.org/ns/xproc" 
 xmlns:tei = "http://www.tei-c.org/ns/1.0"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" version="3.0">
            
	<p:output port="result" serialization="map{'indent' : true()}" />
	
	<p:input port="source" primary="true" href="../testy/Ukazka/2022-10-05/LeDIIR-FACS.xml" />
 
 <p:xquery >
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
  
  <p:store href="../testy/Ukazka/2022-10-05/resources/images/frequency/{$value}.svg" />
  
 </p:for-each>

 <p:count />

</p:declare-step>
