Feature: Endpoint for list all Buckets
  In order to to show all Buckets
  As a Frontend application
  I need a REST endpoint get all Buckets in JSON fomat

  Background:
    * url 'http://localhost:8080/v1/buckets'
    * def generate = Java.type('kanbanboard.TestDataGenerator')

  Scenario: Get all Buckets

    * def uuid = generate.uuid()
    * def position = generate.randomNumber()
    * def name = generate.randomName()
    * def payload =
    """
    {
      id: '#(uuid)',
      position: '#(position)',
      name: '#(name)'
    }
    """

    Given request payload
    When method post
    Then status 201

    When method get
    Then status 200
    And match response contains
    """
    {
      id: '#(uuid)',
      position: '#(position)',
      name: '#(name)'
    }
    """