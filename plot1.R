CreatePlot<-function() {
    dataFile = "household_power_consumption.txt"
    dataDownloadLink = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    dataZipFile = "data.zip"
    
    if(!file.exists(dataFile)) {
        download.file(dataDownloadLink, destfile = dataZipFile, method = "curl")
        unzip(dataZipFile)
    }
    data <- fread(paste("grep '^[12]/2/2007'", dataFile), sep = ";")
    columnNames <- names(fread(dataFile, header = TRUE, sep = ";", nrows = 0))
    setnames(data, columnNames)
    
    png(file="plot1.png", width=480, height=480)
    
    hist(data$Global_active_power, main="Global Active Power",
         xlab="Global Active Power (kilowatts)", col="red")
    dev.off()
}