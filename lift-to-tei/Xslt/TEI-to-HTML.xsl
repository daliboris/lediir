<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:xs="http://www.w3.org/2001/XMLSchema"
 xmlns:tei="http://www.tei-c.org/ns/1.0"
 xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
 exclude-result-prefixes="xs tei xd"
 version="3.0">
 
 <xsl:import href="TEI-to-HTML-common.xsl"/>
 <xsl:import href="TEI-to-Frequency.xsl"/>
 <xsl:import href="TEI-to-Facets.xsl"/>
 
 <xsl:strip-space elements="*"/> <!-- tei:pc tei:gramGrp -->
 <!--<xsl:preserve-space elements="tei:pc tei:gramGrp"/>-->
 <xsl:output method="xhtml" indent="yes" encoding="UTF-8" omit-xml-declaration="yes" html-version="5" />
 
 <xsl:template match="/">
  <html>
   <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>LeDIIR</title>
    <link rel="stylesheet" type="text/css" href="lediir.css"></link>
    <!-- https://stackoverflow.com/questions/43008609/expanding-all-details-tags -->
    <script>
     
     function AddFunctionality() {
     // Reference the toggle link
     var xa = document.getElementById('expAll');
     
     // Register link on click event
     xa.addEventListener('click', function(e) {
     
     /* Toggle the two classes that represent "state"
     || determined when link is clicked
     */
     e.target.classList.toggle('exp');
     e.target.classList.toggle('col');
     
     // Collect all details into a NodeList
      var details = document.querySelectorAll('details');
      
      /* Convert NodeList into an array then iterate
      || throught it...
      */
      Array.from(details).forEach(function(obj, idx) {
      
      /* If the link has the class .exp...
      || make each detail's open attribute true
       */
       if (e.target.classList.contains('exp')) {
       obj.open = true;
       // Otherwise make it false
       } else {
       obj.open = false;
       }
       
       });
       
       }, false);
       
       var xa = document.getElementById('changeAbbr');
       
       xa.addEventListener('click', function(e) {
       
       var abbrItems = document.querySelectorAll('span[data-abbr]');
       abbrItems.forEach(function(abbrItem) {
            var text = abbrItem.textContent;
            var abbr = abbrItem.getAttribute("data-abbr");
            var expanded = abbrItem.getAttribute("data-abbr-expanded");
            if(text == abbr)
                {abbrItem.textContent = expanded;}
            else {abbrItem.textContent = abbr;  }
       });
       
       }, false);
       
       }
    </script>
    <xsl:call-template name="svg-styles"/>
   </head>
   <body onload="AddFunctionality()">
    <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:classDecl" />
    
    <aside>
     <h2>Filtry</h2>
     <xsl:call-template name="create-facets" />
    </aside>
    <main>
     <h2>Slovníková hesla</h2>
     <p><a href='#' id='expAll' class='exp'>Rozbalit vše</a> (poprvé je potřeba kliknout dvakrát); <a href='#' id='changeAbbr'>Změnit zkratky na rozepsané a naopak</a></p>
     <hr />
     <div id="hesla" class="collapse">
      <xsl:apply-templates select="tei:TEI/tei:text/tei:body" />
     </div>
    </main>
   </body>
  </html>
 </xsl:template>
 
 <xd:doc>
  <xd:desc/>
 </xd:doc>
 
 
 <xsl:template match="tei:div">
  <section>
   <details>
    <summary><xsl:apply-templates select="tei:head" /></summary> 
   <xsl:apply-templates select="tei:entry[not(@copyOf)]" />
   </details>
  </section>
 </xsl:template>

 <xsl:template match="tei:div/tei:head">
  <h1><xsl:apply-templates /></h1>
 </xsl:template>
 
 <!-- TODO: dodělat pouze odkazová hesla; viz např. xml:id="FACS.bd72fc2f-090c-4d3b-8c66-0328217ddcc1"
  match="tei:entry[tei:form[not(tei:orth[not(@type)])]]
 -->
 
 <xsl:template match="tei:entry[tei:form[not(tei:orth[not(@type)])]]" priority="5" />
 
 <xsl:template match="tei:entry[not(@copyOf)][tei:form[tei:orth[not(@type)]]]">
  <hr style="margin: 1em;" />
  <article class="entry" id="{@xml:id}">
   <details>
    <summary>
     <h4>
      <input type="checkbox" />
      <!--<xsl:apply-templates select="* except (tei:sense | tei:xr | tei:etym | tei:entry[@copyOf])" />-->
      <xsl:apply-templates select="* except (tei:sense | tei:usg[@type='frequency'] | tei:xr | tei:etym | tei:entry[@copyOf])" />
      <xsl:apply-templates select="tei:sense[1]" mode="summary" />
      <xsl:apply-templates select="tei:usg[@type='frequency']" />
     </h4>
    </summary>
    <xsl:apply-templates select="tei:etym" />
    <xsl:apply-templates select="tei:sense" />
    <xsl:apply-templates select="tei:xr[not(@type=('_component-lexeme'))]" />
    <!--<xsl:apply-templates />-->
    <xsl:if test="tei:entry[@copyOf]">
     
      <details class="complex-forms">
       <summary>
        <h5>Komplexní formy</h5>
       </summary>
       <xsl:for-each select="tei:entry">
        <xsl:apply-templates select="." mode="copy-entry" />
       </xsl:for-each>
      </details>
     
    </xsl:if>
   </details>
  </article>
  <!--<div class="tei-entry">
   <xsl:apply-templates />
  </div>-->
 </xsl:template>
 
 <xsl:template match="tei:entry[@copyOf][tei:form[tei:orth[not(@type)]]]" mode="copy-entry">
  <xsl:variable name="entry" select="id(substring-after(@copyOf, '#'))"/>
  <hr style="margin: 1em;" />
  <article class="entry copy" id="{substring-after(@copyOf, '#')}-copy">
   <!--<details>-->
