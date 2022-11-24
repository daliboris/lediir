<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs math xd tei" version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 27, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
            <xd:p />
        </xd:desc>
    </xd:doc>


    <xsl:variable name="frequency-step-width" select="2.5" />
    <xsl:variable name="frequency-box-width" select="$frequency-step-width * 30" /> <!-- 130 při 5px -->

    <xsl:template name="process-frequency">
        <xsl:param name="frequency-step-width" select="$frequency-step-width" />
        <xsl:param name="frequency-box-width" select="$frequency-box-width" />
        <xsl:variable name="height" select="number(7)" />
        <xsl:variable name="values" select="tokenize(normalize-space(.), '\s|;')[.][position() &lt;= 3]" />
        
        <svg width="{$frequency-box-width}px" height="40px" xmlns="http://www.w3.org/2000/svg" class="frequency-chart">
          <style>
           .frequency-chart {
           position: relative;
           }
           .frequency-bar-1 {
           fill: #537614;
           }
           .frequency-bar-2 {
           fill: #789E35;
           }
           .frequency-bar-3 {
           fill: #A2C563;
           }
           .frequency-bar-4 {
           fill: #137177;
           }
           .frequency-text {
           font-family: Arial, sans-serif;
           font-size: 0.5em;
           font-weight: bold;
           }
          </style>
         
            <g>
                <xsl:for-each select="$values">
                    <xsl:variable name="value" select="." />
                    
                    <xsl:variable name="corpus">
                        <xsl:choose>
                            <xsl:when test="string-length($value) = 2">
                                <xsl:value-of select="substring($value, 1, 1)"/>
                            </xsl:when>
                            <xsl:when test="count($values) = 3 and position() = 2">
                                <xsl:value-of select="'L'"/>
                            </xsl:when>
                            <xsl:when test="count($values) = 3 and position() = 3">
                                <xsl:value-of select="'V'"/>
                            </xsl:when>
                           <xsl:when test="count($values) = 2 and position() = 1">
                            <xsl:value-of select="'L'"/>
                           </xsl:when>
                           <xsl:when test="count($values) = 2 and position() = 2">
                            <xsl:value-of select="'V'"/>
                           </xsl:when>
                         <xsl:otherwise>
                                <xsl:value-of select="'T'"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    
                    <xsl:variable name="corpus-name">
                        <xsl:choose>
                            <xsl:when test="$corpus = ('T', 'M')"><xsl:value-of select="'Talkbank/Araneum'"/></xsl:when>
                            <xsl:when test="$corpus = ('L')"><xsl:value-of select="'Korpus převážně psaného jazyka'"/></xsl:when>
                            <xsl:when test="$corpus = ('S', 'V')"><xsl:value-of select="'Korpus mluveného jazyka'"/></xsl:when>
                        </xsl:choose>
                    </xsl:variable>

                    <xsl:variable name="number">
                        <xsl:call-template name="frequency-to-number">
                            <xsl:with-param name="text" select="$value" />
                        </xsl:call-template>
                    </xsl:variable>

                    <xsl:if test="$value != '' and string(number($number)) != 'NaN'">
                        <xsl:variable name="numbers" as="xs:double*">
                            <xsl:call-template name="frequency-to-numbers">
                                <xsl:with-param name="text" select="$value" />
                                <xsl:with-param name="frequency-step-width" select="$frequency-step-width" />
                            </xsl:call-template>
                        </xsl:variable>

                        <xsl:variable name="class" select="concat('frequency-bar-', position())" />
                        <xsl:variable name="position" select="position()" />

                        <xsl:variable name="y-step" select="($position - 1) * ($height div 2)" />
                        <xsl:variable name="y" select="
                                if ($position = 1) then
                                    0
                                else
                                    (($position - 1) * $height)" />

                        <text x="0" y="{$y + $height + $y-step + 5}" class="frequency-text"><xsl:value-of select="$corpus"/>: <title><xsl:value-of select="$corpus-name"/></title> </text>


                        <xsl:for-each select="$numbers">
                            <xsl:variable name="num" select="." />
                            <xsl:variable name="item" select="position()" />
                            <xsl:variable name="x" select="
                                    if ($item = 1) then
                                        0
                                    else
                                        (sum($numbers[position() lt $item]) + (($item - 1) * 2))" />


                            <rect class="{$class}" width="{$num}px" height="{$height}" y="{$y + $height + $y-step}" x="{$x + 10}">
                                <title>
                                    <xsl:value-of select="$value" />
                                </title>
                            </rect>
                        </xsl:for-each>
                    </xsl:if>

                </xsl:for-each>
            </g>

        </svg>

    </xsl:template>

    <xsl:template name="frequency-to-numbers" as="xs:double*">
        <xsl:param name="text" />
        <xsl:param name="frequency-step-width" select="$frequency-step-width" />
        <xsl:variable name="number">
            <xsl:call-template name="frequency-to-number">
                <xsl:with-param name="text" select="$text" />
            </xsl:call-template>
        </xsl:variable>


        <xsl:if test="$number != ''"> </xsl:if>
        <xsl:variable name="result" as="xs:double*">
            <xsl:choose>
                <xsl:when test="$number = 0">
                    <xsl:sequence select="()" />
                </xsl:when>
                <xsl:when test="$number = 5">
                    <!--<xsl:sequence select="(5)"/>-->
                    <xsl:sequence select="($frequency-step-width)" />
                </xsl:when>
                <xsl:when test="$number = 20">
                    <!--<xsl:sequence select="(5, 15)"/>-->
                    <xsl:sequence select="($frequency-step-width, $frequency-step-width * 3)" />
                </xsl:when>
                <xsl:when test="$number = 40">
                    <!--<xsl:sequence select="(5,15,20)"/>-->
                    <xsl:sequence select="($frequency-step-width, $frequency-step-width * 3, $frequency-step-width * 4)" />
                </xsl:when>
                <xsl:when test="$number = 60">
                    <!--<xsl:sequence select="(5,15,20,20)"/>-->
                    <xsl:sequence select="($frequency-step-width, $frequency-step-width * 3, $frequency-step-width * 4, $frequency-step-width * 4)" />
                </xsl:when>
                <xsl:when test="$number = 80">
                    <!--<xsl:sequence select="(5,15,20,20,20)"/>-->
                    <xsl:sequence select="($frequency-step-width, $frequency-step-width * 3, $frequency-step-width * 4, $frequency-step-width * 4, $frequency-step-width * 4)" />
                </xsl:when>
                <xsl:when test="$number = 100">
                    <!--<xsl:sequence select="(5,15,20,20,20,20)"/>-->
                    <xsl:sequence select="($frequency-step-width, $frequency-step-width * 3, $frequency-step-width * 4, $frequency-step-width * 4, $frequency-step-width * 4, $frequency-step-width * 4)" />
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="$result" />
    </xsl:template>

    <xsl:template name="frequency-to-number">
        <xsl:param name="text" />
        <xsl:variable name="frq">
            <xsl:choose>
                <xsl:when test="string-length($text) eq 2">
                    <xsl:value-of select="substring($text, 2, 1)" />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$text" />
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:choose>
            <xsl:when test="$frq = 'X'">0</xsl:when>
            <!-- X znamená, že v korpusu vůbec nebylo nalezeno -->
            <xsl:when test="$frq = 'R'">5</xsl:when>
            <!-- R je vzácný výskyt -->
            <xsl:when test="$frq = 'E'">20</xsl:when>
            <xsl:when test="$frq = 'D'">40</xsl:when>
            <xsl:when test="$frq = 'C'">60</xsl:when>
            <xsl:when test="$frq = 'B'">80</xsl:when>
            <xsl:when test="$frq = 'A'">100</xsl:when>
        </xsl:choose>
    </xsl:template>



</xsl:stylesheet>
