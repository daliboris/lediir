declare namespace tei = "http://www.tei-c.org/ns/1.0";
declare namespace xsl = "http://www.w3.org/1999/XSL/Transform";


let $frequencies := //tei:usg[@type='frequency']
return <xsl:variable name="frequencies" xmlns="http://www.tei-c.org/ns/1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
 {
  for $value in distinct-values($frequencies/@value)
    let $item := $frequencies[@value = $value][1]
    order by $item/@value
    return $item
  }
</xsl:variable>
  