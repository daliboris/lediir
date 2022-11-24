xquery version "3.1" encoding "utf-8";

declare variable $document as xs:string external;

declare function local:extract-data ($element as element(item)) as item() 
{
 let $tokens := $element/item[@type='tokens']
 let $dot-items := for $item in $tokens/item[contains(., '.')]
  order by $item/.
  return $item
 let $frequent-items := for $item in $tokens/item[@count > 5]
  order by xs:integer($item/@count)
  return $item
  
 return
   <item name="{$element/@name}">
    <item name="tokens with dot" count="{count($dot-items)}"> {$dot-items} </item>
    <item name="frequent tokens" count="{count($frequent-items)}"> {$frequent-items} </item>
   </item>
};

let $doc := if ($document)
            (:then doc(concat('../testy/Ukazka/', $document ,'/', $document, '.lift')):)
            then doc(concat('../testy/FLEx/Output/', $document, '.xml'))
            else .

return <report url="{document-uri($doc)}">
{
 for $element in $doc/report/items/item[@type='element']
    return local:extract-data($element)
}
</report>