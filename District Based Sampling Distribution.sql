SELECT 
    hh.district,
    SUM(CASE WHEN sample_type = 'Asil' THEN 1 ELSE 0 END) AS Asil,
    SUM(CASE WHEN sample_type = 'İkame' THEN 1 ELSE 0 END) AS İkame,
    SUM(CASE WHEN sample_type = 'Kentsel Dönüşüm' THEN 1 ELSE 0 END) AS Kentsel_Dönüşüm
FROM household AS hh
JOIN survey AS s ON hh.hh_id = s.id
WHERE
    s.s_date  >= '2024-02-5'
    AND s.result = 'Görüşme Tamamlandı'
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
    AND hh.district IS NOT NULL
GROUP BY 
    hh.district
ORDER BY 
    hh.district
