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

    public static String randomName() {
        return faker().pokemon().name();
    }

    public static int randomNumber() {
        return faker().number().numberBetween(1, 1000);
    }

    public static Faker faker() {
        return TestDataGenerator.faker(TestDataGenerator.defaultLocale);
    }

    public static Faker faker(String locale) {
        return new Faker(new Locale(locale));
    }
}