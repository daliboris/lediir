declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace xsl = "http://www.w3.org/1999/XSL/Transform";

(:
 Vytvoří seznam jedinečných elementů <usg /> typu 'frequency'.
 Seznam následně slouží jako podklad pro generování grafickcýh souborů SVG.
:)

  let $regex := "^[TMLV][ABCDEXR](-[TMLV][ABCDEXR]){0,2}$"
  let $frequencies := //tei:usg[@type='frequency']
  let $items := for $frequency in $frequencies
  let $value := $frequency/@value
  group by $value
  let $is-valid := matches($value, $regex)
  order by $is-valid, $value
  return <item value="{$value}" count="{count($frequency)}" valid="{$is-valid}" />
 
 return <items>{$items}</items>