<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:math="http://www.w3.org/2005/xpath-functions/math"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs math xd"
 version="3.0">
 <xd:doc scope="stylesheet">
  <xd:desc>
   <xd:p><xd:b>Created on:</xd:b> May 18, 2024</xd:p>
   <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
   <xd:p></xd:p>
  </xd:desc>
 </xd:doc>
 
 <xsl:output method="html" />
 <xsl:strip-space elements="*"/>
 
 <xsl:template match="/">
  <html>
   <head>
    <title>Frekvence</title>
    <style>
     caption {
     caption-side: top;
     text-align: center;
     padding-bottom: 10px;
     font-weight: bold;
     font-size: 1.75em;
     }
     
     table.redTable {
     border: 2px solid #A40808;
     background-color: #EEE7DB;
      border-collapse: collapse;
     }
     table.redTable td, table.redTable th {
     border: 1px solid #AAAAAA;
     padding: 3px 2px;
     }
     table.redTable tbody td {
     font-size: 1.25em;
     }
     table.redTable tr:nth-child(even) {
     background: #F5C8BF;
     }
     table.redTable thead {
     background: #A40808;
     }
     table.redTable thead th {
     font-size: 1.5em;
     font-weight: bold;
     color: #FFFFFF;
     text-align: center;
     border-left: 2px solid #A40808;
     }
     table.redTable thead th:first-child {
     border-left: none;
     }
     
     
     
     table.greenTable {
     font-family: Georgia, serif;
     border: 6px solid #24943A;
     background-color: #D4EED1;
      text-align: center;
     }
     table.greenTable td, table.greenTable th {
     border: 1px solid #24943A;
     padding: 3px 2px;
     }
     table.greenTable tbody td {
     font-size: 1.25em;
     }
     table.greenTable thead {
     background: #24943A;
     background: -moz-linear-gradient(top, #5baf6b 0%, #3a9e4d 66%, #24943A 100%);
     background: -webkit-linear-gradient(top, #5baf6b 0%, #3a9e4d 66%, #24943A 100%);
     background: linear-gradient(to bottom, #5baf6b 0%, #3a9e4d 66%, #24943A 100%);
     border-bottom: 0px solid #444444;
     }
     table.greenTable thead th {
     font-size: 1.5em;
     font-weight: bold;
     color: #F0F0F0;
     text-align: left;
     border-left: 2px solid #24943A;
     }
     table.greenTable thead th:first-child {
     border-left: none;
     }

    </style>
   </head>
   <body>
    <h1>Frekvence u hesel z webové aplikace</h1>
    <p>Uvedené počty se týkají hesel z webové aplikace, tj. ve FLExu můžou být vyšší.</p>
    <ul>
     <li>povolená označení korpusů: M, L, V, T</li>
     <li>povolená označení frekvence: A, B, C, D, E, X, R</li>
    </ul>
    <xsl:apply-templates select="/items" mode="invalid">
     <xsl:with-param name="caption" select="'Problémové frekvence'" />
     <xsl:with-param name="table" select="'redTable'" />
    </xsl:apply-templates>
    <xsl:apply-templates select="/items"  mode="valid">
     <xsl:with-param name="caption" select="'Bezproblémové frekvence'" />
     <xsl:with-param name="table" select="'greenTable'" />
    </xsl:apply-templates>
   </body>
  </html>
 </xsl:template>
 
 <xsl:template match="items" mode="valid invalid">
  <xsl:param name="caption" as="xs:string" />
  <xsl:param name="table" as="xs:string" />
  <table class="{$table}">
   <caption><xsl:value-of select="$caption" /></caption>
   <thead>
    <tr>
     <th>Frekvence</th>
     <th>Počet výskytů</th>
    </tr>
   </thead>
   <tbody>
    <xsl:apply-templates mode="#current" />
   </tbody>
  </table>
 </xsl:template>
 
 <xsl:template match="item[@valid='false']" mode="valid" />
 <xsl:template match="item[@valid='false']" mode="invalid">
  <tr>
   <td><xsl:value-of select="@value"/> </td>
   <td><xsl:value-of select="@count"/> </td>
  </tr>
 </xsl:template>
 <xsl:template match="item[@valid='trie']" mode="invalid" />
 <xsl:template match="item[@valid='true']" mode="valid">
  <tr>
   <td><xsl:value-of select="@value"/> </td>
   <td><xsl:value-of select="@count"/> </td>
  </tr>
 </xsl:template>

 
</xsl:stylesheet>