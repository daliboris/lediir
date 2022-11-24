<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Nov 23, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="xml" indent="yes" encoding="UTF-8" />
 <xsl:mode on-no-match="shallow-copy"/>
 
 <xd:doc>
  <xd:desc>
   <xd:p>Odstranění významů, které neobsahují definici významu (ekvivalent)</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:sense[not(tei:def) and not(tei:xr | tei:usg)]" />
 
 
 <xd:doc>
  <xd:desc>
   <xd:p>Odstranění dokladů, které neobsahují ekvivalent.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="//tei:entry/tei:sense/tei:quote" />
 
 <xd:doc>
  <xd:desc>
   <xd:p>Odstranění heslových statí, které žádné údaje (nejspíš problém exportu; TODO).</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:entry[not(*)]" />
 
 <xd:doc>
  <xd:desc>
   <xd:p>Špatně zpracované heslové stati; chybně vygenerované heslové slovo. TODO</xd:p>
  </xd:desc>
 </xd:doc>
<!-- <xsl:template match="tei:div[tei:head = ('k', 'n', 'p', 'ء')]" />-->
 
 
 <xd:doc>
  <xd:desc>
   <xd:p>Poznámky o zdroji ctivaného dokladu. Momentálně jsou zpracovány nejednotně, např.</xd:p>
   <xd:ul>
    <xd:li>{https://wikijoo.ir}</xd:li>
    <xd:li>https://fa.wikipedia.org</xd:li>
    <xd:li>{Mahmúd Doulatábádí: Kolonel}</xd:li>
   </xd:ul>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:note[@type='reference']" priority="3" />
 
 
 <xd:doc>
  <xd:desc>
   <xd:p>Poznámky uváděné v heslové stati. Obvykle obsahují poznámky k prameni, ale nejen.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:note" />
 
 <!--
  <ref target="#FACS.a4f178e4-fe54-4351-96ea-a5f103f34a7f" type="entry"/>
 -->
 <xsl:template match="tei:xr/tei:ref[not(node())][@target='#FACS.']" />
 
 <xd:doc>
  <xd:desc>
   <xd:p>Skupina odkazů bez odkazových hesel.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:xr[not(tei:ref)]" />
 
 <xd:doc>
  <xd:desc>
   <xd:p>Odkazy, které nevedou nikam (hesla ještě nebyla zpracována).</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:xr/tei:ref[not(node())][not(id(substring-after(@target, '#')))]"></xsl:template>
</xsl:stylesheet>