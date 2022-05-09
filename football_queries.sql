-- 1. Find all the matches from 2017.
SELECT * FROM matches WHERE season = 2017;

-- 2. Find all the matches featuring Barcelona.
SELECT * FROM matches WHERE hometeam = 'Barcelona';

-- 3. What are the names of the Scottish divisions included?
-- SELECT name, country FROM divisions WHERE country = 'Scotland' GROUP BY name, ountry;
SELECT  DISTINCT names FROM divisions WHERE country = 'Scotland';

-- 4. Find the division code for the Bundesliga. Use that code to find out how
-- many matches Freiburg have played in the Bundesliga since the data started being collected.
-- option 1:
SELECT * INTO result1 FROM divisions WHERE name = 'Bundesliga';
SELECT COUNT(*) FROM matches WHERE name = 'Freiburg' AND division_code = 'D1';

-- option 2:
SELECT COUNT(*), matches.hometeam FROM matches 
INNER JOIN divisions on divisions.code = matches.division_code
WHERE matches.hometeam = 'Freiburg' and divisions.name = 'Bundesliga' 
GROUP BY matches.hometeam;


-- 5. Find the unique names of the teams which include the word "City" in their name (as entered in the database)
SELECT DISTINCT hometeam FROM matches WHERE hometeam ILIKE '%City%';

-- 6. How many different teams have played in matches recorded in a French division?
SELECT COUNT(DISTINCT matches.hometeam) FROM matches 
INNER JOIN divisions on divisions.code = matches.division_code
WHERE divisions.country = 'France';


-- 7. Have Huddersfield played Swansea in the period covered?
SELECT COUNT(*) FROM matches
WHERE hometeam = 'Huddersfield' and awayteam = 'Swansea'
GROUP BY hometeam; 
-- answer is 6, which means yes, Huddersfield have played Swansea in the period covered.


-- 8. How many draws were there in the Eredivisie between 2010 and 2015?
SELECT COUNT(*) FROM matches
WHERE fthg = ftag AND season <= 2015 AND season >= 2010;


-- 9. Select the matches played in the Premier League in order of total goals scored from highest to lowest. 
-- Where there is a tie the match with more home goals should come first.
SELECT * From matches
INNER JOIN divisions on divisions.code = matches.division_code
WHERE divisions.name = 'Premier League'
ORDER BY fthg DESC;



-- 10. In which division and which season were the most goals scored?
SELECT divisions.name, matches.season FROM divisions 
INNER JOIN matches ON matches.division_code = divisions.code
WHERE matches.ftag = (SELECT GREATEST(ftag, fthg) FROM matches) or matches.fthg = (SELECT GREATEST(ftag, fthg) FROM matches);
-- result : Eredivisie 2021

