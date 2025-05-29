<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	exclude-result-prefixes="xs"
	version="3.0">
	<xsl:strip-space elements="*"/>
	<xsl:output indent="yes" />
	
	<xsl:template match="/">
		<seznam-poli>
			<xsl:apply-templates/>
		</seznam-poli>
	</xsl:template>
	
	<xsl:template match="Normální[nazev-pole][following-sibling::*[1][self::Export]]" priority="2">
		<xsl:variable name="nazev" select="normalize-space(nazev-pole)"/>
		<xsl:variable name="export" select="following-sibling::*[1][self::Export]/normalize-space(*)"/>
		<pole>
			<xsl:attribute name="nazev">
				<xsl:choose>
					<xsl:when test="contains($nazev, '(\')">
						<xsl:value-of select="normalize-space(translate(substring-before($nazev, '(\'), '–', ''))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="translate($nazev, '–', '')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			<xsl:attribute name="znacka">
				<xsl:analyze-string select="$nazev" regex="\\\w\w">
					<xsl:matching-substring>
						<xsl:value-of select="."/>
					</xsl:matching-substring>
				</xsl:analyze-string>
			</xsl:attribute>
			
			<xsl:attribute name="export">
				<xsl:choose>
					<xsl:when test="contains($export, '–')">
						<xsl:value-of select="normalize-space(substring-before($export, '–'))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:analyze-string select="$export" regex="ANO|NE|\?">
							<xsl:matching-substring>
								<xsl:value-of select="."/>
							</xsl:matching-substring>
						</xsl:analyze-string>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="export-info">
				<xsl:choose>
					<xsl:when test="contains($export, '–')">
						<xsl:value-of select="normalize-space(substring-after($export, '–'))"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:analyze-string select="$export" regex="ANO|NE|\?">
							<xsl:non-matching-substring>
								<xsl:choose>
									<xsl:when test="starts-with(., ',')">
										<xsl:value-of select="normalize-space(substring(., 2))"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="normalize-space(.)"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:non-matching-substring>
						</xsl:analyze-string>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			<xsl:attribute name="popis">
				<xsl:value-of select="normalize-space(translate(popis, '–', ''))"/>
			</xsl:attribute>
		</pole>
	</xsl:template>
	
	<xsl:template match="/body/*" />
	
	
</xsl:stylesheet>