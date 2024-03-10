SELECT
    TRIM("public"."survey"."surveyor") AS "surveyor",
    SUM(CASE WHEN "public"."survey"."result" = 'Görüşme Tamamlandı' THEN 1 ELSE 0 END) AS "Görüşme Tamamlandı",
    SUM(CASE WHEN "public"."survey"."result" = 'Görüşme reddedildi' THEN 1 ELSE 0 END) AS "Görüşme reddedildi",
    COUNT(*) AS "Toplam Ziyaret Sayısı",
    (SUM(CASE WHEN "public"."survey"."result" = 'Görüşme Tamamlandı' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS "Görüşme Başarı Oranı"
FROM
    "public"."survey"
WHERE
    "public"."survey"."s_date" >= CURRENT_DATE - INTERVAL '1 week' AND
    "public"."survey"."s_date" < CURRENT_DATE
     AND survey.org_id = 'ZN1034'
GROUP BY
    TRIM("public"."survey"."surveyor")
ORDER BY
    TRIM("public"."survey"."surveyor") ASC;
    
    
    
    
    
SELECT
    TRIM(s."surveyor") AS "surveyor",
    SUM(CASE WHEN s."result" = 'Görüşme Tamamlandı' THEN 1 ELSE 0 END) AS "Görüşme Tamamlandı",
    SUM(CASE WHEN s."result" = 'Görüşme reddedildi' THEN 1 ELSE 0 END) AS "Görüşme reddedildi",
    COUNT(*) AS "Toplam Ziyaret Sayısı",
    (SUM(CASE WHEN s."result" = 'Görüşme Tamamlandı' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS "Görüşme Başarı Oranı"
FROM
    "public"."survey" s
JOIN
    "public"."household" hh ON s."id" = hh."hh_id"
WHERE
    s."s_date" >= '2024-02-05'
    AND hh."district" <> ''
    AND hh."district" IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT', 'SİLİVRİ')
    AND DATE(s."s_date") >= '2024-02-05'
    AND s."org_id" = 'ZN1034'
GROUP BY
    TRIM(s."surveyor")
ORDER BY
    TRIM(s."surveyor") ASC;

