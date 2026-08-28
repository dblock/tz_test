import org.ocpsoft.prettytime.PrettyTime;
import java.time.*;
import java.util.*;

public class TzTest {
    public static void main(String[] args) {
        // Norfolk Island permanent offset change
        ZoneId norfolk = ZoneId.of("Pacific/Norfolk");
        ZonedDateTime start = ZonedDateTime.of(2015, 1, 15, 0, 0, 0, 0, norfolk);
        ZonedDateTime finish = ZonedDateTime.of(2016, 3, 15, 0, 0, 0, 0, norfolk);

        System.out.println("start offset: " + start.getOffset());
        System.out.println("finish offset: " + finish.getOffset());

        Duration diff = Duration.between(start, finish);
        System.out.println("Norfolk raw diff (seconds): " + diff.getSeconds());
        System.out.println("Norfolk raw diff (days): " + diff.toDays());

        Period period = Period.between(start.toLocalDate(), finish.toLocalDate());
        System.out.println("Norfolk Period (calendar y/m/d): " + period.getYears() + "y " + period.getMonths() + "m " + period.getDays() + "d");

        PrettyTime p = new PrettyTime(Date.from(start.toInstant()));
        System.out.println("Norfolk PrettyTime.format: " + p.format(Date.from(finish.toInstant())));

        // Dublin DST transition
        ZoneId dublin = ZoneId.of("Europe/Dublin");
        ZonedDateTime dstart = ZonedDateTime.of(2024, 10, 27, 1, 59, 30, 0, dublin);
        ZonedDateTime dfinish = dstart.plusMinutes(1);
        System.out.println("\nDublin start offset: " + dstart.getOffset());
        System.out.println("Dublin finish offset: " + dfinish.getOffset());
        System.out.println("Dublin raw diff (seconds): " + Duration.between(dstart, dfinish).getSeconds());

        PrettyTime dp = new PrettyTime(Date.from(dstart.toInstant()));
        System.out.println("Dublin PrettyTime.format: " + dp.format(Date.from(dfinish.toInstant())));
    
        // reversed order (finish before start) and zero distance
        System.out.println();
        System.out.println("Reversed PrettyTime (ref=finish, format start): " +
            new PrettyTime(Date.from(finish.toInstant())).format(Date.from(start.toInstant())));
        System.out.println("Zero distance PrettyTime: " +
            new PrettyTime(Date.from(start.toInstant())).format(Date.from(start.toInstant())));
    }
}
