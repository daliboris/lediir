declare namespace tei = "http://www.tei-c.org/ns/1.0"; 

(:
 Pomocná funkce, která vrátí seznam odkazů na identifikátory @xml:id, které v dokumentu neexistují.
 Odkazující identifikátory se odvodí z obsahu libovolného atributu, který začíná znakem křížku (#).
 Slouží ke konktrole kvality vygenerovaných souborů.
:)

let $ids := //@*[starts-with(., '#')]

let $result :=
for $id in $ids
let $i := substring-after($id, '#')
 let $target := //*[@xml:id=$i] 
 return if ($target)
  then () else <id n="{$i}" />

return $result