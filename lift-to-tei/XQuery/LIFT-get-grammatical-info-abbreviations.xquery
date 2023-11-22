xquery version "3.1" encoding "utf-8";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare option output:method "json";
declare option output:indent "yes";

let $items :=
/lift-ranges/range[@id='grammatical-info']/range-element

return 
map:merge(
for $item in $items
  let $id := normalize-unicode($item/@id)
  let $abbr := if ( exists($item/abbrev/form[@lang='en'])) then $item/abbrev/form[@lang='en']/text/data() => normalize-unicode() else $id
  return map:entry( $id, $abbr )
)