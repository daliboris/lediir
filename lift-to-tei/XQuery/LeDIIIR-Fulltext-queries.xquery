xquery version "3.1" encoding "utf-8";

declare namespace tei = "http://www.tei-c.org/ns/1.0";

declare function local:test-ft($doc as xs:string?, $fields as xs:string+, $q as xs:string) as item()*
{
 let $field := $fields[1]
 let $max-items := 30
 
 let $data-root := "/db/apps/lediir/data"
 let $lower-case-q := lower-case($q)
 
 return
  collection($data-root)/tei:TEI[@xml:id = ($doc)]/ft:index-keys-for-field($field, $lower-case-q,
  function ($key, $count) {
   <item
    key="{$key}"
    frequency="{$count[1]}"
    documents="{$count[2]}"
    position="{$count[3]}"/>
  }, $max-items)
};

declare function local:test-ft-collection($doc as xs:string?, $fields as xs:string+, $q as xs:string) as item()*
{
 
 let $field := $fields[1]
 let $max-items := 30
 
 let $data-root := "/db/apps/lediir/data"
 let $lower-case-q := lower-case($q)
 
 return
  collection($data-root)/ft:index-keys-for-field($field, $lower-case-q,
  function ($key, $count) {
   <item
    key="{$key}"
    frequency="{$count[1]}"
    documents="{$count[2]}"
    position="{$count[3]}"/>
  }, $max-items)
};


declare function local:fulltext($doc as xs:string?, $fields as xs:string+, $q as xs:string) {
 let $max-items := 30
 let $data-root := "/db/apps/lediir/data"
 let $f := function ($key, $count) {
  <item
   key="{$key}"
   frequency="{$count[1]}"
   documents="{$count[2]}"
   position="{$count[3]}"/>
 }
 let $lower-case-q := lower-case($q)
 for $field in $fields
 let $field := if ($field = ("partOfSpeech", "style")) then
  $field || "All"
 else
  $field
 
 return
  switch ($field)
   case "entry"
    return
     if ($doc) then
      collection($data-root)/tei:TEI[@xml:id = ($doc)]/util:index-keys-by-qname(xs:QName("tei:entry"), $lower-case-q,
      $f, $max-items, "lucene-index")
     else
      collection($data-root)/util:index-keys-by-qname(xs:QName("tei:entry"), $lower-case-q,
      $f, $max-items, "lucene-index")
   case "definition"
   case "example"
   case "translation"
   case "headword"
   case "pronunciation"
   case "partOfSpeechAll"
   case "styleAll"
   case "domain"
   case "polysemy"
   case "lemma"
    return
     if ($doc) then
      collection($data-root)/tei:TEI[@xml:id = ($doc)]/ft:index-keys-for-field($field, $lower-case-q,
      $f, $max-items)
     else
      collection($data-root)/ft:index-keys-for-field($field, $lower-case-q,
      $f, 30)
   
   default return
    collection($data-root)/ft:index-keys-for-field("title", $lower-case-q,
    $f, $max-items)
};


declare function local:autocomplete($doc as xs:string?, $fields as xs:string+, $q as xs:string) {
 
 <result>
  <parameters
   doc="{$doc}"
   fields="{$fields}"
   q="{$q}"/>
  <auctocomplete
   type="doc">
   {local:test-ft($doc, $fields, $q)}
  </auctocomplete>
  <auctocomplete
   type="collection">
   {local:test-ft-collection($doc, $fields, $q)}
  </auctocomplete>
  <auctocomplete
   type="fulltext">
   {local:fulltext($doc, $fields, $q)}
  </auctocomplete>
 </result>
};

 local:autocomplete("FACS", "headword", "rez") 

(:local:autocomplete((), "partOfSpeech", "p"):)


(:
 let $items := "headwords" 
 return $items[1]:)