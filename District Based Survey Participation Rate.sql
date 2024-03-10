SELECT
    hh.district,
    COUNT(p.p_id) AS toplam_kişi_sayısı,
    COUNT(CASE WHEN p.participation_status = 'Evet' THEN p.p_id END) AS Ankete_katılım_sayısı,
    (COUNT(CASE WHEN p.participation_status = 'Evet' THEN p.p_id END) * 100.0) / COUNT(p.p_id) AS Katılım_oranı_yüzde
FROM
    profile as p
LEFT JOIN
    household hh ON hh.hh_id = p.hh_id
LEFT JOIN
    survey s ON s.id = p.hh_id
WHERE hh.district IS NOT NULL  
    AND hh.district <> '' 
    AND DATE(s.s_date) >= '2024-02-5' 
    AND s.result = 'Görüşme Tamamlandı'
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
    AND hh.district IS NOT NULL
GROUP BY
    hh.district
ORDER BY 
    hh.district;
