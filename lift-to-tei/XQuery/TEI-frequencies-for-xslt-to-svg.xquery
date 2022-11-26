declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace xsl = "http://www.w3.org/1999/XSL/Transform";

(:
 Vytvoří seznam jedinečných elementů <usg /> typu 'frequency'.
 Seznam následně slouží jako podklad pro generování grafickcýh souborů SVG.
:)

let $frequencies := //tei:usg[@type='frequency']
  for $value in distinct-values($frequencies/@value)
    let $item := $frequencies[@value = $value][1]
    order by $item/@value
    return $item  