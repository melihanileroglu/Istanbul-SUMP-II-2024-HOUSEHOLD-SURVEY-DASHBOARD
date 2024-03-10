SELECT 
    hh.house_type,
    COUNT(DISTINCT CASE WHEN s.result = 'Görüşme reddedildi' THEN hh.tuik_id END) AS reddedilen_gorusme_sayisi
FROM 
    Household AS hh
LEFT JOIN 
    survey AS s ON s.id = hh.hh_id
WHERE
    s.s_date >= '2024-02-5' 
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
    AND hh.district IS NOT NULL
GROUP BY 
    hh.house_type
ORDER BY 
    hh.house_type;
