xquery version "3.1" encoding "utf-8";

(:
 Pomocná funkce pro vytvoření seznamu polí.
:)

let $items := //field
let $ones := distinct-values($items/@type)
for $one in $ones

  return <item value="{concat ('  - ', $one)}">{
  for $value in $items[@type = $one]
    return concat ('    - ', $value/@name, '&#xa;')
  }
  </item>
  
  