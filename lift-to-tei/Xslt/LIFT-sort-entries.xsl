<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="3.0">
	<xsl:import href="LeDIIR-text-functions.xsl" />
	<xsl:output indent="yes" />

	<xsl:template match="node() | @*">
		<xsl:copy>
			<xsl:apply-templates select="node() | @*" />
		</xsl:copy>
	</xsl:template>

	<xsl:template match="lift">
		<xsl:copy>
			<xsl:copy-of select="@*" />
			<xsl:copy-of select="header" />
			<xsl:apply-templates select="entry">
			 <xsl:sort select="lexical-unit" collation="http://www.w3.org/2013/collation/UCA?lang=fa" />
			 <xsl:sort select="citation" collation="http://www.w3.org/2013/collation/UCA?lang=fa" />
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
