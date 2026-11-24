import java.time.*;
import java.time.temporal.ChronoUnit;

String[] linesData;
String[][] data;
LocalDate startDate;

String formatDate(String s) {
  int[] p = int(split(s, '/'));
  return "2026-" + nf(p[1], 2) + "-" + nf(p[0], 2);
}

void setup() {
  linesData = loadStrings("data/observations.csv");
  linesData = subset(linesData, 1);

  data = new String[linesData.length][];

  for (int i = 0; i < linesData.length; i++) {
    data[i] = split(linesData[i], ",");
    data[i][0] = formatDate(data[i][0]);
  }

  // Get the first date in the data for calculating date differences.
  startDate = LocalDate.parse(data[0][0]);

  for (int i = 0; i < data.length; i++) {
    LocalDate rowDate = LocalDate.parse(data[i][0]);
    int days = (int)ChronoUnit.DAYS.between(startDate, rowDate)+1;
    data[i] = append(data[i], str(days));
    String hour = data[i][1];
    int[] timeParts = int(trim(split(hour, ":")));
    String totalMinutes = str(timeParts[0] * 60 + timeParts[1]);
    data[i] = append(data[i], totalMinutes);
    println(totalMinutes);
    println(data[i]);
  }
}
