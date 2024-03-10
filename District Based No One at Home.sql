SELECT 
    hh.district,
    COUNT(CASE WHEN s.result = 'Evde kimse yok'THEN hh.tuik_id END) AS Evde_Kimse_Yok,
    COUNT(CASE WHEN s.result = 'Görüşme reddedildi' THEN hh.tuik_id END) AS Görüşme_Reddedildi
FROM 
    Household AS hh
LEFT JOIN 
    survey AS s ON s.id = hh.hh_id
WHERE
    DATE(s.s_date) >= '2024-02-5'  
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT', 'SİLİVRİ')
GROUP BY 
    hh.district
ORDER BY 
    hh.district;
