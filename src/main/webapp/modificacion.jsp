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
                <h3>Ingresar nueva especie</h3>
                <form class="input-datos" action="ModificacionesaBD/ingresaPlanta.jsp" method="post">
                    <div class="input-row">
                    Tipo de especie: 
                        <select name="tipo" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="planta">Planta</option>
                            <option value="ave">Ave</option>
                             <option value="artropodo">Artropodo</option>
                        </select><br>
                        Nombre: <input type="text" name="nombre" required><br>
                        Nombre Cientifico: <input type="text" name="nombreC"><br>
                        Especie invasora: 
                        <select name="invasora" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="true">Verdadero</option>
                            <option value="false">False</option>
                        </select><br>
                        Peligro de extincion: 
                        <select name="extincion" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="true">Verdadero</option>
                            <option value="false">False</option>
                        </select><br>
                        <input type="submit" value="Consultar">
                    </div>
                </form>
            </div>
            
            <div class="catalogo">
                <h3>Eliminar especie</h3>
                <form class="input-datos" action="ModificacionesaBD/eliminaPlanta.jsp" method="post">
                    <div class="input-row">
                        <select name="tipo" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="planta">Planta</option>
                            <option value="ave">Ave</option>
                             <option value="artropodo">Artropodo</option>
                        </select><br>
                        Nombre: <input type="text" name="nombre" required><br>
                        <input type="submit" value="Eliminar">
                    </div>
                </form>
            </div>
            
            <div class="catalogo">
                <h3>Modificar especie</h3>
                <form class="input-datos" action="ModificacionesaBD/modificaPlanta.jsp" method="post">
                    <div class="input-row">
                        <h4>Datos nuevos</h4>
                        <select name="tipo" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="planta">Planta</option>
                            <option value="ave">Ave</option>
                             <option value="artropodo">Artropodo</option>
                        </select><br>
                        Nombre: <input type="text" name="nombre" required><br>
                        Nombre Cientifico: <input type="text" name="nombreC"><br>
                        Especie invasora: 
                        <select name="invasora" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="true">Verdadero</option>
                            <option value="false">False</option>
                        </select><br>
                        Peligro de extincion: 
                        <select name="extincion" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="true">Verdadero</option>
                            <option value="false">False</option>
                        </select><br>
                        <h4>Dato de referencia</h4>
                        Nombre a cambiar: <input type="text" name="nombreA" required><br>
                        <input type="submit" value="Modificar">
                    </div>
                </form>
            </div>
        </section>
        
        <!-- Sección de Áreas Protegidas -->
        <section class="form-section">
            <h2>Areas Naturales Protegidas</h2>
            
            <div class="catalogo">
                <h3>Ingresar nueva area protegida</h3>
                <form class="input-datos" action="ModificacionesaBD/nuevaAP.jsp" method="post">
                    <div class="input-row">
                        Nombre: <input type="text" name="nombre" required><br>
                        Area total protegida: <input type="number" name="areaP" placeholder="Ej: 13222"required><br>
                        Area total protegida efectiva: <input type="number" name="areaE" placeholder="Ej: 10222" required><br>
                        <input type="submit" value="Guardar">
                    </div>
                </form>
            </div>
        </section>
        
        <!-- Sección de Presupuesto -->
        <section class="form-section">
            <h2>Gestion de Presupuesto</h2>
            
            <div class="catalogo">
                <h3>Ingresar gasto en biodiversidad</h3>
                <form class="input-datos" action="ModificacionesaBD/ingresaGastoBio.jsp" method="post">
                    <div class="input-row">
                        Tipo de gasto: 
                        <select name="tipogasto" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="biofin">Biofin</option>
                            <option value="Actividad ambiental">Actividad ambiental</option>
                        </select><br>
                        
                        Subcategoria: <input type="text" name="subcategoria" placeholder="Ej:Redes de alcantarillado" required><br>
                        Dinero asignado: <input type="text" name="dinero" required><br>
                        <input type="submit" value="Guardar">
                    </div>
                </form>
            </div>
            
            <div class="catalogo">
                <h3>Modificar gasto en biodiversidad</h3>
                <form class="input-datos" action="ModificacionesaBD/modificarGastoB.jsp" method="post">
                    <div class="input-row">
                        Tipo de gasto: 
                        <select name="tipogasto" required>
                            <option value="">Seleccione una opcion</option>
                            <option value="biofin">Biofin</option>
                            <option value="Actividad ambiental">Actividad ambiental</option>
                        </select><br>
                        
                        Subcategoria: <input type="text" name="subcategoria" placeholder="Ej:Redes de alcantarillado" required><br>
                        Dinero asignado: <input type="text" name="dinero"placeholder="Ej:10999.12" required><br>
                        Subcategoria a cambiar: <input type="text" name="subcategoriaA" required><br>
                        <input type="submit" value="Guardar">
                    </div>
                </form>
            </div>
            
            <div class="catalogo">
                <h3>Presupuesto total CDMX</h3>
                <form class="input-datos" action="ModificacionesaBD/ingresaPresupuestoCDMX.jsp" method="post">
                    <div class="input-row">
                        Presupuesto total: <input type="text" name="presupuesto" placeholder="Ej:11202020202.12" required><br>
                        <input type="submit" value="Guardar">
                    </div>
                </form>
            </div>
        </section>
    </div>
</body>
</html>