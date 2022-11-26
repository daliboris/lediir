xquery version "3.1" encoding "utf-8";

(:
Pomocná funkce, která ve analyzuje vstupní dokument a pro zvolené elementy vygeneruje statistiky, 
tj. seznam tokenů, které tvoří jejich textový obsah, popř. obsah jejich atributů.
Detailní údaje lze v přehledu vynechat.
:)

declare variable $document as xs:string external;

declare function local:get-content-values ($elements as element()*) as item()* 
{
    let $distinct := distinct-values($elements[not(*)][text()]/normalize-space())
    let $distinct := for $item in $distinct order by $item return $item 

    let $items := <item type="content" count="{count($distinct)}"> {
    for $item in $distinct
        return <item type="text" text="{$item}" count="{count($distinct[. = $item])}" />
    }
    </item>
    
    let $tokens := local:get-tokens($items)
    
    return ($items, <item type="tokens" count="{count($tokens)}">{$tokens}</item>)
   
    

};

declare function local:get-tokens ($items as element(item)) as item()* {
 let $all-tokens :=
  for $item in $items/item
    let $tokens := tokenize($item/@text, "[\s\(\);:?„“,!]")
    for $token in $tokens return <t count="{$item/@count}">{$token}</t>
  
 let $result := for $token in $all-tokens
  let $text := $token/text()
  group by $text
  order by $text
  return <item type="text" count="{sum($token/@count)}">{$text}</item>
 
 return $result
};

declare function local:get-attribute-values ($attributes as attribute()*) as item()* 
{
    let $distinct := distinct-values($attributes)
    let $distinct := for $item in $distinct order by $item return $item 
    for $item in $distinct
        return <item type="value" text="{$item}" count="{count($attributes[. = $item])}" />
};

declare function local:get-attributes ($elements as element()*) as item()* 
{
    let $names := $elements/@*/name()
    let $distinct := distinct-values($names)
    let $distinct := for $item in $distinct order by $item return $item 
    for $name in $distinct
        return <item type="attribute" name="{$name}" count="{count($names[. = $name])}">
            {local:get-attribute-values($elements/@*[name() = $name])}
        </item>
};

declare function local:get-elements ($document as document-node(), $wanted-elements as xs:string*, $skip-details as xs:boolean) as item()*
{
let $wanted := if(exists($wanted-elements)) then $wanted-elements else ()
let $items :=  $document//*/name()
let $distinct := distinct-values($items) 
let $distinct := for $item in $distinct 
 where $item = $wanted
 order by $item  
return $item 
return <items>
{
for $item in $distinct
	return <item type="element" name="{$item}" count="{count($items[. = $item])}">
	   {
	   if($skip-details) then ()
	   else
	   (
	   local:get-attributes($document//*[name() = $item]),
	   local:get-content-values($document//*[name() = $item])
	   )
	   }
	</item>
}
</items>
};


let $doc := if ($document)
            (:then doc(concat('../../lediir-data/', $document ,'/', $document, '.lift')):)
            then doc(concat('../Dictionaries/', $document, '.xml'))
            else .
return <report url="{document-uri($doc)}">
{
    local:get-elements($doc, ('orth', 'quote'), false())
}
</report>
