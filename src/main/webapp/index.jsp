<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200">
    <title>Biodiversidad CDMX</title>
</head>
<style>
 * {
     margin: 0;
     padding: 0;
     box-sizing: border-box;
     color: wheat;
 }
.audiopajarito{
    display: flex;
    justify-content: right;
    align-items: right;
    padding-left: 60% ; 
    background: transparent;
    position: relative;

}
 body {
     background-image: url('naturaleza-cdmx-chapu.jpg');
     width: 100vw;
     height: 100vh;
     background-size: cover;
     background-position: center;
     display: flex;
     align-items: center;
     justify-content: center;
     position:relative;
 }

 body::before {
     content: "";
     position: absolute;
     width: 100vw;
     height: 100vh;
     background: rgba(0, 0, 0, 0.15);
     backdrop-filter: blur(5px);
     z-index: 0;
 }

 .main-container {
     border: solid;
     width: 700px;
     height: 500px;
     z-index: 1;
     background: linear-gradient(
         to top,
         rgba(0, 0, 0, 0.15),
         rgba(255, 255, 255, 0.15)
     );
     border-radius: 12px;
     backdrop-filter: blur(50px);
     padding: 20px;
 }
 .input-container{
     position: relative;
 }
 .consulta-input{
     width: 600px;
     padding: 10px;
     border-radius: 99px;
     border: 3px solid transparent;
     background: rgba(0, 0, 0, 0.15);
     outline: none;
     font-weight: 500;
     transition: 0.25s border;
     padding-right: 45px;
 }
 .consulta-input:focus{
     border:3px sold rgba(255, 255, 255, 0.15)
 }
 .consulta-input::placeholder{
     color: rgba(255, 255, 255, 0.75);
 }
 .search-btn{
     position: absolute;
     right: 16px;
     top: 50%;
     transform: translateY(-50%);
     background: none;
     display: flex;
     border: none;
     cursor: pointer;
 }


 /*aqui puse las mamadas de las tablas*/
 /* Estilos para los resultados */
 .results-container {
     margin-top: 20px;
     padding: 15px;
     background: rgba(255, 255, 255, 0.1);
     backdrop-filter: blur(10px);
     border-radius: 8px;
     max-height: 70vh;
     overflow-y: auto;
 }

 .table-responsive {
     overflow-x: auto;
 }

 .data-table {
     width: 100%;
     border-collapse: collapse;
     color: wheat;
 }

 .data-table th, .data-table td {
     padding: 12px 15px;
     text-align: left;
     border-bottom: 1px solid rgba(255, 255, 255, 0.2);
 }

 .data-table th {
     background-color: rgba(0, 0, 0, 0.3);
     position: sticky;
     top: 0;
 }

 .data-table tr:hover {
     background-color: rgba(255, 255, 255, 0.05);
 }

 .error {
     color: #ff6b6b;
     padding: 10px;
     background: rgba(255, 0, 0, 0.1);
     border-radius: 4px;
 }

 .success {
     color: #51cf66;
     padding: 10px;
     background: rgba(0, 255, 0, 0.1);
     border-radius: 4px;
 }
 .audiopajarito {
    position: absolute; 
    top: -70px;    
    right: -35px;      
    width: 200px; 
    z-index: 100;       
    
}
</style>
<body>
 <div class="audio-container">
    <audio class="audiopajarito" loop>
        <source src="bird-song-23221.mp3" type="audio/mp3">
    </audio>
</div>
    <main class="main-container">
        <header class="input-container">
            <form action="MiServlet" method="post">
                <input class="consulta-input" type="text" name="consulta" 
                       placeholder="Ej: SELECT * FROM especies WHERE habitat='Xochimilco'" required>
                <button type="submit" class="search-btn">
                    <span class="material-symbols-outlined">search</span>
                </button>
            </form>
        </header>
        
        <div id="resultsContainer" class="results-container">
            <!-- Los resultados se mostrarán aquí -->
        </div>
    </main>
    <!--Esta es la parte mas extrema del codigo y la que mas se rifo chatgot porque no manches estaba bien difisilisimo-->
    <script>
    /*esta parte toma la consulta y la retiene para que no refresques la pagina*/
        document.getElementById('queryForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            //esta madre manda la informacion a mi servlet jeje para que procese la informacion, los archivos jsp solo los uso como vistas jeje
           fetch('MiServlet', {
    method: 'POST',
    body: `consulta=${encodeURIComponent(consulta)}` 
})

            .then(response => response.text())
            .then(data => {
                //aqui lo manda a el resultado, osea que lo mandara a otro archivo
                document.getElementById('resultsContainer').innerHTML = data;
            })//esto pues namas cacha que si se haga la consulta, por ejemplo si no existe la tabla aqui te manda el error loko
            .catch(error => {
                document.getElementById('resultsContainer').innerHTML = 
                    `<div class="error">Error al procesar la consulta: ${error.message}</div>`;
            });
        });
    </script>
</body>
</html>