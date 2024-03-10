SELECT 
    hh.district, 
    AVG(hh.hh_size) AS Hanehalkı_Anketi_Ortalama_Hane_Büyüklüğü,
    CASE 
        WHEN hh.district = 'ADALAR' THEN 2.35
        WHEN hh.district = 'ARNAVUTKÖY' THEN 3.81
        WHEN hh.district = 'ATAŞEHİR' THEN 2.96
        WHEN hh.district = 'AVCILAR' THEN 3.25
        WHEN hh.district = 'BAĞCILAR' THEN 3.71
        WHEN hh.district = 'BAHÇELİEVLER' THEN 3.26
        WHEN hh.district = 'BAKIRKÖY' THEN 2.77
        WHEN hh.district = 'BAŞAKŞEHİR' THEN 3.64
        WHEN hh.district = 'BAYRAMPAŞA' THEN 3.20
        WHEN hh.district = 'BEŞİKTAŞ' THEN 2.33
        WHEN hh.district = 'BEYKOZ' THEN 3.12
        WHEN hh.district = 'BEYLİKDÜZÜ' THEN 3.24
        WHEN hh.district = 'BEYOĞLU' THEN 2.89
        WHEN hh.district = 'BÜYÜKÇEKMECE' THEN 3.13
        WHEN hh.district = 'ÇATALCA' THEN 2.69
        WHEN hh.district = 'ÇEKMEKÖY' THEN 3.22
        WHEN hh.district = 'ESENLER' THEN 3.58
        WHEN hh.district = 'ESENYURT' THEN 3.43
        WHEN hh.district = 'EYÜPSULTAN' THEN 3.10
        WHEN hh.district = 'FATİH' THEN 2.84
        WHEN hh.district = 'GAZİOSMANPAŞA' THEN 3.36
        WHEN hh.district = 'GÜNGÖREN' THEN 3.25
        WHEN hh.district = 'KADIKÖY' THEN 2.32
        WHEN hh.district = 'KAĞITHANE' THEN 3.03
        WHEN hh.district = 'KARTAL' THEN 2.97
        WHEN hh.district = 'KÜÇÜKÇEKMECE' THEN 3.27
        WHEN hh.district = 'MALTEPE' THEN 2.82
        WHEN hh.district = 'PENDİK' THEN 3.23
        WHEN hh.district = 'SANCAKTEPE' THEN 3.52
        WHEN hh.district = 'SARIYER' THEN 2.90
        WHEN hh.district = 'ŞİLE' THEN 2.50
        WHEN hh.district = 'SİLİVRİ' THEN 2.94
        WHEN hh.district = 'ŞİŞLİ' THEN 2.47
        WHEN hh.district = 'SULTANBEYLİ' THEN 3.93
        WHEN hh.district = 'SULTANGAZİ' THEN 3.86
        WHEN hh.district = 'TUZLA' THEN 3.15
        WHEN hh.district = 'ÜMRANİYE' THEN 3.20
        WHEN hh.district = 'ÜSKÜDAR' THEN 2.92
        WHEN hh.district = 'ZEYTİNBURNU' THEN 3.51
    END AS "Districti Ortalama Hanehalkı Büyüklüğü 2022"
FROM 
    household AS hh
LEFT JOIN 
    survey AS s ON hh.hh_id = s.id
WHERE 
    s.result = 'Görüşme Tamamlandı' 
    AND hh.district IS NOT NULL 
    AND DATE(s.s_date) >= '2024-02-5' 
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT', 'SİLİVRİ')
GROUP BY 
    hh.district, s.result
ORDER BY
    hh.district





