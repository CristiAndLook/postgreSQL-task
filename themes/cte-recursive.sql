-- nombre de la tabla en memoria
WITH RECURSIVE countdown(val) AS (
-- valores iniciales
    SELECT 10 AS val
UNION
-- valores recursivos
    SELECT val - 1 FROM countdown WHERE val > 1
)
-- consulta final
SELECT * FROM countdown;


-- nombre de la tabla en memoria
WITH RECURSIVE countdown(val) AS (
-- valores iniciales
    SELECT 0 AS val
UNION
-- valores recursivos
    SELECT val + 1 FROM countdown WHERE val < 10
)
-- consulta final
SELECT * FROM countdown;
    