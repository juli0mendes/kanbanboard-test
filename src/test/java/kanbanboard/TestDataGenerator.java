package kanbanboard;

import com.github.javafaker.Faker;

import java.util.Locale;
import java.util.Random;

import static java.lang.System.currentTimeMillis;
import static java.util.UUID.randomUUID;

public class TestDataGenerator {
    private  static  final String defaultLocale = "en-US";

    public static String uuid() {
        return randomUUID().toString();
    }

    public static Faker faker() {
        return TestDataGenerator.faker(TestDataGenerator.defaultLocale);
    }

    public static Faker faker(String locale) {
        return new Faker(new Locale(locale));
    }
}