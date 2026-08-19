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

# Create the combined date-time variable
power_data$DateTime <- strptime(
  paste(power_data$Date, power_data$Time),
  format = "%d/%m/%Y %H:%M:%S"
)

# Convert the measurement to numeric
power_data$Global_active_power <- as.numeric(
  power_data$Global_active_power
)

# Use English weekday labels where supported
try(Sys.setlocale("LC_TIME", "C"), silent = TRUE)

# Create the PNG file
png(
  filename = "plot2.png",
  width = 480,
  height = 480
)

# Construct the line plot
plot(
  power_data$DateTime,
  power_data$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)"
)

dev.off()