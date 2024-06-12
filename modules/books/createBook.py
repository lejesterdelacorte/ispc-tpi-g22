from ..utils.dBConnection import DatabaseConnection

def createBook():
    titulo = input("Ingrese el título del libro: ")
    autor = input("Ingrese el autor del libro: ")
    editorial = input("Ingrese la editorial del libro: ")
    fecha_publicacion =	input("Ingrese la fecha en la que fue publicado el libro: ")
    genero = input("Ingrese el género al que pertenece el libro: ")
    usuario_id_usuario = input("Ingrese el id de usuario al que pertenece el libro: ")	
    db_instance = DatabaseConnection()
    connection = db_instance.get_connection()
    cursor = connection.cursor()
    sql = "INSERT INTO libro (titulo, autor, editorial, fecha_publicacion, genero) VALUES (%s, %s, %s, %s, %s, %s);"
    values = (titulo, autor, editorial, fecha_publicacion, genero, usuario_id_usuario)
    cursor.execute(sql, values)
    connection.commit()
