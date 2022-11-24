<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs tei xd" version="3.0">
 <xsl:import href="TEI-to-HTML-common.xsl"/>

 <xsl:param name="html-format" select="'bootstrap'"/>
 <xsl:strip-space elements="*"/>
 <xsl:output method="xhtml" indent="yes" encoding="UTF-8" html-version="5"/>

 <xsl:template match="/">
  <html>
   <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>LeDIIR</title>
    <link rel="stylesheet" type="text/css" href="lediir.css"/>
    <!--    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />-->
    <!-- https://stackoverflow.com/questions/43008609/expanding-all-details-tags -->
    <script type="text/javascript">
     function AddFunctionality() {
      // Reference the toggle link
      var xa = document.getElementById('expAll');
      
      // Register link on click event
      xa.addEventListener('click', function (e) {
       
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
       Array. from (details).forEach(function (obj, idx) {
        
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
      },
      false);
     }</script>
   </head>
   <body>
    <!--<p><a href="#/" id="expAll" class="exp">Rozbalit vše</a> (poprvé je potřeba kliknout dvakrát)</p>-->
    <div id="facety">
     <!--<xsl:apply-templates select="tei:TEI/tei:text/tei:body" />-->
    </div>
   </body>
  </html>
 </xsl:template>

 <!-- <xsl:template match="tei:body">
  <xsl:call-template name="create-facets" />
 </xsl:template>-->

 <xsl:template name="create-facets">

  <xsl:call-template name="facet">
   <xsl:with-param name="id" select="'pos'"/>
   <xsl:with-param name="items" select=".//tei:gram[@type = 'pos']"/>
   <xsl:with-param name="title" select="'Slovní druh'"/>
  </xsl:call-template>
  <xsl:call-template name="facet">
   <xsl:with-param name="id" select="'etym'"/>
   <xsl:with-param name="items" select=".//tei:etym/tei:lang"/>
   <xsl:with-param name="title" select="'Jazyky'"/>
  </xsl:call-template>

  <xsl:call-template name="facet">
   <xsl:with-param name="id" select="'domain'"/>
   <xsl:with-param name="items" select=".//tei:usg[@type = 'domain']/concat(tei:idno, ' ', tei:term)"/>
   <xsl:with-param name="title" select="'Sémantické okruhy'"/>
  </xsl:call-template>

  <xsl:call-template name="facet">
   <xsl:with-param name="id" select="'frequency'"/>
   <xsl:with-param name="items" select=".//tei:usg[@type = 'frequency']"/>
   <xsl:with-param name="title" select="'Frekvence'"/>
  </xsl:call-template>

  <xsl:variable name="polysem" select=".//tei:entry/count(tei:sense)"/>

  <xsl:call-template name="facet">
   <xsl:with-param name="id" select="'polysemy'"/>
   <xsl:with-param name="items" select="
     for $p in $polysem
     return
      string($p)"/>
   <xsl:with-param name="title" select="'Polysémie'"/>
  </xsl:call-template>

  <xsl:call-template name="facet">
   <xsl:with-param name="id" select="'quotes'"/>
   <xsl:with-param name="items" select="
     for $p in .//tei:entry/count(.//tei:cit[@type = 'example'])
     return
      if ($p gt 0) then
       's doklady'
      else
       'bez dokladů'"/>
   <xsl:with-param name="title" select="'Doklady'"/>
  </xsl:call-template>

  <!--   <xsl:call-template name="facet">
   <xsl:with-param name="id" select="'etymology'" />
   <xsl:with-param name="items" select="for $p in $polysem return string($p)" />
   <xsl:with-param name="title" select="'Etymologie'" />
  </xsl:call-template>-->

  <xsl:call-template name="facet">
   <xsl:with-param name="id" select="'cross-reference'"/>
   <xsl:with-param name="items" select=".//tei:entry//tei:lbl[@type = 'cross-rerefence']"/>
   <xsl:with-param name="title" select="'Odkazy'"/>
  </xsl:call-template>

 </xsl:template>

 <xsl:template name="bootstrap-facet">
  <xsl:param name="id"/>
  <xsl:param name="items" as="xs:string*"/>
  <xsl:param name="title"/>

  <xsl:variable name="values" as="xs:string*">
   <xsl:perform-sort select="distinct-values($items)">
    <xsl:sort select="."/>
   </xsl:perform-sort>
  </xsl:variable>

  <xsl:call-template name="insert-html-bootstrap">
   <xsl:with-param name="title" select="$title"/>
   <xsl:with-param name="id" select="$id"/>
   <xsl:with-param name="values" select="$values"/>
   <xsl:with-param name="items" select="$items"/>
  </xsl:call-template>
 </xsl:template>

 <xsl:template name="insert-html-bootstrap">
  <xsl:param name="title"/>
  <xsl:param name="id"/>
  <xsl:param name="values" as="xs:string*"/>
  <xsl:param name="items" as="xs:string*"/>
  <div class="panel panel-default">
   <div class="panel-heading">
    <h3 class="panel-title">
     <xsl:value-of select="$title"/>
     <button class="btn btn-outline-info btn-sm pull-right" type="button" data-toggle="collapse" data-target="#facetCheckboxes-{$id}" aria-expanded="false" aria-controls="facetCheckboxes-{$id}">⇅</button>
    </h3>
   </div>
   <div class="panel-body collapse" id="facetCheckboxes-{$id}">
    <xsl:for-each select="$values">
     <xsl:variable name="value" select="."/>
     <xsl:variable name="count" select="count($items[. = $value])"/>
     <div class="checkbox">
      <label>
       <input type="checkbox" />
        <xsl:value-of select="$value"/>
        <xsl:text> </xsl:text>
        <span class="badge badge-light">
         <xsl:value-of select="$count"/>
        </span>
      </label>
     </div>
    </xsl:for-each>
   </div>
  </div>
 </xsl:template>

 <xsl:template name="facet">
  <xsl:param name="id"/>
  <xsl:param name="items" as="xs:string*"/>
  <xsl:param name="title"/>

  <xsl:variable name="values" as="xs:string*">
   <xsl:perform-sort select="distinct-values($items)">
    <xsl:sort select="."/>
   </xsl:perform-sort>
  </xsl:variable>

  <xsl:choose>
   <xsl:when test="$html-format = 'bootstrap'">
    <xsl:call-template name="insert-html-bootstrap">
     <xsl:with-param name="title" select="$title"/>
     <xsl:with-param name="id" select="$id"/>
     <xsl:with-param name="values" select="$values"/>
     <xsl:with-param name="items" select="$items"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:call-template name="insert-html-simple">
     <xsl:with-param name="title" select="$title"/>
     <xsl:with-param name="id" select="$id"/>
     <xsl:with-param name="values" select="$values"/>
     <xsl:with-param name="items" select="$items"/>
    </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>


 </xsl:template>

 <xsl:template name="insert-html-simple">
  <xsl:param name="title"/>
  <xsl:param name="id"/>
  <xsl:param name="values" as="xs:string*"/>
  <xsl:param name="items" as="xs:string*"/>
  <article>
   <details>
    <summary>
     <h4>
      <xsl:value-of select="$title"/>
     </h4>
    </summary>
    <div class="panel-body ollapse show" id="facetCheckboxes-{$id}">
     <xsl:for-each select="$values">
      <xsl:variable name="value" select="."/>
      <div class="checkbox">
       <label>
        <input type="checkbox"/>
        <xsl:call-template name="abbr-pos-to-text">
         <xsl:with-param name="abbr" select="$value"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <span class="badge badge-light">
         <xsl:value-of select="count($items[. = $value])"/>
        </span>
       </label>
      </div>
     </xsl:for-each>
    </div>
   </details>
  </article>
 </xsl:template>

</xsl:stylesheet>
