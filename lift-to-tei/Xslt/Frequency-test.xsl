<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs math xd" version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 27, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
            <xd:p />
        </xd:desc>
    </xd:doc>

    <xsl:import href="TEI-to-Frequency.xsl" />

    <xsl:import href="TEI-to-HTML-common.xsl" />

 <xsl:variable
  name="frequencies">
  <usg type="frequency" value="C-LD-VC">C LD VC</usg>
  <usg type="frequency" value="LA-VA">LA VA</usg>
  <usg type="frequency" value="LA-VB">LA VB</usg>
  <usg type="frequency" value="LA-VC">LA VC</usg>
  <usg type="frequency" value="LB-VA">LB VA</usg>
  <usg type="frequency" value="LB-VB">LB VB</usg>
  <usg type="frequency" value="LB-VC">LB VC</usg>
  <usg type="frequency" value="LB-VD">LB VD</usg>
  <usg type="frequency" value="LB-VR">LB VR</usg>
  <usg type="frequency" value="LB-VX">LB VX</usg>
  <usg type="frequency" value="LC-VB">LC VB</usg>
  <usg type="frequency" value="LC-VC">LC VC</usg>
  <usg type="frequency" value="LC-VD">LC VD</usg>
  <usg type="frequency" value="LC-VR">LC VR</usg>
  <usg type="frequency" value="LC-VX">LC VX</usg>
  <usg type="frequency" value="LD-VB">LD VB</usg>
  <usg type="frequency" value="LD-VC">LD VC</usg>
  <usg type="frequency" value="LD-VD">LD VD</usg>
  <usg type="frequency" value="LD-VR">LD VR</usg>
  <usg type="frequency" value="LD-VX">LD VX</usg>
  <usg type="frequency" value="LR-VB">LR VB</usg>
  <usg type="frequency" value="LR-VC">LR VC</usg>
  <usg type="frequency" value="LR-VD">LR VD</usg>
  <usg type="frequency" value="LR-VR">LR VR</usg>
  <usg type="frequency" value="LR-VX">LR VX</usg>
  <usg type="frequency" value="LX-VB">LX VB</usg>
  <usg type="frequency" value="LX-VC">LX VC</usg>
  <usg type="frequency" value="LX-VD">LX VD</usg>
  <usg type="frequency" value="LX-VD-TD">LX VD TD</usg>
  <usg type="frequency" value="LX-VR">LX VR</usg>
  <usg type="frequency" value="MA-LA-VA">MA LA VA</usg>
  <usg type="frequency" value="MA-LA-VC">MA LA VC</usg>
  <usg type="frequency" value="MA-LB-VA">MA LB VA</usg>
  <usg type="frequency" value="MA-LB-VB">MA LB VB</usg>
  <usg type="frequency" value="MB">MB</usg>
  <usg type="frequency" value="MB-LA-VB">MB LA VB</usg>
  <usg type="frequency" value="MB-LA-VC">MB LA VC</usg>
  <usg type="frequency" value="MB-LB-VA">MB LB VA</usg>
  <usg type="frequency" value="MB-LB-VB">MB LB VB</usg>
  <usg type="frequency" value="MB-LB-VC">MB LB VC</usg>
  <usg type="frequency" value="MB-LB-VD">MB LB VD</usg>
  <usg type="frequency" value="MB-LC-VA">MB LC VA</usg>
  <usg type="frequency" value="MB-LC-VB">MB LC VB</usg>
  <usg type="frequency" value="MB-LC-VC">MB LC VC</usg>
  <usg type="frequency" value="MB-LC-VD">MB LC VD</usg>
  <usg type="frequency" value="MB-LD-VB">MB LD VB</usg>
  <usg type="frequency" value="MB-LD-VC">MB LD VC</usg>
  <usg type="frequency" value="MB-LD-VD">MB LD VD</usg>
  <usg type="frequency" value="MC">MC</usg>
  <usg type="frequency" value="MC-LA-VR">MC LA VR</usg>
  <usg type="frequency" value="MC-LA-VX">MC LA VX</usg>
  <usg type="frequency" value="MC-LB-VB">MC LB VB</usg>
  <usg type="frequency" value="MC-LB-VC">MC LB VC</usg>
  <usg type="frequency" value="MC-LB-VD">MC LB VD</usg>
  <usg type="frequency" value="MC-LC-VB">MC LC VB</usg>
  <usg type="frequency" value="MC-LC-VC">MC LC VC</usg>
  <usg type="frequency" value="MC-LC-VD">MC LC VD</usg>
  <usg type="frequency" value="MC-LC-VR">MC LC VR</usg>
  <usg type="frequency" value="MC-LC-VX">MC LC VX</usg>
  <usg type="frequency" value="MC-LD-VA">MC LD VA</usg>
  <usg type="frequency" value="MC-LD-VB">MC LD VB</usg>
  <usg type="frequency" value="MC-LD-VC">MC LD VC</usg>
  <usg type="frequency" value="MC-LD-VD">MC LD VD</usg>
  <usg type="frequency" value="MC-LD-VR">MC LD VR</usg>
  <usg type="frequency" value="MC-LD-VX">MC LD VX</usg>
  <usg type="frequency" value="MC-LR-VC">MC LR VC</usg>
  <usg type="frequency" value="MC-LR-VD">MC LR VD</usg>
  <usg type="frequency" value="MC-LR-VR">MC LR VR</usg>
  <usg type="frequency" value="MC-LR-VX">MC LR VX</usg>
  <usg type="frequency" value="MC-LX-VC">MC LX VC</usg>
  <usg type="frequency" value="MC-LX-VD">MC LX VD</usg>
  <usg type="frequency" value="MC-LX-VR">MC LX VR</usg>
  <usg type="frequency" value="MD">MD</usg>
  <usg type="frequency" value="MD-LB-VD">MD LB VD</usg>
  <usg type="frequency" value="MD-LC-VB">MD LC VB</usg>
  <usg type="frequency" value="MD-LC-VC">MD LC VC</usg>
  <usg type="frequency" value="MD-LC-VD">MD LC VD</usg>
  <usg type="frequency" value="MD-LC-VR">MD LC VR</usg>
  <usg type="frequency" value="MD-LC-VX">MD LC VX</usg>
  <usg type="frequency" value="MD-LD-VB">MD LD VB</usg>
  <usg type="frequency" value="MD-LD-VC">MD LD VC</usg>
  <usg type="frequency" value="MD-LD-VD">MD LD VD</usg>
  <usg type="frequency" value="MD-LD-VR">MD LD VR</usg>
  <usg type="frequency" value="MD-LD-VX">MD LD VX</usg>
  <usg type="frequency" value="MD-LR-VB">MD LR VB</usg>
  <usg type="frequency" value="MD-LR-VC">MD LR VC</usg>
  <usg type="frequency" value="MD-LR-VD">MD LR VD</usg>
  <usg type="frequency" value="MD-LR-VR">MD LR VR</usg>
  <usg type="frequency" value="MD-LR-VX">MD LR VX</usg>
  <usg type="frequency" value="MD-LX-VB">MD LX VB</usg>
  <usg type="frequency" value="MD-LX-VC">MD LX VC</usg>
  <usg type="frequency" value="MD-LX-VD">MD LX VD</usg>
  <usg type="frequency" value="MD-LX-VR">MD LX VR</usg>
  <usg type="frequency" value="ME">ME</usg>
  <usg type="frequency" value="ME-LC-VR">ME LC VR</usg>
  <usg type="frequency" value="ME-LC-VX">ME LC VX</usg>
  <usg type="frequency" value="ME-LD-VD">ME LD VD</usg>
  <usg type="frequency" value="ME-LD-VX">ME LD VX</usg>
  <usg type="frequency" value="ME-LR-VD">ME LR VD</usg>
  <usg type="frequency" value="ME-LR-VR">ME LR VR</usg>
  <usg type="frequency" value="ME-LR-VX">ME LR VX</usg>
  <usg type="frequency" value="ME-LX-VD">ME LX VD</usg>
  <usg type="frequency" value="ME-LX-VR">ME LX VR</usg>
  <usg type="frequency" value="MR">MR</usg>
  <usg type="frequency" value="MR-LD-VX">MR LD VX</usg>
  <usg type="frequency" value="MR-LR-VX">MR LR VX</usg>
  <usg type="frequency" value="MR-LX-VD">MR LX VD</usg>
  <usg type="frequency" value="MR-LX-VR">MR LX VR</usg>
  <usg type="frequency" value="MR-LX-VX">MR LX VX</usg>
  <usg type="frequency" value="MX">MX</usg>
  <usg type="frequency" value="ND">ND</usg>
  <usg type="frequency" value="T-LD-VC">T LD VC</usg>
  <usg type="frequency" value="TA">TA</usg>
  <usg type="frequency" value="TA-LA-VA">TA LA VA</usg>
  <usg type="frequency" value="TA-LA-VB">TA LA VB</usg>
  <usg type="frequency" value="TA-LA-VD">TA LA VD</usg>
  <usg type="frequency" value="TA-LB-VA">TA LB VA</usg>
  <usg type="frequency" value="TA-LB-VB">TA LB VB</usg>
  <usg type="frequency" value="TA-LB-VC">TA LB VC</usg>
  <usg type="frequency" value="TA-LB-VD">TA LB VD</usg>
  <usg type="frequency" value="TA-LC-VB">TA LC VB</usg>
  <usg type="frequency" value="TA-LC-VC">TA LC VC</usg>
  <usg type="frequency" value="TA-LC-VD">TA LC VD</usg>
  <usg type="frequency" value="TB">TB</usg>
  <usg type="frequency" value="TB-LB-VA">TB LB VA</usg>
  <usg type="frequency" value="TB-LB-VB">TB LB VB</usg>
  <usg type="frequency" value="TB-LB-VC">TB LB VC</usg>
  <usg type="frequency" value="TB-LB-VD">TB LB VD</usg>
  <usg type="frequency" value="TB-LC-VA">TB LC VA</usg>
  <usg type="frequency" value="TB-LC-VB">TB LC VB</usg>
  <usg type="frequency" value="TB-LC-VC">TB LC VC</usg>
  <usg type="frequency" value="TB-LC-VD">TB LC VD</usg>
  <usg type="frequency" value="TB-LC-VR">TB LC VR</usg>
  <usg type="frequency" value="TB-LD-VA">TB LD VA</usg>
  <usg type="frequency" value="TB-LD-VC">TB LD VC</usg>
  <usg type="frequency" value="TB-LD-VD">TB LD VD</usg>
  <usg type="frequency" value="TB-LR-VD">TB LR VD</usg>
  <usg type="frequency" value="TB-LR-VX">TB LR VX</usg>
  <usg type="frequency" value="TB-LX-VD">TB LX VD</usg>
  <usg type="frequency" value="TC">TC</usg>
  <usg type="frequency" value="TC-LB-VB">TC LB VB</usg>
  <usg type="frequency" value="TC-LB-VC">TC LB VC</usg>
  <usg type="frequency" value="TC-LB-VD">TC LB VD</usg>
  <usg type="frequency" value="TC-LB-VR">TC LB VR</usg>
  <usg type="frequency" value="TC-LB-VX">TC LB VX</usg>
  <usg type="frequency" value="TC-LC-VB">TC LC VB</usg>
  <usg type="frequency" value="TC-LC-VC">TC LC VC</usg>
  <usg type="frequency" value="TC-LC-VD">TC LC VD</usg>
  <usg type="frequency" value="TC-LC-VR">TC LC VR</usg>
  <usg type="frequency" value="TC-LC-VX">TC LC VX</usg>
  <usg type="frequency" value="TC-LD-VB">TC LD VB</usg>
  <usg type="frequency" value="TC-LD-VC">TC LD VC</usg>
  <usg type="frequency" value="TC-LD-VD">TC LD VD</usg>
  <usg type="frequency" value="TC-LD-VR">TC LD VR</usg>
  <usg type="frequency" value="TC-LD-VX">TC LD VX</usg>
  <usg type="frequency" value="TC-LR-VB">TC LR VB</usg>
  <usg type="frequency" value="TC-LR-VC">TC LR VC</usg>
  <usg type="frequency" value="TC-LR-VD">TC LR VD</usg>
  <usg type="frequency" value="TC-LR-VR">TC LR VR</usg>
  <usg type="frequency" value="TC-LR-VX">TC LR VX</usg>
  <usg type="frequency" value="TC-LX-VB">TC LX VB</usg>
  <usg type="frequency" value="TC-LX-VC">TC LX VC</usg>
  <usg type="frequency" value="TC-LX-VD">TC LX VD</usg>
  <usg type="frequency" value="TC-LX-VR">TC LX VR</usg>
  <usg type="frequency" value="TD">TD</usg>
  <usg type="frequency" value="TD-LB-VC">TD LB VC</usg>
  <usg type="frequency" value="TD-LB-VX">TD LB VX</usg>
  <usg type="frequency" value="TD-LC-VC">TD LC VC</usg>
  <usg type="frequency" value="TD-LC-VD">TD LC VD</usg>
  <usg type="frequency" value="TD-LC-VR">TD LC VR</usg>
  <usg type="frequency" value="TD-LC-VX">TD LC VX</usg>
  <usg type="frequency" value="TD-LD-VB">TD LD VB</usg>
  <usg type="frequency" value="TD-LD-VC">TD LD VC</usg>
  <usg type="frequency" value="TD-LD-VD">TD LD VD</usg>
  <usg type="frequency" value="TD-LD-VR">TD LD VR</usg>
  <usg type="frequency" value="TD-LD-VX">TD LD VX</usg>
  <usg type="frequency" value="TD-LE-VE">TD LE VE</usg>
  <usg type="frequency" value="TD-LR-VC">TD LR VC</usg>
  <usg type="frequency" value="TD-LR-VD">TD LR VD</usg>
  <usg type="frequency" value="TD-LR-VR">TD LR VR</usg>
  <usg type="frequency" value="TD-LR-VX">TD LR VX</usg>
  <usg type="frequency" value="TD-LX-VC">TD LX VC</usg>
  <usg type="frequency" value="TD-LX-VD">TD LX VD</usg>
  <usg type="frequency" value="TD-LX-VR">TD LX VR</usg>
  <usg type="frequency" value="TE">TE</usg>
  <usg type="frequency" value="TE-LC-VC">TE LC VC</usg>
  <usg type="frequency" value="TE-LC-VX">TE LC VX</usg>
  <usg type="frequency" value="TE-LD-VC">TE LD VC</usg>
  <usg type="frequency" value="TE-LD-VR">TE LD VR</usg>
  <usg type="frequency" value="TE-LD-VX">TE LD VX</usg>
  <usg type="frequency" value="TE-LR-VC">TE LR VC</usg>
  <usg type="frequency" value="TE-LR-VD">TE LR VD</usg>
  <usg type="frequency" value="TE-LR-VR">TE LR VR</usg>
  <usg type="frequency" value="TE-LR-VX">TE LR VX</usg>
  <usg type="frequency" value="TE-LX-VD">TE LX VD</usg>
  <usg type="frequency" value="TE-LX-VR">TE LX VR</usg>
  <usg type="frequency" value="TE-R">TE R</usg>
  <usg type="frequency" value="TR">TR</usg>
  <usg type="frequency" value="TR-LD-VX">TR LD VX</usg>
  <usg type="frequency" value="TR-LR-VC">TR LR VC</usg>
  <usg type="frequency" value="TR-LR-VR">TR LR VR</usg>
  <usg type="frequency" value="TR-LR-VX">TR LR VX</usg>
  <usg type="frequency" value="TR-LX-VC">TR LX VC</usg>
  <usg type="frequency" value="TR-LX-VD">TR LX VD</usg>
  <usg type="frequency" value="TR-LX-VR">TR LX VR</usg>
  <usg type="frequency" value="TR-SD">TR SD</usg>
  <usg type="frequency" value="TX">TX</usg>
  <usg type="frequency" value="TX-LR-VX">TX LR VX</usg>
  <usg type="frequency" value="TX-LX-VR">TX LX VR</usg>
  <usg type="frequency" value="VC-LB-VC">VC LB VC</usg>
  <usg type="frequency" value="VC-LD-VB">VC LD VB</usg>
  <usg type="frequency" value="VC-LD-VC">VC LD VC</usg>
  <usg type="frequency" value="VC-LD-VR">VC LD VR</usg>
  <usg type="frequency" value="VD">VD</usg>
  <usg type="frequency" value="VD-LD-VC">VD LD VC</usg>
  <usg type="frequency" value="VD-LR-VR">VD LR VR</usg>
  <usg type="frequency" value="VD-LR-VX">VD LR VX</usg>
  <usg type="frequency" value="VD-LX-VD">VD LX VD</usg>
  <usg type="frequency" value="VE">VE</usg>
  <usg type="frequency" value="VR">VR</usg>
  <usg type="frequency" value="VX">VX</usg>
 </xsl:variable>
 

    <xsl:variable name="frequencies-all">
        <usg type="frequency">TX LX SX</usg>
        <usg type="frequency">TX LX SR</usg>
        <usg type="frequency">TX LX SE</usg>
        <usg type="frequency">TX LX SD</usg>
        <usg type="frequency">TX LX SC</usg>
        <usg type="frequency">TX LX SB</usg>
        <usg type="frequency">TX LX SA</usg>
        <usg type="frequency">TX LR SX</usg>
        <usg type="frequency">TX LR SR</usg>
        <usg type="frequency">TX LR SE</usg>
        <usg type="frequency">TX LR SD</usg>
        <usg type="frequency">TX LR SC</usg>
        <usg type="frequency">TX LR SB</usg>
        <usg type="frequency">TX LR SA</usg>
        <usg type="frequency">TX LE SX</usg>
        <usg type="frequency">TX LE SR</usg>
        <usg type="frequency">TX LE SE</usg>
        <usg type="frequency">TX LE SD</usg>
        <usg type="frequency">TX LE SC</usg>
        <usg type="frequency">TX LE SB</usg>
        <usg type="frequency">TX LE SA</usg>
        <usg type="frequency">TX LD SX</usg>
        <usg type="frequency">TX LD SR</usg>
        <usg type="frequency">TX LD SE</usg>
        <usg type="frequency">TX LD SD</usg>
        <usg type="frequency">TX LD SC</usg>
        <usg type="frequency">TX LD SB</usg>
        <usg type="frequency">TX LD SA</usg>
        <usg type="frequency">TX LC SX</usg>
        <usg type="frequency">TX LC SR</usg>
        <usg type="frequency">TX LC SE</usg>
        <usg type="frequency">TX LC SD</usg>
        <usg type="frequency">TX LC SC</usg>
        <usg type="frequency">TX LC SB</usg>
        <usg type="frequency">TX LC SA</usg>
        <usg type="frequency">TX LB SX</usg>
        <usg type="frequency">TX LB SR</usg>
        <usg type="frequency">TX LB SE</usg>
        <usg type="frequency">TX LB SD</usg>
        <usg type="frequency">TX LB SC</usg>
        <usg type="frequency">TX LB SB</usg>
        <usg type="frequency">TX LB SA</usg>
        <usg type="frequency">TX LA SX</usg>
        <usg type="frequency">TX LA SR</usg>
        <usg type="frequency">TX LA SE</usg>
        <usg type="frequency">TX LA SD</usg>
        <usg type="frequency">TX LA SC</usg>
        <usg type="frequency">TX LA SB</usg>
        <usg type="frequency">TX LA SA</usg>
        <usg type="frequency">TR LX SX</usg>
        <usg type="frequency">TR LX SR</usg>
        <usg type="frequency">TR LX SE</usg>
        <usg type="frequency">TR LX SD</usg>
        <usg type="frequency">TR LX SC</usg>
        <usg type="frequency">TR LX SB</usg>
        <usg type="frequency">TR LX SA</usg>
        <usg type="frequency">TR LR SX</usg>
        <usg type="frequency">TR LR SR</usg>
        <usg type="frequency">TR LR SE</usg>
        <usg type="frequency">TR LR SD</usg>
        <usg type="frequency">TR LR SC</usg>
        <usg type="frequency">TR LR SB</usg>
        <usg type="frequency">TR LR SA</usg>
        <usg type="frequency">TR LE SX</usg>
        <usg type="frequency">TR LE SR</usg>
        <usg type="frequency">TR LE SE</usg>
        <usg type="frequency">TR LE SD</usg>
        <usg type="frequency">TR LE SC</usg>
        <usg type="frequency">TR LE SB</usg>
        <usg type="frequency">TR LE SA</usg>
        <usg type="frequency">TR LD SX</usg>
        <usg type="frequency">TR LD SR</usg>
        <usg type="frequency">TR LD SE</usg>
        <usg type="frequency">TR LD SD</usg>
        <usg type="frequency">TR LD SC</usg>
        <usg type="frequency">TR LD SB</usg>
        <usg type="frequency">TR LD SA</usg>
        <usg type="frequency">TR LC SX</usg>
        <usg type="frequency">TR LC SR</usg>
        <usg type="frequency">TR LC SE</usg>
        <usg type="frequency">TR LC SD</usg>
        <usg type="frequency">TR LC SC</usg>
        <usg type="frequency">TR LC SB</usg>
        <usg type="frequency">TR LC SA</usg>
        <usg type="frequency">TR LB SX</usg>
        <usg type="frequency">TR LB SR</usg>
        <usg type="frequency">TR LB SE</usg>
        <usg type="frequency">TR LB SD</usg>
        <usg type="frequency">TR LB SC</usg>
        <usg type="frequency">TR LB SB</usg>
        <usg type="frequency">TR LB SA</usg>
        <usg type="frequency">TR LA SX</usg>
        <usg type="frequency">TR LA SR</usg>
        <usg type="frequency">TR LA SE</usg>
        <usg type="frequency">TR LA SD</usg>
        <usg type="frequency">TR LA SC</usg>
        <usg type="frequency">TR LA SB</usg>
        <usg type="frequency">TR LA SA</usg>
        <usg type="frequency">TE LX SX</usg>
        <usg type="frequency">TE LX SR</usg>
        <usg type="frequency">TE LX SE</usg>
        <usg type="frequency">TE LX SD</usg>
        <usg type="frequency">TE LX SC</usg>
        <usg type="frequency">TE LX SB</usg>
        <usg type="frequency">TE LX SA</usg>
        <usg type="frequency">TE LR SX</usg>
        <usg type="frequency">TE LR SR</usg>
        <usg type="frequency">TE LR SE</usg>
        <usg type="frequency">TE LR SD</usg>
        <usg type="frequency">TE LR SC</usg>
        <usg type="frequency">TE LR SB</usg>
        <usg type="frequency">TE LR SA</usg>
        <usg type="frequency">TE LE SX</usg>
        <usg type="frequency">TE LE SR</usg>
        <usg type="frequency">TE LE SE</usg>
        <usg type="frequency">TE LE SD</usg>
        <usg type="frequency">TE LE SC</usg>
        <usg type="frequency">TE LE SB</usg>
        <usg type="frequency">TE LE SA</usg>
        <usg type="frequency">TE LD SX</usg>
        <usg type="frequency">TE LD SR</usg>
        <usg type="frequency">TE LD SE</usg>
        <usg type="frequency">TE LD SD</usg>
        <usg type="frequency">TE LD SC</usg>
        <usg type="frequency">TE LD SB</usg>
        <usg type="frequency">TE LD SA</usg>
        <usg type="frequency">TE LC SX</usg>
        <usg type="frequency">TE LC SR</usg>
        <usg type="frequency">TE LC SE</usg>
        <usg type="frequency">TE LC SD</usg>
        <usg type="frequency">TE LC SC</usg>
        <usg type="frequency">TE LC SB</usg>
        <usg type="frequency">TE LC SA</usg>
        <usg type="frequency">TE LB SX</usg>
        <usg type="frequency">TE LB SR</usg>
        <usg type="frequency">TE LB SE</usg>
        <usg type="frequency">TE LB SD</usg>
        <usg type="frequency">TE LB SC</usg>
        <usg type="frequency">TE LB SB</usg>
        <usg type="frequency">TE LB SA</usg>
        <usg type="frequency">TE LA SX</usg>
        <usg type="frequency">TE LA SR</usg>
        <usg type="frequency">TE LA SE</usg>
        <usg type="frequency">TE LA SD</usg>
        <usg type="frequency">TE LA SC</usg>
        <usg type="frequency">TE LA SB</usg>
        <usg type="frequency">TE LA SA</usg>
        <usg type="frequency">TD LX SX</usg>
        <usg type="frequency">TD LX SR</usg>
        <usg type="frequency">TD LX SE</usg>
        <usg type="frequency">TD LX SD</usg>
        <usg type="frequency">TD LX SC</usg>
        <usg type="frequency">TD LX SB</usg>
        <usg type="frequency">TD LX SA</usg>
        <usg type="frequency">TD LR SX</usg>
        <usg type="frequency">TD LR SR</usg>
        <usg type="frequency">TD LR SE</usg>
        <usg type="frequency">TD LR SD</usg>
        <usg type="frequency">TD LR SC</usg>
        <usg type="frequency">TD LR SB</usg>
        <usg type="frequency">TD LR SA</usg>
        <usg type="frequency">TD LE SX</usg>
        <usg type="frequency">TD LE SR</usg>
        <usg type="frequency">TD LE SE</usg>
        <usg type="frequency">TD LE SD</usg>
        <usg type="frequency">TD LE SC</usg>
        <usg type="frequency">TD LE SB</usg>
        <usg type="frequency">TD LE SA</usg>
        <usg type="frequency">TD LD SX</usg>
        <usg type="frequency">TD LD SR</usg>
        <usg type="frequency">TD LD SE</usg>
        <usg type="frequency">TD LD SD</usg>
        <usg type="frequency">TD LD SC</usg>
        <usg type="frequency">TD LD SB</usg>
        <usg type="frequency">TD LD SA</usg>
        <usg type="frequency">TD LC SX</usg>
        <usg type="frequency">TD LC SR</usg>
        <usg type="frequency">TD LC SE</usg>
        <usg type="frequency">TD LC SD</usg>
        <usg type="frequency">TD LC SC</usg>
        <usg type="frequency">TD LC SB</usg>
        <usg type="frequency">TD LC SA</usg>
        <usg type="frequency">TD LB SX</usg>
        <usg type="frequency">TD LB SR</usg>
        <usg type="frequency">TD LB SE</usg>
        <usg type="frequency">TD LB SD</usg>
        <usg type="frequency">TD LB SC</usg>
        <usg type="frequency">TD LB SB</usg>
        <usg type="frequency">TD LB SA</usg>
        <usg type="frequency">TD LA SX</usg>
        <usg type="frequency">TD LA SR</usg>
        <usg type="frequency">TD LA SE</usg>
        <usg type="frequency">TD LA SD</usg>
        <usg type="frequency">TD LA SC</usg>
        <usg type="frequency">TD LA SB</usg>
        <usg type="frequency">TD LA SA</usg>
        <usg type="frequency">TC LX SX</usg>
        <usg type="frequency">TC LX SR</usg>
        <usg type="frequency">TC LX SE</usg>
        <usg type="frequency">TC LX SD</usg>
        <usg type="frequency">TC LX SC</usg>
        <usg type="frequency">TC LX SB</usg>
        <usg type="frequency">TC LX SA</usg>
        <usg type="frequency">TC LR SX</usg>
        <usg type="frequency">TC LR SR</usg>
        <usg type="frequency">TC LR SE</usg>
        <usg type="frequency">TC LR SD</usg>
        <usg type="frequency">TC LR SC</usg>
        <usg type="frequency">TC LR SB</usg>
        <usg type="frequency">TC LR SA</usg>
        <usg type="frequency">TC LE SX</usg>
        <usg type="frequency">TC LE SR</usg>
        <usg type="frequency">TC LE SE</usg>
        <usg type="frequency">TC LE SD</usg>
        <usg type="frequency">TC LE SC</usg>
        <usg type="frequency">TC LE SB</usg>
        <usg type="frequency">TC LE SA</usg>
        <usg type="frequency">TC LD SX</usg>
        <usg type="frequency">TC LD SR</usg>
        <usg type="frequency">TC LD SE</usg>
        <usg type="frequency">TC LD SD</usg>
        <usg type="frequency">TC LD SC</usg>
        <usg type="frequency">TC LD SB</usg>
        <usg type="frequency">TC LD SA</usg>
        <usg type="frequency">TC LC SX</usg>
        <usg type="frequency">TC LC SR</usg>
        <usg type="frequency">TC LC SE</usg>
        <usg type="frequency">TC LC SD</usg>
        <usg type="frequency">TC LC SC</usg>
        <usg type="frequency">TC LC SB</usg>
        <usg type="frequency">TC LC SA</usg>
        <usg type="frequency">TC LB SX</usg>
        <usg type="frequency">TC LB SR</usg>
        <usg type="frequency">TC LB SE</usg>
        <usg type="frequency">TC LB SD</usg>
        <usg type="frequency">TC LB SC</usg>
        <usg type="frequency">TC LB SB</usg>
        <usg type="frequency">TC LB SA</usg>
        <usg type="frequency">TC LA SX</usg>
        <usg type="frequency">TC LA SR</usg>
        <usg type="frequency">TC LA SE</usg>
        <usg type="frequency">TC LA SD</usg>
        <usg type="frequency">TC LA SC</usg>
        <usg type="frequency">TC LA SB</usg>
        <usg type="frequency">TC LA SA</usg>
        <usg type="frequency">TB LX SX</usg>
        <usg type="frequency">TB LX SR</usg>
        <usg type="frequency">TB LX SE</usg>
        <usg type="frequency">TB LX SD</usg>
        <usg type="frequency">TB LX SC</usg>
        <usg type="frequency">TB LX SB</usg>
        <usg type="frequency">TB LX SA</usg>
        <usg type="frequency">TB LR SX</usg>
        <usg type="frequency">TB LR SR</usg>
        <usg type="frequency">TB LR SE</usg>
        <usg type="frequency">TB LR SD</usg>
        <usg type="frequency">TB LR SC</usg>
        <usg type="frequency">TB LR SB</usg>
        <usg type="frequency">TB LR SA</usg>
        <usg type="frequency">TB LE SX</usg>
        <usg type="frequency">TB LE SR</usg>
        <usg type="frequency">TB LE SE</usg>
        <usg type="frequency">TB LE SD</usg>
        <usg type="frequency">TB LE SC</usg>
        <usg type="frequency">TB LE SB</usg>
        <usg type="frequency">TB LE SA</usg>
        <usg type="frequency">TB LD SX</usg>
        <usg type="frequency">TB LD SR</usg>
        <usg type="frequency">TB LD SE</usg>
        <usg type="frequency">TB LD SD</usg>
        <usg type="frequency">TB LD SC</usg>
        <usg type="frequency">TB LD SB</usg>
        <usg type="frequency">TB LD SA</usg>
        <usg type="frequency">TB LC SX</usg>
        <usg type="frequency">TB LC SR</usg>
        <usg type="frequency">TB LC SE</usg>
        <usg type="frequency">TB LC SD</usg>
        <usg type="frequency">TB LC SC</usg>
        <usg type="frequency">TB LC SB</usg>
        <usg type="frequency">TB LC SA</usg>
        <usg type="frequency">TB LB SX</usg>
        <usg type="frequency">TB LB SR</usg>
        <usg type="frequency">TB LB SE</usg>
        <usg type="frequency">TB LB SD</usg>
        <usg type="frequency">TB LB SC</usg>
        <usg type="frequency">TB LB SB</usg>
        <usg type="frequency">TB LB SA</usg>
        <usg type="frequency">TB LA SX</usg>
        <usg type="frequency">TB LA SR</usg>
        <usg type="frequency">TB LA SE</usg>
        <usg type="frequency">TB LA SD</usg>
        <usg type="frequency">TB LA SC</usg>
        <usg type="frequency">TB LA SB</usg>
        <usg type="frequency">TB LA SA</usg>
        <usg type="frequency">TA LX SX</usg>
        <usg type="frequency">TA LX SR</usg>
        <usg type="frequency">TA LX SE</usg>
        <usg type="frequency">TA LX SD</usg>
        <usg type="frequency">TA LX SC</usg>
        <usg type="frequency">TA LX SB</usg>
        <usg type="frequency">TA LX SA</usg>
        <usg type="frequency">TA LR SX</usg>
        <usg type="frequency">TA LR SR</usg>
        <usg type="frequency">TA LR SE</usg>
        <usg type="frequency">TA LR SD</usg>
        <usg type="frequency">TA LR SC</usg>
        <usg type="frequency">TA LR SB</usg>
        <usg type="frequency">TA LR SA</usg>
        <usg type="frequency">TA LE SX</usg>
        <usg type="frequency">TA LE SR</usg>
        <usg type="frequency">TA LE SE</usg>
        <usg type="frequency">TA LE SD</usg>
        <usg type="frequency">TA LE SC</usg>
        <usg type="frequency">TA LE SB</usg>
        <usg type="frequency">TA LE SA</usg>
        <usg type="frequency">TA LD SX</usg>
        <usg type="frequency">TA LD SR</usg>
        <usg type="frequency">TA LD SE</usg>
        <usg type="frequency">TA LD SD</usg>
        <usg type="frequency">TA LD SC</usg>
        <usg type="frequency">TA LD SB</usg>
        <usg type="frequency">TA LD SA</usg>
        <usg type="frequency">TA LC SX</usg>
        <usg type="frequency">TA LC SR</usg>
        <usg type="frequency">TA LC SE</usg>
        <usg type="frequency">TA LC SD</usg>
        <usg type="frequency">TA LC SC</usg>
        <usg type="frequency">TA LC SB</usg>
        <usg type="frequency">TA LC SA</usg>
        <usg type="frequency">TA LB SX</usg>
        <usg type="frequency">TA LB SR</usg>
        <usg type="frequency">TA LB SE</usg>
        <usg type="frequency">TA LB SD</usg>
        <usg type="frequency">TA LB SC</usg>
        <usg type="frequency">TA LB SB</usg>
        <usg type="frequency">TA LB SA</usg>
        <usg type="frequency">TA LA SX</usg>
        <usg type="frequency">TA LA SR</usg>
        <usg type="frequency">TA LA SE</usg>
        <usg type="frequency">TA LA SD</usg>
        <usg type="frequency">TA LA SC</usg>
        <usg type="frequency">TA LA SB</usg>
        <usg type="frequency">TA LA SA</usg>
    </xsl:variable>

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <title>LeDIIR</title>
                <!--<link rel="stylesheet" type="text/css" href="lediir.css" />-->
             <style>
              
              .tei-orth {display: table-cell; padding-left: 0.5em; }
              .tei-pron {display: table-cell; padding-left: 0.5em; }
              
              .tei-pron {color: orange; margin-left: 1em;}
              .tei-pron::before { content: " ["  }
              .tei-pron::after { content: "]"  }
              .tei-form {}
              
              .tei-orth { font-size: 2em; }
              
              body {
              display:flex;
              max-width:1200px;
              margin:0 auto;
              }
              
              main {
              flex-grow:1;
              }
              
              aside {
              width: 40%;
              padding-left: .5rem;
              margin-left: .5rem;
              flex-shrink:0;
              width:280px;
              }
              
              @media all and (max-width: 800px) {
              
              body {
              flex-flow:column;
              }
              
              /* Make the sidebar take the entire width of the screen */
              
              aside {
              width:auto;
              }
              
              }
              .frequency-chart {
              position: relative;
              top: 0.8em;
              border-radius: 5px;
              border: 1px solid #495C2D;
              padding-left: 5px;
              margin-left: 1em;
              }
             </style>
                <!-- https://stackoverflow.com/questions/43008609/expanding-all-details-tags -->
                <xsl:call-template name="svg-styles" />
            </head>
            <body>
                <main>
                    <h2>Slovníková hesla</h2>
                    <hr />
                    <table style="padding: 1em; border-collapse: collapse;">
                        <thead>
                            <tr>
                                <th>Střední varianta</th>
                                <th>Široká varianta</th>
                                <th>Úzká varianta</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="$frequencies/usg">
                                <xsl:variable name="frq" select="." />
                                <tr>
                                    <td style="padding: 2rem; border-bottom: 1px solid silver; ">
                                        <span class="tei-form">
                                            <span class="tei-orth" xml:lang="fa" lang="fa">آئورت</span>
                                            <span class="tei-pron">a´ort</span>
                                        </span>
                                        <xsl:apply-templates select="$frq" />
                                    </td>
                                    <td style="padding: 2rem; border-bottom: 1px solid silver; border-left: 1px solid silver; ">
                                        <span class="tei-form">
                                            <span class="tei-orth" xml:lang="fa" lang="fa">آئورت</span>
                                            <span class="tei-pron">a´ort</span>
                                        </span>
                                        <xsl:apply-templates select="$frq" mode="wider" />
                                    </td>
                                    <td style="padding: 2rem; border-bottom: 1px solid silver; border-left: 1px solid silver; ">
                                        <span class="tei-form">
                                            <span class="tei-orth" xml:lang="fa" lang="fa">آئورت</span>
                                            <span class="tei-pron">a´ort</span>
                                        </span>
                                        <xsl:apply-templates select="$frq" mode="taller" />
                                    </td>
                                </tr>
                            </xsl:for-each>

                        </tbody>

                    </table>
                </main>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="usg">
      <xsl:call-template name="process-frequency" />
    </xsl:template>

    <xsl:template match="usg" mode="wider">
        <xsl:call-template name="process-frequency">
            <xsl:with-param name="frequency-step-width" select="5" />
            <xsl:with-param name="frequency-box-width" select="130" />
        </xsl:call-template>
    </xsl:template>

    <xsl:template match="usg" mode="taller">
     <xsl:variable name="value" select="translate(normalize-space(.), ' ', '-')"/>
     <xsl:call-template name="process-frequency">
      <xsl:with-param name="frequency-step-width" select="1.5" />
      <xsl:with-param name="frequency-box-width" select="60" />
     </xsl:call-template>
     
     <!-- Pro vygenerování souborů do uvedené složky odkomentujte následující element. -->
     <!--<xsl:result-document href="../../Dictionary/resources/images/frequency/{$value}.svg">
      <xsl:call-template name="process-frequency">
            <xsl:with-param name="frequency-step-width" select="1.5" />
            <xsl:with-param name="frequency-box-width" select="60" />
        </xsl:call-template>
     </xsl:result-document>-->
    </xsl:template>


</xsl:stylesheet>
