# This sql code is what I used to figure out the correct sql query for the zillow project

use zillow;

SELECT count(distinct(parcelid))
FROM properties_2017;

SELECT COUNT(*)
FROM properties_2017;

# what I used for the exercises (not for the project)
SELECT bedroomcnt, bathroomcnt, calculatedfinishedsquarefeet, taxvaluedollarcnt, yearbuilt, taxamount, fips
FROM properties_2017
JOIN propertylandusetype USING (propertylandusetypeid)
WHERE propertylandusedesc = 'Single Family Residential'
;

SELECT *
FROM propertylandusetype;

SELECT parcelid, COUNT(parcelid) as p_cnt, MAX(transactiondate)
FROM predictions_2017
GROUP BY parcelid
HAVING p_cnt >= 2
ORDER BY p_cnt
;

SELECT parcelid, MAX(transactiondate)
FROM predictions_2017
GROUP BY parcelid
;
# first I wanted a query that gets me all distinct parcelids with the latest transaction date
#   i.e. it accounts for parcelids that were sold more than once in 2017
SELECT parcelid, logerror, maxdates.transactiondate
FROM (
	SELECT parcelid, MAX(transactiondate) as transactiondate
	FROM predictions_2017
	GROUP BY parcelid ) as maxdates
JOIN predictions_2017 using (parcelid)
WHERE predictions_2017.transactiondate = maxdates.transactiondate
;

# this code proves the above code gave me the right number of rows: 77414 which is 200 less than all parcelids
SELECT COUNT(parcelid)
FROM (
	SELECT parcelid, MAX(transactiondate) as transactiondate
	FROM predictions_2017
	GROUP BY parcelid ) as maxdates
JOIN predictions_2017 using (parcelid)
WHERE predictions_2017.transactiondate = maxdates.transactiondate
;

# total count is 2,985,217. distinct count is also 2,985,217. So, no repeated parcelid's in the big table
SELECT COUNT(DISTINCT(parcelid))
FROM properties_2017;

SELECT *
FROM propertylandusetype;

SELECT bedroomcnt, bathroomcnt, calculatedfinishedsquarefeet, taxvaluedollarcnt, yearbuilt, taxamount, fips
FROM properties_2017
JOIN propertylandusetype USING (propertylandusetypeid)
WHERE propertylandusedesc = 'Single Family Residential';

# Here is the sql call that pulls the correct data: 52,320 rows
# This pulls all columns
SELECT *
FROM properties_2017
JOIN propertylandusetype USING (propertylandusetypeid)
JOIN (
	SELECT parcelid, logerror, maxdates.transactiondate
	FROM (
		SELECT parcelid, MAX(transactiondate) as transactiondate
		FROM predictions_2017
        WHERE transactiondate LIKE '%2017%' 
		GROUP BY parcelid ) as maxdates
	JOIN predictions_2017 using (parcelid)
	WHERE predictions_2017.transactiondate = maxdates.transactiondate
    ) AS target_transactions USING (parcelid)
WHERE propertylandusedesc = 'Single Family Residential'
;


# I looked at null counts, and these are the columns I want back.
SELECT parcelid, bathroomcnt, bedroomcnt, poolcnt
        , calculatedfinishedsquarefeet, lotsizesquarefeet, yearbuilt
        , fips, regionidcity, regionidzip
        , latitude, longitude, rawcensustractandblock, censustractandblock, taxvaluedollarcnt
FROM properties_2017
JOIN propertylandusetype USING (propertylandusetypeid)
JOIN (
	SELECT parcelid, logerror, maxdates.transactiondate
	FROM (
		SELECT parcelid, MAX(transactiondate) as transactiondate
		FROM predictions_2017
        WHERE transactiondate LIKE '%2017%'
		GROUP BY parcelid ) as maxdates
	JOIN predictions_2017 using (parcelid)
	WHERE predictions_2017.transactiondate = maxdates.transactiondate
    ) AS target_transactions USING (parcelid)
WHERE (propertylandusedesc = 'Single Family Residential')
;

# So, I think I have some rows where the transaction date is not within 2017. need to fix

SELECT DISTINCT(transactiondate)
FROM predictions_2017
WHERE transactiondate LIKE '%2017%'
ORDER BY transactiondate
;
SELECT parcelid, MAX(transactiondate) as transactiondate
FROM predictions_2017
WHERE transactiondate LIKE '%2017%'
GROUP BY parcelid
ORDER BY transactiondate DESC
;
-- ----------------------------------------------------------
-- The code below is in preparation for the clustering exercises
-- You will want to end with a single dataframe. Include the logerror field 
-- and all other fields related to the properties that are available. 
-- You will end up using all the tables in the database.

-- Be sure to do the correct join (inner, outer, etc.). We do not want to 
-- eliminate properties purely because they may have a null value for 
-- airconditioningtypeid. - Only include properties with a transaction in 2017, 
-- and include only the last transaction for each property (so no duplicate 
-- property ID's), along with zestimate error and date of transaction. 
-- (Hint: read the docs for the .duplicated method) - Only include properties 
-- that have a latitude and longitude value.

SELECT *
FROM properties_2017
WHERE isnull(airconditioningtypeid) = False
;

SELECT *
FROM predictions_2017;

SELECT parcelid, MAX(transactiondate) as transactiondate
FROM predictions_2017
WHERE transactiondate LIKE '%2017%'
GROUP BY parcelid
ORDER BY transactiondate DESC
;

# This query gets all the parcelid's with a 2017 transaction date with the latest transactiondate
SELECT temp.parcelid as parcelid, p.logerror as logerror, temp.transactiondate as transactiondate
FROM (
	SELECT parcelid, MAX(transactiondate) as transactiondate
	FROM predictions_2017
	WHERE transactiondate LIKE '%2017%'
	GROUP BY parcelid
	ORDER BY transactiondate DESC
    ) AS temp
JOIN predictions_2017 as p ON p.parcelid = temp.parcelid AND p.transactiondate = temp.transactiondate
;
# Checking for duplicate parcelids in properties_2017 - there are none
SELECT COUNT(DISTINCT(parcelid))
FROM properties_2017;

# furthermore, the number of unique parcelids in properties_2017 = the number of unique parcelids in unique_properties
# Therefore, I'm assuming those parcelids are the same
SELECT COUNT(parcelid)
FROM unique_properties;


SELECT *
FROM (
		SELECT temp.parcelid as parcelid, p.logerror as logerror, temp.transactiondate as transactiondate
		FROM (
			SELECT parcelid, MAX(transactiondate) as transactiondate
			FROM predictions_2017
			WHERE (transactiondate >= '2017-01-01') and (transactiondate < '2018-01-01')
			GROUP BY parcelid
			ORDER BY transactiondate DESC
			) AS temp
		JOIN predictions_2017 as p ON p.parcelid = temp.parcelid AND p.transactiondate = temp.transactiondate
	) AS p_2017
JOIN properties_2017 USING(parcelid)
LEFT JOIN airconditioningtype USING(airconditioningtypeid)
LEFT JOIN architecturalstyletype USING (architecturalstyletypeid)
LEFT JOIN buildingclasstype USING (buildingclasstypeid)
LEFT JOIN heatingorsystemtype USING (heatingorsystemtypeid)
LEFT JOIN propertylandusetype USING (propertylandusetypeid)
LEFT JOIN storytype USING (storytypeid)
LEFT JOIN typeconstructiontype USING (typeconstructiontypeid)
;

select * from predictions_2017;
select * from predictions_2017 where transactiondate >= '2018-01-01'
;
