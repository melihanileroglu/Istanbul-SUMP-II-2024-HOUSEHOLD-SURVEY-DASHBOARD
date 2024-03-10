SELECT
    hh.district,
    COUNT(CASE WHEN t.mode = 'Belediye Otobüsü' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Metrobüs' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Deniz Motoru' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Dolmuş' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Marmaray' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Metro' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Minibüs' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Şehir Hatları Vapuru' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Tramvay' THEN 1 END) as Public_Transport,
    COUNT(CASE WHEN t.mode = 'Diğer' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Korsan Taksi' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Kurum/ Firma Aracı' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Motosiklet' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Özel Araç' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Taksi' THEN 1 END) as Private_Vehicle,
    COUNT(CASE WHEN t.mode = 'Servis' THEN 1 END) as Service,
    COUNT(CASE WHEN t.mode = 'Yürüme' THEN 1 END) + COUNT(CASE WHEN t.mode = 'Skuter' THEN 1 END)+COUNT(CASE WHEN t.mode = 'Paylaşımlı Skuter' THEN 1 END) as Walking_Micromobility
FROM
    trip AS t
LEFT JOIN
    household AS hh ON hh.hh_id = t.hh_id
LEFT JOIN
    survey AS s ON t.hh_id = s.id
WHERE  
    DATE(s.s_date) >= '2024-02-5'  
    AND s.result = 'Görüşme Tamamlandı' 
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
    AND t.purpose = 'İşe gidiş' -- İşe gidiş olanlar için filtre
GROUP BY
    hh.district
ORDER BY 
    hh.district;
