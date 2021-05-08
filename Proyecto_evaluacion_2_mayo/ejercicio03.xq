"1. Obtener los nombres de todos los países ordenadas alfabéticamente",
for $nom in distinct-values(doc("opendata.ecdc.europa.eu.xml")//record/countriesAndTerritories/text())
order by $nom ascending
return $nom
,
"2.- Obtener los países que tengan más de 100 casos en algún día.:)",
for $nom in doc("opendata.ecdc.europa.eu.xml")//record
where $nom/cases > 100
return <pais nombre="{$nom/countriesAndTerritories/text()}" casos="{$nom/cases/data()}" />
,
"3.- Casos y muertes totales de España.",
let $recs := doc("opendata.ecdc.europa.eu.xml")//record
let $sp := for $recs in $recs where $recs/countriesAndTerritories = "Spain" return $recs
let $spCasos := sum($sp/cases)
let $spMuerte := sum($sp/deaths)
return <spain cases="{$spCasos}" deaths="{$spMuerte}" />
,

"4.- Obtener los casos y muertes totales de los países de Europa cuya suma de casos sea mayor de 20000.",
for $rec in doc("opendata.ecdc.europa.eu.xml")//record
let $eu := for $rec in $rec where $rec/continentExp = "Europe" return $rec
let $pa := for $nom in $eu return $eu/countriesAndTerritories/text()
group by $pa
order by $pa
let $casos := sum($eu/cases)
let $res := <pais nombre="{$pa}" cases="{$casos}" />
for $res1 in $res where $res/@cases > 2000 return $res
,
(:5.- Mostrar los nombres de los 10 países con más fallecidos totales..:)

"6.- Mostrar el país que haya tenido más fallecidos en un día.",
let $in := doc("opendata.ecdc.europa.eu.xml")//record
let $casos := $in/cases
let $max := max(for $casos in $casos return $casos)
let $pais := for $in in $in where $in/cases = $max return $in/countriesAndTerritories
return <max_cases pais="{$pais}" casos="{$max}" />