import java.util.GregorianCalendar;

public class Kiloseconds {

	public static void main(String[] args) {

		GregorianCalendar calendar = new GregorianCalendar();
		int hours, minutes, seconds, kiloseconds;

		hours = calendar.get(GregorianCalendar.HOUR_OF_DAY);
		minutes = calendar.get(GregorianCalendar.MINUTE);
		seconds = calendar.get(GregorianCalendar.SECOND);
		kiloseconds = (hours*3600 + minutes*60 + seconds) / 1000;
		System.out.println(kiloseconds + "\n");

	}

}

