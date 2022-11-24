<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:math="http://www.w3.org/2005/xpath-functions/math" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs math xd tei" version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 8, 2021</xd:p>
            <xd:p><xd:b>Author:</xd:b> Boris</xd:p>
            <xd:p />
        </xd:desc>
    </xd:doc> <xsl:output method="html" indent="yes" encoding="UTF-8" omit-xml-declaration="yes" html-version="5" />

    <xsl:template match="/">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
                <title>LeDIIR</title>
                <link rel="stylesheet" type="text/css" href="lediir.css" />
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
       
       }, true);
       
       
       }
    </script>
                <style>
                    .frequency-bar-1 {
                        fill: #BFE1B0;
                    }
                    .frequency-bar-2 {
                        fill: #99D492;
                    }
                    .frequency-bar-3 {
                        fill: #39A96B;
                    }
                    .frequency-bar-4 {
                        fill: #137177;
                    }
                    
                    article > details > summary {
                    /*font-size: 28px;*/
                    margin-top: 0em;
                    margin-bottom: 0em;
                    }
                    <![CDATA[
                    article > details > h4 {
                    margin-top: 0em;
                    margin-bottom: 0em;
                    margin-left: 2em;
                    margin-right:1em;
                    }
                    ]]>
                    
                </style>
               <script>
                $('input').prop('checked', true);
                
                function checkParents($li, state) {
                var $siblings = $li.siblings();
                var $parent = $li.parent().closest('li');
                state = state &amp;&amp; $siblings.children('label').find('input').prop('checked');
                $parent.children('label').find('input').prop('checked', state);
                if ($parent.parents('li').length)
                checkParents($parent, state);
                }
                
                $('input').change(function () {
                var $cb = $(this);
                var $li = $cb.closest('li');
                var state = $cb.prop('checked');
                
                // check all children
                $li.find('input').prop('checked', state);
                
                // check all parents, as applicable
                if ($li.parents('li').length)
                checkParents($li, state);
                });
               </script>
            
            </head>
            <body onload="AddFunctionality()">
                <p><a href="#" id="expAll" class="exp">Rozbalit vše</a> (poprvé je potřeba kliknout dvakrát)</p>
                <div id="taxonomie" class="collapse">
                    <xsl:apply-templates select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:classDecl/tei:taxonomy" />
                </div>
                <!--    <div id="hesla" class="collapse">
     <xsl:apply-templates select="tei:TEI/tei:text/tei:body" />
    </div>-->
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:taxonomy">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="tei:bibl">
        <h2>
            <xsl:apply-templates />
        </h2>
    </xsl:template>

   <xsl:template match="tei:category[not(tei:category)]">
    <h4><input type="checkbox" value="{@xml:id}" />
     <xsl:apply-templates select="tei:catDesc[@xml:lang='en']" mode="summary" />
    </h4>
   </xsl:template>

    <xsl:template match="tei:category">
        <article class="category" id="{@xml:id}">
            <details>
                <summary>
                 <h4><input type="checkbox" value="{@xml:id}" />
                       <xsl:apply-templates select="tei:catDesc[@xml:lang='en']" mode="summary" />
                    </h4>
                </summary>
                <!--<xsl:apply-templates select="tei:catDesc" mode="detail" />-->
                <xsl:apply-templates select="tei:category" />
            </details>
        </article>
    </xsl:template>

    <xsl:template match="tei:catDesc" mode="summary">
        <span lang="{@xml:lang}" xml:lang="{@xml:lang}" class="tei-catDesc">
            <xsl:choose>
                <xsl:when test="lang('fa')">
                    <span class="tei-term">
                        <xsl:apply-templates select="tei:term" />
                    </span>
                    <xsl:text> </xsl:text>
                    <span class="tei-idno">
                        <xsl:apply-templates select="tei:idno" />
                    </span>
                </xsl:when>
                <xsl:otherwise>
                    <span class="tei-idno">
                        <xsl:apply-templates select="tei:idno" />
                    </span>
                    <xsl:text> </xsl:text>
                    <span class="tei-term">
                        <xsl:apply-templates select="tei:term" />
                    </span>

                </xsl:otherwise>
            </xsl:choose>

        </span>
    </xsl:template>

    <xsl:template match="tei:catDesc" mode="detail">
        <p lang="{@xml:lang}" class="tei-gloss">
            <xsl:apply-templates select="tei:gloss" />
        </p>
    </xsl:template>

</xsl:stylesheet>