<!--    <summary>
     <h6>
      <!-\-<input type="checkbox" />-\->
      <xsl:apply-templates select="tei:form" mode="#current" />
 <!-\-     <xsl:apply-templates select="$entry/* except ($entry/tei:sense |  $entry/tei:usg[@type='frequency'] | $entry/tei:xr | $entry/tei:etym | $entry/tei:entry[@copyOf])" />-\->
      <!-\-<xsl:apply-templates select="tei:sense[1]" mode="summary" />-\->
      <!-\-<xsl:apply-templates select="tei:usg[@type='frequency']" />-\->
     </h6>
    </summary>-->
   <h6>
    <xsl:apply-templates select="tei:form" mode="#current" />
    <xsl:apply-templates select="$entry/tei:sense" mode="summary" />
   </h6>
    <!--<xsl:apply-templates select="$entry/tei:etym" />
    <xsl:apply-templates select="$entry/tei:sense" />
    <xsl:apply-templates select="$entry/tei:xr[not(@type=('_component-lexeme'))]" />-->
   <!--</details>-->
  </article>
  <!--<div class="tei-entry">
   <xsl:apply-templates />
  </div>-->
 </xsl:template>
 
 <xsl:template match="tei:form[not(@type='variant')][tei:orth[not(@type)]]" mode="copy-entry">
  <a href="{parent::tei:entry/@copyOf}">
   <span class="tei-form"><xsl:apply-templates mode="#current" /></span>   
  </a>
 </xsl:template>
 
 <xsl:template match="tei:form[not(@type='variant')]">
  <span class="tei-form"><xsl:apply-templates /></span>
 </xsl:template>
 
 <xsl:template match="tei:form[not(@type='variant')]/tei:orth" mode="#default copy-entry">
  <xsl:variable name="lang" select="(ancestor-or-self::*/@xml:lang)[last()]"/>
  <span class="tei-orth" xml:lang="{$lang}" lang="{$lang}">
    <xsl:call-template name="add-dir-attribute">
     <xsl:with-param name="lang" select="$lang" />
    </xsl:call-template>
      <xsl:apply-templates />
  </span>
 </xsl:template>
 
 
 <xd:doc>
  <xd:desc>
   <xd:p>Variantní podoby jsou ve slovníku pouze kvůli vyhledávání, uživateli se nezobrazují</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:form[@type='variant']" priority="2" mode="#all" />
 
 
 <xsl:template match="tei:note">
  <div class="tei-note">
   <xsl:apply-templates />
  </div>
 </xsl:template>
 
 <xsl:template match="tei:pron">
  <span class="tei-pron"><xsl:apply-templates /></span>
 </xsl:template>
 
 
 <xd:doc>
  <xd:desc>
   <xd:p>U komplexních forem se v zahnízovaných heslech výslovnost neuvádí</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:pron" mode="copy-entry" />
 
 
 <xsl:template match="tei:sense" mode="summary">
  <span class="tei-sense summary">
   <xsl:if test="@n">
   <span class="tei-sense-num"><xsl:value-of select="@n"/></span>
   </xsl:if>
   <xsl:apply-templates select="tei:def" />
  </span>
 </xsl:template>
 
 <xsl:template match="tei:sense">
  <div class="tei-sense" id="{@xml:id}" dir="ltr">
   <xsl:if test="@n">
    <span class="tei-sense-num"><xsl:value-of select="@n"/></span>
   </xsl:if>
   <xsl:apply-templates />
  </div>
 </xsl:template>
 
 <xsl:template match="tei:sense/tei:form[@type='inflected']" priority="3">
  <span class="tei-form-inflected">
   <xsl:apply-templates select="ancestor::tei:entry/tei:form[@type='lemma']/tei:orth[not(@type)][1]"/>
   <xsl:apply-templates />
  </span>
 </xsl:template>
 
 <xsl:template match="tei:usg[@type='meaningType']">
  <span class="tei-{name()} {@type}"><xsl:apply-templates /></span>
  <xsl:text> </xsl:text>
 </xsl:template>
 
 <xsl:template match="tei:usg[@type='frequency']">
  <span class="tei-frequency">
   <!--<xsl:apply-templates />-->
   <xsl:call-template name="process-frequency" />
  </span>
 </xsl:template>

 <xsl:template match="tei:def">
  <span class="tei-def"><xsl:apply-templates /></span>
 </xsl:template>
 
 <xsl:template match="tei:usg[@type='domain'][1]">
  <div class="tei-usg-domain">
   <ul>
    <xsl:apply-templates select=". | following-sibling::tei:usg[@type='domain']" mode="domain">
     <xsl:sort select="tei:idno" />
    </xsl:apply-templates>
   </ul>
  </div>
 </xsl:template>
 
 <xsl:template match="tei:usg[@type='domain'][position() gt 1]" />
 
 <xsl:template match="tei:usg[@type='domain']" mode="domain">
  <li>
   <xsl:apply-templates />
  </li>
 </xsl:template>
 
 <xsl:template match="tei:usg[@type='domain']/tei:idno">
  <a href="TEI-taxonomy.html#LeDIIR.taxonomy.{.}" target="taxonomy"><xsl:apply-templates /></a>
 </xsl:template>
 
 <xsl:template match="tei:note[@type='reversal']">
  <!--<div class="tei-note">
   <span>Viz též: </span>
   <xsl:apply-templates />
  </div>-->
 </xsl:template>
 
 <xsl:template match="tei:xr[@type='reversal']">
  <span class="tei-xr-reversal"><xsl:apply-templates /></span>
 </xsl:template>
 
 <xsl:template match="tei:cit[@type='example']">
  <div class="tei-cit-example"><xsl:apply-templates /></div>
 </xsl:template>
 
 <xsl:template match="tei:cit[@type='example']/tei:quote">
  <span class="tei-quote" data-tei-tag="quote" xml:lang="{@xml:lang}" lang="{@xml:lang}"><xsl:apply-templates /></span>
  <span class="quote-index">☚</span>
 </xsl:template>
 
 <xsl:template match="tei:cit[@type='translation']/tei:quote">
  <span class="translation-index">☛</span>
  <span class="tei-translation" xml:lang="{parent::tei:cit/@xml:lang}" lang="{parent::tei:cit/@xml:lang}"><xsl:apply-templates /></span>
 </xsl:template>
 
 <xsl:template match="tei:ref">
  <a href="{@target}"><xsl:apply-templates /></a>
 </xsl:template>
 
 <xsl:template match="tei:gramGrp">
  <span class="tei-gramGrp"><xsl:apply-templates /><xsl:text>: </xsl:text></span>
 </xsl:template>
 
 <xsl:template match="tei:gram">
  <xsl:variable name="abbr" select="."/>
  <xsl:variable name="text">
   <xsl:call-template name="abbr-pos-to-text">
    <xsl:with-param name="abbr" select="$abbr" />
   </xsl:call-template>
  </xsl:variable>
  <xsl:variable name="abbreviation">
   <xsl:call-template name="abbr-pos-to-abbreviation">
    <xsl:with-param name="abbr" select="$abbr" />
   </xsl:call-template>
  </xsl:variable>
  <span data-tei-type="{name()}" data-abbr="{$abbreviation}" data-abbr-expanded="{$text}" title="{$text}">
   <xsl:value-of select="$text"/>
  </span>
 </xsl:template>
 
 <xsl:template match="tei:gramGrp[tei:gram[@type='collocate']]">
  <span class="tei-gramGrp"><xsl:apply-templates /></span>
 </xsl:template>
 
 <xsl:template match="tei:gram[@type='collocate']">
  <xsl:text> </xsl:text>
  <span class="tei-gram collocate">
   <xsl:call-template name="add-dir-attribute">
    <xsl:with-param name="lang" select="if(exists(@xml:lang)) then @xml:lang else ''" />
   </xsl:call-template>
   <xsl:text>(</xsl:text><xsl:apply-templates /><xsl:text>)</xsl:text>
  </span>
  <xsl:text> </xsl:text>
 </xsl:template>

 <xsl:template match="tei:sense/tei:xr">
  <xsl:text>, </xsl:text>
  <span class="tei-xr-{@type}">
   <xsl:apply-templates />
  </span>
 </xsl:template>


 <xsl:template match="tei:entry/tei:xr">
  <div class="tei-xr-{@type}">
   <xsl:apply-templates />
  </div>
 </xsl:template>
 
 <xsl:template match="tei:xr/tei:lbl">
  <xsl:apply-templates /><xsl:text> </xsl:text>
 </xsl:template>
 
  <xd:doc>
  <xd:desc>
   <xd:p>Odkazy, které neobsahují text. Tyto případy by neměly nastat, Kvůli validnímu výstupu pro HTML5 (element <xd:pre>&lt;a&gt;</xd:pre> nemůže být self closing) se vkládá prázdná mezera.</xd:p>
  </xd:desc>
 </xd:doc>
 <xsl:template match="tei:xr/tei:ref">
  <a href="{@target}">
   <xsl:choose>
    <xsl:when test="text()"><xsl:apply-templates /></xsl:when>
    <xsl:otherwise>
     <xsl:text>&#x200b;</xsl:text>
    </xsl:otherwise>
   </xsl:choose>
  </a>
  <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
 </xsl:template>
 <xsl:template match="tei:etym">
  <div class="tei-etym">
   <span>Původ: </span><xsl:apply-templates />
  </div>
 </xsl:template>
 
 

</xsl:stylesheet>