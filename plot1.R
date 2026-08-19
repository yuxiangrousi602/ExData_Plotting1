# Read the household power consumption dataset
power_data <- read.table(
  "household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# Keep only February 1 and February 2, 2007
power_data <- subset(
  power_data,
  Date %in% c("1/2/2007", "2/2/2007")
)

# Convert the required variable to numeric
power_data$Global_active_power <- as.numeric(
  power_data$Global_active_power
)

# Open a 480 x 480 PNG device
png(
  filename = "plot1.png",
  width = 480,
  height = 480
)

# Construct the histogram
hist(
  power_data$Global_active_power,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)

# Close the PNG device
dev.off()