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

    Observation(String[] data) {
        this.date = LocalDate.parse(formatDate(data[0]));
        println("Parsed date: " + this.date); // Debugging line to check the parsed date
        // Para calcular o numero de dias desde a primeira data, faço data atual menos a primeira data e adiciono 1.
        this.startHour = data[1];
        this.minutes = Integer.parseInt(trim(data[2]));
        this.module = data[3];
        this.type = data[4];
        this.place = data[5];
        this.energy = data[6];
        this.focus = data[7];
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
        println("Total minutes for " + this.startHour + ": " + this.totalMinutes);
    }
}