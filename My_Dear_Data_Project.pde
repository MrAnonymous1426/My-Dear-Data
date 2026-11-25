import java.time.*;
import java.time.temporal.ChronoUnit;

String[] linesData;
LocalDate startDate;
String[] parsedRow;

Observation observationRow;
Observation[] observations;

void setup() {

  size(1000, 500);

  linesData = loadStrings("data/observations.csv");
  // Remove the header row from the data.
  linesData = subset(linesData, 1);

  observations = new Observation[linesData.length];

  for (int i = 0; i < linesData.length; i++) {
    parsedRow = split(linesData[i], ",");
    observations[i] = new Observation(parsedRow);
  }

  // Get the first date in the data for calculating date differences.
  startDate = observations[0].date;

  for (int i = 0; i < observations.length; i++) {
    observations[i].calculateDaysSinceStart(startDate);
    observations[i].calculateTotalMinutes();
  }

  int lastDay = 0;
  int longestSession = 0;

  for (int i = 0; i < observations.length; i++) {
    lastDay = max(lastDay, observations[i].daysSinceStart);
    longestSession = max(longestSession, observations[i].minutes);
  }

  for (int i = 0; i < observations.length; i++) {
    observations[i].setVisuals(lastDay, longestSession);
    observations[i].display();
  }
}
