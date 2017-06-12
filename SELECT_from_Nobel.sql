/*
| yr | subject | winner |
| 1960 | Chemistry | Willard F. Libby |
| 1960 |	Literature | Saint-John Perse |
| 1960 |	Medicine | Sir Frank Macfarlane Burnet |
| 1960 |	Medicine | Peter Madawar |
| ... |


We continue practicing simple SQL queries on a single table.

This tutorial is concerned with a table of Nobel prize winners:

nobel(yr, subject, winner)
Using the SELECT statement.

*/

/*
1) Change the query shown so that it displays Nobel prizes for 1950.
*/

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950

/*
2) Show who won the 1962 prize for Literature.
*/

SELECT winner
FROM nobel
WHERE yr = 1962 AND subject = 'Literature'

/*
3) Show the year and subject that won 'Albert Einstein' his prize.
*/

SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'

/*
4) Give the name of the 'Peace' winners since the year 2000, including 2000.
*/

SELECT winner FROM nobel
WHERE subject = 'Peace' AND yr >= 2000

/*
5)Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive.
*/

SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Literature' AND yr BETWEEN 1980 AND 1989

/*
6) Show all details of the presidential winners:

Theodore Roosevelt
Woodrow Wilson
Jimmy Carter
Barack Obama
*/

SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')

/*
7) Show the winners with first name John
*/

SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

/*
8) Show the Physics winners for 1980 together with the Chemistry winners for 1984.
*/

SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Physics' AND yr = '1980' OR subject = 'Chemistry' AND yr = '1984'

/*
9) Show the winners for 1980 excluding the Chemistry and Medicine
*/

SELECT yr, subject, winner
FROM nobel
WHERE yr = 1980 AND subject NOT LIKE 'Chemistry' AND subject NOT LIKE 'Medicine'

/*
10) Show who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with
winners of a 'Literature' prize in a later year (after 2004, including 2004)
*/

SELECT yr, subject, winner
FROM nobel
WHERE subject = 'Medicine' AND yr < 1910 OR subject = 'Literature' AND yr >= '2004'

/*
11) Find all details of the prize won by PETER GRÜNBERG

Non-ASCII characters
The u in his name has an umlaut. You may find this link useful
https://en.wikipedia.org/wiki/%C3%9C#Keyboarding
*/

SELECT yr, subject, winner
FROM nobel
WHERE winner = 'Peter Grünberg'

/*
12) Find all details of the prize won by EUGENE O'NEILL

Escaping single quotes
You can't put a single quote in a quote string directly. You can use two single quotes within
a quoted string.
*/

SELECT yr, subject, winner
FROM nobel
WHERE winner = 'Eugene O''Neill'

/*
13) Knights in order

List the winners, year and subject where the winner starts with Sir.
Show the the most recent first, then by name order.
*/

SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC

/*
14) The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.

Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last.
*/

SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject,winner

-- QUIZ

/*
1)  Pick the code which shows the name of winner's names beginning with C and ending in n
*/

SELECT winner FROM nobel
WHERE winner LIKE 'C%' AND winner LIKE '%n'

/*
2) Select the code that shows how many Chemistry awards were given between 1950 and 1960
*/

SELECT COUNT(subject) FROM nobel
WHERE subject = 'Chemistry' AND yr BETWEEN 1950 and 1960

/*
3) Pick the code that shows the amount of years where no Medicine awards were given
*/

SELECT COUNT(DISTINCT yr) FROM nobel
WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine')

/*
4) Select the result that would be obtained from the following code:
*/

SELECT subject, winner FROM nobel
WHERE winner LIKE 'Sir%' AND yr LIKE '196%'

/*
| Medicine | Sir John Eccles |
| Medicine | Sir Frank Macfarlane Burnet |
*/

/*
5) Select the code which would show the year when neither a Physics or Chemistry award was given
*/

SELECT yr FROM nobel
WHERE yr NOT IN (SELECT yr FROM nobel WHERE subject IN ('Chemistry','Physics'))

/*
6)  Select the code which shows the years when a Medicine award was given but no Peace or
Literature award was
*/

SELECT DISTINCT yr FROM nobel
WHERE subject='Medicine'
  AND yr NOT IN(SELECT yr FROM nobel WHERE subject='Literature')
  AND yr NOT IN (SELECT yr FROM nobel WHERE subject='Peace')

/*
7) Pick the result that would be obtained from the following code:
*/

SELECT subject, COUNT(subject) FROM nobel
WHERE yr ='1960'
GROUP BY subject

/*
| Chemistry | 1 |
| Literature | 1 |
| Medicine | 2 |
| Peace | 1 |
| Physics | 1 |
*/
