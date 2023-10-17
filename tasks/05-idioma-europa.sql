

-- ¿Cuál es el idioma (y código del idioma) oficial más hablado por diferentes países en Europa?

select * from countrylanguage where isofficial = true;

select * from country;

select * from continent;

Select * from "language";

SELECT count(*), b.languagecode, b.language FROM country AS a
INNER JOIN countrylanguage AS b ON a.code = b.countrycode
WHERE a.continent = 5 AND b.isofficial = true
GROUP BY b.languagecode, b.language
ORDER BY count(*) DESC;
LIMIT 5;

-- Listado de todos los países cuyo idioma oficial es el más hablado de Europa 
-- (no hacer subquery, tomar el código anterior)
SELECT * FROM country AS a
INNER JOIN countrylanguage AS b ON a.code = b.countrycode
WHERE a.continent = 5 AND b.isofficial = true AND b.languagecode = 'eng';






