Feature: Comprobaciones usuarios pagina petstore actualizacion
  Background:
    * url 'https://petstore.swagger.io/v2/user/'

  @createUpdateAndFindUser
  Scenario Outline: Crear usuario, actualizarlo y luego buscarlo
    #invocar a la creación de usuario del feature reusar, pasándole los valores desde el archivo csv
    * call read("reusar.feature@createUser") ({otroUsername}, {firstname}, {lastname}, {email})
    #cargar la estructura json de un usuario de petshop para validarla en el then
    * def estructura = read('jsons/userStructure.json')
    #buscar al usuario que se acaba de crear para modificarle sus campos firstName e email
    Given path user_name_created
    When method GET
    Then status 200
    * def usuario_creado = response
    * print "usuario creado: " + usuario_creado
    * def usuario2 = read('jsons/userToUpdate.json')
    * set usuario_creado.firstName = usuario2.firstName
    * set usuario_creado.email = usuario2.email
    #actualizar usuario luego de haberle asignado firstName e email cargado en usuario2 desde un json
    Given path usuario_creado.username
    And request usuario_creado
    When method PUT
    Then status 200
    * def usuarioModificado = usuario_creado.username
    * def estructura = read('jsons/userStructure.json')
    #buscar al usuario modificado y comprobar que los campos efectivamente fueron modificados
    Given path usuarioModificado
    When method GET
    Then status 200
    And match response == estructura
    And assert response.firstName == usuario2.firstName
    And assert response.email == usuario2.email
    #eliminar usuario para que no esté presente en la próxima ejecución (limpiando)
    Given path usuarioModificado
    When method DELETE
    Then status 200

    Examples:
    |read('datosPruebaActualizacion.csv')|
