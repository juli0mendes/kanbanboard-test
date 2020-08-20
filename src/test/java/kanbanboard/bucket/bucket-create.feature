Feature: Bucket create endpoints

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def generate = Java.type('kanbanboard.TestDataGenerator')

  Scenario: Create a Bucket with valid data
    Given request
    """
    {
      "id": '#(generate.uuid())',
      "position": '#(generate.randomNumber())',
      "name": '#(generate.randomWord)'
    }
    """
    When method post
    Then status 201

  Scenario Outline: Can't create Bucket with invalid data
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
      | null               | #(generate.randomNumber()) | #(generate.randomWord())
      | #(generate.uuid()) | 0                          | #(generate.randomWord())
      | #(generate.uuid()) | -1                         | #(generate.randomWord())
      | #(generate.uuid()) | #(generate.randomNumber()) | ''
      | #(generate.uuid()) | #(generate.randomNumber()) | '      '
