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

</style>
<body>
 <div class="audio-container">
    <audio class="audiopajarito" autoplay controller>
        <source src="bird-song-23221.mp3" type="audio/mp3">
    </audio>
</div>
    <main class="main-container">
        <header class="input-container">
            <form action="MiServlet" method="post">
                <input class="consulta-input" type="text" name="consulta" 
                       placeholder="Ej: SELECT * FROM ecosistema'" required>
                <button type="submit" class="search-btn">
                    <span class="material-symbols-outlined">search</span>
                </button>
            </form>
        </header>
        
      
    </main>

    <script>
    /*esta parte toma la consulta y la retiene para que no refresques la pagina*/
        document.getElementById('queryForm').addEventListener('submit', function(e) {
            e.preventDefault();
            const formData = new FormData(this);
            //esta madre manda la informacion a mi servlet jeje para que procese la informacion, los archivos jsp solo los uso como vistas jeje
           fetch('MiServlet', {
    method: 'POST', //usamo este metodo porque enviaremos datos al servidor
    body: `consulta=${encodeURIComponent(consulta)}` //lo enviamos en el cuerpo del http no en el url
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