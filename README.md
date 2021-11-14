# Fraud-analysis-SQL
Using PostSQL and python to determine if in a database of transaction we can determine fraud

## Data Analysis in PostSQL
Based on the small transaction analysis I could determine if something unusual is occuring. Each cardholder keeps a small amount of transaction compared to their total amount of transaction.
Same comclusion for the small transactions between 7:00 and 9:00. The total amount of small transaction represent 43units wheras the total amount of small transaction during the hole day is 353units.
Finally the 5 top mercahnts prone to being hacked were identified using the average price per transaction. This choice is based on the fact that it would be the most difficult to determine for them if small transactions are unusual.


## Data Analysis in Python
Cardholder 2 and cardholder 18 are at first subject to our analysis.
We notified that there are serval transactions that are unusual for cardholder 18. The analysis on Cardholder 2 doesn't show any conclusions.

Our second analysis was targetting cardholder 25.
There is in average 1.5times per month a transaction that looks strange. It is a large amount compared to all other transactions.
April and June are the most suspicious with three unusual transactions.

## Challenge
This part determines the outliers based on the empiric methode of the standard deviation and it's alternative the interquartile.
We defined function to run randomely for card holders.