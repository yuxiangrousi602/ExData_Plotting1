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

# Create the date-time variable
power_data$DateTime <- strptime(
  paste(power_data$Date, power_data$Time),
  format = "%d/%m/%Y %H:%M:%S"
)

# Convert required columns to numeric
numeric_columns <- c(
  "Global_active_power",
  "Global_reactive_power",
  "Voltage",
  "Sub_metering_1",
  "Sub_metering_2",
  "Sub_metering_3"
)

power_data[numeric_columns] <- lapply(
  power_data[numeric_columns],
  as.numeric
)

try(Sys.setlocale("LC_TIME", "C"), silent = TRUE)

# Create the PNG file
png(
  filename = "plot4.png",
  width = 480,
  height = 480
)

# Arrange four plots in a 2 x 2 layout
par(mfrow = c(2, 2))

# Top-left plot
plot(
  power_data$DateTime,
  power_data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power"
)

# Top-right plot
plot(
  power_data$DateTime,
  power_data$Voltage,
  type = "l",
  xlab = "datetime",
  ylab = "Voltage"
)

# Bottom-left plot
plot(
  power_data$DateTime,
  power_data$Sub_metering_1,
  type = "l",
  col = "black",
  xlab = "",
  ylab = "Energy sub metering"
)

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

legend(
  "topright",
  legend = c(
    "Sub_metering_1",
    "Sub_metering_2",
    "Sub_metering_3"
  ),
  col = c("black", "red", "blue"),
  lty = 1,
  bty = "n",
  cex = 0.7
)

# Bottom-right plot
plot(
  power_data$DateTime,
  power_data$Global_reactive_power,
  type = "l",
  xlab = "datetime",
  ylab = "Global_reactive_power"
)

dev.off()