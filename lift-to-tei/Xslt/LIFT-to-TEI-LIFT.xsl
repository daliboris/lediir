<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	exclude-result-prefixes="xs"
	version="2.0">
	<!--<xsl:import href="Dictionary-header.xsl"/>-->
	<xsl:output method="xml" indent="yes" />
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="/">
		<tei:TEI xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0">
			<xsl:call-template name="dictionary-header">
				<xsl:with-param name="title">
					<xsl:text>Elektronická lexikální databáze indoíránských jazyků (LIFT)</xsl:text>
				</xsl:with-param>
			</xsl:call-template>
			<tei:text>
				<tei:body>
					<tei:div>
					<xsl:copy-of select="lift" />
					</tei:div>
				</tei:body>
			</tei:text>
		</tei:TEI>
	</xsl:template>
	
	<xsl:template name="dictionary-header">
		<xsl:param name="title"  select="'Elektronická lexikální databáze indoíránských jazyků'"/>
		<tei:teiHeader>
			<tei:fileDesc>
				<tei:titleStmt>
					<tei:title><xsl:value-of select="$title"/></tei:title>
					<tei:author>Darina Vystrčilová a kol.</tei:author>
					<tei:respStmt>
						<tei:resp>Připravila</tei:resp>
						<tei:name>Darina Vystei:trčilová</tei:name>
					</tei:respStmt>
					<tei:respStmt>
						<tei:resp>Revize</tei:resp>
						<tei:name>Radka Taucová</tei:name>
					</tei:respStmt>
				</tei:titleStmt>
				<tei:publicationStmt>
					<tei:distributor>Sociologický ústav ˇAV ČR</tei:distributor>
					<tei:distributor>Filozofická fakulta UK</tei:distributor>
					<tei:address>
						<tei:addrLine>nám. J. Palacha 2, 118 00 Praha 1</tei:addrLine>
					</tei:address>
					<tei:availability>
						<tei:p>Veškerá práva vyhrazena.</tei:p>
					</tei:availability>
					<tei:date when="2020">2020</tei:date>
				</tei:publicationStmt>
				<tei:sourceDesc>
					<tei:bibl>Elektronická lexikální databáze indoíránských jazyků: Perština. Praha 2020.</tei:bibl>
				</tei:sourceDesc>
			</tei:fileDesc>
			<tei:encodingDesc>
				<tei:projectDesc>
					<p>Data vznikla v rámci projektu podpořeného TA ČR.</p>
				</tei:projectDesc>
				<tei:editorialDecl>
					<tei:correction>
						<tei:p>Doklady byly upraveny pro potřeby překladového slovníku.</tei:p>
					</tei:correction>
					<tei:normalization>
						<tei:p>Pravopis dokladů byl sjednocen. Pravopisné varianty uvádíme v obvyklých pravopisných podobách.</tei:p>
					</tei:normalization>
				</tei:editorialDecl>
			</tei:encodingDesc>
			<tei:revisionDesc>
				<tei:list>
					<tei:item>
						<tei:date when="2020-10-08">8. října 2020</tei:date> první verze</tei:item>
				</tei:list>
			</tei:revisionDesc>
		</tei:teiHeader>
	</xsl:template>
	
	
</xsl:stylesheet>