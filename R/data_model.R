# Data model 

# load libraries 
library(rpart)
library(lubridate)
library(randomForest)

# Import data and labels
training.set <- read.csv("~/github/water-pump/R/training_set.csv")
training.labels <- read.csv("~/github/water-pump/R/training_labels.csv")
test.set <- read.csv("~/github/water-pump/R/test_set.csv")

# Combine the training set and the labels. 
training.dat <- cbind(status_group = training.labels$status_group, training.set)
# Create an age using the construction year and the date recorded.
training.dat$age <- ifelse(training.dat$construction_year==0, NA,
                year(training.dat$date_recorded)-training.dat$construction_year)
test.set$age <- ifelse(test.set$construction_year==0, NA,
                           year(test.set$date_recorded)-test.set$construction_year)

# These two models are using a decision tree from the libray rpart
# The success of these are in the 0.60ish range. 
fit1 <- rpart(status_group ~ region + water_quality, method="class", data=training.dat)
fit2 <- rpart(status_group ~ region + water_quality + quantity + waterpoint_type + 
                age + amount_tsh + latitude + longitude + gps_height + population + 
                source + payment + extraction_type_group, 
              method="class", data=training.dat)

# The second two models use the randomForest package. 
fit.rf2 <- randomForest(status_group ~ region + water_quality + quantity + waterpoint_type + 
                amount_tsh + latitude + longitude + gps_height + population + 
                source + payment + extraction_type_group, 
              method="class", data=training.dat)

# This one performs the best. 
fit.rf3 <- randomForest(status_group ~ region + water_quality + quantity + waterpoint_type + 
                          amount_tsh + latitude + longitude + gps_height + population + 
                          source + payment + extraction_type_group + basin + public_meeting +
                          permit + management_group, 
                        method="class", data=training.dat)


## Classify the test data. 
labels1 <- predict(fit1, test.set, type = "class")
labels2 <- predict(fit2, test.set, type = "class")
labels.rf2 <- predict(fit.rf2, test.set, type = "class")
labels.rf3 <- predict(fit.rf3, test.set, type = "class")

# Check the distribution of the test labels. 
count1 <- length(labels.rf2)
count2 <- length(training.labels$status_group)

table(labels1)
table(labels2)
table(labels.rf2)*100/count1
table(labels.rf3)*100/count1
table(training.labels$status_group)*100/count2

# Write csv to judge the test data for the 2 random forest models. 
test.labels.rf2 <- data.frame(cbind(id=test.set$id, status_group=as.character(labels.rf2)))
write.csv(test.labels.rf2, "bootstrap_test.csv", row.names=FALSE)

test.labels.rf3 <- data.frame(cbind(id=test.set$id, status_group=as.character(labels.rf3)))
write.csv(test.labels.rf3, "bootstrap_test2.csv", row.names=FALSE)
