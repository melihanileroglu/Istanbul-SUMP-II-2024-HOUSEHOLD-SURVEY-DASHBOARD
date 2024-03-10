
SELECT 
    s.surveyor,
    COUNT(*) AS yolculuğu_olmayan
FROM 
    profile AS p
LEFT JOIN 
    survey AS s ON p.hh_id = s.id
LEFT JOIN 
    household AS hh ON p.hh_id = hh.hh_id
WHERE 
    p.participation_status = 'Evet' 
    AND p.work_status = 'Çalışıyor' 
    AND (p.work_type = 'İş yeri/Ofis' OR p.work_type = 'Mobil Çalışan(Sabit yerde çalışmayan, taksi, kurye vb.)') 
    AND p.had_trip = 'Hayır'
    AND (p.no_trip_reason <> 'Hastalık')
    AND DATE(s.s_date) >= '2024-02-5' 
    AND s.result = 'Görüşme Tamamlandı'
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
GROUP BY 
    s.surveyor;

