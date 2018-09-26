library(stringr)
library(lubridate)

# read in the household_power_consumption dataset
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# subset the data to observations coming from 2007-02-01 and 2007-02-02 
df <- subset(df, Date == "1/2/2007" | Date == "2/2/2007")

# replace ? with proper NA 
df[] <- lapply(df, gsub, pattern = "\\?", replacement = NA)

# convert feature to numeric class
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

# convert Date and Time features to the proper format
df$datetime <- str_c(df$Date, df$Time, sep = " ")
df$datetime <- as_datetime(df$datetime, format = "%e/%m/%Y %H:%M:%S")

# preparing plotting device 
png("plot3.png")

# plotting plot3 
with(df, plot(datetime, Sub_metering_1, type = "n", 
              xlab = "", 
              ylab = "Energy sub metering"))
with(df, lines(datetime, Sub_metering_1, col = "black"))
with(df, lines(datetime, Sub_metering_2, col = "red"))
with(df, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)

# closing device 
dev.off()


