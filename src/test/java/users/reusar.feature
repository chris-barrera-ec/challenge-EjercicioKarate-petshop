Feature: Escenarios para reutilizar
  Background:
    * url 'https://petstore.swagger.io'
    * path '/v2/user/'

  @createUser @Ignore
  Scenario: Crear un usuario
    #extrae el usuario a crear de un json base
    * def request_usuarios_crear = read('jsons/usersToCreate.json')
    #le cambia algunos atributos del usuario según parametros que le han pasado
    * set request_usuarios_crear[0].username = otroUsername
    * set request_usuarios_crear[0].firstName = firstname
    * set request_usuarios_crear[0].lastName = lastname
    * set request_usuarios_crear[0].email = email
    #se crea el usuario pasandole una lista con un elemento
    Given path 'createWithList'
    And request request_usuarios_crear
    When method POST
    Then status 200
    #ademas de comprobar el estado 200 en la respuesta, se asigna el valor de username del usuario creado a la variable user_name_created para que pueda ser utilizada en los escenarios que reutilicen este escenario
    And def user_name_created = request_usuarios_crear[0].username
