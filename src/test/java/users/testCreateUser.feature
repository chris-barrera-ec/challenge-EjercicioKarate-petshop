Feature: Comprobaciones usuarios pagina petstore creacion
  Background:
    * url 'https://petstore.swagger.io/v2/user/'

  @createAndFindUserCreated
  Scenario Outline: Crear y Buscar al usuario creado
    #invocar a la creación de usuario del feature reusar, pasándole los valores desde el archivo csv
    * call read("reusar.feature@createUser") ({otroUsername}, {firstname}, {lastname}, {email})
    #cargar la estructura json de un usuario de petshop para validarla en el then
    * def estructura = read('jsons/userStructure.json')
    #buscar usuario creado
    Given path user_name_created
    When method GET
    Then status 200
    And match response == estructura
    And assert response.username == user_name_created
    #eliminar usuario para que no esté presente en la próxima ejecución (limpiando)
    Given path user_name_created
    When method DELETE
    Then status 200
    Examples:
      |read('datosPruebaCreacion.csv')|