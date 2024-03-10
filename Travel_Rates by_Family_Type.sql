WITH Tablo AS (
    SELECT
        CASE
            WHEN h.hh_type = 'Anne, Baba ve çocuklardan oluşan' THEN h.hh_type
            WHEN h.hh_type = 'Sadece evli çiftten oluşan' THEN h.hh_type
            WHEN h.hh_type = 'Yalnız yaşayan kişi' THEN h.hh_type
            WHEN h.hh_type = 'Anne ve çocuklardan oluşan' THEN h.hh_type
            WHEN h.hh_type = 'Çekirdek Aile + çekirdek aile dışında en az bir kişiden oluşan' THEN h.hh_type
            WHEN h.hh_type = 'Çekirdek aile bulunmayan birden fazla kişiden oluşan(Ev arkadaşları vb.)' THEN h.hh_type
            WHEN h.hh_type = 'Baba ve çocuklardan oluşan' THEN h.hh_type
            ELSE 'Diğer'
        END AS hh_type,
        SUM(tr.toplam_yolculuk_sayısı) AS toplam_yolculuk_sayısı,
        COUNT(DISTINCT h.hh_id) AS ziyaret_edilen_hane_sayısı,
        COUNT(DISTINCT p.p_id) AS toplam_kişi_sayısı,
        COUNT(DISTINCT CASE WHEN p.had_trip = 'Evet' THEN p.p_id END) AS yolculuk_yapan_kişi_sayısı,
        SUM(tr.toplam_yolculuk_sayısı) * 1.0 / COUNT(DISTINCT p.p_id) AS brut_rate,
        SUM(tr.toplam_yolculuk_sayısı) * 1.0 / COUNT(DISTINCT CASE WHEN p.had_trip = 'Evet' THEN p.p_id END) AS net_rate
    FROM
        household AS h
    LEFT JOIN
        profile AS p ON h.hh_id = p.hh_id
    LEFT JOIN
    (
        SELECT  
            (
                CASE
                    WHEN t2.acc_p LIKE 'Tek' THEN 0
                    ELSE LENGTH(t2.acc_p) - LENGTH(REPLACE(t2.acc_p, ',', '')) + 1
                END
            ) + 1 AS toplam_yolculuk_sayısı,  
            t2.*
        FROM
            (
                SELECT DISTINCT
                    hh_id, p_id, purpose, start_time
                FROM
                    trip AS t
            ) AS t1
        JOIN
            trip AS t2 ON t1.hh_id = t2.hh_id AND t1.p_id = t2.p_id AND t1.purpose = t2.purpose AND t1.start_time = t2.start_time
    ) AS tr ON p.p_id = tr.p_id
    LEFT JOIN
        survey AS s ON h.hh_id = s.id
    WHERE
        h.hh_type IS NOT NULL
        AND DATE(s.s_date) >= '2024-02-05'  -- 5 Şubat 2024'ten itibaren
        AND s.result = 'Görüşme Tamamlandı'
        AND p.age > 5
        AND p.participation_status = 'Evet'
        AND h.district IN ('AVCILAR', 'BEYLİKDÜZÜ', 'ZEYTİNBURNU', 'BÜYÜKÇEKMECE', 'KÜÇÜKÇEKMECE', 'BAKIRKÖY', 'ESENYURT', 'SİLİVRİ')
    GROUP BY
        CASE
            WHEN h.hh_type = 'Anne, Baba ve çocuklardan oluşan' THEN h.hh_type
            WHEN h.hh_type = 'Sadece evli çiftten oluşan' THEN h.hh_type
            WHEN h.hh_type = 'Yalnız yaşayan kişi' THEN h.hh_type
            WHEN h.hh_type = 'Anne ve çocuklardan oluşan' THEN h.hh_type
            WHEN h.hh_type = 'Çekirdek Aile + çekirdek aile dışında en az bir kişiden oluşan' THEN h.hh_type
            WHEN h.hh_type = 'Çekirdek aile bulunmayan birden fazla kişiden oluşan(Ev arkadaşları vb.)' THEN h.hh_type
            WHEN h.hh_type = 'Baba ve çocuklardan oluşan' THEN h.hh_type
            ELSE 'Diğer'
        END
)
SELECT 
    hh_type,
    toplam_yolculuk_sayısı,
    ziyaret_edilen_hane_sayısı,
    toplam_kişi_sayısı,
    yolculuk_yapan_kişi_sayısı,
    CASE WHEN toplam_kişi_sayısı > 0 THEN toplam_yolculuk_sayısı * 1.0 / toplam_kişi_sayısı ELSE 0 END AS brut_rate,
    CASE WHEN yolculuk_yapan_kişi_sayısı > 0 THEN toplam_yolculuk_sayısı * 1.0 / yolculuk_yapan_kişi_sayısı ELSE 0 END AS net_rate
FROM 
    Tablo

UNION ALL

SELECT 
    'Genel Toplam',
    SUM(toplam_yolculuk_sayısı),
    SUM(ziyaret_edilen_hane_sayısı),
    SUM(toplam_kişi_sayısı),
    SUM(yolculuk_yapan_kişi_sayısı),
    CASE WHEN SUM(toplam_kişi_sayısı) > 0 THEN SUM(toplam_yolculuk_sayısı) * 1.0 / SUM(toplam_kişi_sayısı) ELSE 0 END AS brut_rate,
    CASE WHEN SUM(yolculuk_yapan_kişi_sayısı) > 0 THEN SUM(toplam_yolculuk_sayısı) * 1.0 / SUM(yolculuk_yapan_kişi_sayısı) ELSE 0 END AS net_rate
FROM 
    Tablo;
