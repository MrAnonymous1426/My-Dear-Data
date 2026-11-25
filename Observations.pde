class Observation{
    // date,start,minutes,module,type,place,energy,focus,sleep,caffeine,moved,distractions,main_distraction,reward
    LocalDate date;
    String startHour;
    int minutes;
    String module;
    String type;
    String place;
    String energy;
    String focus;
    String sleep;
    String caffeine;
    String moved;
    String distractions;
    String main_distraction;
    String reward;
    int daysSinceStart;
    int totalMinutes;
    int focusvalue;
    //Visualization
    float x, y;   // position on the canvas
    float w;      // size (diameter)
    color c;      // colour

    Observation(String[] data) {
        this.date = LocalDate.parse(formatDate(data[0]));
        // Para calcular o numero de dias desde a primeira data, faço data atual menos a primeira data e adiciono 1.
        this.startHour = data[1];
        this.minutes = Integer.parseInt(trim(data[2]));
        this.module = data[3];
        this.type = data[4];
        this.place = data[5];
        this.energy = data[6];
        this.focus = trim(data[7]);
        if (this.focus.charAt(0) != 'f'){
            println("Focus value: " + this.focus); // Debugging line to check the focus value
        }
        this.focusvalue = parseInt(this.focus.substring(1));
        this.sleep = data[8];
        this.caffeine = data[9];
        this.moved = data[10];
        this.distractions = data[11];
        this.main_distraction = data[12];
        this.reward = data[13];
    }

    String formatDate(String s) {
        int[] p = int(split(s, '/'));
        return "2026-" + nf(p[1], 2) + "-" + nf(p[0], 2); 
    }

    void calculateDaysSinceStart(LocalDate startDate) {
        this.daysSinceStart = (int)ChronoUnit.DAYS.between(startDate, this.date)+1;
    }

    void calculateTotalMinutes() {
        int[] timeParts = int(trim(split(this.startHour, ":")));
        this.totalMinutes = timeParts[0] * 60 + timeParts[1];
    }

    void setVisuals(int lastDay, int maxMinutes) {
        x = map(daysSinceStart, 1, lastDay, 50, width - 50);   // left → right = day 1 → last day
        y = map(totalMinutes, 0, 1440, 50, height - 50);       // top → bottom = 00:00 → 23:59
        w = map(minutes, 0, maxMinutes, 6, 40);                // longer session = bigger circle
        // red (low focus) → green (high focus)
        // Map focus value (1-5) to a color gradient
        c = lerpColor(color(220, 60, 60), color(60, 160, 90), map(this.focusvalue, 1, 5, 0, 1));         
    }

    void display() {
        noStroke();
        fill(c);
        ellipse(x, y, w, w);
    }
}