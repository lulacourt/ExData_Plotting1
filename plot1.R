# Estimation of the memory used to store the object in R.
object.size(read.table("./household_power_consumption.txt"))
# 258083544 bytes


# Reading data (the file is in our working directory).
data<-read.table("./household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors=FALSE)
# Converting date variables.
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
data$Datetime<-strptime(paste(data$Date,data$Time),format="%Y-%m-%d %H:%M:%S")
# Selecting the period.
sub1<-data[which(data$Datetime>="2007-02-01 00:00:00" & data$Datetime<"2007-02-03 00:00:00"),]
# Variables conversion.
for (i in 3:8){sub1[,i]<-as.numeric(sub1[,i])}
# Looking for missing values ("?") -> There's no missing values 
for (i in 3:9){sum_i<-sum(sub1[,i]=="?")
                print(paste("missing values(sub1[ ,",i,"])=",sum_i))}


# Plot 1.
hist(sub1[,3],main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")

# Saving file and closing file device.
dev.copy(png,file="plot1.png")
dev.off()