SELECT 
    CASE 
        WHEN hh.district = 'ADALAR' THEN 60
        WHEN hh.district = 'ARNAVUTKÖY' THEN 1050
        WHEN hh.district = 'ATAŞEHİR' THEN 2260
        WHEN hh.district = 'AVCILAR' THEN 1700
        WHEN hh.district = 'BAĞCILAR' THEN 3980
        WHEN hh.district = 'BAHÇELİEVLER' THEN 3200
        WHEN hh.district = 'BAKIRKÖY' THEN 1230
        WHEN hh.district = 'BAŞAKŞEHİR' THEN 1940
        WHEN hh.district = 'BAYRAMPAŞA' THEN 1480
        WHEN hh.district = 'BEŞİKTAŞ' THEN 940
        WHEN hh.district = 'BEYKOZ' THEN 1020
        WHEN hh.district = 'BEYLİKDÜZÜ' THEN 1540
        WHEN hh.district = 'BEYOĞLU' THEN 1290
        WHEN hh.district = 'BÜYÜKÇEKMECE' THEN 890
        WHEN hh.district = 'ÇATALCA' THEN 330
        WHEN hh.district = 'ÇEKMEKÖY' THEN 1080
        WHEN hh.district = 'ESENLER' THEN 2360
        WHEN hh.district = 'ESENYURT' THEN 3740
        WHEN hh.district = 'EYÜPSULTAN' THEN 2180
        WHEN hh.district = 'FATİH' THEN 2080
        WHEN hh.district = 'GAZİOSMANPAŞA' THEN 2660
        WHEN hh.district = 'GÜNGÖREN' THEN 1520
        WHEN hh.district = 'KADIKÖY' THEN 2580
        WHEN hh.district = 'KAĞITHANE' THEN 2460
        WHEN hh.district = 'KARTAL' THEN 2550
        WHEN hh.district = 'KÜÇÜKÇEKMECE' THEN 4320
        WHEN hh.district = 'MALTEPE' THEN 2810
        WHEN hh.district = 'PENDİK' THEN 3600
        WHEN hh.district = 'SANCAKTEPE' THEN 2280
        WHEN hh.district = 'SARIYER' THEN 1290
        WHEN hh.district = 'ŞİLE' THEN 640
        WHEN hh.district = 'SİLİVRİ' THEN 1620
        WHEN hh.district = 'ŞİŞLİ' THEN 2030
        WHEN hh.district = 'SULTANBEYLİ' THEN 150
        WHEN hh.district = 'SULTANGAZİ' THEN 1470
        WHEN hh.district = 'TUZLA' THEN 1080
        WHEN hh.district = 'ÜMRANİYE' THEN 3770
        WHEN hh.district = 'ÜSKÜDAR' THEN 2800
        WHEN hh.district = 'ZEYTİNBURNU' THEN 1570 
    END AS Örneklem_Sayısı,
    hh.district,
    SUM(CASE WHEN s.result = 'Görüşme Tamamlandı' THEN 1 ELSE 0 END) AS Görüşme_Tamamlanan
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
    hh.district;
