xquery version "3.1" encoding "utf-8";

let $doc := doc('../Testy/Ukazka/2021-09-01/2021-09-01.lift')

let $components-ids := $doc//lift/entry/relation[@type='_component-lexeme'][@ref!='']/substring-after(@ref, '_')
let $components-ids := $doc//lift/entry/sense/relation[@type='Synonyms'][@ref!='']/@ref

let $components-ids := distinct-values($components-ids)

let $entries-ids :=  $doc//lift/entry/@guid/data()
let $entries-ids :=  $doc//lift/entry/sense/@id/data()
let $common := $entries-ids[. =$components-ids]

return <report>
    {
        for $item in $common
            return <i>{$item}</i>
    }
</report>