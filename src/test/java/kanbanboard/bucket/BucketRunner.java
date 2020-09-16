package kanbanboard.bucket;

import com.intuit.karate.junit5.Karate;

class BucketRunner {

    @Karate.Test
    Karate testCreateBucket() {
        return Karate.run("bucket-create").relativeTo(getClass());
    }

    @Karate.Test
    Karate testListAllBuckets() {
        return Karate.run("bucket-list-all").relativeTo(getClass());
    }
}