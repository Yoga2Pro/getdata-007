######################################################################################################
#set work directory if needed


######################################################################################################
#install and load library "plyr" 
if(!is.element("plyr", installed.packages()[,1])){
    install.packages("plyr")
    }
    library(plyr)

    #create a sub-directory for data output
    output_folder <- "output"
    wd <- getwd()
    if (!file.exists(output_folder)){
        dir.create(file.path(wd, output_folder), showWarnings = FALSE)
	}

	#define file source for data input
	file <- "UCI HAR Dataset.zip"
	url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	data_path <- "UCI HAR Dataset"

	#download data zip file to work directory
	if(!file.exists(file)){    
	    download.file(url,file, mode = "wb")
	    }

	    ######################################################################################################
	    #reads single text file with specific column (default is reading all columns)
	    getTable <- function (filename,cols = NULL){
	        f <- unz(file, paste(data_path,filename,sep="/"))
		    data <- data.frame()
		        if(is.null(cols)){
			        data <- read.table(f,sep="",stringsAsFactors=F)
				    } else {
				            data <- read.table(f,sep="",stringsAsFactors=F, col.names= cols)
					        }
						    data    
						    }

						    #use above function to read target files and consolidate into a complete table
						    getData <- function(type, features){
						        subject_data <- getTable(paste(type,"/","subject_",type,".txt",sep=""),"id")
							    y_data <- getTable(paste(type,"/","y_",type,".txt",sep=""),"activity")    
							        x_data <- getTable(paste(type,"/","X_",type,".txt",sep=""),features$V2) 
								    return (cbind(subject_data,y_data,x_data)) 
								    }

								    #save the data into the output folder defined earlier
								    saveResult <- function (data,name){
								        file <- paste(output_folder, "/", name,".csv" ,sep="")
									    write.csv(data,file)
									    }

									    ######################################################################################################
									    #read features file containing all column names, which is used when creating train and test tables
									    features <- getTable("features.txt")

									    #read train and test tables
									    train <- getData("train",features)
									    test <- getData("test",features)

									    ######################################################################################################
									    ######################################################################################################
									    #1. Merges the training and the test sets to create one data set.
									    data <- arrange(rbind(train, test),id)

									    #2. Extracts only the measurements on the mean and standard deviation for each measurement. 
									    data <- data[,c(1,2,grep("std", colnames(data)), grep("mean", colnames(data)))]

									    #3. Uses descriptive activity names to name the activities in the data set.
									    #done in privious step, which used feature file to name columns read into the data set

									    #4. Appropriately labels the data set with descriptive activity names.
									    activity_labels <- getTable("activity_labels.txt")
									    data$activity <- factor(data$activity, levels=activity_labels$V1, labels=activity_labels$V2)

									    #5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
									    tidydata <- ddply(dataset1, .(id, activity), .fun=function(x){ colMeans(x[,-c(1:2)]) })
									    colnames(tidydata)[-c(1:2)] <- paste(colnames(tidydata)[-c(1:2)], "_mean", sep="")
									    saveResult(tidydata,"tidydata")
