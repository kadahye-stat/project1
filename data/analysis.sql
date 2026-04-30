-- [목적] 연도별 재무 데이터를 세로 구조로 변환
CREATE TABLE sample_data_long AS

SELECT 
    기업규모,
    업종명,
    2024 AS 연도,
    CAST("24년 총자산" AS REAL) AS 총자산,
    CAST("24년 부채" AS REAL) AS 부채,
    CAST("24년 자기자본" AS REAL) AS 자기자본
FROM sample_data

UNION ALL

SELECT 
    기업규모,
    업종명,
    2023,
    CAST("23년 총자산" AS REAL),
    CAST("23년 부채" AS REAL),
    CAST("23년 자기자본" AS REAL)
FROM sample_data

UNION ALL

SELECT 
    기업규모,
    업종명,
    2022,
    CAST("22년 총자산" AS REAL),
    CAST("22년 부채" AS REAL),
    CAST("22년 자기자본" AS REAL)
FROM sample_data

UNION ALL

SELECT 
    기업규모,
    업종명,
    2021,
    CAST("21년 총자산" AS REAL),
    CAST("21년 부채" AS REAL),
    CAST("21년 자기자본" AS REAL)
FROM sample_data

UNION ALL

SELECT 
    기업규모,
    업종명,
    2020,
    CAST("20년 총자산" AS REAL),
    CAST("20년 부채" AS REAL),
    CAST("20년 자기자본" AS REAL)
FROM sample_data;

--테이블 생성 확인
SELECT name 
FROM sqlite_master 
WHERE type = 'table';

--데이터 확인
SELECT * FROM sample_data_long LIMIT 10;

-- [목적] 기업 규모별 자산 성장 패턴 분석
SELECT 
    기업규모,
    연도,
    ROUND(AVG(총자산), 2) AS 평균자산
FROM sample_data_long
GROUP BY 기업규모, 연도
ORDER BY 기업규모, 연도;

-- [목적] 기업 규모별 자산 성장률 비교
SELECT 
    기업규모,
    ROUND(
        (AVG(CASE WHEN 연도 = 2024 THEN 총자산 END) -
         AVG(CASE WHEN 연도 = 2023 THEN 총자산 END))
        / AVG(CASE WHEN 연도 = 2023 THEN 총자산 END)
    , 4) AS 성장률
FROM sample_data_long
GROUP BY 기업규모
ORDER BY 성장률 DESC;

-- [목적] 기업 규모별 재무 안정성 (부채비율)
SELECT 
    기업규모,
    연도,
    ROUND(AVG(부채 / 총자산), 4) AS 부채비율
FROM sample_data_long
GROUP BY 기업규모, 연도
ORDER BY 기업규모, 연도;
