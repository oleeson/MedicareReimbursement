#read in file as data frame
file <- "https://raw.githubusercontent.com/merdirafiei/CHF/master/CHF.csv"
chf <- read.csv(file)
#few data
head(chf)
str(chf)
#attach dataframe
attach(chf)

#problem 1: means of charges and reimbursement
mean(AmtReim)
mean(TotAccomChg)
mean(TotDeptChg)

#problem 2: standard deviations of charges and reimbursement
sd(AmtReim)
sd(TotAccomChg)
sd(TotDeptChg)

#problem 3: mean of charges and reimbursement by gender
# sex = 1 for male
# sex = 2 for female
tapply(AmtReim, Sex, mean)
tapply(TotAccomChg, Sex, mean)
tapply(TotDeptChg, Sex, mean)

#problem 4: boxplot of reimbursement and charges by gender
#boxplot for medicare reimbursement
boxplot(AmtReim~Sex, main=toupper("Medicare Reimbursement by Gender"), font.main=3, cex.main=1.2, xlab="Gender: 1 = Male || 2 = Female", ylab="Medicare Reimbursement", font.lab=3, col="lightblue")
#boxplot for total accomodation charges
boxplot(TotAccomChg~Sex, main=toupper("Total Accomodation Charges by Gender"), font.main=3, cex.main=1.2, xlab="Gender: 1 = Male || 2 = Female", ylab="Total Accomodation Charges", font.lab=3, col="lightgreen")
#boxplot for total departmental charges
boxplot(TotDeptChg~Sex, main=toupper("Total Departmental Charges by Gender"), font.main=3, cex.main=1.2, xlab="Gender: 1 = Male || 2 = Female", ylab="Total Departmental Charges", font.lab=3, col="lightpink")

#problem 5: histogram of accomodation charges, gender, and age category
#histogram of accomodation charges
hist(TotAccomChg, main=toupper("Total Accomodation Charges"), xlab = "in Dollars", col='lightgreen')
#histogram of gender
hist(Sex, main=toupper("Gender"), xlab = "Gender: 1 = Male || 2 = Female", col='purple')
#histogram of age category
hist(Age, main=toupper("Ages"), xlab = "1: <25 | 2: 25-44 | 3: 45-64 | 4: 65-69 | 5: 70-74 | 6: 75-79 | 7: 80-84 | 8: 85-89 | 9: >90", col='mediumorchid')

#problem 6: bar chart of admissions source by gender
admsrcbysex <- table(Sex, admsrc)
#create barplot
barplot(admsrcbysex, main = "Admissions Source by Gender", xlab = "Admissions Source Code", col=c("royalblue","deeppink2"),
        legend = c("Male","Female"), beside=TRUE)

#problem 7: bar chart of mortality rates given DRG = 292 and 293
#new data subset of DRG 292 codes 
new292 <- subset(chf, drgcode==292)
#find observation where discharge destination = expired
new292$dischdest[new292$dischdest==20]
#create variable of expired/all discharge destinations
mortrate292 <-round(length(new292$dischdest[new292$dischdest==20])/length(new292$dischdest),3)

#new data subset of DRG 292 codes 
new293 <- subset(chf, drgcode==293)
#find observation where discharge destination = expired
new293$dischdest[new293$dischdest==20]
#create variable of expired/all discharge destinations
mortrate293 <-round(length(new293$dischdest[new293$dischdest==20])/length(new293$dischdest),3)
#create table for our barchart
#bind DRG type and mortality rate
mortnames <- c("Mortality DRG 292", "Mortality DRG 293")
mortrate <- c(mortrate292, mortrate293)
morttable <- table(mortnames,mortrate)
#create bar chart of mortality rates of DRG = 292 and DRG = 293
barplot(mortrate, main = "Mortality Rate among DRG codes 292 and 293", xlab = "DRG Code", col=c("darkorchid4","darkolivegreen1"),
        legend = c("292", "293"), beside=TRUE)

#problem 8
#Is the average LOS for DRG 291 significantly different than 6? 
#Run a 1-sample ttest
#find LOS for drg 291
LOS291 <- LOS[drgcode == 291]
#perform ttest on mu =6
t.test(LOS291, mu=6)



