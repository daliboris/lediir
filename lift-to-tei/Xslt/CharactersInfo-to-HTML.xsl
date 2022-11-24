<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Oct 5, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="html" version="5" indent="yes" />
    
    <xsl:template match="/">
        <html>
            <head>
                <title><xsl:value-of select="charactersInfo/@part"/></title>
                <!-- https://divtable.com/table-styler/ -->
                <style>table.minimalistBlack {
  border: 3px solid #000000;
  /*width: 100%;*/
  text-align: left;
  border-collapse: collapse;
}
table.minimalistBlack td, table.minimalistBlack th {
  border: 1px solid #000000;
  padding: 5px 4px;
}
table.minimalistBlack tbody td {
  font-size: 1em;
}
table.minimalistBlack tbody td.text {
  font-size: 1.5em;
}
table.minimalistBlack thead {
  background: #CFCFCF;
  background: -moz-linear-gradient(top, #dbdbdb 0%, #d3d3d3 66%, #CFCFCF 100%);
  background: -webkit-linear-gradient(top, #dbdbdb 0%, #d3d3d3 66%, #CFCFCF 100%);
  background: linear-gradient(to bottom, #dbdbdb 0%, #d3d3d3 66%, #CFCFCF 100%);
  border-bottom: 3px solid #000000;
}
table.minimalistBlack thead th {
  font-size: 15px;
  font-weight: bold;
  color: #000000;
  text-align: left;
}
table.minimalistBlack tfoot {
  font-size: 14px;
  font-weight: bold;
  color: #000000;
  border-top: 3px solid #000000;
}
table.minimalistBlack tfoot td {
  font-size: 14px;
}</style>
            </head>
            <body>
                <xsl:apply-templates select="charactersInfo" />
            </body>
        </html>
    </xsl:template>
    
    
    <xsl:template match="charactersInfo">
        <h1>Analyzovaná oblast: <xsl:value-of select="if(@part = 'quotes') then 'doklady' else 'heslová slova'"/></h1>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="characters">
        <table class="minimalistBlack">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Znak</th>
                    <th>Název</th>
                    <th>Frekvence</th>
                    <th>Oblast</th>
                    <th>Obousměrný typ znaku</th>
                    <th>Kategorie</th>
                    <th>Rozložení na znaky</th>
                    <th>Druh rozložení</th>
                </tr>
            </thead>
            <tbody>
                <xsl:apply-templates select="character" />
            </tbody>
        </table>
    </xsl:template>
    
    <xsl:template match="character">
        <tr>
            <td><xsl:value-of select="position()"/></td>
            <td class="text"><xsl:value-of select="Text"/></td>
            <td><xsl:value-of select="Name"/></td>
            <td><xsl:value-of select="Frequency"/></td>
            <td><xsl:value-of select="Block"/></td>
            <td><xsl:value-of select="BidirectionalClass"/></td>
            <td><xsl:value-of select="Category"/></td>
            <td class="text"><xsl:value-of select="DecompositionMapping"/></td>
            <td><xsl:value-of select="DecompositionType"/></td>
        </tr>
    </xsl:template>
</xsl:stylesheet>