/* Dear Data: study sessions
   One row per day, one "thread" per study session.

   HOW TO READ IT
   x position      The start time, 08:00 on the left to 20:00 on the right
   length          Minutes studied (60 min = 130 px)
   colour          Module: math red, db navy, sa yellow, pj green
   thickness       Energy (1-5): thicker = more energy
   wobble          Focus (1-5): calmer line = better focus
   double line     The session was homework
   pale page       The session was in the library
   knots           One per distraction: filled = phone, hollow = something else
   brown dot       Had caffeine
   green triangle  Moved before or during the session
   yellow cross    Gave myself a reward
   moon (left)     Sleep the night before: bigger moon = more sleep
*/

Table data;
StringList days = new StringList();   // Each date once, in file order; its index is the row number
HashMap<String, Integer> moduleColour = new HashMap<String, Integer>();

void setup() {
  size(1200, 1100);
  data = loadTable("observations.csv", "header");

  moduleColour.put("math", #E4572E);
  moduleColour.put("db",   #29335C);
  moduleColour.put("sa",   #F3A712);
  moduleColour.put("pj",   #4C9F70);

  // Collect each date once so every day gets its own row.
  for (TableRow r : data.rows()) {
    String d = clean(r, "date");
    if (!days.hasValue(d)) days.append(d);
  }
  noLoop();   // the picture doesn't move, so draw() only needs to run once
}

void draw() {
  background(#FBF7F0);
  for (TableRow r : data.rows()) drawSession(r);
}

// Draws one study session (one row of the CSV).
void drawSession(TableRow r) {
  // Read everything this row needs up front.
  int   row  = days.index(clean(r, "date"));
  float y    = 100 + row * 80;                                // each day sits 80 px below the last
  float x    = map(startHour(r), 8, 20, 180, width - 40);     // 08:00 to 20:00 across the page
  float len  = map(r.getInt("minutes"), 0, 60, 0, 130);       // 60 minutes = 130 px
  color c    = moduleColour.getOrDefault(clean(r, "module"), #999999);  // grey if the module is unknown
  float amp  = map(level(r, "focus"), 1, 5, 14, 0);           // focus 1 = 14 px wobble, focus 5 = flat
  float w    = level(r, "energy") * 1.5;                      // energy 4 = 6 px thick
  float seed = row * 100 + x;                                 // fixed seed, so the wobble is the same every run

  // Day label and sleep moon.
  // Redrawn for every session that day, which is harmless as long as
  // every row for that day has the same sleep value.
  fill(80); 
  noStroke(); 
  textSize(12);
  text(clean(r, "date"), 20, y + 4);
  fill(#C9C3E6);
  circle(120, y, level(r, "sleep") * 4);

  // Library: a pale "page" behind the thread.
  if (clean(r, "place").equals("library")) {
    fill(#EDE6D6);
    rect(x - 6, y - 22, len + 12, 44, 6);
  }

  // The thread, plus a thin second one underneath for homework.
  drawThread(x, y, len, amp, w, c, seed);
  if (clean(r, "type").equals("hw")) drawThread(x, y + 7, len, amp, 1.2, c, seed + 50);

  drawKnots(r, x, y, len, c);
  drawMarks(r, x, y);
}

// One knot per distraction, spaced evenly along the thread.
// For example, 2 distractions sit at 1/3 and 2/3 of the length.
void drawKnots(TableRow r, float x, float y, float len, color c) {
  int     count = level(r, "distractions");
  boolean phone = clean(r, "main_distraction").equals("phone");

  stroke(c); strokeWeight(2);
  if (phone) fill(c); else fill(#FBF7F0);   // filled = phone, hollow = something else
  for (int i = 1; i <= count; i++) {
    circle(x + len * i / (count + 1), y, 10);
  }
}

// Small yes/no marks at the start of the thread.
void drawMarks(TableRow r, float x, float y) {
  noStroke();
  if (yes(r, "caffeine")) {                  // brown dot above
    fill(#6B4226);
    circle(x, y - 16, 6);
  }
  if (yes(r, "moved")) {                     // green triangle below
    fill(#4C9F70);
    triangle(x - 4, y + 20, x + 4, y + 20, x, y + 13);
  }
  if (yes(r, "reward")) {                    // yellow cross above
    stroke(#F3A712); strokeWeight(2);
    line(x - 5, y - 28, x + 5, y - 28);
    line(x, y - 33, x, y - 23);
  }
}

// A wavy line from x to x + len.
// noise() gives a smooth random value between 0 and 1. Subtracting 0.5 and
// multiplying by 2 * amp turns that into an offset between -amp and +amp.
// The 0.05 sets how quickly the wave changes: smaller = longer, lazier waves.
void drawThread(float x, float y, float len, float amp, float w, color c, float seed) {
  noFill(); stroke(c); strokeWeight(w);
  beginShape();
  for (float t = 0; t <= len; t += 2) {      // one point every 2 px
    vertex(x + t, y + (noise(seed + t * 0.05) - 0.5) * 2 * amp);
  }
  endShape();
}

// ---------- helpers for reading the CSV ----------

// Text from a column with spaces and tabs removed, in lower case.
// "  Library\t" becomes "library".
String clean(TableRow r, String col) {
  return r.getString(col).trim().toLowerCase();
}

// Only the digits of a column, as a number. "f4" becomes 4, "3" stays 3.
int level(TableRow r, String col) {
  return int(clean(r, col).replaceAll("[^0-9]", ""));
}

// True when a column ends in "+". "y+" and "+" mean yes; "-" means no.
boolean yes(TableRow r, String col) {
  return clean(r, col).endsWith("+");
}

// Start time as a decimal hour. "9:30" becomes 9.5.
float startHour(TableRow r) {
  String[] t = split(clean(r, "start"), ":");
  return int(t[0]) + int(t[1]) / 60.0;
}
