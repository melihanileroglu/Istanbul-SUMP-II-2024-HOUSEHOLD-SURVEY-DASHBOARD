SELECT
    tam_saat,
    CASE WHEN tam_saat::int < 12 THEN 'Öğleden Önce' ELSE 'Öğleden Sonra' END AS gunun_zamani,
    SUM(CASE WHEN sample_type = 'Asil' THEN 1 ELSE 0 END) AS asil_count
    
FROM (
    SELECT
        hh.sample_type,
        TO_CHAR(s.s_date ,'HH24') AS tam_saat 
    FROM 
        survey AS s
    LEFT JOIN household AS hh ON s.id = hh.hh_id
    WHERE 
        DATE(s.s_date) >= '2024-02-5'  AND s.result = 'Görüşme Tamamlandı'
        AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
         AND hh.district IS NOT NULL
) AS subquery
GROUP BY
    tam_saat
ORDER BY
    tam_saat;


