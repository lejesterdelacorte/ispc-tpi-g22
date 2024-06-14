from ..utils.dBConnection import DatabaseConnection

def listUsers():
    db_instance = DatabaseConnection()
    connection = db_instance.get_connection()
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM usuario')
    users = cursor.fetchall()
    if not users:
        print("No hay usuarios.")
        return
    for user in users:
        print(f"ID: {user[0]}, Nombre: {user[1]}")
    return users

def listBooks(ID_usuario):
    db_instance = DatabaseConnection()
    connection = db_instance.get_connection()
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM libro WHERE ID_usuario = %s', (ID_usuario,))
    books = cursor.fetchall()
    if not books:
        print("No hay libros asociados a este usuario.")
        return
    for book in books:
        print(f"ID: {book[0]}, Título: {book[1]}")
    return books

def listMeetingPoints():
    db_instance = DatabaseConnection()
    connection = db_instance.get_connection()
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM punto_encuentro')
    meeting_points = cursor.fetchall()
    for point in meeting_points:
        print(f"ID: {point[0]}, Nombre: {point[1]}")
    return meeting_points

def createTrade():
    print("----------CREAR UN NUEVO INTERCAMBIO----------") 
    print("Usuarios disponibles:")
    users = listUsers()
    if not users:
        return
    while True:
        ID_usuario1 = input("Ingrese el ID del primer usuario: ")
        print("Libros disponibles para el usuario 1:")
        books1 = listBooks(ID_usuario1)
        if books1:
            break
        print("Por favor, seleccione otro usuario.")
    ID_libro1 = input("Ingrese el ID del libro del primer usuario: ")

    while True:
        ID_usuario2 = input("Ingrese el ID del segundo usuario: ")
        print("Libros disponibles para el usuario 2:")
        books2 = listBooks(ID_usuario2)
        if books2:
            break
        print("Por favor, seleccione otro usuario.")
    ID_libro2 = input("Ingrese el ID del libro del segundo usuario: ")

    print("Puntos de encuentro disponibles:")
    listMeetingPoints()
    ID_punto_encuentro = input("Ingrese el ID del punto de encuentro: ")

    fecha_intercambio = input("Ingrese la fecha del intercambio (formato YYYY-MM-DD): ")

    db_instance = DatabaseConnection()
    connection = db_instance.get_connection()
    cursor = connection.cursor()
    sql = "INSERT INTO intercambio (fecha_intercambio, ID_usuario1, ID_libro1, ID_usuario2, ID_libro2, ID_punto_encuentro) VALUES (%s, %s, %s, %s, %s, %s);"
    values = (fecha_intercambio, ID_usuario1, ID_libro1, ID_usuario2, ID_libro2, ID_punto_encuentro)
    cursor.execute(sql, values)
    connection.commit()
    print("--------EL INTERCAMBIO SE CREÓ CON ÉXITO-------")