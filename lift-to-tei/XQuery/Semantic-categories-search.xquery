xquery version "3.1";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare variable $config-taxonomy-ids := ('LeDIIR.taxonomy');

declare function local:get-summary($catDesc as element(tei:catDesc)?) as item()* { 

if ($catDesc) then
     <span lang="{$catDesc/@xml:lang}" xml:lang="{$catDesc/@xml:lang}" class="tei-catDesc">
        <span class="tei-idno">{concat($catDesc/tei:idno, " ")}</span>
        <span class="tei-term">{string($catDesc/tei:term)}</span>
     </span>
    else ()
 }; 

declare function local:get-hmtl ($category as element(tei:category)) as item()* 
{ 

 if ($category/tei:category) then
  <article class="category" id="{$category/@xml:id}">
            <details>
                <summary>
                    <h4><input type="checkbox" value="{$category/@xml:id}" />
                     {local:get-summary($category/tei:catDesc[@xml:lang='en'])} 
                    </h4>
                </summary>
                {
                 for $cat in $category/tei:category
                  return local:get-hmtl($cat)
                }
            </details>
        </article>
  else
   <h4><input type="checkbox" value="{$category/@xml:id}" />{local:get-summary($category/tei:catDesc[@xml:lang='en'])}</h4>
}; 


let $idnoParam := ()
let $query := ()


let $taxonomy := (collection('/db/apps/lediir/data/')//id($config-taxonomy-ids))[1]

let $found := if ($query and $query != '') then
 $taxonomy//tei:category/tei:catDesc[@xml:lang='en'][ft:query(., $query)]
 else $taxonomy
let $found := if ($idnoParam and $idnoParam != '') then
   if ($query and $query != '') then
    $found[ft:query(., $idnoParam)]
   else
     $found//tei:category/tei:catDesc[@xml:lang='en'][ft:query(., $idnoParam)]
  else $found

 for $item in $taxonomy/tei:category
return local:get-hmtl($item)