package kanbanboard.bucket;

import com.intuit.karate.junit5.Karate;

class BucketRunner {

    @Karate.Test
    Karate testBuckets() {
        return Karate.run("bucket-create").relativeTo(getClass());
    }
}