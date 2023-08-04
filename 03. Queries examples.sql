-- Individuals involved in sexual acts: 
-- people who have a temporary increase in their heart rate during the night for several minutes, 
-- as tracked by their smartwatch.

SELECT dem.user_id, dem.gender, dem.age, hr.datetime, hr.rate FROM demographics dem
JOIN users USING (dem_id)
JOIN medical USING (med_id)
JOIN heart_rate hr USING (rate_id)
WHERE rate > (SELECT AVG(rate) FROM heart_rate)
AND CAST(datetime AS TIME) BETWEEN '00:00:00' AND '06:00:00'
ORDER BY rate DESC;



-- Individuals who cheat on their partners: people who are married according to demographic data, 
--yet possess a dating application on their smartphones where they are registered as 
--“single” or “available”.

SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (dem_id)
JOIN psychographics USING (psy_id)
JOIN dating_app da USING (dating_id)
WHERE dem.marital_status = 'Married'
AND da.status IN ('single', 'available')



-- Individuals dealing with both drug and alcohol problems: 
-- using data voluntarily provided by individuals in their dating app profile descriptions.

SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (dem_id)
JOIN psychographics USING (psy_id)
JOIN dating_app da USING (dating_id)
WHERE da.drugs = 'often'
AND da.drinks IN ('often', 'very often')



-- Individuals in a bad mental state: 
--people who have searched for the term ’depression’ in their search engine 
--and have a high level of stress, as tracked by their smartwatch.

SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (dem_id)
JOIN medical USING (med_id)
JOIN searched_symptoms USING (search_id)
WHERE symptoms LIKE '%depression%'
INTERSECT 
SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (dem_id)
JOIN psychographics USING (psy_id)
JOIN stress_level USING (sl_id)
WHERE stress_level = 'high'



--  Individuals with (probably) lack of motivation: 
-- individuals with an overweight or slightly extra body type but with a shorter duration of daily
-- activity compared to the average.

SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (user_id)
JOIN psychographics USING (psy_id)
JOIN dating_app da USING (dating_id) 
JOIN medical USING (med_id)
JOIN smartwatch sm USING (sm_id)
WHERE sm.active_minutes < (SELECT AVG(active_minutes) FROM smartwatch)
AND da.body_type IN ('overweight', 'a little extra')



--  Individuals with a bad financial status: 
-- People with a modest income but a substantial bank loan responsibility

SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (dem_id)
JOIN financial USING (fin_id)
JOIN bank_loan bl USING (loan_id)
WHERE dem.salary = '<=50K'
AND bl.credit_amount > (SELECT AVG(credit_amount) FROM bank_loan)



--  Individuals with insomnia

SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (dem_id)
JOIN medical USING (med_id)
JOIN smartwatch USING (sm_id)
WHERE minutes_asleep < (SELECT AVG(minutes_asleep) FROM smartwatch);



--  Individuals who make the most online purchases

SELECT ols.user_id, dem.gender, dem.age, COUNT (ols.user_id) FROM online_shopping ols
JOIN financial USING (fin_id)
JOIN users USING (dem_id)
JOIN demographics dem USING (user_id)
GROUP BY ols.user_id, dem.gender, dem.age
ORDER BY count(ols.user_id) desc;



-- Individuals who have children - based on their shopping habits

SELECT DISTINCT dem.user_id, dem.gender, dem.age, ols.item FROM demographics dem
JOIN users USING (dem_id)
JOIN financial USING (fin_id)
JOIN online_shopping ols USING (olshop_id)
WHERE item LIKE '%KIDS%'
OR item LIKE '%KID%'
OR item LIKE '%CHILDRENS%'
OR item LIKE '%CHILDREN%'
OR item LIKE '%TOY%'
OR item LIKE '%TOYS%'



--  Most likely, athletes: 
-- Individuals with an above average total distance
-- but with a typically lower heart rate of less than 60. Regular exercise and
--physical training can lead to several adaptations in the cardiovascular system,
--including a lower resting heart rate.

SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (user_id)
JOIN medical USING (med_id)
JOIN smartwatch sm USING (sm_id)
WHERE sm.total_distance > (SELECT AVG(total_distance) FROM smartwatch)
INTERSECT
SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (user_id)
JOIN medical USING (med_id)
JOIN heart_rate hr USING (rate_id)
WHERE hr.rate <= 60;



--  Individuals who are searching for a job: 
-- those who frequently access LinkedIn.

SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (user_id)
JOIN browser USING (brow_id)
JOIN history h USING (hist_id)
WHERE url LIKE '%linkedin%';



--  Individuals with a high standard of living who enjoy their lives

SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (dem_id)
JOIN financial USING (fin_id)
JOIN bank_loan bl USING (loan_id)
WHERE bl.saving_accounts IN ('rich', 'quite rich')
INTERSECT 
SELECT dem.user_id, dem.gender, dem.age FROM demographics dem
JOIN users USING (dem_id)
JOIN psychographics USING (psy_id)
JOIN stress_level sl USING (sl_id)
WHERE sl.stress_level IN ('low/normal', 'medium_low');
