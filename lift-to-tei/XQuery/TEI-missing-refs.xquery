declare namespace tei = "http://www.tei-c.org/ns/1.0"; 
let $ids := //@*[starts-with(., '#')]

let $result :=
for $id in $ids
let $i := substring-after($id, '#')
 let $target := //*[@xml:id=$i] 
 return if ($target)
  then () else <id n="{$i}" />

return $result