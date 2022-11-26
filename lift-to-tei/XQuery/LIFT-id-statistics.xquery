xquery version "3.1" encoding "utf-8";

(:
 Pomocná funkce pro generování přehledu identifikátorů použitých v souboru LIFT.
:)

declare function local:get-elements ($document as document-node()) as item()*
{
 let $entries := $document//entry
 let $senses := $document//sense
 let $ids := for $entry in $entries
 return <id>{data($entry/@id)}</id>
 let $guids := for $entry in $entries
 return <guid>{data($entry/@guid)}</guid>
 let $senseids := for $sense in $senses
 return <guid>{data($sense/@id)}</guid>
let $guids := ($guids, $senseids)

 return <result>
 <ids count="{count($ids)}" distinct="{count(distinct-values($ids))}">{$ids}</ids>
 <guid count="{count($guids)}" distinct="{count(distinct-values($guids))}">{$guids}</guid>
 </result>
};


let $doc := doc('../Testy/FLEx/LIFT/2021-04-11/LIFT.lift')
return <report>
{
    local:get-elements($doc)
}
</report>
