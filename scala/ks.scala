import java.util.Calendar

object Kilosecond {
    private implicit def enrichCalendar(c: Calendar) = new CalendarWrapper(c)

    def main(args: Array[String]) = {
        val c = Calendar.getInstance

        println("Kiloseconds: " + c.kiloseconds)
    }

    private class CalendarWrapper(c: Calendar) {
        def kiloseconds = {
            val hours = c.get(Calendar.HOUR_OF_DAY)
            val minutes = c.get(Calendar.MINUTE)
            val seconds = c.get(Calendar.SECOND)

            (hours * 3600 + minutes * 60 + seconds) / 1000.0
        }
    }
}
