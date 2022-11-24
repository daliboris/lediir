xquery version "3.1";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare namespace tei="http://www.tei-c.org/ns/1.0";


declare function local:get-domain-hierarchy($entry as element()?) { 
if (empty($entry)) then ()
else
let $root := root($entry)
let $targets := $entry//tei:usg[@type='domain']
let $ids := if (empty($targets)) then () 
    else $targets/substring-after(@ana, '#')

return if (empty($ids)) 
            then ()
            else 
            local:get-hierarchical-descriptor($ids, $root)
};

declare function local:get-descriptor($keys as xs:string*, $root as item()) {  
 (: for $key in $keys return id($key, $root)/ancestor-or-self::tei:category :)
 id($keys, $root)/ancestor-or-self::tei:category/tei:catDesc[@xml:lang='en']/concat(tei:idno, ' ', tei:term)
};

declare function local:get-hierarchical-descriptor($keys as xs:string*, $root as item()) {
  array:for-each (array {$keys}, function($key) {
        id($key,$root)
        /ancestor-or-self::tei:category/tei:catDesc[@xml:lang='en']/concat(tei:idno, ' ', tei:term)
    })
};


let $entry := /tei:TEI/tei:text[1]/tei:body[1]/tei:div[1]/tei:entry[1]

let $result := local:get-domain-hierarchy($entry[3])

return array:get( $result, 3)