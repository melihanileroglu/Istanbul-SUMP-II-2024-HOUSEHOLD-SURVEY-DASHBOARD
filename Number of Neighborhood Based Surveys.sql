SELECT 
    hh.district,
    hh.neig,
    COALESCE(COUNT(CASE WHEN hh.sample_type = 'Asil' THEN 1 END), 0) AS Asil,
    COALESCE(COUNT(CASE WHEN hh.sample_type = 'İkame' THEN 1 END), 0) AS İkame
FROM household AS hh
LEFT JOIN survey AS s ON hh.hh_id = s.id
WHERE hh.neig IS NOT NULL 
    AND DATE(s.s_date) >= '2024-02-5' 
    AND s.result = 'Görüşme Tamamlandı' 
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
GROUP BY hh.neig,hh.district
ORDER BY hh.neig;


 
