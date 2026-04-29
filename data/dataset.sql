-- 1. 데이터 확인
SELECT * FROM sample_data.csv LIMIT 10;

-- 2. 기업규모별 분포 확인
SELECT 기업규모, COUNT(*) 
FROM sample_data.csv
GROUP BY 기업규모;