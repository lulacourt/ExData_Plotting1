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


# Plot 2.
# Generating plot with no x-axis label (xlab=""), no x-value labels (xaxt="n") and white color in order to not showing dots.
plot(as.numeric(sub1[,10]),sub1[,3],xaxt="n",xlab="",ylab="Global Active Power (kilowatts)",col="white")
# Assigning x-value labels according to weekdays.
axis(1, at=quantile(as.numeric(sub1[,10]),probs =c(0,0.5,1)), labels=c("Thu","Fri","Sat"))
# Adding lines.
lines(as.numeric(sub1[,10]),sub1[,3])

# Saving file and closing file device.
dev.copy(png,file="plot2.png")
dev.off()
