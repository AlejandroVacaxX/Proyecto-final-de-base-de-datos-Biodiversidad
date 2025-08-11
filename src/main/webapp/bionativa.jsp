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
         <a href="index.html" class="back-btn">Regresar al menu</a>
        <!-- Sección de Especies -->
        <section class="form-section">
            <h2>Gestion de Especies</h2>
            
            <div class="catalogo">
                <h3>Cambio en el numero de especies</h3>
                <form class="input-datos" action="ModificacionesaBD/selectCambiosBio.jsp" method="post">
                     Tipo de cambio: 
                        <select name="tipo" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="3">Plantas</option>
                            <option value="2">Artropodos</option>
                            <option value="1">Ave</option>
                        </select><br>
                        <input type="submit" value="Guardar">
                </form>
            </div>
        </section>
    </div>
</body>
</html>