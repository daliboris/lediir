<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 8, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:output method="text" />
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="seznam-poli">
# Pole FLExu pro export

| Název pole | Exportovat | Značka | Popis | Další informace |
| ---------- | ---------- | ------ | ----- | --------------- |
<xsl:apply-templates />
        
    </xsl:template>
    
<xsl:template match="pole">| <xsl:value-of select="@nazev"/> | **<xsl:value-of select="@export"/>** | <xsl:value-of select="@znacka"/> | <xsl:value-of select="@popis"/> | <xsl:value-of select="@export-info"/> |
</xsl:template>
    
</xsl:stylesheet>