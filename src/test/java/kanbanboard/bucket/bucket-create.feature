Feature: Bucket create endpoints

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def generate = Java.type('kanbanboard.TestDataGenerator')

  Scenario: Must create only once = Bucket with same valid field

    * def payload =
    """
    {
      "id": '#(generate.uuid())',
      "position": '#(generate.randomNumber())',
      "name": '#(generate.randomName())'
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
      | id                 | position                   | name
      | null               | #(generate.randomNumber()) | #(generate.randomName())
      | ''                 | #(generate.randomNumber()) | #(generate.randomName())
      | #(generate.uuid()) | 0                          | #(generate.randomName())
      | #(generate.uuid()) | -1                         | #(generate.randomName())
      | #(generate.uuid()) | #(generate.randomNumber()) | null
      | #(generate.uuid()) | #(generate.randomNumber()) | ''
      | #(generate.uuid()) | #(generate.randomNumber()) | '      '
