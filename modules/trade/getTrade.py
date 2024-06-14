from ..utils.dBConnection import DatabaseConnection

def getTrade():
    db_instance = DatabaseConnection()
    connection = db_instance.get_connection()
    cursor = connection.cursor()
    cursor.execute('''
        SELECT intercambio.ID_intercambio, intercambio.fecha_intercambio, 
               usuario1.nombre AS nombre_usuario1, libro1.titulo AS titulo_libro1, 
               usuario2.nombre AS nombre_usuario2, libro2.titulo AS titulo_libro2, 
               punto_encuentro.nombre AS nombre_punto_encuentro
        FROM intercambio
        INNER JOIN usuario AS usuario1 ON intercambio.ID_usuario1 = usuario1.ID_usuario
        INNER JOIN libro AS libro1 ON intercambio.ID_libro1 = libro1.ID_libro
        INNER JOIN usuario AS usuario2 ON intercambio.ID_usuario2 = usuario2.ID_usuario
        INNER JOIN libro AS libro2 ON intercambio.ID_libro2 = libro2.ID_libro
        INNER JOIN punto_encuentro ON intercambio.ID_punto_encuentro = punto_encuentro.ID_punto_encuentro
    ''')
    trades = cursor.fetchall()
    for trade in trades:
        print(f"ID: {trade[0]}, Fecha de intercambio: {trade[1]}, Nombre del primer usuario: {trade[2]}, Título del libro del primer usuario: {trade[3]}, Nombre del segundo usuario: {trade[4]}, Título del libro del segundo usuario: {trade[5]}, Nombre del punto de encuentro: {trade[6]}")