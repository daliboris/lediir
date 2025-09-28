<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 6, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
            <xd:p>Extrakce několika heslových statí pro ukázku.</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output indent="yes" />
    <xsl:strip-space elements="*"/>
    <xsl:mode on-no-match="shallow-copy"/>

    
    <xd:doc>
        <xd:desc>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
	<xsl:template match="anthropology" />
	<xsl:template match="discourse" />
	<xsl:template match="entry/sense/note[not(@*)]" />
	<xsl:template match="entry/sense/gloss[@lang='cs-CZ']" />
	<xsl:template match="entry/sense/gloss[@lang='en']" />
 <xsl:template match="entry/sense/example/translation/form[@lang='en']" /> <!-- překlady dokladů do angličtiny -->
	<xsl:template match="entry/note[not(@*)]" />
	<xsl:template match="sense/note[@type='bibliography']" />
	<xsl:template match="sense/note[@type='source']" />
    
 <xsl:template match="entry/sense/example/form[@lang='cs-CZ']" /><!-- příklady nemají mít výslovnost, pouze překlad -->
	
	<xsl:template match="field[@type='import-residue']" />
	<xsl:template match="sense/reversal[not(*)]" priority="2" /> <!-- odstranění reverzních odkazů, které neobsahují formu (heslo) -->
 <xsl:template match="reversal[@type='fa']" /> <!-- reverzní odkazy v perštině jsou pozůstatky staršího zpracování -->
	<xsl:template match="trait[@name='do-not-publish-in']" />
 <xsl:template match="note[@type='discourse']" /> <!-- nejspíš starší verze sémantické kategorie -->
	
	<!-- odstranění anglického ekvivalentu, pokud heslo/význam není zkontrolovaný -->
 <xsl:template match="entry/sense[not(trait[@name='status' and @value=('proved', 'Proved')])]/definition/form[@lang='en']" />
	
	<!-- odstranění významu, který není schválen/neprošel kontrolou -->
    <xsl:template match="sense[trait[@name='status' and not(normalize-space(@value)=('Confirmed', 'Proved Czech', 'Verified by reverse translation', 'Verified by examples', 'Not assessed'))]]" />
	
    <!-- odstranění heslové stati, která neobsahuje jediný význam, který není schválen/neprošel kontrolou -->
    <xsl:template match="entry[not(sense[trait[@name='status' and (normalize-space(@value)=('Confirmed', 'Proved Czech', 'Verified by reverse translation', 'Verified by examples', 'Not assessed'))]])]" />
	
 <!-- Chyba: heslové statě bez heslového slova -->
 <xsl:template match="entry[not(lexical-unit)]" />

 <!-- Heslové stati bez (schválených) významů  -->
 <xsl:template match="entry[not(sense)]" />
 
 <!-- odkazy na variantu lexému, které nevedou nikam -->
 <xsl:template match="relation[trait[@name='variant-type']][@ref = '']" />
 

</xsl:stylesheet>