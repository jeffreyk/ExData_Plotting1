CreatePlot<-function() {
    dataFile = "household_power_consumption.txt"
    dataDownloadLink = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    dataZipFile = "data.zip"
    
    ## download the zip file if the dataFile doesn't exist
    if(!file.exists(dataFile)) {
        download.file(dataDownloadLink, destfile = dataZipFile, method = "curl")
        unzip(dataZipFile)
    }
    
    ## read in data from Feb 1 and 2 2007
    data <- fread(paste("grep '^[12]/2/2007'", dataFile), sep = ";")
    columnNames <- names(fread(dataFile, header = TRUE, sep = ";", nrows = 0))
    setnames(data, columnNames)
    
    
    ## add DateTime Column
    data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format = '%d/%m/%Y %H:%M:%S')
    
    ## save plot as png with specified width and height and make the
    ## background transparent like the example file in the repository
    png(file="plot2.png", width=480, height=480, bg="transparent")
    
    ## plot data
    plot(data$DateTime, data$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)",
         xlab = "")
    dev.off()
}