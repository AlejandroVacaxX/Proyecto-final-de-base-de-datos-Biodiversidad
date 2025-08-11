<!DOCTYPE html>
<html lang="es-MX">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <link rel="stylesheet" href="css/styleCuestionario.css">
    <title>Indice de Biodiversidad Urbana</title>
</head>

<body>
    <div class="main-container">
        <h1>Sistema de Gestion de Biodiversidad</h1>
        
        <!-- Sección de Especies -->
        <section class="form-section">
            <h2>Gestion de Especies</h2>
             <a href="index.html" class="back-btn">Regresar al menu</a>
            <div class="catalogo">
                <h3>Cambio en el numero de especies</h3>
                <form class="input-datos" action="ModificacionesaBD/selectServicios.jsp" method="post">
                     Tipo de gasto: 
                        <select name="tipo" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="1">Biofin</option>
                            <option value="2">Actividad ambiental</option>
                        </select><br>
                        <input type="submit" value="Guardar">
                </form>
            </div>
             <div class="catalogo">
                <h3>Cambio en el estado de los planes de manejo de areas verdes y azules</h3>
                <form class="input-datos" action="ModificacionesaBD/selectplanesVyA.jsp" method="post">
                      Ver los datos: 
                        <select name="tipo" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="1">Consultar</option>
                        </select><br>
                        <input type="submit" value="Guardar">
                </form>
            </div>
            <div class="catalogo">
                <h3>Cambio en el numero de proyectos inplementados por la CDMX</h3>
                <form class="input-datos" action="ModificacionesaBD/proyecto.jsp" method="post">
                      Ver los datos: 
                        <select name="tipo" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="1">Consultar</option>
                        </select><br>
                        <input type="submit" value="Guardar">
                </form>
            </div>
        </section>
    </div>
</body>
</html>