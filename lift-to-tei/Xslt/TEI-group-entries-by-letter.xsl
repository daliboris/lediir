<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.tei-c.org/ns/1.0"
	xmlns:tei="http://www.tei-c.org/ns/1.0"
	xmlns:lediir="https://daliboris.cz/ns/lediir/xslt/1.0"
	exclude-result-prefixes="xs tei lediir"
	version="3.0">
	<xsl:import href="LeDIIR-text-functions.xsl"/>
 
	<xsl:template match="node() | @*">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*"/>
		</xsl:copy>
	</xsl:template>
 
 <xsl:output indent="yes" method="xml" />
	
	<xsl:template match="tei:body">
		<xsl:copy>
			<xsl:for-each-group select="tei:entry" group-by="substring(@sortKey, 1, 1)"> <!-- tei:form[@type='lemma'][1]/tei:orth[1]/substring(., 1, 1) -->
			 <xsl:sort select=" current-grouping-key()"/>
			 <div type="letter" xml:id="{concat('FACS.div.', format-number(string-to-codepoints(current-grouping-key()), '00000'))}">
				 <xsl:attribute name="n">
				  <xsl:value-of select="string-to-codepoints(current-grouping-key())"/>
				 </xsl:attribute>
					<head type="letter"><xsl:value-of select="lediir:convert-sortable-to-sort-key(current-grouping-key())"/></head>
				 <xsl:apply-templates select="current-group()">
				  <xsl:sort select="@sortKey" />
				 </xsl:apply-templates>
				</div>
			</xsl:for-each-group>		
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>