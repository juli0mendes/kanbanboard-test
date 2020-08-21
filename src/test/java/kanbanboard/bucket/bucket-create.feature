Feature: Bucket create endpoints

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def generate = Java.type('kanbanboard.TestDataGenerator')

  Scenario: Must create only once = Bucket with same valid field

    * def payload =
    """
    {
      "id": '#(generate.uuid())',
      "position": '#(generate.faker().number().numberBetween(1, 10000))',
      "name": '#(generate.faker().pokemon().name())'
    }
    """

    Given request payload
    When method post
    Then status 201

    Given request payload
    When method post
    Then status 400

  Scenario Outline: Can't create Bucket with invalid fields
    Given request
    """
    {
      "id": <id>,
      "position": <position>,
      "name": <name>
    }
    """
    When method post
    Then status 400
    Examples:
      | id                 | position                                             | name
      | null               | #(generate.faker().number().numberBetween(1, 10000)) | #(generate.faker().lorem().word()
      | ''                 | #(generate.faker().number().numberBetween(1, 10000)) | #(generate.faker().lorem().word()
      | #(generate.uuid()) | 0                                                    | #(generate.faker().lorem().word()
      | #(generate.uuid()) | -1                                                   | #(generate.faker().lorem().word()
      | #(generate.uuid()) | #(generate.faker().number().numberBetween(1, 10000)) | null
      | #(generate.uuid()) | #(generate.faker().number().numberBetween(1, 10000)) | ''
      | #(generate.uuid()) | #(generate.faker().number().numberBetween(1, 10000)) | '      '
