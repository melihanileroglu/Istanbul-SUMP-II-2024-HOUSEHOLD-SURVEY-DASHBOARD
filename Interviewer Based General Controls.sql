SELECT
  TRIM(surveyor) AS surveyor,
  COUNT(CASE WHEN hh.sample_type = 'Asil' THEN 1 END) AS asil_count,
  COUNT(CASE WHEN hh.sample_type = 'İkame' THEN 1 END) AS ikame_count,
  FLOOR(AVG(EXTRACT(EPOCH FROM (e_date - s_date))/60)) AS avg_duration,
  100 * AVG(CASE WHEN survey.latitude = 0 THEN 1 ELSE 0 END) AS no_location_rate,
  AVG(hh.hh_size::int) AS avg_hh_size,
  100 * AVG(CASE WHEN hh.hh_has_vehicle = 'Evet' THEN 1 ELSE 0 END) AS avg_has_vehicle,
  100 * AVG(CASE WHEN hh.hh_income = 'Belirtmek istemiyorum.' THEN 1 ELSE 0 END) AS no_income_rate,
  100 * AVG(CASE WHEN hh.auto_intent = 'Evet' THEN 1 ELSE 0 END) AS auto_intent_rate,
  100 * AVG(CASE WHEN survey.share_tel = 'Evet' THEN 1 ELSE 0 END) AS share_tel_rate
FROM
  survey
LEFT JOIN household AS hh ON survey."id" = hh."survey_id"
WHERE
  survey.result = 'Görüşme Tamamlandı'
  AND FLOOR(EXTRACT(EPOCH FROM (e_date - s_date))/60) < 60
  AND DATE(survey.s_date) >= '2024-02-5'
  AND hh.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT','SİLİVRİ')
GROUP BY
  TRIM(surveyor)
ORDER BY
  TRIM(surveyor) ASC;
