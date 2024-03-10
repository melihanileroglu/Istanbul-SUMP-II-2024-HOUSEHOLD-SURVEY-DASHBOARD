SELECT
    "Household - Hh"."district" AS "Household - Hh__district",
    CASE
        WHEN "source"."purpose" = 'İşe gidiş' THEN 'İş Amaçlı'
        WHEN "source"."purpose" = 'Okula gidiş(ilk ve ortaöğretim)' THEN 'Okul Amaçlı'
        WHEN "source"."purpose" = 'Okula gidiş(lise)' THEN 'Okul Amaçlı'
        WHEN "source"."purpose" = 'Okula gidiş(üniversite ve üzeri)' THEN 'Okul Amaçlı'
        WHEN "source"."purpose" = 'Sağlık Kurumuna gidiş' THEN 'Sağlık Kurumuna Gidiş'
        WHEN "source"."purpose" = 'Spor, Eğlence vb. gidiş' THEN 'Sosyal Aktivite'
        WHEN "source"."purpose" = 'Yeme/içme Gidiş' THEN 'Sosyal Aktivite'
        WHEN "source"."purpose" = 'Alışveriş' THEN 'Sosyal Aktivite'
        WHEN "source"."purpose" = 'Akraba/Arkadaş  Ziyareti' THEN 'Sosyal Aktivite'
        WHEN "source"."purpose" = 'Diğer' THEN 'Sosyal Aktivite'
        WHEN "source"."purpose" = 'İş takibi/ Ödemeler' THEN 'Sosyal Aktivite'
        WHEN "source"."purpose" = 'Çocuk Alma/Bırakma' THEN 'Alma/Bırakma'
        WHEN "source"."purpose" = 'Diğer Alma/Bırakma' THEN 'Alma/Bırakma'
        ELSE "source"."purpose"
    END AS "purpose",
    COUNT(*) AS "count"
FROM
    (
        SELECT
            "public"."trip"."hh_id" AS "hh_id",
            "public"."trip"."id" AS "id",
            "public"."trip"."p_id" AS "p_id",
            "public"."trip"."t_leg_id" AS "t_leg_id",
            "public"."trip"."purpose" AS "purpose",
            "public"."trip"."weekly_trip_count" AS "weekly_trip_count",
            "public"."trip"."has_transfer" AS "has_transfer",
            "public"."trip"."mode" AS "mode",
            "public"."trip"."acc_p" AS "acc_p",
            "public"."trip"."pc_reason" AS "pc_reason",
            "public"."trip"."orig_loc_type" AS "orig_loc_type",
            "public"."trip"."orig_dist" AS "orig_dist",
            "public"."trip"."orig_neig" AS "orig_neig",
            "public"."trip"."orig_loc" AS "orig_loc",
            "public"."trip"."orig_lat" AS "orig_lat",
            "public"."trip"."orig_lon" AS "orig_lon",
            "public"."trip"."orig_stop_or_autopark" AS "orig_stop_or_autopark",
            "public"."trip"."access_mode" AS "access_mode",
            "public"."trip"."access_latitude" AS "access_latitude",
            "public"."trip"."access_longitude" AS "access_longitude",
            "public"."trip"."access_time" AS "access_time",
            "public"."trip"."dest_stop_or_autopark" AS "dest_stop_or_autopark",
            "public"."trip"."egress_mode" AS "egress_mode",
            "public"."trip"."egress_latitude" AS "egress_latitude",
            "public"."trip"."egress_longitude" AS "egress_longitude",
            "public"."trip"."egress_time" AS "egress_time",
            "public"."trip"."start_time" AS "start_time",
            "public"."trip"."waiting_time" AS "waiting_time",
            "public"."trip"."dest_loc_type" AS "dest_loc_type",
            "public"."trip"."dest_dist" AS "dest_dist",
            "public"."trip"."dest_neig" AS "dest_neig",
            "public"."trip"."dest_loc" AS "dest_loc",
            "public"."trip"."is_paid_road" AS "is_paid_road",
            "public"."trip"."autopark_cost" AS "autopark_cost",
            "public"."trip"."public_transport_cost" AS "public_transport_cost",
            "public"."trip"."end_time" AS "end_time",
            "public"."trip"."dest_lat" AS "dest_lat",
            "public"."trip"."dest_lon" AS "dest_lon"
        FROM
            "public"."trip"
    ) AS "source"
LEFT JOIN "public"."household" AS "Household - Hh" ON "source"."hh_id" = "Household - Hh"."hh_id"
LEFT JOIN "public"."survey" AS "Survey" ON "Household - Hh"."survey_id" = "Survey"."id"
WHERE
    ("Survey"."s_date" >= '2024-02-05') -- 5 Şubat 2024'ten itibaren
    AND ("Survey"."s_date" < CURRENT_DATE) -- Bugünden geriye doğru
    AND ("Survey"."org_id" = 'ZN1034')
    AND (
        ("source"."purpose" <> 'Eve gidiş')
        OR ("source"."purpose" IS NULL)
    )
    AND ("Household - Hh"."district" IS NOT NULL)
    AND (
        ("Household - Hh"."district" <> '')
        OR ("Household - Hh"."district" IS NULL)
    )
GROUP BY
    "Household - Hh"."district",
    "purpose"
ORDER BY
    "Household - Hh"."district" ASC,
    "purpose" ASC;
