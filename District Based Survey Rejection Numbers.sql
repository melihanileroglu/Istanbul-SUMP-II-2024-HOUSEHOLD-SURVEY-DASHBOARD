SELECT 
    hh.district,
    COUNT(CASE WHEN s.result = 'Görüşme reddedildi' THEN hh.tuik_id END) AS hane_bazlı_red_sayısı,
    COUNT(CASE WHEN s.result = 'Görüşme Tamamlandı' THEN hh.tuik_id END) AS hane_bazlı_kabul_sayısı,
    COUNT(CASE WHEN s.result = 'Evde kimse yok' THEN hh.tuik_id END) AS hane_bazlı_evde_kimse_yok
FROM 
    Household AS hh
LEFT JOIN 
    survey AS s ON s.id = hh.hh_id
WHERE
    s.s_date  >= '2024-02-5' 
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
    AND hh.district IS NOT NULL
GROUP BY 
    hh.district
ORDER BY 
    hh.district;
