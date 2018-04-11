## Water Pump data mining competition

This is the code that I am writing as part of a competition to build a model to predict the functionality of water pumps in Tanzania. The data is provided by Taarifa and the Tanzanian Ministry of Water. It is community-provided data. 


## Supervised learning 

This is a supervised learning project with a training and test data set. 

The possible outcome labels are functional, non functional, and functional needs repair. The training dataset has 2 files, training_set.csv, which contains the predictive variables, and training_labels.csv, which is a list of the outcome variables for the training subjects. 

The submission file is the outcome label of the classification (functional, non functional, or functional needs repair), as well as the ID number of the site for test data. The test and training data sets were split by Driven Data. 

The competition can be found at DrivenData.org: 

https://www.drivendata.org/competitions/7/pump-it-up-data-mining-the-water-table/


## Programming 

The analysis will be done using the python programming language. The files will be shareable via a Docker container. 

## Code files 

The code files are divided into several parts.

Data Visualization - This takes a look at the data in the different fields. 
Model Building - Create and build a model. Then predict on test data.
Map Building - Building a map of the water sources and their functionality.

## Unresolved issues

The API for Taarifa has not been updated in 3 years and appears to be broken. Installation cannot be completed, which means the status of the water pumps cannot be tested. 


## To Do

Add a map of Tanzania with the water sources listed, broken down by status.


