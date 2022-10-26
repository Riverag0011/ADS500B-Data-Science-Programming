#Open Country Table from world schema
SELECT * FROM Country;


#1.1 Count countries that became independent in the 20th century
SELECT COUNT(*) Total_Countries From Country
Where IndepYear Between '1901' AND '2000';
#149 countries became independent in the 20th century


#1.2 Number of people in the world expected to live 75yrs above
select count(*) Total_Countries,
COALESCE (sum(Population),0) Number_People 
FROM Country
WHERE IndepYear >= '75';
#Answer = 4,593,107,100 billion people are expected to live at 75yrs and above


#1.3 10 most populated countries in the world (population as percentage of the world population)
#Total world population = 6,078,749,450 billion people
SELECT
COALESCE (SUM(Population),0) Total_population
FROM Country;
#Top 10 population in percentage
SELECT Name, Population,
COALESCE (((Population/6078749450)*100),0) Percent_population
FROM Country
ORDER By Percent_population DESC
LIMIT 10;


#1.4 Top 10 countries with highest population density
Select Name, Population, SurfaceArea,
COALESCE ((Population/SurfaceArea),0) Population_Density
FROM Country
ORDER By Population_Density DESC
LIMIT 10;


#1.5 Count of countries in each Region in descending order
SELECT Region,
COUNT(Name) Num_Countries
FROM Country
GROUP By Region
ORDER By Num_Countries DESC;


#1.6 Countries with more than 1 languages
SELECT CountryCode,
COUNT(Language) Num_Lang
FROM CountryLanguage
GROUP By CountryCode
HAVING Num_Lang > 10
ORDER By Num_Lang DESC;
