<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	exclude-result-prefixes="xs xd"
	version="3.0">
	
	
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> Dec 1, 2021</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p>Úvodní část (hlavička, <xd:b>teiHeader</xd:b>) s metadady o jednotlivých slovnících.</xd:p>
   <xd:p>Na základě hodnoty parametru <xd:b>$dict-id</xd:b> (identifikátoru zpracovávaného slovníku) se vyberou údaje pro odpovídající slovník.</xd:p>
  </xd:desc>
 </xd:doc>
 
	<xsl:template name="dictionary-header-tgcs">
		<xsl:param name="title"  select="'Tádžicko-český slovník'"/>
	 <xsl:param name="source-language"  select="'Tádžičtina'"/>
		<teiHeader xmlns="http://www.tei-c.org/ns/1.0">
			<fileDesc>
				<titleStmt>
					<title><xsl:value-of select="$title"/></title>
				 <author><forename>Ľubomír</forename> <surname>Novák</surname></author>
				</titleStmt>
				<publicationStmt>
					<distributor>Filozofická fakulta UK</distributor>
<!--					<address>
						<addrLine>nám. J. Palacha 2, 118 00 Praha 1</addrLine>
					</address>
-->					
				 <xsl:call-template name="publication-date"/>
				 <xsl:call-template name="publication-availability"/>
				</publicationStmt>
				<sourceDesc>
				 <biblStruct>
				  <monogr>
				   <title>Elektronická lexikální databáze indoíránských jazyků: <xsl:value-of select="$source-language"/></title>
				   <imprint>
				    <distributor>Sociologický ústav AV ČR</distributor>
				    <distributor>Filozofická fakulta UK</distributor>
				    <pubPlace>Praha</pubPlace>
				    <xsl:call-template name="publication-date" />
				   </imprint>
				  </monogr>
				 </biblStruct>
				</sourceDesc>
			</fileDesc>
			<encodingDesc>
				<projectDesc>
					<p>Data vznikla v rámci projektu podpořeného TA ČR.</p>
				</projectDesc>
				<editorialDecl>
<!--					<correction>-->
						<p>Doklady byly upraveny pro potřeby překladového slovníku.</p>
					<!--</correction>-->
<!--					<normalization>-->
						<p>Pravopis dokladů byl sjednocen. Pravopisné varianty uvádíme v obvyklých pravopisných podobách.</p>
					<!--</normalization>-->
				</editorialDecl>
			</encodingDesc>
		 <profileDesc>
		  <langUsage>
		   <!-- jedná se o rzdíl mezi zdrojovým a cílovým jazykem, nebo popisovaným jazykem a jazykem metajazyka, popř. jazykem dokladů a překladů -->
		   <!-- objectLanguage: Object language is the "language being described." (ISO 16642:2017) -->
		   <!-- workingLanguage: Working language is the "language used to describe objects." (ISO 16642:2017) -->
		   <!-- sourceLanguage: Source language is the language of the content to be translated. (ISO 17100:215) -->
		   <!-- targetLanguage: Target language is the language of the content into which source language content is translated. (ISO 17100:215) -->
		   <language ident="tg" role="objectLanguage" usage="40">tádžičtina</language>
		   <language ident="fa" role="objectLanguage" usage="40">perština</language>
		   <language ident="tg" role="sourceLanguage" usage="40">tádžičtina</language>
		   <language ident="cs" role="workingLanguage" usage="25">čeština</language>
		   <language ident="en" role="workingLanguage" usage="5">angličtina</language>
		   <language ident="cs" role="targetLanguage" usage="20">čeština</language>
		   <language ident="en" role="targetLanguage" usage="10">angličtina</language>
		  </langUsage>
		 </profileDesc>
			<revisionDesc>
			 <change when="2022-02-06"><p><date>6. června 2022</date> první testovací verze.</p></change>
			</revisionDesc>
		</teiHeader>
	</xsl:template>
 
 <xsl:template name="publication-availability" xmlns="http://www.tei-c.org/ns/1.0">
  <availability>
   <licence target="http://creativecommons.org/licenses/by-nc-nd/4.0/">Toto dílo podléhá licenci Creative Commons Uveďte původ-Neužívejte komerčně-Nezpracovávejte 4.0 Mezinárodní Licence.</licence>
  </availability>
 </xsl:template>
 
 <xsl:template name="publication-date" xmlns="http://www.tei-c.org/ns/1.0">
  <date when="2022">2022</date>
 </xsl:template>
 
 <xsl:template name="dictionary-header-facs">
  <xsl:param name="title"  select="'Persko-český slovník'"/>
  <xsl:param name="source-language"  select="'Perština'"/>
  <teiHeader xmlns="http://www.tei-c.org/ns/1.0">
   <fileDesc>
    <titleStmt>
     <title><xsl:value-of select="$title"/></title>
     <author><forename>Darina</forename> <surname>Vystrčilová</surname></author>
     <author><forename>Mona</forename> <surname>Khademi</surname></author>
     <author><forename>Radka</forename> <surname>Taucová</surname></author>
     <author><forename>Zuzana</forename> <surname>Kříhová</surname></author>
     <author><forename>Ľubomír</forename> <surname>Novák</surname></author>
     <author><forename>Bořivoj</forename> <surname>Nachtmann</surname></author>
     <respStmt>
      <resp>Připravila</resp>
      <name><forename>Darina</forename> <surname>Vystrčilová</surname></name>
     </respStmt>
     <respStmt>
      <resp>Revize</resp>
      <name><forename>Radka</forename> <surname>Taucová</surname></name>
     </respStmt>
     <respStmt>
      <resp>Jazyková korektura</resp>
      <name><forename>Kristýna</forename> <surname>Přibylová</surname></name>
     </respStmt>
    </titleStmt>
    <publicationStmt>
     <distributor>Sociologický ústav AV ČR</distributor>
     <distributor>Filozofická fakulta UK</distributor>
     <!--					<address>
						<addrLine>nám. J. Palacha 2, 118 00 Praha 1</addrLine>
					</address>
