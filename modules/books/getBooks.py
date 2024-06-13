from ..utils.dBConnection import DatabaseConnection

def getBooks():
    db_instance = DatabaseConnection()
    connection = db_instance.get_connection()
    cursor = connection.cursor() 
    cursor.execute("SELECT * FROM libro;")
    result = cursor.fetchall()
    print(result) 