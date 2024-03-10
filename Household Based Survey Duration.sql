SELECT 
    hh.hh_size, 
    FLOOR(AVG(EXTRACT(EPOCH FROM (e_date - s_date))/60)) AS duration,
    COUNT(hh.hh_id) AS household_count

FROM 
    survey
LEFT JOIN 
    household AS hh ON survey.id = hh.hh_id
WHERE
    result = 'Görüşme Tamamlandı' 
    AND FLOOR(EXTRACT(EPOCH FROM (e_date - s_date))/60) < 60  
    AND DATE(survey.s_date) >= CURRENT_DATE - INTERVAL '1 week'  
    AND survey.org_id = 'ZN1034'
    AND e_date > s_date
GROUP BY 
    hh.hh_size;
