SELECT
    TRIM(s.surveyor) AS surveyor,
    COUNT(DISTINCT hh.hh_id) AS toplam_hane_sayısı,
    COUNT(p.p_id) AS toplam_kişi_sayısı,
    COUNT(CASE WHEN p.participation_status = 'Evet' THEN p.p_id END) AS Ankete_katılım_sayısı,
    (COUNT(CASE WHEN p.participation_status = 'Evet' THEN p.p_id END) * 100.0) / NULLIF(COUNT(p.p_id), 0) AS Katılım_oranı_yüzde
FROM
    profile AS p
LEFT JOIN
    household AS hh ON hh.hh_id = p.hh_id
LEFT JOIN
    survey AS s ON s.id = p.hh_id
WHERE 
    hh.district IS NOT NULL  
    AND DATE(s.s_date) >= '2024-02-5'
    AND s.result = 'Görüşme Tamamlandı'
    AND p.age >= 6  -- 6 yaşından büyük olanları filtreleme
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
GROUP BY
    TRIM(s.surveyor)
ORDER BY 
    TRIM(s.surveyor); 
