<!DOCTYPE html>
<html lang="es-MX">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <link rel="stylesheet" href="../css/styleCuestionario.css">
    <title>Indice de Biodiversidad Urbana</title>
</head>

<body>
    <div class="main-container">
        <h1>Sistema de Gestion de Biodiversidad</h1>
          <a href="../index.html" class="back-btn">Regresar al menu</a>
        <!-- Sección de Especies -->
        <section class="form-section">
            <h2>Gestion de Especies</h2>
            
            <div class="catalogo">
                <h3>Quieres ver Plantas Artropodos o Aves?</h3>
                <form class="input-datos" action="Selectanimal.jsp" method="post">
                     Tipo de especie: 
                        <select name="tipoanimal" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="planta">Plantas</option>
                            <option value="artropodo">Artropodos</option>
                            <option value="ave">Ave</option>
                        </select><br>
                    Tipo de Ecosistema: 
                        <select name="tipoeco" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="Bosque y zona boscosa">Bosque y zona boscosa</option>
                            <option value="Pastizales nativos">Pastizales nativos</option>
                            <option value="Matorralez">Matorrales</option>
                            <option value="Humedales">Humedales</option>
                            <option value="Artificial - Terrestre">Artificial - Terrestre</option>
                            <option value="Artificial - Acuatico">Artificial - Acuatico</option>
                        </select><br>
                        <input type="submit" value="Buscar">
                </form>
            </div>
        </section>
    </div>
</body>
</html>