SELECT 
    name,
    age,
    gender,
    edu,
    work_status,
    pt_card
FROM 
    profile
LEFT JOIN survey as s ON profile.hh_id = s.id
LEFT JOIN household as hh ON profile.hh_id = hh.hh_id
WHERE 
    DATE(s.s_date) >= '2024-02-5'  
    AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT', 'SİLİVRİ')
    AND s.result = 'Görüşme Tamamlandı' 
    AND profile.age > 5
    AND profile.participation_status = 'Evet'
  
