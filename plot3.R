# Read the dataset
power_data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Keep the required dates
power_data <- subset(
  power_data,
  Date %in% c("1/2/2007", "2/2/2007")
)

# Create a date-time variable
power_data$DateTime <- strptime(
  paste(power_data$Date, power_data$Time),
  format = "%d/%m/%Y %H:%M:%S"
)

# Convert sub-metering columns to numeric
power_data$Sub_metering_1 <- as.numeric(
  power_data$Sub_metering_1
)

power_data$Sub_metering_2 <- as.numeric(
  power_data$Sub_metering_2
)

power_data$Sub_metering_3 <- as.numeric(
  power_data$Sub_metering_3
)

try(Sys.setlocale("LC_TIME", "C"), silent = TRUE)

# Create the PNG file
png(
  filename = "plot3.png",
  width = 480,
  height = 480
)

# Draw the first line
plot(
  power_data$DateTime,
  power_data$Sub_metering_1,
  type = "l",
  col = "black",
  xlab = "",
  ylab = "Energy sub metering"
)

# Add the other two lines
lines(
  power_data$DateTime,
  power_data$Sub_metering_2,
  col = "red"
)

lines(
  power_data$DateTime,
  power_data$Sub_metering_3,
  col = "blue"
)

# Add the legend
legend(
  "topright",
  legend = c(
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  ),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n"
)

dev.off()