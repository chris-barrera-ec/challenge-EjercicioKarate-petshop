Feature: Comprobaciones usuarios pagina petstore eliminacion
  Background:
    * url 'https://petstore.swagger.io/v2/user/'

  @createUserAndDelete
  Scenario Outline: Crear usuario y luego borrarlo
    #invocar a la creación de usuario del feature reusar, pasándole los valores desde el archivo csv
    * call read("reusar.feature@createUser") ({otroUsername}, {firstname}, {lastname}, {email})
    #asignar a otra variable el username del usuario creado
    * def usuarioABorrar = user_name_created
    #eliminación del usuario creado
    Given path usuarioABorrar
    When method DELETE
    Then status 200
    #Verificar que al buscar al usuario, éste no se pueda encontrar ya que fue borrado
    Given path usuarioABorrar
    When method GET
    Then status 404

    Examples:
    |read('datosPruebaEliminacion.csv')|