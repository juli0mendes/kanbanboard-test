Feature: Bucket create endpoints

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def generate = Java.type('kanbanboard.TestDataGenerator')

  Scenario: Must create a Bucket with valid field

    * def uuid =  generate.uuid()

    Given request
    """
    {
      "id": '#(uuid)',
      "position": '#(generate.faker().number().numberBetween(1, 10000))',
      "name": '#(generate.faker().pokemon().name())'
    }
    """
    When method post
    Then status 201

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
