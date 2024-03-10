SELECT
    surveyor AS anketör_adı,
    SUM(CASE WHEN tam_saat = '12' THEN 1 ELSE 0 END) AS "12:00",
    SUM(CASE WHEN tam_saat = '13' THEN 1 ELSE 0 END) AS "13:00",
    SUM(CASE WHEN tam_saat = '14' THEN 1 ELSE 0 END) AS "14:00",
    SUM(CASE WHEN tam_saat = '15' THEN 1 ELSE 0 END) AS "15:00",
    SUM(CASE WHEN tam_saat = '16' THEN 1 ELSE 0 END) AS "16:00",
    SUM(CASE WHEN tam_saat = '17' THEN 1 ELSE 0 END) AS "17:00",
    SUM(CASE WHEN tam_saat = '18' THEN 1 ELSE 0 END) AS "18:00",
    SUM(CASE WHEN tam_saat = '19' THEN 1 ELSE 0 END) AS "19:00",
    SUM(CASE WHEN tam_saat = '20' THEN 1 ELSE 0 END) AS "20:00",
    SUM(CASE WHEN tam_saat = '21' THEN 1 ELSE 0 END) AS "21:00",
    SUM(CASE WHEN tam_saat = '22' THEN 1 ELSE 0 END) AS "22:00"
FROM (
    SELECT
        s.surveyor,
        TO_CHAR(s.s_date ,'HH24') AS tam_saat
    FROM 
        survey AS s
    LEFT JOIN household AS hh ON s.id = hh.hh_id
    WHERE 
        DATE(s.s_date) >= '2024-02-5'  AND s.result = 'Görüşme Tamamlandı'
        AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
        AND hh.district <> '' 
) AS subquery
GROUP BY
    surveyor
ORDER BY
    surveyor;