-->					
     <xsl:call-template name="publication-date"/>
     <xsl:call-template name="publication-availability"/>
    </publicationStmt>
    <sourceDesc>
     <biblStruct>
      <monogr>
       <title>Elektronická lexikální databáze indoíránských jazyků: <xsl:value-of select="$source-language"/></title>
       <imprint>
        <distributor>Sociologický ústav AV ČR</distributor>
        <distributor>Filozofická fakulta UK</distributor>
        <pubPlace>Praha</pubPlace>
        <xsl:call-template name="publication-date" />
       </imprint>
      </monogr>
     </biblStruct>
    </sourceDesc>
   </fileDesc>
   <encodingDesc>
    <projectDesc>
     <p>Data vznikla v rámci projektu podpořeného TA ČR.</p>
    </projectDesc>
    <editorialDecl>
     <!--					<correction>-->
     <p>Doklady byly upraveny pro potřeby překladového slovníku.</p>
     <!--</correction>-->
     <!--					<normalization>-->
     <p>Pravopis dokladů byl sjednocen. Pravopisné varianty uvádíme v obvyklých pravopisných podobách.</p>
     <!--</normalization>-->
    </editorialDecl>
   </encodingDesc>
   <profileDesc>
    <langUsage>
     <!-- jedná se o rzdíl mezi zdrojovým a cílovým jazykem, nebo popisovaným jazykem a jazykem metajazyka, popř. jazykem dokladů a překladů -->
     <!-- objectLanguage: Object language is the "language being described." (ISO 16642:2017) -->
     <!-- workingLanguage: Working language is the "language used to describe objects." (ISO 16642:2017) -->
     <!-- sourceLanguage: Source language is the language of the content to be translated. (ISO 17100:215) -->
     <!-- targetLanguage: Target language is the language of the content into which source language content is translated. (ISO 17100:215) -->
     <language ident="fa" role="objectLanguage" usage="20">perština</language>
     <language ident="fa" role="sourceLanguage" usage="40">perština</language>
     <language ident="cs" role="workingLanguage" usage="25">čeština</language>
     <language ident="en" role="workingLanguage" usage="5">angličtina</language>
     <language ident="cs" role="targetLanguage" usage="20">čeština</language>
     <language ident="en" role="targetLanguage" usage="10">angličtina</language>
    </langUsage>
   </profileDesc>
  <!-- <revisionDesc>
    <change when="2020-10-08"><p><date>8. října 2020</date> první verze.</p></change>
    <change when="2022-03-25"><p><date>25. března 2022</date> poslední známá verze.</p></change>
   </revisionDesc>-->
  </teiHeader>
 </xsl:template>
	
	<xsl:template name="dictionary-header">
	 <xsl:param name="dict-id" as="xs:string" />
	 <xsl:choose>
	  <xsl:when test="$dict-id='FACS'">
	   <xsl:call-template name="dictionary-header-facs" />
	  </xsl:when>
	  <xsl:when test="$dict-id='TGCS'">
	   <xsl:call-template name="dictionary-header-tgcs" />
	  </xsl:when>
	 </xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>