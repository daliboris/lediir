xquery version "3.1" encoding "utf-8";

(:
 Pomocná funkce pro identifikaci různých typů relací (konkrétně '_component-lexeme' a 'Synonyms') mezi hesly a významy.
:)

let $directory := '2022-11-05'
let $doc := doc(concat('../../lediir-data/', $directory, '/', $directory, '.lift'))

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