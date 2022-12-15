<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs xd"
 version="2.0">
 
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Dec 1, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p>Úvodní část (hlavička, <xd:b>teiHeader</xd:b>) s metadady o projektu a jednotlivých slovnících.</xd:p>
   <xd:p>Obsahuje všechny oddíly, které se zobrazí jako doprovodné texty ve webové aplikaci, např. <xd:i>O projektu</xd:i>, <xd:i>Jak citovat</xd:i> ap.</xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:template name="front">
  <tei:front>
   <xsl:call-template name="front-content"/>
  </tei:front>
 </xsl:template>
 
 <xsl:template name="front-content">
  <tei:div xml:lang="cs-CZ" xml:id="project-about">
   <tei:head>O projektu</tei:head>
   <tei:div xml:id="project-head">
    <tei:head>Elektronická lexikální databáze indoíránských jazyků, persko-český modul</tei:head>
    <tei:p>Copyright © 2022, Sociologický ústav AV ČR, Filozofická fakulta UK</tei:p>
    <tei:p>Autorský tým: SOÚ AV ČR: Darina Vystrčilová, Mona Khademi, Radka Taucová,<tei:lb/> FF UK: Zuzana Kříhová, Ľubomír Novák, Bořivoj Nachtmann</tei:p>
    <tei:p>Jazykové korektury češtiny: Kristýna Přibylová</tei:p>
    <tei:p>Odborný konzultant: Michal Škrabal</tei:p>
    <tei:p>Technická spolupráce: Boris Lehečka, Milan Paučula</tei:p>
    <tei:p>Vytvoření jazykových korpusů <tei:hi rend="italic">Araneum Persicum</tei:hi>: Vladimír Benko</tei:p>
    <tei:p>Další spolupráce: Peter Fajnor, Martina Hartmannová, Filip Lachmann, Zuzana Řezníčková, Martin Vávra</tei:p>
    <tei:p>Lexikální databáze je zpracovávána v programu <tei:ref target="https://software.sil.org/fieldworks">FLEx</tei:ref> (FieldWorks Language Explorer) společnosti <tei:ref target="https://www.sil.org/">SIL International</tei:ref>.</tei:p>
   </tei:div>
  </tei:div>
  <tei:div xml:id="project-how-to-cite">
   <tei:head>Jak citovat</tei:head>
   <tei:p>Darina Vystrčilová, Mona Khademi, Zuzana Kříhová et al.: Elektronická lexikální databáze indoíránských jazyků, persko-český modul. Praha 2022. Verze dat: 2022-11-01. Dostupné z WWW: <tei:xr>&lt;<tei:ref target="https://eldi.soc.cas.cz">https://eldi.soc.cas.cz</tei:ref>&gt;</tei:xr>
   </tei:p>
  </tei:div>
  <tei:div xml:id="project-help">
   <tei:head>Nápověda</tei:head>
   <tei:p>Nápověda k ovládání webové aplikace.</tei:p>
  </tei:div>
  <tei:div xml:id="project-news">
   <tei:head>Aktuality</tei:head>
   <tei:div>
    <tei:head>Spuštění beta-verze</tei:head>
    <tei:p>Beta-verze webového slovníku byla spuštěna na 6. 12. 2021.</tei:p>
   </tei:div>
  </tei:div>
  <tei:div xml:id="project-about-language">
   <tei:head>O jazyce</tei:head>
   <tei:p>Informace o perštině a dalších jazycích.</tei:p>
  </tei:div>
 </xsl:template>
 
</xsl:stylesheet>