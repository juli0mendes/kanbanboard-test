Feature: Endpoint for Bucket creation
  In order to create a new Bucket
  As a Frontend application
  I need a REST endpoint to send Bucket data as JSON

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def generate = Java.type('kanbanboard.TestDataGenerator')

  Scenario: Must create only once = Bucket with same valid field

    * def uuid = generate.uuid()
    * def position = generate.randomNumber()
    * def expectedLocation = '/v1/buckets/' + uuid
    * def payload =
    """
    {
      id: '#(uuid)',
      position: '#(position)',
      name: '#(generate.randomName())'
    }
    """

    Given request payload
    When method post
    Then status 201
    And match responseHeaders['Location'][0] == expectedLocation

    Given request payload
    When method post
    Then status 400
    And match response == { message: 'Invalid duplicated data', id: '#(uuid)', position: '#(position)' }

  Scenario Outline: Invalid fields must return error code 400
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
    And match response == <expected>

    Examples:
      | id                 | position                   | name                     | expected
      | null               | 0                          | ''                       | { name: 'não deve estar em branco', id: 'não deve ser nulo', position: 'deve ser maior que 0' }
      | #(generate.uuid()) | -1                         | #(generate.randomName()) | { position: 'deve ser maior que 0' }
      | #(generate.uuid()) | #(generate.randomNumber()) | null                     | { name: 'não deve estar em branco' }x
      | #(generate.uuid()) | #(generate.randomNumber()) | '      '                 | { name: 'não deve estar em branco' }x
