SELECT
  "public"."profile"."work_status" AS "work_status",
  "public"."profile"."had_trip" AS "had_trip",
  COUNT(*) AS "count"
FROM
  "public"."profile"
LEFT JOIN "public"."household" AS "household__via__hh_id" ON "public"."profile"."hh_id" = "household__via__hh_id"."hh_id"
LEFT JOIN "public"."survey" AS "Survey" ON "household__via__hh_id"."survey_id" = "Survey"."id"
WHERE
  ("Survey"."result" = 'Görüşme Tamamlandı')
  AND ("public"."profile"."age" > 5)
  AND ("Survey"."s_date" >= DATE '2024-02-05')
  AND ("Survey"."s_date" < CAST(NOW() AS date))
  AND (
    ("public"."profile"."had_trip" = 'Evet')
    OR ("public"."profile"."had_trip" = 'Hayır')
  )
GROUP BY
  "public"."profile"."work_status",
  "public"."profile"."had_trip"
ORDER BY
  "public"."profile"."work_status" ASC,
  "public"."profile"."had_trip" ASC;
