
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
   

    <link rel="stylesheet"href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">

    <title>Indice Bio</title>
</head>

<body>
   
    <div class="main-container">
        <div class="catagolo">
            <h1>Ingrese una nueva especie de Planta, Ave o Artropodo</h1>
            <form  class="input-datos"  action="ModificacionesaBD/ingresaPlanta.jsp" method="post">
                <div class="input-row">
                Tipo: <input type="text" name="tipo"><br>
                Nombre: <input type="text" name="nombre"><br>
                Nombre Cientifico: <input type="text" name="nombreC"><br>
                Es una especie invasora: <input type="text" name="invasora"><br>
                Esta en peligro de extincion: <input type="text" name="extincion"><br>
                <input type="submit" value="Guardar">
                </div>
            </form>
        </div>
        <div class="catagolo">
            <h1>Elimine una especie de Planta, Ave o Artropodo del catalogo</h1>
             <form  class="input-datos"  action="ModificacionesaBD/eliminaPlanta.jsp" method="post">
                <div class="input-row">
                Tipo: <input type="text" name="tipo"><br>
                Nombre: <input type="text" name="nombre"><br>
                <input type="submit" value="Eliminar">
                </div>
            </form>
        </div>
        <div class="catagolo">
            <h1>Modifique el nombre de una Planta, Ave o Artropodo</h1>
             <form  class="input-datos"  action="ModificacionesaBD/modificaPlanta.jsp" method="post">
                <div class="input-row">
                <h4>Datos Nuevos</h4>
                Tipo: <input type="text" name="tipo"><br>
                Nombre: <input type="text" name="nombre"><br>
                Nombre Cientifico: <input type="text" name="nombreC"><br>
                Es una especie invasora: <input type="text" name="invasora"><br>
                Esta en peligro de extincion: <input type="text" name="extincion"><br>
                <h4>Dato de referencia</h4>
                Nombre a cambiar: <input type="text" name="nombreA"><br>
                <input type="submit" value="modificar">
                </div>
            </form>
        </div>
         <div class="catagolo">
            <h4>Ingresa una nueva area natural protegida</h4>
             <form  class="input-datos"  action="ModificacionesaBD/nuevaAP.jsp" method="post">
                <div class="input-row">
                Nombre: <input type="text" name="nombre" ><br>
                Area total protegida: <input type="text" name="areaP" ><br>
                Area total protegida efectiva: <input type="text" name="areaE" ><br>
                <input type="submit" value="Guardar">
                </div>
            </form>
        </div>
       <div class="catagolo">
    <h4>Ingresa nuevos datos para el gasto en biodiversidad de este año</h4>
    <form class="input-datos" action="ModificacionesaBD/ingresaGastoBio.jsp" method="post">
        <div class="input-row">
            Tipo de gasto: 
            <select name="tipogasto" required>
                <option value="">Seleccione una opcion</option>
                <option value="biofin">Biofin</option>
                <option value="Actividad ambiental">Actividad ambiental</option>
            </select><br>
            
            Subcategoria: <input type="text" name="subcategoria" required><br>
            Dinero asignado: <input type="text" name="dinero" required><br>
            <input type="submit" value="Guardar">
        </div>
    </form>
</div>
        <div class="catagolo">
            <h4>Modifique los datos para el gasto en biodiversidad de este año</h4>
             <form  class="input-datos"  action="ModificacionesaBD/modificarGastoB.jsp" method="post">
               <div class="input-row">
            Tipo de gasto: 
            <select name="tipogasto" required>
                <option value="">Seleccione una opcion</option>
                <option value="biofin">Biofin</option>
                <option value="Actividad ambiental">Actividad ambiental</option>
            </select><br>
            
            Subcategoria: <input type="text" name="subcategoria" required><br>
            Dinero asignado: <input type="text" name="dinero" required><br>
            <input type="submit" value="Guardar">
            Subcategoria a cambiar: <input type="text" name="subcategoriaA" required><br>
        </div>
            </form>
        </div>
        <div class="catagolo">
            <h4>Ingrese el nuevo presupuesto total de la CDMX a la biodiversidad</h4>
             <form  class="input-datos"  action="ModificacionesaBD/ingresaPresupuestoCDMX.jsp" method="post">
                <div class="input-row">
                Presupuesto total: <input type="text" name="presupuesto" ><br>
                <input type="submit" value="Guardar">
                </div>
            </form>
        </div>
    </div>
</body>

</html>