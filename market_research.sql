USE market_research;

# Pulling all records from each state, including D.C, to show stats

SELECT * FROM pet_ownership_statistics_usa;

# How many states have a percentage of over 50 with pets in households?

SELECT State, TotalHouseoldsPerc
FROM pet_ownership_statistics_usa
WHERE TotalHouseoldsPerc >= 50
ORDER BY TotalHouseoldsPerc DESC;

	-- 40 states have over 50% of households that has pets! USA sure loves their pets!
    
# What's the average percentage of households in the USA that has pets?

SELECT AVG(TotalHouseoldsPerc) AS AvgTotalHousholdsPerc
FROM pet_ownership_statistics_us;

	-- An average of over 58% of housholds in tha USA has atleast one pet!
    
# Which states have the highest average number of dogs or cats per household?

SELECT State, AvgNumDogs, AvgNumCats
FROM pet_ownership_statistics_usa
ORDER BY AvgNumDogs DESC, AvgNumCats DESC
LIMIT 10; 

	-- Common to see close to 2 dogs or 2 cats in each household. Better in pairs!

# Which states have the highest percentage of households with dogs and cats?

SELECT State, DogOwnersPerc, CatOwnersPerc
FROM pet_ownership_statistics_usa
ORDER BY DogOwnersPerc DESC, CatOwnersPerc DESC
LIMIT 10;

	-- Idaho has 58.3% households with dogs and 33% of households with cats! Will this correlate with Idaho having a high dog devotion score?
    
	SELECT * FROM pet_ownership_statistics_usa
	WHERE State = 'Idaho';
	
	-- Unforuntately, Idaho is ranking low on Dog Devotion Score which reflects it in the %'s of who would spend $4k to save their dog and who would stay at a job they dislike for the dog

## Which states have the highest "Dog Devotion Scores?

SELECT State, DogDevotionScore
FROM pet_ownership_statistics_usa
ORDER BY DogDevotionScore DESC
LIMIT 10;

-- Wow! Colorado rated a perfect 100% score on their devotion to dogs. Let's see the rest of the stats for Colorado:

	SELECT * FROM pet_ownership_statistics_usa
	WHERE State = 'Colorado';
    
    /*This data tells me that although they love their dogs deeply, almost 50% of the owners would spend $4k to save them, but very few would sacrifice to stay at a job they dislike 
    for their dogs. This isn't bad because they could mean they would upgrade their job with more money and better work-life balance to spoil their dogs. */
    
# Which are the top states that show high devotion (Spend over $4k to save their dog or stay at a job they dislike)

SELECT State, WhoStayedAtAJobTheyDislikedForDogPerc, WhoWouldSpend4kToSaveDogPerc
FROM pet_ownership_statistics_usa
ORDER BY WhoStayedAtAJobTheyDislikedForDogPerc DESC, WhoWouldSpend4kToSaveDogPerc DESC
LIMIT 10;

	-- Relatively, most states show low percentage to stay at a job they disliked, which is a good thing, because it's not a good thing to sacrifice your health/sanity to please others

#What about which states show high percentage of who would spend $4k to spend their dogs and have high Dog Devotion score over 80?

SELECT State, WhoWouldSpend4kToSaveDogPerc, DogDevotionScore
FROM pet_ownership_statistics_usa
WHERE DogDevotionScore >= 80
ORDER BY DogDevotionScore DESC
LIMIT 10;

	/*From these results, I would choose to expand my market to either Colorado, Virginia, Georgia, or Washington. A high dog devotion score over 80 and over 40% of willingness to spend
    over $4k for their dogs health shows that they would actively upkeep their dogs health and care. Therefore, it would show that these states would support having pet care service 
    businesses in the area. */
  
  
/*Let's create a formula that can identify a high index combining the columns of Dog devotion score, % of people who would stay at a job they dislike, and % of people who would spend $4k
weighted by the % of dog ownership */

SELECT State, 
       (DogOwnersPerc * (DogDevotionScore + WhoStayedAtAJobTheyDislikedForDogPerc + WhoWouldSpend4kToSaveDogPerc) / 3) AS PetLoyaltyIndex
FROM pet_ownership_statistics_usa
ORDER BY PetLoyaltyIndex DESC;

	-- Once again, this confirms that Colorado is a solid choice where theres a high chance of a pet care service business doing well!


# Last, but not least let's see the stats for Illinois where I will first be opening the business in comparison to Colorado where I plan to expand the business to:

SELECT * FROM pet_ownership_statistics_usa
WHERE State IN ('Illinois','Colorado');

-- Although Illinois doesn't show the highest devotion score, the rest of it's stats are solid (close to 50% of household with pets and close to 40% of who will spend $4k to save their dog




/* !! Now I'll show a different data set to show that there's a need of dog groomers in Chicago !! */

SELECT * FROM market_research.google_trend_dog_grooming_chicago; 

-- This is a table reflecting the google trends from the past 12 months of people searching dog grooming in Chicago. The score is out of 100 in popularity.


# Which week's reflected a score above 85?

SELECT * FROM google_trend_dog_grooming_chicago
WHERE Popular_Score_100 >= 85
ORDER BY Popular_Score_100 DESC;

/* Out of this data set it shows people search for dog groomers a lot after valentines day. Also for 3 weeks straight in November, it ranked a high popular score. 
This shows that people are more inclined to groom their dogs before thanksgiving. */


# What are the minimum, maximum, average, and median popularity scores?

SELECT MIN(Popular_Score_100) AS Min_Score, MAX(Popular_Score_100) AS Max_Score, AVG(Popular_Score_100) AS Average_Score
FROM google_trend_dog_grooming_chicago;

-- An average of over 76 shows the popularity score for chicagoans looking for dog groomers throughout the past 12 months. 


# By breaking the date into Year and Months, what is the average per month?

SELECT year(Week) AS Year, month(Week) AS Month, AVG(Popular_Score_100) AS Average_Score
FROM google_trend_dog_grooming_chicago
GROUP BY Year, Month;

/* This shows that the last quarter of the year (October, November, December) has the among the highest average for chicagoans looking for dog groomers, 
which coincide with the holiday season */

# Let's confirm this by showing the average score by quarters

SELECT year(Week) AS Year, quarter(Week) AS Quarters_of_the_Year, AVG(Popular_Score_100) AS Average_Score
FROM google_trend_dog_grooming_chicago
GROUP BY Year, Quarters_of_the_Year;

-- As shown, I'm currently starting my business at a great time to gear up for the holiday rush and need of dog groomers in Chicago! 